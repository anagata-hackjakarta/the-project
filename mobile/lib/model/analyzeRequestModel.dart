class AnalyzeRequestModel {
  String? sensorId;
  String? tripId;
  String? uid;
  String? timestamp;
  Location? location;
  Speed? speed;
  Accelerometer? accelerometer;
  Gyroscope? gyroscope;
  LaneChange? laneChange;
  Turning? turning;
  Deceleration? deceleration;

  AnalyzeRequestModel(
      {this.sensorId,
        this.tripId,
        this.uid,
        this.timestamp,
        this.location,
        this.speed,
        this.accelerometer,
        this.gyroscope,
        this.laneChange,
        this.turning,
        this.deceleration});

  AnalyzeRequestModel.fromJson(Map<String, dynamic> json) {
    sensorId = json['sensor_id'];
    tripId = json['trip_id'];
    uid = json['uid'];
    timestamp = json['timestamp'];
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
    speed = json['speed'] != null ? new Speed.fromJson(json['speed']) : null;
    accelerometer = json['accelerometer'] != null
        ? new Accelerometer.fromJson(json['accelerometer'])
        : null;
    gyroscope = json['gyroscope'] != null
        ? new Gyroscope.fromJson(json['gyroscope'])
        : null;
    laneChange = json['lane_change'] != null
        ? new LaneChange.fromJson(json['lane_change'])
        : null;
    turning =
    json['turning'] != null ? new Turning.fromJson(json['turning']) : null;
    deceleration = json['deceleration'] != null
        ? new Deceleration.fromJson(json['deceleration'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sensor_id'] = this.sensorId;
    data['trip_id'] = this.tripId;
    data['uid'] = this.uid;
    data['timestamp'] = this.timestamp;
    if (this.location != null) {
      data['location'] = this.location!.toJson();
    }
    if (this.speed != null) {
      data['speed'] = this.speed!.toJson();
    }
    if (this.accelerometer != null) {
      data['accelerometer'] = this.accelerometer!.toJson();
    }
    if (this.gyroscope != null) {
      data['gyroscope'] = this.gyroscope!.toJson();
    }
    if (this.laneChange != null) {
      data['lane_change'] = this.laneChange!.toJson();
    }
    if (this.turning != null) {
      data['turning'] = this.turning!.toJson();
    }
    if (this.deceleration != null) {
      data['deceleration'] = this.deceleration!.toJson();
    }
    return data;
  }
}

class Location {
  double? lat;
  double? lon;

  Location({this.lat, this.lon});

  Location.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lon = json['lon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lat'] = this.lat;
    data['lon'] = this.lon;
    return data;
  }
}

class Speed {
  int? current;

  Speed({this.current});

  Speed.fromJson(Map<String, dynamic> json) {
    current = json['current'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current'] = this.current;
    return data;
  }
}

class Accelerometer {
  double? x;
  double? y;
  double? z;

  Accelerometer({this.x, this.y, this.z});

  Accelerometer.fromJson(Map<String, dynamic> json) {
    x = json['x'];
    y = json['y'];
    z = json['z'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['x'] = this.x;
    data['y'] = this.y;
    data['z'] = this.z;
    return data;
  }
}

class Gyroscope {
  double? roll;
  double? pitch;
  double? yaw;

  Gyroscope({this.roll, this.pitch, this.yaw});

  Gyroscope.fromJson(Map<String, dynamic> json) {
    roll = json['roll'];
    pitch = json['pitch'];
    yaw = json['yaw'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['roll'] = this.roll;
    data['pitch'] = this.pitch;
    data['yaw'] = this.yaw;
    return data;
  }
}

class LaneChange {
  int? count;

  LaneChange({this.count});

  LaneChange.fromJson(Map<String, dynamic> json) {
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    return data;
  }
}

class Turning {
  int? leftTurns;
  int? rightTurns;

  Turning({this.leftTurns, this.rightTurns});

  Turning.fromJson(Map<String, dynamic> json) {
    leftTurns = json['left_turns'];
    rightTurns = json['right_turns'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['left_turns'] = this.leftTurns;
    data['right_turns'] = this.rightTurns;
    return data;
  }
}

class Deceleration {
  int? count;
  double? averageDeceleration;

  Deceleration({this.count, this.averageDeceleration});

  Deceleration.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    averageDeceleration = json['average_deceleration'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    data['average_deceleration'] = this.averageDeceleration;
    return data;
  }
}
