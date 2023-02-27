class NotificationModel {
  String? id;
  String? userId;
  String? title;
  String? message;
  String? type;
  String? createdAt;

  NotificationModel(
      {this.id,
        this.userId,
        this.title,
        this.message,
        this.type,
        this.createdAt});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    title = json['title'];
    message = json['message'];
    type = json['type'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['title'] = this.title;
    data['message'] = this.message;
    data['type'] = this.type;
    data['created_at'] = this.createdAt;
    return data;
  }
}
