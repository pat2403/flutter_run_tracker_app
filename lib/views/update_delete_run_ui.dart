// ignore_for_file: sort_child_properties_last

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_run_tracker_app/models/run.dart';
import 'package:flutter_run_tracker_app/services/supabase_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UpdateDeleteRunUI extends StatefulWidget {
  // สร้างตัวแปรมารับข้อมูลที่ส่งมา เพื่อเอาไปใช้กับคลาสด้านล่าง
  Run? runUDShow;

  // เอาตัวแปรที่สร้างมารับข้อมูล
  UpdateDeleteRunUI({super.key, this.runUDShow});

  @override
  State<UpdateDeleteRunUI> createState() => _UpdateDeleteRunUIState();
}

class _UpdateDeleteRunUIState extends State<UpdateDeleteRunUI> {
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
  void initState() {
    // เอาข้อมูลที่ส่งมากำหนดให้กับ widget บนหน้าจอ
    runWhereCtrl.text = widget.runUDShow!.runWhere!;
    runPersonCtrl.text = widget.runUDShow!.runPerson!;
    runDistanceCtrl.text = widget.runUDShow!.runDistance.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 3, 5, 73),
        title: Text(
          'Run Tracker (แก้ไข/ลบ)',
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
      body: Padding(
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
              // --------------------------------------------------------
              // ใช้ Ternary Operator แบบต่อเนื่อง
              imageFile !=
                      null // ได้ถ่าย-เลือกรูปหรือไม่ ถ้าถ่าย-เลือกก็แสดงรูปที่ถ่าย-เลือก
                  ? InkWell(
                      onTap: () {
                        openGalleryAndTakePhoto();
                      },
                      child: Image.memory(
                        imageBytes!,
                        width: MediaQuery.of(context).size.width * 0.35,
                        height: MediaQuery.of(context).size.width * 0.35,
                      ),
                    )
                  : widget.runUDShow!.runImageUrl != ""
                      ? InkWell(
                          onTap: () {
                            openGalleryAndTakePhoto();
                          },
                          child: Image.network(
                            widget.runUDShow!.runImageUrl!,
                            width: MediaQuery.of(context).size.width * 0.35,
                            height: MediaQuery.of(context).size.width * 0.35,
                          ),
                        )
                      : InkWell(
                          onTap: () {
                            openGalleryAndTakePhoto();
                          },
                          child: Image.asset(
                            'assets/images/logo.png',
                            width: MediaQuery.of(context).size.width * 0.35,
                            height: MediaQuery.of(context).size.width * 0.35,
                          ),
                        ),
              // --------------------------------------------------------
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
                  hintText: 'วิ่งที่ ม.เอเชีย',
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
                  hintText: 'วิ่งคนเดียว',
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
                  hintText: '2',
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
                    // ก่อน upload ต้องตรวจสอบก่อนว่ามีรูปเดิม ถ้ามีรูปเดิมต้องลบทิ้งก่อนด้วย
                    if (widget.runUDShow!.runImageUrl != "") {
                      await SupabaseService().removeFile(
                        widget.runUDShow!.runImageUrl!.split("/").last,
                      );
                    }

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
                  await SupabaseService().updateRun(
                      run, widget.runUDShow!.id!); // ส่งข้อมูลไปบันทึกลง DB

                  // แสดง SnackBar แจ้งเตือนบันทึกแก้ไขข้อมูลเรียบร้อย
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('บันทึกแก้ไขข้อมูลเรียบร้อย'),
                      backgroundColor: Colors.green,
                      duration: Duration(seconds: 3),
                    ),
                  );

                  // ย้อนกลับไปยังหน้าก่อน
                  Navigator.pop(context);
                },
                child: Text(
                  'บันทึกแก้ไขข้อมูล',
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
                onPressed: () async {
                  // ตรวจสอบก่อนว่าข้อมูลที่ลบมีรูปเดิมไหม ถ้ามีอย่าลืมลบรูปทิ้งด้วย
                  if (widget.runUDShow!.runImageUrl != "") {
                    await SupabaseService().removeFile(
                      widget.runUDShow!.runImageUrl!.split("/").last,
                    );
                  }

                  // ลบข้อมูลออกจาก Table
                  await SupabaseService().deleteRun(widget.runUDShow!.id!);

                  // แสดงข้อความแจ้งผลการทำงานด้วย SnackBar
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('ลบข้อมูลสําเร็จ'),
                      backgroundColor: Colors.green,
                      duration: Duration(seconds: 2),
                    ),
                  );

                  // กลับไปหน้าหลัก
                  Navigator.pop(context);
                },
                child: Text(
                  'ลบข้อมูล',
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
    );
  }
}
