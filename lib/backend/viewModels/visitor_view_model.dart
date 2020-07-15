import 'package:checkin/backend/viewModels/base_model.dart';
import 'dart:convert';

class VisitorViewModel extends BaseModel {
  init() {}

  String getPrettyJSONString(jsonObject) {
    JsonEncoder encoder = new JsonEncoder.withIndent('  ');
    String jsonString = encoder.convert(json.decode(jsonObject));
    return jsonString;
  }

  
}
