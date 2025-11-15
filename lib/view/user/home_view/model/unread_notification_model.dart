class NotificationUnreadModel {
  NotificationUnreadModel({
     this.success,
     this.message,
     this.data,
  });

  final bool? success;
  final String? message;
  final int? data;

  factory NotificationUnreadModel.fromJson(Map<String, dynamic> json){
    return NotificationUnreadModel(
      success: json["success"],
      message: json["message"],
      data: json["data"],
    );
  }

}
