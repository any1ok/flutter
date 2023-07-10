import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inflearn/common/const/default_layout.dart';
import 'package:inflearn/common/dio/dio.dart';
import 'package:inflearn/common/model/cursor_pagination_model.dart';
import 'package:inflearn/product/component/product_card.dart';
import 'package:inflearn/rating/component/rating_card.dart';
import 'package:inflearn/rating/model/rating_model.dart';
import 'package:inflearn/restaurant/component/restaurant_card.dart';
import 'package:dio/dio.dart';
import 'package:inflearn/restaurant/provider/restaurant_rating_provider.dart';
import 'package:inflearn/restaurant/provider/restuarant_provider.dart';
import 'package:inflearn/restaurant/repository/restaurant_rating_repository.dart';
import 'package:inflearn/restaurant/repository/restaurant_repository.dart';
import 'package:skeletons/skeletons.dart';

import '../../common/const/data.dart';
import '../../common/utils/pagination_utils.dart';
import '../model/restaurant_detail_model.dart';
import '../model/restaurant_model.dart';

class RestaurantDetailScreen extends ConsumerStatefulWidget {
  final String id;

  const RestaurantDetailScreen({
    required this.id,
    Key? key
  }) : super(key: key);

  @override
  ConsumerState<RestaurantDetailScreen> createState() => _RestaurantDetailScreenState();
}

class _RestaurantDetailScreenState extends ConsumerState<RestaurantDetailScreen> {
  final ScrollController controller = ScrollController();

  @override
  void initState(){
    super.initState();

    ref.read(restaurantProvider.notifier).getDetail(id: widget.id);
    controller.addListener(scrollListener);
  }
  void scrollListener(){
    PaginationUtils.paginate(controller: controller, provider:
    ref.read(restuarantRatingProvider(widget.id).notifier));
    // if(controller.offset > controller.position.maxScrollExtent - 300){
    //   ref.read(restaurantProvider.notifier).paginate(
    //     fetchMore: true,
    //   );
    // }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(restaurantDetailProvider(widget.id));
    final ratingsState = ref.watch(restuarantRatingProvider(widget.id));
    if (state == null) {
      return DefaultLayout(
          child: Center
            (child: CircularProgressIndicator(),
          )
      );
    }
    return DefaultLayout(
        title: '불타는 떡볶이',
        child: CustomScrollView(
          controller: controller,
          slivers: [
            renderTop(
              model: state,
            ),
            if(state is! RestaurantDetailModel)
              renderLoading(),
            if(state is RestaurantDetailModel)
              renderLabel(),
            if(state is RestaurantDetailModel)
              renderProduct(products: state.products),
            if(ratingsState is CursorPagination<RatingModel>)
            renderRatings(models :ratingsState.data),
          ],
        ),
    );
  }

  SliverPadding renderRatings({
  required List<RatingModel> models
}){
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 16.0,vertical: 16.0),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
            (_,index) => Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: RatingCard.fromModel(
                model : models[index],
              ),
            ),
          childCount: models.length,
        ),
      ),
    );
  }

  SliverPadding renderLoading() {
    return SliverPadding(padding: EdgeInsets.symmetric(
        vertical: 16.0 ,horizontal: 16.0),
    sliver:  SliverList(
        delegate: SliverChildListDelegate(
        List.generate(3, (index) => Padding(
          padding: const EdgeInsets.only(bottom: 32.0),
          child: SkeletonParagraph(
            style: SkeletonParagraphStyle(
              lines: 5,
              padding: EdgeInsets.zero
            ),
          ),
        ))
    ),
    ),
    );
  }

  SliverToBoxAdapter renderTop({
    required RestaurantModel model,
  }) {
    return SliverToBoxAdapter(
      child: RestaurantCard.fromModel(
        model: model,
        isDetail: true,
      ),
    );
  }

  SliverPadding renderLabel() {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      sliver: SliverToBoxAdapter(
        child: Text(
          '메뉴',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  renderProduct({
    required List<RestaurantProductModel> products,
  }) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
          final model = products[index];

          return Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: ProductCard.fromRestaurantProductModel(model: model),
          );
        }, childCount: products.length),
      ),
    );
  }
}
