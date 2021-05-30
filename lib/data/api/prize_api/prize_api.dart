import 'package:retrash_app/data/api/prize_api/prize_type.dart';
import 'package:retrash_app/utils/encode_map.dart';
import 'package:retrash_app/data/type_alias.dart';

class PrizeApi {
  int id;
  String imageUrl;
  String name;
  String partnerName;
  int requiredPoints;
  PrizeType prizeType;

  PrizeApi(this.id, this.imageUrl, this.name, this.partnerName,
      this.requiredPoints, this.prizeType);

  factory PrizeApi.fromJson(Json json) => PrizeApi(
      json['id'],
      json['image_url'],
      json['name'],
      json['partner_name'],
      json['required_points'],
      encodeMap(json['type'], _prizeTypeMap)!);
}

const _prizeTypeMap = {
  'discount': PrizeType.discount,
  'full price': PrizeType.fullPrice,
};
