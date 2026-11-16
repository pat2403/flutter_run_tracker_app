// ไฟล์ประเภท service จะใช้สำหรับคำสั่งการทำงานต่างๆ
import 'package:flutter_run_tracker_app/models/run.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  // *** สำคัญต้องสร้าง instance/object/ตัวแทนเพื่อที่จะใช้ทำงานกับ Supabase
  final supabase = Supabase.instance.client;

  // ------ ต่อจากนี้ไป ก็จะเป็นเมธอดคำสั่งการทำงานต่างๆ กับ Supabase เช่น เพิ่ม ลบ แก้ไข ดูข้อมูลใน table ใน DB, upload ไฟล์
  // ------ คำสั่ง upload ไฟล์ไปยัง bucket ใน storage
  Future<String> uploadFile(XFile xfile) async {
    // ก่อนอัปโหลดเปลี่ยนชื่อไฟล์ใหม่ก่อนจะได้ไม่ซ้ำ
    final newFileName =
        '${DateTime.now().millisecondsSinceEpoch}_${xfile.name}';

    // upload ไฟล์
    await supabase.storage.from('run_bk').uploadBinary(
          newFileName,
          await xfile.readAsBytes(),
          fileOptions: FileOptions(contentType: xfile.mimeType),
        );

    // หลังจากอัปโหลดเสร็จ ให้ดึงที่อยู่ของไฟล์ที่อัปโหลดไปกลับมาใช้งาน
    return supabase.storage.from('run_bk').getPublicUrl(newFileName);
  }

  // ------ คำสั่ง บันทึกข้อมูลลงใน table ใน DB
  Future<void> insertRun(Run run) async {
    await supabase.from('run_tb').insert(run.toJson());
  }

  // ------ คำสั่ง ดึงข้อมูลจาก table ใน DB

  // ------ คำสั่ง บันทึกแก้ไขข้อมูลลงใน table ใน DB

  // ------ คำสั่ง ลบข้อมูลออกจาก table ใน DB
}
