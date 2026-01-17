class AllOpenMatsModel {
  AllOpenMatsModel({
     this.success,
     this.message,
     this.data,
  });

  final bool? success;
  final String? message;
  final List<AllMats>? data;

  factory AllOpenMatsModel.fromJson(Map<String, dynamic> json){
    return AllOpenMatsModel(
      success: json["success"],
      message: json["message"],
      data: json["data"] == null ? [] : List<AllMats>.from(json["data"]!.map((x) => AllMats.fromJson(x))),
    );
  }

}

class AllMats {
  AllMats({
    required this.gymId,
    required this.gymName,
    required this.gymImages,
    required this.day,
    required this.from,
    required this.fromView,
    required this.to,
    required this.toView,
  });

  final String? gymId;
  final String? gymName;
  final List<GymImage> gymImages;
  final String? day;
  final int? from;
  final String? fromView;
  final int? to;
  final String? toView;

  factory AllMats.fromJson(Map<String, dynamic> json){
    return AllMats(
      gymId: json["gymId"],
      gymName: json["gymName"],
      gymImages: json["gymImages"] == null ? [] : List<GymImage>.from(json["gymImages"]!.map((x) => GymImage.fromJson(x))),
      day: json["day"],
      from: json["from"],
      fromView: json["from_view"],
      to: json["to"],
      toView: json["to_view"],
    );
  }

}

class GymImage {
  GymImage({
    required this.key,
    required this.url,
    required this.id,
  });

  final String? key;
  final String? url;
  final String? id;

  factory GymImage.fromJson(Map<String, dynamic> json){
    return GymImage(
      key: json["key"],
      url: json["url"],
      id: json["_id"],
    );
  }

}
