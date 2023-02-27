class PackageModel {
  String? packagesId;
  String? title;
  String? description;
  String? price;
  String? subscriptionType;
  String? noOfDays;
  String? language;
  String? status;
  String? createdAt;
  String? updatedAt;

  PackageModel(
      {this.packagesId,
        this.title,
        this.description,
        this.price,
        this.subscriptionType,
        this.noOfDays,
        this.language,
        this.status,
        this.createdAt,
        this.updatedAt});

  PackageModel.fromJson(Map<String, dynamic> json) {
    packagesId = json['packages_id'];
    title = json['title'];
    description = json['description'];
    price = json['price'];
    subscriptionType = json['subscription_type'];
    noOfDays = json['no_of_days'];
    language = json['language'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['packages_id'] = this.packagesId;
    data['title'] = this.title;
    data['description'] = this.description;
    data['price'] = this.price;
    data['subscription_type'] = this.subscriptionType;
    data['no_of_days'] = this.noOfDays;
    data['language'] = this.language;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
class HistoryModel {
  String? id;
  String? orderId;
  String? txnId;
  String? userId;
  String? subscriptionType;
  String? price;
  String? packagesId;
  String? endSubscriptionDate;
  String? createdAt;
  String? subscriptionTitle;
  String? subscriptionName;
  int? days;
  String? subscriptionStartDate;
  String? subscriptionEndDate;

  HistoryModel(
      {this.id,
        this.orderId,
        this.txnId,
        this.userId,
        this.subscriptionType,
        this.price,
        this.packagesId,
        this.endSubscriptionDate,
        this.createdAt,
        this.subscriptionTitle,
        this.subscriptionName,
        this.days,
        this.subscriptionStartDate,
        this.subscriptionEndDate});

  HistoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['order_id'];
    txnId = json['txn_id'];
    userId = json['user_id'];
    subscriptionType = json['subscription_type'];
    price = json['price'];
    packagesId = json['packages_id'];
    endSubscriptionDate = json['end_subscription_date'];
    createdAt = json['created_at'];
    subscriptionTitle = json['subscription_title'];
    subscriptionName = json['subscription_name'];
    days = json['days'];
    subscriptionStartDate = json['subscription_start_date'];
    subscriptionEndDate = json['subscription_end_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['order_id'] = this.orderId;
    data['txn_id'] = this.txnId;
    data['user_id'] = this.userId;
    data['subscription_type'] = this.subscriptionType;
    data['price'] = this.price;
    data['packages_id'] = this.packagesId;
    data['end_subscription_date'] = this.endSubscriptionDate;
    data['created_at'] = this.createdAt;
    data['subscription_title'] = this.subscriptionTitle;
    data['subscription_name'] = this.subscriptionName;
    data['days'] = this.days;
    data['subscription_start_date'] = this.subscriptionStartDate;
    data['subscription_end_date'] = this.subscriptionEndDate;
    return data;
  }
}
