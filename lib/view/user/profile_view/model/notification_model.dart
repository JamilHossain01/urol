class NotificationModel {
  NotificationModel({
     this.success,
     this.message,
     this.data,
  });

  final bool? success;
  final String? message;
  final Data? data;

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      success: json["success"],
      message: json["message"],
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );
  }
}

class Data {
  Data({
    required this.data,
    required this.meta,
  });

  final List<NotificationData> data;
  final Meta? meta;

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      data: json["data"] == null
          ? []
          : List<NotificationData>.from(
              json["data"]!.map((x) => NotificationData.fromJson(x))),
      meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
    );
  }
}

class NotificationData {
  NotificationData({
    required this.id,
    required this.sender,
    required this.receiver,
    required this.receiverEmail,
    required this.receiverRole,
    required this.type,
    required this.title,
    required this.message,
    required this.isRead,
    required this.link,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  final String? id;
  final String? sender;
  final String? receiver;
  final String? receiverEmail;
  final String? receiverRole;
  final String? type;
  final String? title;
  final String? message;
  final bool? isRead;
  final dynamic link;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  factory NotificationData.fromJson(Map<String, dynamic> json) {
    return NotificationData(
      id: json["_id"],
      sender: json["sender"],
      receiver: json["receiver"],
      receiverEmail: json["receiverEmail"],
      receiverRole: json["receiverRole"],
      type: json["type"],
      title: json["title"],
      message: json["message"],
      isRead: json["isRead"],
      link: json["link"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      v: json["__v"],
    );
  }
}

class Meta {
  Meta({
    required this.page,
    required this.limit,
    required this.total,
    required this.totalPage,
  });

  final int? page;
  final int? limit;
  final int? total;
  final int? totalPage;

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      page: json["page"],
      limit: json["limit"],
      total: json["total"],
      totalPage: json["totalPage"],
    );
  }
}
