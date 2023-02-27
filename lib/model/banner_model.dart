class BannerModel {
  String? websiteBannerId;
  String? title;
  String? description;
  String? image;
  String? status;
  String? createdAt;
  String? updatedAt;

  BannerModel(
      {this.websiteBannerId,
        this.title,
        this.description,
        this.image,
        this.status,
        this.createdAt,
        this.updatedAt});

  BannerModel.fromJson(Map<String, dynamic> json) {
    websiteBannerId = json['website_banner_id'];
    title = json['title'];
    description = json['description'];
    image = json['image'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['website_banner_id'] = this.websiteBannerId;
    data['title'] = this.title;
    data['description'] = this.description;
    data['image'] = this.image;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
class MutualModel {
  String? userAvtar;

  MutualModel({this.userAvtar});

  MutualModel.fromJson(Map<String, dynamic> json) {
    userAvtar = json['user_avtar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_avtar'] = this.userAvtar;
    return data;
  }
}
