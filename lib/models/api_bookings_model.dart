class ApiBookingsModel {
  String? message;
  List<Data>? data;

  ApiBookingsModel({this.message, this.data});

  ApiBookingsModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  int? roomsId;
  String? roomName;
  int? categoriesId;
  String? categoryName;
  String? categoryRemarks;
  String? nik;
  String? userName;
  String? division;
  String? requestDate;
  String? requiredDate;
  String? timeStart;
  String? timeEnd;
  List<String>? participants;
  List<Facilities>? facilities;
  List<FacilitiesOther>? facilitiesOther;
  String? description;
  int? isApproved;
  String? usersIdApprover;
  String? usernameApprover;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
        this.roomsId,
        this.roomName,
        this.categoriesId,
        this.categoryName,
        this.categoryRemarks,
        this.nik,
        this.userName,
        this.division,
        this.requestDate,
        this.requiredDate,
        this.timeStart,
        this.timeEnd,
        this.participants,
        this.facilities,
        this.facilitiesOther,
        this.description,
        this.isApproved,
        this.usersIdApprover,
        this.usernameApprover,
        this.createdAt,
        this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    roomsId = json['rooms_id'];
    roomName = json['room_name'];
    categoriesId = json['categories_id'];
    categoryName = json['category_name'];
    categoryRemarks = json['category_remarks'];
    nik = json['nik'];
    userName = json['user_name'];
    division = json['division'];
    requestDate = json['request_date'];
    requiredDate = json['required_date'];
    timeStart = json['time_start'];
    timeEnd = json['time_end'];
    participants = json['participants'].cast<String>();
    if (json['facilities'] != null) {
      facilities = <Facilities>[];
      json['facilities'].forEach((v) {
        facilities!.add(new Facilities.fromJson(v));
      });
    }
    if (json['facilities_other'] != null) {
      facilitiesOther = <FacilitiesOther>[];
      json['facilities_other'].forEach((v) {
        facilitiesOther!.add(new FacilitiesOther.fromJson(v));
      });
    }
    description = json['description'];
    isApproved = json['is_approved'];
    usersIdApprover = json['users_id_approver'];
    usernameApprover = json['username_approver'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['rooms_id'] = this.roomsId;
    data['room_name'] = this.roomName;
    data['categories_id'] = this.categoriesId;
    data['category_name'] = this.categoryName;
    data['category_remarks'] = this.categoryRemarks;
    data['nik'] = this.nik;
    data['user_name'] = this.userName;
    data['division'] = this.division;
    data['request_date'] = this.requestDate;
    data['required_date'] = this.requiredDate;
    data['time_start'] = this.timeStart;
    data['time_end'] = this.timeEnd;
    data['participants'] = this.participants;
    if (this.facilities != null) {
      data['facilities'] = this.facilities!.map((v) => v.toJson()).toList();
    }
    if (this.facilitiesOther != null) {
      data['facilities_other'] =
          this.facilitiesOther!.map((v) => v.toJson()).toList();
    }
    data['description'] = this.description;
    data['is_approved'] = this.isApproved;
    data['users_id_approver'] = this.usersIdApprover;
    data['username_approver'] = this.usernameApprover;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Facilities {
  int? id;
  String? name;

  Facilities({this.id, this.name});

  Facilities.fromJson(Map<String, dynamic> json) {
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

class FacilitiesOther {
  int? id;
  String? name;

  FacilitiesOther({this.id, this.name});

  FacilitiesOther.fromJson(Map<String, dynamic> json) {
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
