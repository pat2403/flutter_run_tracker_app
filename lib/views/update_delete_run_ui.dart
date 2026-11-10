// ignore_for_file: sort_child_properties_last

import 'package:flutter/material.dart';

class UpdateDeleteRunUI extends StatefulWidget {
  const UpdateDeleteRunUI({super.key});

  @override
  State<UpdateDeleteRunUI> createState() => _UpdateDeleteRunUIState();
}

class _UpdateDeleteRunUIState extends State<UpdateDeleteRunUI> {
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
              Image.asset(
                'assets/images/logo.png',
                width: MediaQuery.of(context).size.width * 0.35,
                height: MediaQuery.of(context).size.width * 0.35,
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
                onPressed: () {},
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
                onPressed: () {},
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
