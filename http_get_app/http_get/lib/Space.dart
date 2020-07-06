import 'package:flutter/cupertino.dart';

class Space extends ChangeNotifier{
  String displayName;
  String meta;
  String description;

  Space({this.displayName, this.meta, this.description});

  factory Space.fromJson(Map<String, dynamic> json) {
    return Space(
      displayName: json["displayName"],
      meta: json["meta"],
      description: json["description"],
    );
  }
  void changeDisplayName(String displayName) {
   displayName = displayName;
    notifyListeners();
  }
  void changMeta(String metaName) {
    meta = metaName;
    notifyListeners();
  }
  void changeDescription(String descName) {
    description = descName;
    notifyListeners();
  }

}
