import 'dart:convert';

RecordModel recordModelFromJson(String str) => RecordModel.fromJson(json.decode(str));

String recordModelToJson(RecordModel data) => json.encode(data.toJson());

List<RecordModel> recordModelFromJsonList(String str) => List<RecordModel>.from(json.decode(str).map((x) => RecordModel.fromJson(x)));

String recordModelToJsonList(List<RecordModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RecordModel {
  String name;
  String date;
  String duration;
  String path;

  RecordModel({
    required this.name,
    required this.date,
    required this.duration,
    required this.path,
  });

  RecordModel copyWith({
    String? name,
    String? date,
    String? duration,
    String? path,
  }) =>
      RecordModel(
        name: name ?? this.name,
        date: date ?? this.date,
        duration: duration ?? this.duration,
        path: path ?? this.path,
      );

  factory RecordModel.fromJson(Map<String, dynamic> json) => RecordModel(
        name: json["name"],
        date: json["date"],
        duration: json["duration"],
        path: json["path"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "date": date,
        "duration": duration,
        "path": path,
      };
}
