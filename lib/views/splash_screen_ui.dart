import 'package:flutter/material.dart';
import 'package:flutter_run_tracker_app/views/show_all_run_ui.dart';

class SplashScreenUI extends StatefulWidget {
  const SplashScreenUI({super.key});

  @override
  State<SplashScreenUI> createState() => _SplashScreenUIState();
}

class _SplashScreenUIState extends State<SplashScreenUI> {
  @override
  void initState() {
    // หน่วงเวลาหน้าจอ 3 วินาทีแล้วเปิดไป ShowAllRunUI แบบย้อนกลับไม่ได้
    Future.delayed(
      // เวลาที่จะหน่วง
      Duration(
        seconds: 3,
      ),
      // เมื่อครบกําหนดให้เปิดหน้า ShowAllRunUI แบบย้อนกลับไม่ได้
      () {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => ShowAllRunUI(),
            ));
      },
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 3, 5, 73),
      body: Stack(
        children: [
          // ชั้นที่ 1 ภาพlogo ชื่อแอป progress indicator
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/logo.png',
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: MediaQuery.of(context).size.width * 0.5,
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'Run Tracker',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                CircularProgressIndicator(
                  color: Colors.white,
                ),
              ],
            ),
          ),
          // ชั้นที่ 2 ข้อความด้านล่าง Copyright, Created by
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  '©️ 2026 Run Tracker. All rights reserved.',
                  style: TextStyle(
                      color: const Color.fromARGB(255, 129, 128, 128)),
                ),
                SizedBox(height: 5),
                Text(
                  'Created by: Phattharakon SAU TEAM',
                  style: TextStyle(
                      color: const Color.fromARGB(255, 129, 128, 128)),
                ),
                SizedBox(height: 50),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
