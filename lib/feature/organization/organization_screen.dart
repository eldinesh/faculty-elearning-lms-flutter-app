import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms_user_app/components/loading_indicator.dart';
import 'package:lms_user_app/controller/organization_controller.dart';
import 'package:lms_user_app/feature/bookStore/widget/organization_header_section.dart';
import 'package:lms_user_app/feature/bookStore/widget/organizer_info.dart';
import 'package:lms_user_app/feature/organization/widget/course_tab.dart';
import 'package:lms_user_app/feature/organization/widget/course_info.dart';
import 'package:lms_user_app/feature/organization/widget/instructor_tab.dart';
import 'package:lms_user_app/utils/dimensions.dart';
import 'package:lms_user_app/utils/styles.dart';

class OrganizationScreen extends StatefulWidget {
  const OrganizationScreen({Key? key}) : super(key: key);

  @override
  State<OrganizationScreen> createState() => _OrganizationScreenState();
}

class _OrganizationScreenState extends State<OrganizationScreen>
    with TickerProviderStateMixin {
  late ScrollController _scrollController;
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    Get.find<OrganizationController>().getOrganizationProfile(Get.arguments);
    Get.find<OrganizationController>().getCourseList(Get.arguments);
    Get.find<OrganizationController>().getInstructorList(Get.arguments);
    _tabController = TabController(length: 2, initialIndex: 0, vsync: this);
    _scrollController = ScrollController()
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<OrganizationController>(
        builder: (controller) {
          return controller.isLoading
              ? const LoadingIndicator()
              : mainUI(context, controller);
        },
      ),
    );
  }

  DefaultTabController mainUI(
      BuildContext context, OrganizationController controller) {
    return DefaultTabController(
      length: 2,
      child: NestedScrollView(
          controller: _scrollController,
          floatHeaderSlivers: false,
          headerSliverBuilder: (context, bool innerBoxIsScrolled) {
            return [
              SliverAppBar(
                expandedHeight: 240,
                elevation: 0.0,
                pinned: true,
                backgroundColor: Theme.of(context).primaryColor,
                leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Get.isDarkMode
                        ? Colors.white
                        : Theme.of(context).cardColor,
                  ),
                  onPressed: () {
                    Get.back();
                  },
                ),
                title: SABT(
                  child: Text(
                    controller.profileData.name ?? "",
                    textAlign: TextAlign.start,
                    style: robotoSemiBold.copyWith(
                        color: Get.isDarkMode
                            ? Theme.of(context).textTheme.bodyLarge?.color
                            : Theme.of(context).cardColor,
                        fontSize: Dimensions.fontSizeDefault),
                  ),
                ),
                flexibleSpace: FlexibleSpaceBar(
                  expandedTitleScale: 1,
                  background: Container(
                    color: Theme.of(context).cardColor,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        OrganizationHeaderSection(data: controller.profileData),
                      ],
                    ),
                  ),
                  collapseMode: CollapseMode.parallax,
                ),
              ),
              SliverPersistentHeader(
                pinned: false,
                floating: false,
                delegate: Delegate(
                    height: 87,
                    widget: Container(
                        color: Theme.of(context).cardColor,
                        child: OrganizerInfo(data: controller.profileData))),
              ),
              SliverToBoxAdapter(
                  child: CourseInformation(
                profileData: controller.profileData,
              )),
              SliverPersistentHeader(
                pinned: true,
                floating: false,
                delegate: Delegate(
                    height: 40,
                    widget: Container(
                      color: Theme.of(context).cardColor,
                      child: TabBar(
                        padding: const EdgeInsets.symmetric(
                            horizontal: Dimensions.paddingSizeDefault),
                        indicatorWeight: 1,
                        controller: _tabController,
                        indicatorSize: TabBarIndicatorSize.tab,
                        indicatorColor: Get.isDarkMode
                            ? Colors.green
                            : Theme.of(context).primaryColor,
                        labelColor: Get.isDarkMode
                            ? Colors.green
                            : Theme.of(context).primaryColor,
                        unselectedLabelColor: Get.isDarkMode
                            ? Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .color!
                                .withOpacity(0.6)
                            : Theme.of(context).textTheme.bodyLarge!.color!,
                        unselectedLabelStyle: robotoMedium.copyWith(
                            color: Theme.of(context).primaryColor,
                            fontSize: Dimensions.fontSizeSmall),
                        labelStyle: robotoBold.copyWith(
                          color: Theme.of(context).textTheme.bodyLarge!.color!,
                          fontSize: Dimensions.fontSizeSmall,
                        ),
                        tabs: [
                          Tab(text: 'course'.toUpperCase().tr),
                          Tab(text: 'instructor'.toUpperCase().tr),
                        ],
                      ),
                    )),
              ),
            ];
          },
          body: TabBarView(
            controller: _tabController,
            children: [
              // CourseTab(id: Get.arguments),
              const CourseTab(),
              InstructorTab(organizationId: Get.arguments),
            ],
          )),
    );
  }
}

class Delegate extends SliverPersistentHeaderDelegate {
  final double height;
  final Widget widget;

  Delegate({required this.height, required this.widget});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return widget;
  }

  @override
  double get maxExtent => height;

  @override
  double get minExtent => height;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}

class SABT extends StatefulWidget {
  final Widget child;
  const SABT({
    Key? key,
    required this.child,
  }) : super(key: key);
  @override
  SABTState createState() {
    return SABTState();
  }
}

class SABTState extends State<SABT> {
  ScrollPosition? _position;
  bool? _visible;
  @override
  void dispose() {
    _removeListener();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _removeListener();
    _addListener();
  }

  void _addListener() {
    _position = Scrollable.of(context).position;
    _position?.addListener(_positionListener);
    _positionListener();
  }

  void _removeListener() {
    _position?.removeListener(_positionListener);
  }

  void _positionListener() {
    final FlexibleSpaceBarSettings? settings =
        context.dependOnInheritedWidgetOfExactType<FlexibleSpaceBarSettings>();
    bool visible =
        settings == null || settings.currentExtent <= settings.minExtent;
    if (_visible != visible) {
      setState(() {
        _visible = visible;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: _visible!,
      child: widget.child,
    );
  }
}
