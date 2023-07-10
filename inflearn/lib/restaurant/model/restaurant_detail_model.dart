import 'package:inflearn/common/utils/data_utils.dart';
import 'package:inflearn/restaurant/model/restaurant_model.dart';
import '../../common/const/data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'restaurant_detail_model.g.dart';

@JsonSerializable()
class RestaurantDetailModel extends RestaurantModel{
  final String detail;
  final List<RestaurantProductModel> products;

  RestaurantDetailModel({
    required super.id,
    required super.name,
    required super.thumbUrl,
    required super.tags,
    required super.priceRange,
    required super.ratings,
    required super.ratingsCount,
    required super.deliveryFee,
    required super.deliveryTime,
    required this.detail,
    required this.products,
  });

  factory RestaurantDetailModel.fromJson( Map<String, dynamic> json)
  => _$RestaurantDetailModelFromJson(json);

  Map<String, dynamic> toJson() => _$RestaurantDetailModelToJson(this);

  // factory RestaurantDetailModel.fromJson({
  //   required Map<String, dynamic> json
  // }){
  //   return RestaurantDetailModel(
  //       id: json['id'],
  //       name: json['name'],
  //       thumbUrl: 'http://$ip${json['thumbUrl']}',
  //       tags: List<String>.from(json['tags']),
  //       priceRange: RestaurantPriceRange.values.firstWhere((e) => e.name == json['priceRange']),
  //       ratings: json['ratings'],
  //       ratingsCount: json['ratingsCount'],
  //       deliveryTime: json['deliveryTime'],
  //       deliveryFee: json['deliveryFee'],
  //       detail: json['detail'],
  //       products: json['products'].map<RestaurantProductModel>(
  //           (x) => RestaurantProductModel.fromJson(
  //             json: x,
  //           )
  //       ).toList(),
  //   );
  // }

}

@JsonSerializable()
class RestaurantProductModel{
  final String id;
  final String name;
  @JsonKey(
    fromJson: DataUtils.pathToUrl
  )
  final String imgUrl;
  final String detail;
  final int price;

  RestaurantProductModel({
  required this.id,
  required this.name,
  required this.imgUrl,
  required this.detail,
  required this.price, });

  factory RestaurantProductModel.fromJson(Map<String,dynamic> json)
  => _$RestaurantProductModelFromJson(json);

}
