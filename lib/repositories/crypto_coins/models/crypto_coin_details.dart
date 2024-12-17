// import libraries
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:json_annotation/json_annotation.dart';

// import part of file, g - means that file is generated
part 'crypto_coin_details.g.dart';

// creates HiveType annotation - that creates hive adapter
@HiveType(typeId: 1)
// @jsonSerializable() - annotaion, that creates json serialization
@JsonSerializable()
// CryptoCoin model class that extends from Equatable, Equtable- class that checks if two instances are equal
class CryptoCoinDetail extends Equatable {
  // constructor - lets to create intances of CryptoCoin
  const CryptoCoinDetail(
      {required this.priceInUSD,
      required this.imageUrl,
      required this.toSymbol,
      required this.lastUpdate,
      required this.hight24Hour,
      required this.low24Hours});
  // model poles
  // creates HiveField annotation for field 1
  @HiveField(0)
  // @jsonKey(name: 'TOSYMBOL') - annotation, that changes name of pole in json
  @JsonKey(name: 'TOSYMBOL')
  final String toSymbol;

  // creates HiveField annotation for field 2
  @HiveField(1)
  // @JsonKey(name: 'LASTUPDATE')
  @JsonKey(
      name: 'LASTUPDATE', toJson: _dateTimeToJson, fromJson: _dateTimeFromJson)
  final DateTime lastUpdate;

  // creates HiveField annotation for field 3
  @HiveField(2)
  // @JsonKey(name: 'HIGHT24HOUR')
  @JsonKey(name: 'HIGH24HOUR')
  final double hight24Hour;

  // creates HiveField annotation for field 4
  @HiveField(3)
  // @JsonKey(name: 'LOW24HOURS')
  @JsonKey(name: 'LOW24HOUR')
  final double low24Hours;

  // creates HiveField annotation for field 5
  @HiveField(4)
  // @JsonKey(name: 'PRICEINUSD')
  @JsonKey(name: 'PRICE')
  final double priceInUSD;

  // creates HiveField annotation for field 6
  @HiveField(5)
  // @JsonKey(name: 'IMAGEURL')
  @JsonKey(name: 'IMAGEURL')
  final String imageUrl;
  // getter for full image url
  String get fullImageUrl => 'https://cryptocompare.com/$imageUrl';

  /// Connects the generated CryptoCoinDetailFromJson function to the `fromJson`
  /// factory method - converts json data to model
  factory CryptoCoinDetail.fromJson(Map<String, dynamic> json) =>
      _$CryptoCoinDetailFromJson(json);

  /// Connects the generated $CryptoCoinDetailToJson function to the `toJson` method.
  Map<String, dynamic> toJson() => _$CryptoCoinDetailToJson(this);

  // creates custom serializer which converts DateTime to int
  static int _dateTimeToJson(DateTime time) => time.millisecondsSinceEpoch;

  // creates custrom serializer which converts int to DateTime
  static DateTime _dateTimeFromJson(int milliseconds) =>
      DateTime.fromMillisecondsSinceEpoch(milliseconds);

  // overrides get props method
  @override
  // gets model properties
  List<Object> get props =>
      [toSymbol, lastUpdate, hight24Hour, low24Hours, priceInUSD, imageUrl];
}
