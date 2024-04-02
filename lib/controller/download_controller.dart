import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:android_path_provider/android_path_provider.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';
import 'package:lms_user_app/components/custom_snackbar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../data/model/order/order_history_list/order_history.dart';

class DownloaderController extends GetxController implements GetxService {
  late bool _permissionReady;
  late String _localPath;
  final ReceivePort _port = ReceivePort();

  @override
  void onInit() {
    _bindBackgroundIsolate();
    FlutterDownloader.registerCallback(downloadCallback);
    _permissionReady = false;
    _prepare();
    super.onInit();
  }

  @override
  void dispose() {
    _unbindBackgroundIsolate();
    super.dispose();
  }

  Future<void> _prepare() async {
    _permissionReady = await _checkPermission();
    if (_permissionReady) {
      await _prepareSaveDir();
    }
  }

  Future<void> _prepareSaveDir() async {
    _localPath = (await _getSaveDir())!;
    final savedDir = Directory(_localPath);
    if (!savedDir.existsSync()) {
      await savedDir.create();
    }
  }

  Future<String?> _getSaveDir() async {
    String? externalStorageDirPath;
    if (Platform.isAndroid) {
      try {
        externalStorageDirPath = await AndroidPathProvider.downloadsPath;
      } catch (err) {
        final directory = await getExternalStorageDirectory();
        externalStorageDirPath = directory?.path;
      }
    } else if (Platform.isIOS) {
      externalStorageDirPath =
          (await getApplicationDocumentsDirectory()).absolute.path;
    }
    return externalStorageDirPath;
  }

  @pragma('vm:entry-point')
  static void downloadCallback(
    String id,
    int status,
    int progress,
  ) {
    IsolateNameServer.lookupPortByName('downloader_send_port')
        ?.send([id, status, progress]);
  }

  void _bindBackgroundIsolate() {
    final isSuccess = IsolateNameServer.registerPortWithName(
      _port.sendPort,
      'downloader_send_port',
    );
    if (!isSuccess) {
      _unbindBackgroundIsolate();
      _bindBackgroundIsolate();
      return;
    }
    _port.listen((dynamic data) {
      final taskId = (data as List<dynamic>)[0] as String;
      final status = DownloadTaskStatus.fromInt(data[1] as int);
      final progress = data[2] as int;

      if (kDebugMode) {
        print(
        'Callback on UI isolate: '
        'task ($taskId) is in status ($status) and process ($progress)',
      );
      }
    });
  }

  void _unbindBackgroundIsolate() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
  }

  Future<void> downloadFile(OrderHistory history) async {
    await _retryRequestPermission();
    if (history.invoiceLink == null) {
      customSnackBar("failed_to_download".tr, isError: true);
      return;
    } else if (history.invoiceLink!.isEmpty) {
      customSnackBar("failed_to_download".tr, isError: true);
      return;
    }
    await FlutterDownloader.enqueue(
      url: history.invoiceLink!,
      headers: {}, // optional: header send with url (auth token etc)
      savedDir: _localPath,
      fileName: history.title,
      showNotification:
          true, // show download progress in status bar (for Android)
      openFileFromNotification:
          true, // click on notification to open downloaded file (for Android)
    );
  }

  Future<void> _retryRequestPermission() async {
    final hasGranted = await _checkPermission();

    if (hasGranted) {
      await _prepareSaveDir();
    }
    _permissionReady = hasGranted;
  }

  Future<bool> _checkPermission() async {
    if (Platform.isIOS) {
      return true;
    }

    if (Platform.isAndroid) {
      await Permission.notification.isDenied.then((value) {
        if (value) {
          Permission.notification.request();
        }
      });
      final info = await DeviceInfoPlugin().androidInfo;
      if (info.version.sdkInt > 28) {
        return true;
      }

      final status = await Permission.storage.status;
      if (status == PermissionStatus.granted) {
        return true;
      }

      final result = await Permission.storage.request();
      return result == PermissionStatus.granted;
    }

    throw StateError('unknown platform');
  }
}
