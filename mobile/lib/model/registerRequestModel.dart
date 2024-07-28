class RegisterRequestModel {
  String? uuid;
  String? firstName;
  String? lastName;
  String? vehicleType;
  int? vehicleYearProduction;
  int? vehicleCapacity;

  RegisterRequestModel(
      {this.uuid,
        this.firstName,
        this.lastName,
        this.vehicleType,
        this.vehicleYearProduction,
        this.vehicleCapacity});

  RegisterRequestModel.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    vehicleType = json['vehicleType'];
    vehicleYearProduction = json['vehicleYearProduction'];
    vehicleCapacity = json['vehicleCapacity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uuid'] = this.uuid;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['vehicleType'] = this.vehicleType;
    data['vehicleYearProduction'] = this.vehicleYearProduction;
    data['vehicleCapacity'] = this.vehicleCapacity;
    return data;
  }
}