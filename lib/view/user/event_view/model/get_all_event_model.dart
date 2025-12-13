class CompetitionModel {
  CompetitionModel({
     this.success,
     this.message,
     this.data,
  });

  final bool? success;
  final String? message;
  final List<CompetitionData>? data;

  factory CompetitionModel.fromJson(Map<String, dynamic> json){
    return CompetitionModel(
      success: json["success"],
      message: json["message"],
      data: json["data"] == null ? [] : List<CompetitionData>.from(json["data"]!.map((x) => CompetitionData.fromJson(x))),
    );
  }

}

class CompetitionData {
  CompetitionData({
    required this.id,
    required this.eventName,
    required this.eventDate,
    required this.division,
    required this.city,
    required this.state,
    required this.result,
    required this.user,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  final String? id;
  final String? eventName;
  final DateTime? eventDate;
  final String? division;
  final String? city;
  final String? state;
  final String? result;
  final String? user;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  factory CompetitionData.fromJson(Map<String, dynamic> json){
    return CompetitionData(
      id: json["_id"],
      eventName: json["event_name"],
      eventDate: DateTime.tryParse(json["event_date"] ?? ""),
      division: json["division"],
      city: json["city"],
      state: json["state"],
      result: json["result"],
      user: json["user"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      v: json["__v"],
    );
  }

}
