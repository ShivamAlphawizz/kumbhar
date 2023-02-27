class ReligionModel {
  String? regionId;
  String? region;
  String? status;
  String? language;
  String? createdAt;
  String? updateAt;

  ReligionModel(
      {this.regionId,
        this.region,
        this.status,
        this.language,
        this.createdAt,
        this.updateAt});

  ReligionModel.fromJson(Map<String, dynamic> json) {
    regionId = json['region_id'];
    region = json['region'];
    status = json['status'];
    language = json['language'];
    createdAt = json['created_at'];
    updateAt = json['update_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['region_id'] = this.regionId;
    data['region'] = this.region;
    data['status'] = this.status;
    data['language'] = this.language;
    data['created_at'] = this.createdAt;
    data['update_at'] = this.updateAt;
    return data;
  }
}
class CommunityModel {
  String? id;
  String? name;
  String? status;

  CommunityModel({this.id, this.name, this.status});

  CommunityModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['status'] = this.status;
    return data;
  }
}
class CountryModel {
  String? id;
  String? iso;
  String? name;
  String? nicename;
  String? iso3;
  String? numcode;
  String? phonecode;

  CountryModel(
      {this.id,
        this.iso,
        this.name,
        this.nicename,
        this.iso3,
        this.numcode,
        this.phonecode});

  CountryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    iso = json['iso'];
    name = json['name'];
    nicename = json['nicename'];
    iso3 = json['iso3'];
    numcode = json['numcode'];
    phonecode = json['phonecode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['iso'] = this.iso;
    data['name'] = this.name;
    data['nicename'] = this.nicename;
    data['iso3'] = this.iso3;
    data['numcode'] = this.numcode;
    data['phonecode'] = this.phonecode;
    return data;
  }
}
class StateModel {
  String? id;
  String? name;
  String? nameHi;

  StateModel({this.id, this.name, this.nameHi});

  StateModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    nameHi = json['name_hi'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['name_hi'] = this.nameHi;
    return data;
  }
}
class CityModel {
  String? id;
  String? stateId;
  String? name;
  String? nameHi;

  CityModel({this.id, this.stateId, this.name, this.nameHi});

  CityModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    stateId = json['state_id'];
    name = json['name'];
    nameHi = json['name_hi'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['state_id'] = this.stateId;
    data['name'] = this.name;
    data['name_hi'] = this.nameHi;
    return data;
  }
}
class CastModel {
  String? casteId;
  String? regionId;
  String? caste;
  String? status;
  String? language;
  String? createdAt;
  String? updatedAt;

  CastModel(
      {this.casteId,
        this.regionId,
        this.caste,
        this.status,
        this.language,
        this.createdAt,
        this.updatedAt});

