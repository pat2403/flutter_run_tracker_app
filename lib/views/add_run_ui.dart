// ignore_for_file: sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AddRunUI extends StatefulWidget {
  const AddRunUI({super.key});

  @override
  State<AddRunUI> createState() => _AddRunUIState();
}

class _AddRunUIState extends State<AddRunUI> {
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
              FaIcon(
                FontAwesomeIcons.cameraRetro,
                size: MediaQuery.of(context).size.width * 0.35,
                color: Colors.grey[400],
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
                onPressed: () {},
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
                onPressed: () {},
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
    );
  }
}
