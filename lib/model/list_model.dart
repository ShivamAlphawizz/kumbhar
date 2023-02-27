class UserModel {
  String? sNo;
  String? userId;
  String? name;
  String? email;
  String? countryCode;
  String? mobile;
  String? otp;
  String? gender;
  String? profileFor;
  String? password;
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
  String? shortlisted;
  String? status;
  String? critical;
  String? deviceType;
  String? deviceToken;
  String? userAvtar;
  String? endSubscriptionDate;
  String? reasons;
  String? createdAt;
  String? updatedAt;
  String? csutId;
  String? custId;
  String? payment;
  String? membership;
  String? imageStatus;
  String? video;
  String? videoStatus;
  String? casteId;
  String? regionId;
  String? subId;
  String? horoscope;
  String? casteStatus;
  String? religionStatus;
  String? horoStatus;
  String? idProof;
  String? description;
  String? descriptionStatus;
  String? photos;
  String? age;
  String? hight;
  String? nakchatra;
  String? country;
  String? noB;
  String? brotherName;
  String? note;
  String? origin;
  String? motherTongue;
  String? physicalStatus;
  String? designation;
  String? community;
  String? dosh;
  String? fatherStatus;
  String? motherStatus;
  String? otherCast;
  String? subCast;
  String? religion;
  String? fuid;
  String? nativeLanguage;
  String? lat;
  String? lang;
  String? profileStatus;
  String? onlineOffline;
  String? mystatus;
  int? request;
  List<UserImgs>? userImgs;

  UserModel(
      {this.sNo,
        this.userId,
        this.name,
        this.email,
        this.countryCode,
        this.mobile,
        this.otp,
        this.gender,
        this.profileFor,
        this.password,
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
        this.deviceType,
        this.deviceToken,
        this.userAvtar,
        this.endSubscriptionDate,
        this.reasons,
        this.createdAt,
        this.updatedAt,
        this.csutId,
        this.custId,
        this.payment,
        this.membership,
        this.imageStatus,
        this.video,
        this.videoStatus,
        this.casteId,
        this.regionId,
        this.subId,
        this.horoscope,
        this.casteStatus,
        this.religionStatus,
        this.horoStatus,
        this.idProof,
        this.description,
        this.descriptionStatus,
        this.photos,
        this.age,
        this.hight,
        this.nakchatra,
        this.country,
        this.noB,
        this.brotherName,
        this.note,
        this.origin,
        this.motherTongue,
        this.physicalStatus,
        this.designation,
        this.community,
        this.dosh,
        this.fatherStatus,
        this.motherStatus,
        this.otherCast,
        this.subCast,
        this.religion,
        this.fuid,
        this.nativeLanguage,
        this.lat,
        this.lang,
        this.profileStatus,
        this.onlineOffline,
        this.request,
        this.userImgs,this.mystatus});

  UserModel.fromJson(Map<String, dynamic> json) {
    sNo = json['s_no'];
    mystatus = json['mystatus'];
    userId = json['user_id'];
    name = json['name'];
    email = json['email'];
    countryCode = json['country_code'];
    mobile = json['mobile'];
    otp = json['otp'];
    gender = json['gender'];
    profileFor = json['profile_for'];
    password = json['password'];
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
    shortlisted = json['shortlisted'].toString();
    status = json['status'];
    critical = json['critical'];
    deviceType = json['device_type'];
    deviceToken = json['device_token'];
    userAvtar = json['user_avtar'];
    endSubscriptionDate = json['end_subscription_date'];
    reasons = json['reasons'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    csutId = json['csut_id'];
    custId = json['cust_id'];
    payment = json['payment'];
    membership = json['membership'];
    imageStatus = json['image_status'];
    video = json['video'];
    videoStatus = json['video_status'];
    casteId = json['caste_id'];
    regionId = json['region_id'];
    subId = json['sub_id'];
    horoscope = json['horoscope'];
    casteStatus = json['caste_status'];
    religionStatus = json['religion_status'];
    horoStatus = json['horo_status'];
    idProof = json['id_proof'];
    description = json['description'];
    descriptionStatus = json['description_status'];
    photos = json['photos'];
    age = json['age'];
    hight = json['hight'];
    nakchatra = json['nakchatra'];
    country = json['country'];
    noB = json['no_b'];
    brotherName = json['brother_name'];
    note = json['note'];
    origin = json['origin'];
    motherTongue = json['mother_tongue'];
    physicalStatus = json['physical_status'];
    designation = json['designation'];
    community = json['community'];
    dosh = json['dosh'];
    fatherStatus = json['father_status'];
    motherStatus = json['mother_status'];
    otherCast = json['other_cast'];
    subCast = json['sub_cast'];
    religion = json['religion'];
    fuid = json['fuid'];
    nativeLanguage = json['native_language'];
    lat = json['lat'];
    lang = json['lang'];
    profileStatus = json['profile_status'];
    onlineOffline = json['online_offline'];
    request = json['request'];
    if (json['user_imgs'] != null) {
      userImgs = <UserImgs>[];
      json['user_imgs'].forEach((v) {
        userImgs!.add(new UserImgs.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['s_no'] = this.sNo;
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['email'] = this.email;
    data['country_code'] = this.countryCode;
    data['mobile'] = this.mobile;
    data['otp'] = this.otp;
    data['gender'] = this.gender;
    data['profile_for'] = this.profileFor;
    data['password'] = this.password;
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
    data['device_type'] = this.deviceType;
    data['device_token'] = this.deviceToken;
    data['user_avtar'] = this.userAvtar;
    data['end_subscription_date'] = this.endSubscriptionDate;
    data['reasons'] = this.reasons;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['csut_id'] = this.csutId;
    data['cust_id'] = this.custId;
    data['payment'] = this.payment;
    data['membership'] = this.membership;
    data['image_status'] = this.imageStatus;
    data['video'] = this.video;
    data['video_status'] = this.videoStatus;
    data['caste_id'] = this.casteId;
    data['region_id'] = this.regionId;
    data['sub_id'] = this.subId;
    data['horoscope'] = this.horoscope;
    data['caste_status'] = this.casteStatus;
    data['religion_status'] = this.religionStatus;
    data['horo_status'] = this.horoStatus;
    data['id_proof'] = this.idProof;
    data['description'] = this.description;
    data['description_status'] = this.descriptionStatus;
    data['photos'] = this.photos;
    data['age'] = this.age;
    data['hight'] = this.hight;
    data['nakchatra'] = this.nakchatra;
    data['country'] = this.country;
    data['no_b'] = this.noB;
    data['brother_name'] = this.brotherName;
    data['note'] = this.note;
    data['origin'] = this.origin;
    data['mother_tongue'] = this.motherTongue;
    data['physical_status'] = this.physicalStatus;
    data['designation'] = this.designation;
    data['community'] = this.community;
    data['dosh'] = this.dosh;
    data['father_status'] = this.fatherStatus;
    data['mother_status'] = this.motherStatus;
    data['other_cast'] = this.otherCast;
    data['sub_cast'] = this.subCast;
    data['religion'] = this.religion;
    data['fuid'] = this.fuid;
    data['native_language'] = this.nativeLanguage;
    data['lat'] = this.lat;
    data['lang'] = this.lang;
    data['profile_status'] = this.profileStatus;
    data['online_offline'] = this.onlineOffline;
    data['request'] = this.request;
    if (this.userImgs != null) {
     // data['user_imgs'] = this.userImgs!.map((v) => v!.toJson()).toList();
    }
    return data;
  }
}


/*class UserModel {
  String? sNo;
  String? userId;
  String? name;
  String? email;
  String? countryCode;
  String? mobile;
  String? otp;
  String? gender;
  String? profileFor;
  String? password;
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
  String? shortlisted;
  String? status;
  String? critical;
  String? deviceType;
  String? deviceToken;
  String? userAvtar;
  String? endSubscriptionDate;
  String? reasons;
  String? createdAt;
  String? updatedAt;
  String? csutId;
  String? custId;
  String? payment;
  String? membership;
  String? imageStatus;
  String? video;
  String? videoStatus;
  String? casteId;
  String? regionId;
  String? subId;
  String? horoscope;
  String? casteStatus;
  String? religionStatus;
  String? horoStatus;
  String? idProof;
  String? description;
  String? descriptionStatus;
  String? photos;
  String? age;
  String? hight;
  String? nakchatra;
  String? country;
  String? noB;
  String? brotherName;
  String? note;
  String? origin;
  String? motherTongue;
  String? physicalStatus;
  String? designation;

  String? community;
  String? dosh;
  String? fatherStatus;
  String? motherStatus;
  String? religion;
  String? mystatus;
  String? fuid;
  int? request;
  List<UserImgs>? userImgs;

  UserModel(
      {this.sNo,
        this.userId,
        this.name,
        this.email,
        this.countryCode,
        this.mobile,
        this.otp,
        this.gender,
        this.profileFor,
        this.password,
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
        this.deviceType,
        this.deviceToken,
        this.userAvtar,
        this.endSubscriptionDate,
        this.reasons,
        this.createdAt,
        this.updatedAt,
        this.csutId,
        this.custId,
        this.payment,
        this.membership,
        this.imageStatus,
        this.video,
        this.videoStatus,
        this.casteId,
        this.regionId,
        this.subId,
        this.horoscope,
        this.casteStatus,
        this.religionStatus,
        this.horoStatus,
        this.idProof,
        this.description,
        this.descriptionStatus,
        this.photos,
        this.age,
        this.hight,
        this.nakchatra,
        this.country,
        this.noB,
        this.brotherName,
        this.note,
        this.origin,
        this.motherTongue,
        this.physicalStatus,
        this.designation,
        this.community,
        this.dosh,
        this.fatherStatus,
        this.motherStatus,
        this.request,
        this.fuid,
        this.userImgs,this.religion,this.mystatus});

  UserModel.fromJson(Map<String, dynamic> json) {
    sNo = json['s_no'];
    fuid = json['fuid'];
    userId = json['user_id'];
    name = json['name'];
    email = json['email'];
    countryCode = json['country_code'];
    mobile = json['mobile'];
    otp = json['otp'];
    gender = json['gender'];
    profileFor = json['profile_for'];
    password = json['password'];
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
    shortlisted = json['shortlisted'].toString();
    status = json['status'];
    critical = json['critical'];
    deviceType = json['device_type'];
    deviceToken = json['device_token'];
    userAvtar = json['user_avtar'];
    endSubscriptionDate = json['end_subscription_date'];
    reasons = json['reasons'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    csutId = json['csut_id'];
    custId = json['cust_id'];
    payment = json['payment'];
    membership = json['membership'];
    imageStatus = json['image_status'];
    video = json['video'];
    videoStatus = json['video_status'];
    casteId = json['caste_id'];
    regionId = json['region_id'];
    religion = json['religion'];
    subId = json['sub_id'];
    horoscope = json['horoscope'];
    casteStatus = json['caste_status'];
    religionStatus = json['religion_status'];
    horoStatus = json['horo_status'];
    idProof = json['id_proof'];
    description = json['description'];
    descriptionStatus = json['description_status'];
    photos = json['photos'];
    age = json['age'];
    hight = json['hight'];
    nakchatra = json['nakchatra'];
    country = json['country'];
    noB = json['no_b'];
    brotherName = json['brother_name'];
    note = json['note'];
    origin = json['origin'];
    motherTongue = json['mother_tongue'];
    physicalStatus = json['physical_status'];
    designation = json['designation'];
    community = json['community'];
    dosh = json['dosh'];
    fatherStatus = json['father_status'];
    motherStatus = json['mother_status'];
    mystatus = json['mystatus'];
    request = json['request'];
    if (json['user_imgs'] != null) {
      userImgs = <UserImgs>[];
      json['user_imgs'].forEach((v) {
        userImgs!.add(new UserImgs.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['s_no'] = this.sNo;
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['email'] = this.email;
    data['country_code'] = this.countryCode;
    data['mobile'] = this.mobile;
    data['otp'] = this.otp;
    data['gender'] = this.gender;
    data['profile_for'] = this.profileFor;
    data['password'] = this.password;
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
    data['device_type'] = this.deviceType;
    data['device_token'] = this.deviceToken;
    data['user_avtar'] = this.userAvtar;
    data['end_subscription_date'] = this.endSubscriptionDate;
    data['reasons'] = this.reasons;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['csut_id'] = this.csutId;
    data['cust_id'] = this.custId;
    data['payment'] = this.payment;
    data['membership'] = this.membership;
    data['image_status'] = this.imageStatus;
    data['video'] = this.video;
    data['video_status'] = this.videoStatus;
    data['caste_id'] = this.casteId;
    data['region_id'] = this.regionId;
    data['sub_id'] = this.subId;
    data['horoscope'] = this.horoscope;
    data['caste_status'] = this.casteStatus;
    data['religion_status'] = this.religionStatus;
    data['horo_status'] = this.horoStatus;
    data['id_proof'] = this.idProof;
    data['description'] = this.description;
    data['description_status'] = this.descriptionStatus;
    data['photos'] = this.photos;
    data['age'] = this.age;
    data['hight'] = this.hight;
    data['nakchatra'] = this.nakchatra;
    data['country'] = this.country;
    data['no_b'] = this.noB;
    data['brother_name'] = this.brotherName;
    data['note'] = this.note;
    data['origin'] = this.origin;
    data['mother_tongue'] = this.motherTongue;
    data['physical_status'] = this.physicalStatus;
    data['designation'] = this.designation;
    data['community'] = this.community;
    data['dosh'] = this.dosh;
    data['father_status'] = this.fatherStatus;
    data['mother_status'] = this.motherStatus;
    data['request'] = this.request;
    if (this.userImgs != String) {
      data['user_imgs'] = this.userImgs!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
*/

class UserImgs {
  String? mediaId;
  String? userId;
  String? image;
  String? createdAt;

  UserImgs({this.mediaId, this.userId, this.image, this.createdAt});

  UserImgs.fromJson(Map<String, dynamic> json) {
    mediaId = json['media_id'];
    userId = json['user_id'];
    image = json['image'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['media_id'] = this.mediaId;
    data['user_id'] = this.userId;
    data['image'] = this.image;
    data['created_at'] = this.createdAt;
    return data;
  }
}