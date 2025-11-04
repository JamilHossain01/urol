class SettingsMetaDataModel {
  SettingsMetaDataModel({
    this.success,
    this.message,
    this.data,
  });

  final bool? success;
  final String? message;
  final Data? data;

  factory SettingsMetaDataModel.fromJson(Map<String, dynamic> json) {
    return SettingsMetaDataModel(
      success: json["success"],
      message: json["message"],
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );
  }
}

class Data {
  Data({
    required this.id,
    required this.key,
    required this.value,
  });

  final String? id;
  final String? key;
  final String? value;

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json["_id"],
      key: json["key"],
      value: json["value"],
    );
  }
}