  CastModel.fromJson(Map<String, dynamic> json) {
    casteId = json['caste_id'];
    regionId = json['region_id'];
    caste = json['caste'];
    status = json['status'];
    language = json['language'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['caste_id'] = this.casteId;
    data['region_id'] = this.regionId;
    data['caste'] = this.caste;
    data['status'] = this.status;
    data['language'] = this.language;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
class SubCastModel {
  String? subId;
  String? casteId;
  String? regionId;
  String? subcaste;
  String? status;
  String? language;
  String? createAt;
  String? updateAt;

  SubCastModel(
      {this.subId,
        this.casteId,
        this.regionId,
        this.subcaste,
        this.status,
        this.language,
        this.createAt,
        this.updateAt});

  SubCastModel.fromJson(Map<String, dynamic> json) {
    subId = json['sub_id'];
    casteId = json['caste_id'];
    regionId = json['region_id'];
    subcaste = json['subcaste'];
    status = json['status'];
    language = json['language'];
    createAt = json['create_at'];
    updateAt = json['update_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sub_id'] = this.subId;
    data['caste_id'] = this.casteId;
    data['region_id'] = this.regionId;
    data['subcaste'] = this.subcaste;
    data['status'] = this.status;
    data['language'] = this.language;
    data['create_at'] = this.createAt;
    data['update_at'] = this.updateAt;
    return data;
  }
}
class GotraModel {
  String? id;
  String? title;
  String? satus;

  GotraModel({this.id, this.title, this.satus});

  GotraModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    satus = json['satus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['satus'] = this.satus;
    return data;
  }
}
class ManglicModel {
  String? manglikId;
  String? manglik;
  String? status;
  String? language;
  String? createdAt;
  String? updatedAt;

  ManglicModel(
      {this.manglikId,
        this.manglik,
        this.status,
        this.language,
        this.createdAt,
        this.updatedAt});

  ManglicModel.fromJson(Map<String, dynamic> json) {
    manglikId = json['manglik_id'];
    manglik = json['manglik'];
    status = json['status'];
    language = json['language'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['manglik_id'] = this.manglikId;
    data['manglik'] = this.manglik;
    data['status'] = this.status;
    data['language'] = this.language;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
class HeightModel {
  String? id;
  String? height;

  HeightModel({this.id, this.height});

  HeightModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    height = json['height'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['height'] = this.height;
    return data;
  }
}
class DoshModel {
  String? id;
  String? title;
  String? status;

  DoshModel({this.id, this.title, this.status});

  DoshModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['status'] = this.status;
    return data;
  }
}
class langModel {
  String? languageId;
  String? languageCode;
  String? languageName;
  String? status;
  String? createdAt;
  String? updatedAt;

  langModel(
      {this.languageId,
        this.languageCode,
        this.languageName,
        this.status,
        this.createdAt,
        this.updatedAt});

  langModel.fromJson(Map<String, dynamic> json) {
    languageId = json['language_id'];
    languageCode = json['language_code'];
    languageName = json['language_name'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['language_id'] = this.languageId;
    data['language_code'] = this.languageCode;
    data['language_name'] = this.languageName;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
class dietModel {
  String? dietId;
  String? diet;

  dietModel({this.dietId, this.diet});

  dietModel.fromJson(Map<String, dynamic> json) {
    dietId = json['diet_id'];
    diet = json['diet'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['diet_id'] = this.dietId;
    data['diet'] = this.diet;
    return data;
  }
}
class QuaModel {
  String? id;
  String? title;
  String? status;

  QuaModel({this.id, this.title, this.status});

  QuaModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['status'] = this.status;
    return data;
  }
}
class OccupationModel {
  String? occupationId;
  String? occupation;
  String? status;
  String? language;
  String? createdAt;
  String? updatedAt;

  OccupationModel(
      {this.occupationId,
        this.occupation,
        this.status,
        this.language,
        this.createdAt,
        this.updatedAt});

  OccupationModel.fromJson(Map<String, dynamic> json) {
    occupationId = json['occupation_id'];
    occupation = json['occupation'];
    status = json['status'];
    language = json['language'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['occupation_id'] = this.occupationId;
    data['occupation'] = this.occupation;
    data['status'] = this.status;
    data['language'] = this.language;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
class WorkingModel {
  String? id;
  String? title;

  WorkingModel({this.id, this.title});

  WorkingModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    return data;
  }
}
class IncomeModel {
  String? incomeId;
  String? income;
  String? language;
  String? status;
  String? createdAt;
  String? updatedAt;

  IncomeModel(
      {this.incomeId,
        this.income,
        this.language,
        this.status,
        this.createdAt,
        this.updatedAt});

  IncomeModel.fromJson(Map<String, dynamic> json) {
    incomeId = json['income_id'];
    income = json['income'];
    language = json['language'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['income_id'] = this.incomeId;
    data['income'] = this.income;
    data['language'] = this.language;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
class FamilyStatusModel {
  String? familyStatuId;
  String? familyStatus;

  FamilyStatusModel({this.familyStatuId, this.familyStatus});

  FamilyStatusModel.fromJson(Map<String, dynamic> json) {
    familyStatuId = json['family_statu_id'];
    familyStatus = json['family_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['family_statu_id'] = this.familyStatuId;
    data['family_status'] = this.familyStatus;
    return data;
  }
}
class FamilyTypeModel {
  String? familyTypeId;
  String? familyType;

  FamilyTypeModel({this.familyTypeId, this.familyType});

  FamilyTypeModel.fromJson(Map<String, dynamic> json) {
    familyTypeId = json['family_type_id'];
    familyType = json['family_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['family_type_id'] = this.familyTypeId;
    data['family_type'] = this.familyType;
    return data;
  }
}
class FamilyValueModel {
  String? familyValuesId;
  String? familyValues;

  FamilyValueModel({this.familyValuesId, this.familyValues});

  FamilyValueModel.fromJson(Map<String, dynamic> json) {
    familyValuesId = json['family_values_id'];
    familyValues = json['family_values'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['family_values_id'] = this.familyValuesId;
    data['family_values'] = this.familyValues;
    return data;
  }
}
class OriginModel {
  String? id;
  String? title;
  String? status;

  OriginModel({this.id, this.title, this.status});

  OriginModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['status'] = this.status;
    return data;
  }
}
class FatherStatusModel {
  String? fathersOccupationId;
  String? fathersOccupation;

  FatherStatusModel({this.fathersOccupationId, this.fathersOccupation});

  FatherStatusModel.fromJson(Map<String, dynamic> json) {
    fathersOccupationId = json['fathers_occupation_id'];
    fathersOccupation = json['fathers_occupation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fathers_occupation_id'] = this.fathersOccupationId;
    data['fathers_occupation'] = this.fathersOccupation;
    return data;
  }
}
class MotherStatusModel {
  String? mothersOccupationId;
  String? mothersOccupation;

  MotherStatusModel({this.mothersOccupationId, this.mothersOccupation});

  MotherStatusModel.fromJson(Map<String, dynamic> json) {
    mothersOccupationId = json['mothers_occupation_id'];
    mothersOccupation = json['mothers_occupation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mothers_occupation_id'] = this.mothersOccupationId;
    data['mothers_occupation'] = this.mothersOccupation;
    return data;
  }
}
class DrinkModel {
  String? drinkingSmokingId;
  String? drinkingSmoking;

  DrinkModel({this.drinkingSmokingId, this.drinkingSmoking});

  DrinkModel.fromJson(Map<String, dynamic> json) {
    drinkingSmokingId = json['drinking_smoking_id'];
    drinkingSmoking = json['drinking_smoking'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['drinking_smoking_id'] = this.drinkingSmokingId;
    data['drinking_smoking'] = this.drinkingSmoking;
    return data;
  }
}
class AgeModel {
  String? id;
  String? title;
  String? status;

  AgeModel({this.id, this.title, this.status});

  AgeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['status'] = this.status;
    return data;
  }
}
class GenderModel {
  String? genderId;
  String? gender;
  String? lookingFor;

  GenderModel({this.genderId, this.gender, this.lookingFor});

  GenderModel.fromJson(Map<String, dynamic> json) {
    genderId = json['gender_id'];
    gender = json['gender'];
    lookingFor = json['looking_for'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['gender_id'] = this.genderId;
    data['gender'] = this.gender;
    data['looking_for'] = this.lookingFor;
    return data;
  }
}
class PhysicalModel1 {
  String? id;
  String? name;

  PhysicalModel1({this.id, this.name});

  PhysicalModel1.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

