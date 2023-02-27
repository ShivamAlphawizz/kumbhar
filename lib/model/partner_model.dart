class PartnerModel {
  String? id;
  String? userId;
  String? age;
  String? height;
  String? martialStatus;
  String? motherTongue;
  String? physicalStaus;
  String? smoking;
  String? drinking;
  String? religion;
  String? caste;
  String? subcaste;
  String? dosh;
  String? gotra;
  String? manglik;
  String? occuption;
  String? workingAs;
  String? annualIncome;
  String? state;
  String? city;

  PartnerModel(
      {this.id,
        this.userId,
        this.age,
        this.height,
        this.martialStatus,
        this.motherTongue,
        this.physicalStaus,
        this.smoking,
        this.drinking,
        this.religion,
        this.caste,
        this.subcaste,
        this.dosh,
        this.gotra,
        this.manglik,
        this.occuption,
        this.workingAs,
        this.annualIncome,
        this.state,
        this.city});

  PartnerModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    age = json['age'];
    height = json['height'];
    martialStatus = json['martial_status'];
    motherTongue = json['mother_tongue'];
    physicalStaus = json['physical_staus'];
    smoking = json['smoking'];
    drinking = json['drinking'];
    religion = json['religion'];
    caste = json['caste'];
    subcaste = json['subcaste'];
    dosh = json['dosh'];
    gotra = json['gotra'];
    manglik = json['manglik'];
    occuption = json['occuption'];
    workingAs = json['working_as'];
    annualIncome = json['annual_income'];
    state = json['state'];
    city = json['city'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['age'] = this.age;
    data['height'] = this.height;
    data['martial_status'] = this.martialStatus;
    data['mother_tongue'] = this.motherTongue;
    data['physical_staus'] = this.physicalStaus;
    data['smoking'] = this.smoking;
    data['drinking'] = this.drinking;
    data['religion'] = this.religion;
    data['caste'] = this.caste;
    data['subcaste'] = this.subcaste;
    data['dosh'] = this.dosh;
    data['gotra'] = this.gotra;
    data['manglik'] = this.manglik;
    data['occuption'] = this.occuption;
    data['working_as'] = this.workingAs;
    data['annual_income'] = this.annualIncome;
    data['state'] = this.state;
    data['city'] = this.city;
    return data;
  }
}
