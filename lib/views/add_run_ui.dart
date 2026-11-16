// ignore_for_file: sort_child_properties_last

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_run_tracker_app/models/run.dart';
import 'package:flutter_run_tracker_app/services/supabase_service.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

class AddRunUI extends StatefulWidget {
  const AddRunUI({super.key});

  @override
  State<AddRunUI> createState() => _AddRunUIState();
}

class _AddRunUIState extends State<AddRunUI> {
  // ------ โค้ดคำสั่งที่เกี่ยวกับการเปิดกล้อง หรือแกลลอรี่ -------
  Uint8List? imageBytes; // เอาไว้เก็บรูปที่จะแสดงที่ UI บนหน้าจอ
  XFile? imageFile;

  // เมธอดเปิดกล้องเพื่อถ่ายรูป
  Future<void> openGalleryAndTakePhoto() async {
    // เปิดกล้องเพื่อถ่ายรูป
    imageFile = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 80);

    // แปลงรูปที่ถ่ายเป็น Byte เพื่อแสดงที่ UI บนหน้าจอ แต่ต้องตรวจสอบก่อนว่าเขาได้ถ่ายไหม
    if (imageFile != null) {
      final bytes = await imageFile!.readAsBytes();
      setState(() {
        imageBytes = bytes;
      });
    }
  }

  // เมธอดเปิด gallery เพื่อเลือกรูปภาพ
  Future<void> openCameraAndSelectPhoto() async {
    // เปิด gallery เพื่อเลือกรูปภาพ
    imageFile = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 80);

    // แปลงรูปที่ถ่ายเป็น Byte เพื่อแสดงที่ UI บนหน้าจอ แต่ต้องตรวจสอบก่อนว่าเขาได้เลือกรูปไหม
  }
  // -------------------------------------------------

  // สร้างตัวควบคุม TextField
  TextEditingController runWhereCtrl = TextEditingController();
  TextEditingController runPersonCtrl = TextEditingController();
  TextEditingController runDistanceCtrl = TextEditingController();

  // ตัวแปรเก็บที่อยู๋รูปกรณีมีการอัปโหลดไฟล์
  String? imageUrlFromUpload = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 3, 5, 73),
        title: Text(
          'Run Tracker (เพื่ม)',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Colors.white,
          ),
        ),
      ),
      // ส่วนของ body
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 35,
            right: 35,
          ),
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.075,
                ),
                // จะใช้ Ternary Operator _______ ? _______ : _______
                imageBytes == null
                    ? InkWell(
                        // หรือใช่ GestureDetector ก็ได้
                        onTap: () {
                          // เปิดกล้องเพื่อถ่ายรูป หรือ เปิด gallery เพื่อเลือกรูปภาพ
                          openGalleryAndTakePhoto();
                        },
                        child: FaIcon(
                          FontAwesomeIcons.cameraRetro,
                          size: MediaQuery.of(context).size.width * 0.35,
                          color: Colors.grey[400],
                        ),
                      )
                    : InkWell(
                        // หรือใช่ GestureDetector ก็ได้
                        onTap: () {
                          // เปิดกล้องเพื่อถ่ายรูป หรือ เปิด gallery เพื่อเลือกรูปภาพ
                          openGalleryAndTakePhoto();
                        },
                        child: Image.memory(
                          imageBytes!,
                          width: MediaQuery.of(context).size.width * 0.35,
                          height: MediaQuery.of(context).size.width * 0.35,
                          fit: BoxFit.cover,
                        ),
                      ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.050,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'วิ่งที่ไหน',
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.045,
                    ),
                  ),
                ),
                TextField(
                  controller: runWhereCtrl,
                  decoration: InputDecoration(
                    hintText: 'เช่น สวนสาธารณะ, สนามกีฬา หรือ อื่นๆ',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey[400]!,
                        width: 2,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey[400]!,
                        width: 2,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'วิ่งกับใคร',
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.045,
                    ),
                  ),
                ),
                TextField(
                  controller: runPersonCtrl,
                  decoration: InputDecoration(
                    hintText: 'เช่น เพื่อน 3 คน, แฟน หรือ อื่นๆ',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey[400]!,
                        width: 2,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey[400]!,
                        width: 2,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'ระยะทาง',
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.045,
                    ),
                  ),
                ),
                TextField(
                  controller: runDistanceCtrl,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'เช่น 1, 5, 11 หรือ อื่นๆ',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey[400]!,
                        width: 2,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey[400]!,
                        width: 2,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.04,
                ),
                ElevatedButton(
                  onPressed: () async {
                    // ควรจะต้อง Validate ก่อนว่าป้อนครบหรือยัง (รูปไม่ถ่ายหรือเลือกก็ได้)
                    if (runWhereCtrl.text.isEmpty ||
                        runPersonCtrl.text.isEmpty ||
                        runDistanceCtrl.text.isEmpty) {
                      // แสดง SnackBar แจ้งเตือน
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('กรุณากรอกข้อมูลให้ครบ'),
                          backgroundColor: Colors.red,
                          duration: Duration(seconds: 3),
                        ),
                      );
                      return;
                    }

                    // Upload File ไปยัง Storage และบันทึกข้อมูลไปยัง DB
                    // เริ่มจาก Upload File โดยต้องตรวจสอบก่อนว่าผู้ใช้ได้เลือกรูปหรือไม่
                    if (imageFile != null) {
                      // หรือตรวจสอบจาก imageBytes ก็ได้
                      // หากไม่เท่ากับ null แปลว่ามีการ upload
                      imageUrlFromUpload =
                          await SupabaseService().uploadFile(imageFile!);
                    }

                    // เพิ่มข้อมูลลงใน table ใน DB
                    // แพ็คข้อมูล
                    Run run = Run(
                      runWhere: runWhereCtrl.text,
                      runPerson: runPersonCtrl.text,
                      runDistance: int.parse(runDistanceCtrl.text),
                      runImageUrl: imageUrlFromUpload,
                    );
                    await SupabaseService()
                        .insertRun(run); // ส่งข้อมูลไปบันทึกลง DB

                    // แสดง SnackBar แจ้งเตือนบันทึกข้อมูลเรียบร้อย
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('บันทึกข้อมูลเรียบร้อย'),
                        backgroundColor: Colors.green,
                        duration: Duration(seconds: 3),
                      ),
                    );

                    // ย้อนกลับไปยังหน้าก่อน
                    Navigator.pop(context);
                  },
                  child: Text(
                    'บันทึกข้อมูล',
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.045,
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    minimumSize: Size(
                      double.infinity,
                      MediaQuery.of(context).size.height * 0.065,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                ElevatedButton(
                  onPressed: () {
                    // ล้างข้อมูลใน TextField และล้างรูปภาพ
                    setState(() {
                      imageBytes = null;
                      imageFile = null;
                      imageUrlFromUpload = null;
                      runWhereCtrl.clear();
                      runPersonCtrl.clear();
                      runDistanceCtrl.clear();
                    });
                  },
                  child: Text(
                    'ยกเลิก',
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.045,
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    minimumSize: Size(
                      double.infinity,
                      MediaQuery.of(context).size.height * 0.065,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
