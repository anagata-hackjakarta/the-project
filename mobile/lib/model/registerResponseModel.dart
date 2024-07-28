class RegisterResponseModel {
  User? user;
  String? message;

  RegisterResponseModel({this.user, this.message});

  RegisterResponseModel.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class User {
  int? id;
  String? uuid;
  String? firstName;
  String? lastName;
  String? vehicleType;
  int? vehicleYearProduction;
  int? vehicleCapacity;
  String? createdAt;
  String? updatedAt;

  User(
      {this.id,
        this.uuid,
        this.firstName,
        this.lastName,
        this.vehicleType,
        this.vehicleYearProduction,
        this.vehicleCapacity,
        this.createdAt,
        this.updatedAt});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uuid = json['uuid'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    vehicleType = json['vehicleType'];
    vehicleYearProduction = json['vehicleYearProduction'];
    vehicleCapacity = json['vehicleCapacity'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['uuid'] = this.uuid;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['vehicleType'] = this.vehicleType;
    data['vehicleYearProduction'] = this.vehicleYearProduction;
    data['vehicleCapacity'] = this.vehicleCapacity;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
