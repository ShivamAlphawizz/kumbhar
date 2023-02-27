class ProfileModel {
  String? sNo;
  String? userId;
  String? name;
  String? email;
  String? mobile;
  String? gender;
  String? profileFor;
  String? areaOfInterest;
  String? bloodGroup;
  String? caste;
  String? complexion;
  String? bodyType;
  String? weight;
  String? aboutMe;
  String? height;
  String? qualification;
  String? occupation;
  String? income;
  String? workPlace;
  String? organisationName;
  String? city;
  String? motherTongue;
  String? designation;
  String? horoscope;
  String? maternalGrandFatherName;
  String? state;
  String? district;
  String? currentAddress;
  String? pin;
  String? whatsappNo;
  String? challenged;
  String? permanentAddress;
  String? maritalStatus;
  String? aadhaar;
  String? dob;
  String? birthPlace;
  String? birthTime;
  String? manglik;
  String? gotra;
  String? gotraNanihal;
  String? familyAddress;
  String? fatherName;
  String? fatherOccupation;
  String? familyStatus;
  String? familyDistrict;
  String? motherName;
  String? grandFatherName;
  String? familyState;
  String? familyPin;
  String? motherOccupation;
  String? familyType;
  String? familyIncome;
  String? familyCity;
  String? maternalGrandFatherNameAddress;
  String? familyValue;
  String? mobile2;
  String? brother;
  String? sister;
  String? drinking;
  String? dietary;
  String? hobbies;
  String? smoking;
  String? language;
  String? interests;
  String? working;
  int? shortlisted;
  String? status;
  String? critical;
  String? religion;
  String? community;
  String? origin;
  String? age;
  String? fatherStatus;
  String? motherStatus;
  String? noB;
  String? noSister;
  String? fatherMobile;
  String? physicalStatus;
  String? nakchatra;
  String? country;
  String? password;
  String? dosh;
  String? deviceToken;
  String? endSubscriptionDate;
  String? userAvtar;
  String? createdAt;
  String? updatedAt;

  ProfileModel(
      {this.sNo,
        this.userId,
        this.name,
        this.email,
        this.mobile,
        this.gender,
        this.profileFor,
        this.areaOfInterest,
        this.bloodGroup,
        this.caste,
        this.complexion,
        this.bodyType,
        this.weight,
        this.aboutMe,
        this.height,
        this.qualification,
        this.occupation,
        this.income,
        this.workPlace,
        this.organisationName,
        this.city,
        this.motherTongue,
        this.designation,
        this.horoscope,
        this.maternalGrandFatherName,
        this.state,
        this.district,
        this.currentAddress,
        this.pin,
        this.whatsappNo,
        this.challenged,
        this.permanentAddress,
        this.maritalStatus,
        this.aadhaar,
        this.dob,
        this.birthPlace,
        this.birthTime,
        this.manglik,
        this.gotra,
        this.gotraNanihal,
        this.familyAddress,
        this.fatherName,
        this.fatherOccupation,
        this.familyStatus,
        this.familyDistrict,
        this.motherName,
        this.grandFatherName,
        this.familyState,
        this.familyPin,
        this.motherOccupation,
        this.familyType,
        this.familyIncome,
        this.familyCity,
        this.maternalGrandFatherNameAddress,
        this.familyValue,
        this.mobile2,
        this.brother,
        this.sister,
        this.drinking,
        this.dietary,
        this.hobbies,
        this.smoking,
        this.language,
        this.interests,
        this.working,
        this.shortlisted,
        this.status,
        this.critical,
        this.religion,
        this.community,
        this.origin,
        this.age,
        this.fatherStatus,
        this.motherStatus,
        this.noB,
        this.noSister,
        this.fatherMobile,
        this.physicalStatus,
        this.nakchatra,
        this.country,
        this.password,
        this.dosh,
        this.deviceToken,
        this.endSubscriptionDate,
        this.userAvtar,
        this.createdAt,
        this.updatedAt});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    sNo = json['s_no'];
    userId = json['user_id'];
    name = json['name'];
    email = json['email'];
    mobile = json['mobile'];
    gender = json['gender'];
    profileFor = json['profile_for'];
    areaOfInterest = json['area_of_interest'];
    bloodGroup = json['blood_group'];
    caste = json['caste'];
    complexion = json['complexion'];
    bodyType = json['body_type'];
    weight = json['weight'];
    aboutMe = json['about_me'];
    height = json['height'];
    qualification = json['qualification'];
    occupation = json['occupation'];
    income = json['income'];
    workPlace = json['work_place'];
    organisationName = json['organisation_name'];
    city = json['city'];
    motherTongue = json['mother_tongue'];
    designation = json['designation'];
    horoscope = json['horoscope'];
    maternalGrandFatherName = json['maternal_grand_father_name'];
    state = json['state'];
    district = json['district'];
    currentAddress = json['current_address'];
    pin = json['pin'];
    whatsappNo = json['whatsapp_no'];
    challenged = json['challenged'];
    permanentAddress = json['permanent_address'];
    maritalStatus = json['marital_status'];
    aadhaar = json['aadhaar'];
    dob = json['dob'];
    birthPlace = json['birth_place'];
    birthTime = json['birth_time'];
    manglik = json['manglik'];
    gotra = json['gotra'];
    gotraNanihal = json['gotra_nanihal'];
    familyAddress = json['family_address'];
    fatherName = json['father_name'];
    fatherOccupation = json['father_occupation'];
    familyStatus = json['family_status'];
    familyDistrict = json['family_district'];
    motherName = json['mother_name'];
    grandFatherName = json['grand_father_name'];
    familyState = json['family_state'];
    familyPin = json['family_pin'];
    motherOccupation = json['mother_occupation'];
    familyType = json['family_type'];
    familyIncome = json['family_income'];
    familyCity = json['family_city'];
    maternalGrandFatherNameAddress = json['maternal_grand_father_name_address'];
    familyValue = json['family_value'];
    mobile2 = json['mobile2'];
    brother = json['brother'];
    sister = json['sister'];
    drinking = json['drinking'];
    dietary = json['dietary'];
    hobbies = json['hobbies'];
    smoking = json['smoking'];
    language = json['language'];
    interests = json['interests'];
    working = json['working'];
    shortlisted = json['shortlisted'];
    status = json['status'];
    critical = json['critical'];
    religion = json['religion'];
    community = json['community'];
    origin = json['origin'];
    age = json['age'];
    fatherStatus = json['father_status'];
    motherStatus = json['mother_status'];
    noB = json['no_b'];
    noSister = json['no_sister'];
    fatherMobile = json['father_mobile'];
    physicalStatus = json['physical_status'];
    nakchatra = json['nakchatra'];
    country = json['country'];
    password = json['password'];
    dosh = json['dosh'];
    deviceToken = json['device_token'];
    endSubscriptionDate = json['end_subscription_date'];
    userAvtar = json['user_avtar'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['s_no'] = this.sNo;
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    data['gender'] = this.gender;
    data['profile_for'] = this.profileFor;
    data['area_of_interest'] = this.areaOfInterest;
    data['blood_group'] = this.bloodGroup;
    data['caste'] = this.caste;
    data['complexion'] = this.complexion;
    data['body_type'] = this.bodyType;
    data['weight'] = this.weight;
    data['about_me'] = this.aboutMe;
    data['height'] = this.height;
    data['qualification'] = this.qualification;
    data['occupation'] = this.occupation;
    data['income'] = this.income;
    data['work_place'] = this.workPlace;
    data['organisation_name'] = this.organisationName;
    data['city'] = this.city;
    data['mother_tongue'] = this.motherTongue;
    data['designation'] = this.designation;
    data['horoscope'] = this.horoscope;
    data['maternal_grand_father_name'] = this.maternalGrandFatherName;
    data['state'] = this.state;
    data['district'] = this.district;
    data['current_address'] = this.currentAddress;
    data['pin'] = this.pin;
    data['whatsapp_no'] = this.whatsappNo;
    data['challenged'] = this.challenged;
    data['permanent_address'] = this.permanentAddress;
    data['marital_status'] = this.maritalStatus;
    data['aadhaar'] = this.aadhaar;
    data['dob'] = this.dob;
    data['birth_place'] = this.birthPlace;
    data['birth_time'] = this.birthTime;
    data['manglik'] = this.manglik;
    data['gotra'] = this.gotra;
    data['gotra_nanihal'] = this.gotraNanihal;
    data['family_address'] = this.familyAddress;
    data['father_name'] = this.fatherName;
    data['father_occupation'] = this.fatherOccupation;
    data['family_status'] = this.familyStatus;
    data['family_district'] = this.familyDistrict;
    data['mother_name'] = this.motherName;
    data['grand_father_name'] = this.grandFatherName;
    data['family_state'] = this.familyState;
    data['family_pin'] = this.familyPin;
    data['mother_occupation'] = this.motherOccupation;
    data['family_type'] = this.familyType;
    data['family_income'] = this.familyIncome;
    data['family_city'] = this.familyCity;
    data['maternal_grand_father_name_address'] =
        this.maternalGrandFatherNameAddress;
    data['family_value'] = this.familyValue;
    data['mobile2'] = this.mobile2;
    data['brother'] = this.brother;
    data['sister'] = this.sister;
    data['drinking'] = this.drinking;
    data['dietary'] = this.dietary;
    data['hobbies'] = this.hobbies;
    data['smoking'] = this.smoking;
    data['language'] = this.language;
    data['interests'] = this.interests;
    data['working'] = this.working;
    data['shortlisted'] = this.shortlisted;
    data['status'] = this.status;
    data['critical'] = this.critical;
    data['religion'] = this.religion;
    data['community'] = this.community;
    data['origin'] = this.origin;
    data['age'] = this.age;
    data['father_status'] = this.fatherStatus;
    data['mother_status'] = this.motherStatus;
    data['no_b'] = this.noB;
    data['no_sister'] = this.noSister;
    data['father_mobile'] = this.fatherMobile;
    data['physical_status'] = this.physicalStatus;
    data['nakchatra'] = this.nakchatra;
    data['country'] = this.country;
    data['password'] = this.password;
    data['dosh'] = this.dosh;
    data['device_token'] = this.deviceToken;
    data['end_subscription_date'] = this.endSubscriptionDate;
    data['user_avtar'] = this.userAvtar;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
