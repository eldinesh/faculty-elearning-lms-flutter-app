import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms_user_app/components/loading_indicator.dart';
import 'package:lms_user_app/controller/book_store_controller.dart';
import 'package:lms_user_app/data/model/book_store_model/book_store_data.dart';
import 'package:lms_user_app/feature/bookStore/widget/banner_view.dart';
import 'package:lms_user_app/feature/bookStore/widget/high_rated_books.dart';
import 'package:lms_user_app/feature/bookStore/widget/popular_books.dart';
import 'package:lms_user_app/feature/bookStore/widget/recent_published.dart';
import 'package:lms_user_app/feature/bookStore/widget/trending.dart';
import 'package:lms_user_app/feature/home/widgets/home_app_bar.dart';
import 'package:lms_user_app/utils/dimensions.dart';

import '../../core/helper/responsive_helper.dart';
import '../../utils/styles.dart';
import '../common/book_category.dart';
import '../common/book_widget.dart';

class BookStoreScreen extends StatefulWidget {
  const BookStoreScreen({Key? key}) : super(key: key);

  @override
  State<BookStoreScreen> createState() => _BookStoreScreenState();
}

class _BookStoreScreenState extends State<BookStoreScreen> {
  final bookController = Get.put(BookStoreController());
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        bookController.paginate();
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HomeAppBar(
        backButton: true,
      ),
      body: SafeArea(
        child: GetBuilder<BookStoreController>(
            initState: (state) => bookController.getBookStoreData(),
            builder: (controller) {
              return controller.isBookStoreDataLoading &&
                      controller.bookStoreModel == null
                  ? const LoadingIndicator()
                  : mainUI(scrollController, context);
            }),
      ),
    );
  }

  Widget mainUI(ScrollController scrollController, BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => bookController.getBookStoreData(),
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: CustomScrollView(
          controller: scrollController,
          scrollDirection: Axis.vertical,
          // physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            if (bookController.bookStoreModel != null)
              SliverToBoxAdapter(
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemCount: bookController.bookStoreModel?.data?.length,
                  itemBuilder: (BuildContext context, int index) {
                    return itemBuilderByCategory(
                        context, index, bookController.bookStoreModel!.data!);
                  },
                ),
              ),
            if (bookController.bookList.isNotEmpty)
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.all(Dimensions.paddingSizeDefault),
                      child: Text(
                        'all_books'.tr,
                        style: robotoSemiBold.copyWith(
                            fontSize: Dimensions.fontSizeDefault),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: Dimensions.paddingSizeDefault),
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisSpacing: Dimensions.paddingSizeDefault,
                          mainAxisSpacing: Dimensions.paddingSizeDefault,
                          childAspectRatio:
                              ResponsiveHelper.isTab(context) ? .9 : .63,
                          mainAxisExtent:
                              ResponsiveHelper.isMobile(context) ? 225 : 260,
                          crossAxisCount: ResponsiveHelper.isMobile(context)
                              ? 2
                              : ResponsiveHelper.isTab(context)
                                  ? 3
                                  : 5,
                        ),
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: bookController.bookList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return BookWidget(
                              book: bookController.bookList[index]);
                        },
                      ),
                    ),
                    const SizedBox(height: Dimensions.paddingSizeDefault),
                    if (bookController.isLoadingMoreData == true)
                      const Padding(
                        padding: EdgeInsets.all(Dimensions.paddingSizeDefault),
                        child: Center(child: LoadingIndicator()),
                      ),
                  ],
                ),
              )
          ],
        ),
      ),
    );
  }

  Widget itemBuilderByCategory(
      BuildContext context, int index, List<BookStoreData> data) {
    switch (data[index].sectionType) {
      case 'sliders':
        return BannerView(bannerIndex: index);
      case 'trending_books':
        return Padding(
          padding: const EdgeInsets.only(top: Dimensions.paddingSizeDefault),
          child: Trending(bookList: data[index].trendingBooks!),
        );
      case 'categories':
        return Padding(
          padding: const EdgeInsets.only(top: Dimensions.paddingSizeExtraSmall),
          child: BookCategoryWidget(
            title: 'Books Category',
            categoryList: data[index].categories!,
          ),
        );
      case 'recent_published':
        return Padding(
          padding: const EdgeInsets.only(top: Dimensions.paddingSizeExtraLarge),
          child: RecentPublished(bookList: data[index].recentPublished!),
        );
      case 'popular_books':
        return Padding(
          padding: const EdgeInsets.only(top: Dimensions.paddingSizeExtraLarge),
          child: PopularBooks(bookList: data[index].popularBooks!),
        );
      case 'high_rated_books':
        return Padding(
          padding: const EdgeInsets.only(top: Dimensions.paddingSizeExtraLarge),
          child: HighRatedBooks(bookList: data[index].highRatedBooks!),
        );
      default:
        return const SizedBox();
    }
  }
}
