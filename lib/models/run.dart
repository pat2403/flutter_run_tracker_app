// ไฟล์ประเภทโมเดล จะใช้สำหรับแมปข้อมูลต่าง ๆ ที่จะทำงานด้วยซึ่งจะล้อกับ colum ใน table ใน DB
// รวมถึงคำสั่งแปลง JSON เป็น Object(ข้อมูลใช้ในโปรเจค) และ Object(ข้อมูลใช้ในโปรเจค) เป็น JSON ด้วย
// ignore_for_file: non_constant_identifier_names

class Run {
  // ตัวแปรที่ล้อกับ column ใน table ใน DB
  String? id;
  String? created_at;
  String? runWhere;
  String? runPerson;
  int? runDistance;
  String? runImageUrl;

  // Constructor (เอาไว้แพ็คข้อมูล)
  Run({
    this.id,
    this.created_at,
    this.runWhere,
    this.runPerson,
    this.runDistance,
    this.runImageUrl,
  });

  // คำสั่งแปลง JSON เป็น Object(ข้อมูลใช้ในโปรเจค) เรียกว่า fromJson
  factory Run.fromJson(Map<String, dynamic> json) => Run(
        id: json['id'] as String?,
        created_at: json['created_at'] as String?,
        runWhere: json['runWhere'] as String?,
        runPerson: json['runPerson'] as String?,
        runDistance: json['runDistance'] as int?,
        runImageUrl: json['runImageUrl'] as String?,
      );

  // คำสั่งแปลง Object(ข้อมูลใช้ในโปรเจค) เป็น JSON เรียกว่า toJson
  Map<String, dynamic> toJson() => {
        'runWhere': runWhere,
        'runPerson': runPerson,
        'runDistance': runDistance,
        'runImageUrl': runImageUrl,
      };
}
