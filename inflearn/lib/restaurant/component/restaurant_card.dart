import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:inflearn/common/const/colors.dart';
import 'package:inflearn/restaurant/model/restaurant_detail_model.dart';
import 'package:inflearn/restaurant/model/restaurant_model.dart';

import '../../common/const/data.dart';

class RestaurantCard extends StatelessWidget {



  final Widget image;
  final String name;
  final List<String> tags;
  final int ratingsCount;
  final int deliveryTime; // deliveryTime
  final int deliveryFee; // deliveryFee;
  final double ratings;
  final bool isDetail;
  final String? detail;
  final String? heroKey;
  const RestaurantCard({
    Key? key,
    required this.image,
    required this.name,
    required this.tags,
    required this.ratingsCount,
    required this.deliveryTime,
    required this.deliveryFee,
    required this.ratings,
    this.heroKey,
    this.isDetail = false,
    this.detail,
  }) : super(key: key);

  factory RestaurantCard.fromModel({
    required RestaurantModel model,
    bool isDetail = false,
}){
    return RestaurantCard(
      image: Image.network(
        model.thumbUrl,
        fit: BoxFit.cover,
      ),
      // image : Image.asset(
      //   'asset/img/food/ddeok_bok_gi.jpg',
      //   fit: BoxFit.cover,
      // ),
      heroKey: model.id,
      name: model.name,
      tags: model.tags,
      ratingsCount: model.ratingsCount,
      deliveryTime: model.deliveryFee,
      deliveryFee: model.deliveryFee,
      ratings: model.ratings,
      isDetail: isDetail,
      detail: model is RestaurantDetailModel ? model.detail : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if(heroKey != null)
        Hero(
          tag: ObjectKey(heroKey),
          child: ClipRRect(
            child: image,
            borderRadius: BorderRadius.circular(isDetail ? 0 : 12.0),
          ),
        ),
        if(heroKey == null)
             ClipRRect(
              child: image,
              borderRadius: BorderRadius.circular(isDetail ? 0 : 12.0),
            ),
        const SizedBox(height: 16.0,),
        Padding(
          padding:  EdgeInsets.symmetric(horizontal: isDetail ? 16.0 :0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                name,
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8.0,),
              Text(
                tags.join(' · '),
                style: TextStyle(
                    color: BODY_TEXT_COLOR,
                    fontSize: 14.0,
                ),
              ),
              const SizedBox(height: 8.0,),
              Row(
                children: [
                  _IconText(
                      icon: Icons.star,
                      label: ratings.toString(),
                  ),
                  renderDot(),
                  _IconText(
                    icon: Icons.receipt,
                    label: ratingsCount.toString(),
                  ),
                  renderDot(),
                  _IconText(
                    icon: Icons.timelapse_outlined,
                    label: '$deliveryTime : 00 ',
                  ),
                  renderDot(),
                  _IconText(
                    icon: Icons.add_road_outlined,
                    label: deliveryFee == 0 ? '현위치' : '$deliveryFee m'
                  ),
                ],
              ),
              if(detail != null && isDetail)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(detail!),
                ),
            ],
          ),
        )
      ],
    );
  }

  Widget renderDot(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Text(
        '·',
        style: TextStyle(
          fontSize: 12.0,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}


class _IconText extends StatelessWidget {
  final IconData icon;
  final String label;

  const _IconText({
    Key? key,
    required this.icon,
    required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: PRIMARY_COLOR,
          size: 14.0,
        ),
        const SizedBox(width: 8.0,),
        Text(
          label,
          style: TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.w500,
          ),
        )
      ],
    );
  }
}
