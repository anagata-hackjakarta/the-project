class AnalyzeResponseModel {
  String? sensorId;
  String? tripId;
  String? uid;
  String? timestamp;
  List<Alerts>? alerts;

  AnalyzeResponseModel(
      {this.sensorId, this.tripId, this.uid, this.timestamp, this.alerts});

  AnalyzeResponseModel.fromJson(Map<String, dynamic> json) {
    sensorId = json['sensor_id'];
    tripId = json['trip_id'];
    uid = json['uid'];
    timestamp = json['timestamp'];
    if (json['alerts'] != null) {
      alerts = <Alerts>[];
      json['alerts'].forEach((v) {
        alerts!.add(new Alerts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sensor_id'] = this.sensorId;
    data['trip_id'] = this.tripId;
    data['uid'] = this.uid;
    data['timestamp'] = this.timestamp;
    if (this.alerts != null) {
      data['alerts'] = this.alerts!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Alerts {
  String? type;
  String? description;
  String? severity;
  String? suggestion;
  List<String>? feedbackType;

  Alerts(
      {this.type,
        this.description,
        this.severity,
        this.suggestion,
        this.feedbackType});

  Alerts.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    description = json['description'];
    severity = json['severity'];
    suggestion = json['suggestion'];
    feedbackType = json['feedback type'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['description'] = this.description;
    data['severity'] = this.severity;
    data['suggestion'] = this.suggestion;
    data['feedback type'] = this.feedbackType;
    return data;
  }
}
