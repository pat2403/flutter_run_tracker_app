// ignore_for_file: sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:flutter_run_tracker_app/models/run.dart';
import 'package:flutter_run_tracker_app/services/supabase_service.dart';
import 'package:flutter_run_tracker_app/views/add_run_ui.dart';
import 'package:flutter_run_tracker_app/views/update_delete_run_ui.dart';

class ShowAllRunUI extends StatefulWidget {
  const ShowAllRunUI({super.key});

  @override
  State<ShowAllRunUI> createState() => _ShowAllRunUIState();
}

class _ShowAllRunUIState extends State<ShowAllRunUI> {
  // สร้างตัวแปรเก็บข้อมูลที่ดึงมาจาก Supabase
  List<Run>? runData;

  // สร้างคำสั่งเรียกใช้เมธอดดึงข้อมูลจาก SupabaseService()
  Future<void> fetchRunData() async {
    final data = await SupabaseService().getAllRuns();

    setState(() {
      runData = data;
    }); // ใช้ setState เพื่อให้ UI อัปเดตตามข้อมูลใหม่
  }

  @override
  void initState() {
    fetchRunData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ส่วนของ AppBar
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 3, 5, 73),
        title: Text(
          'Run Tracker',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      // ส่วนของ floatingActionButton
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // เปิดไปหน้า AddRunUI แบบย้อนกลับได้
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddRunUI(),
            ),
          );

          // พอเปิดย้อนกลับมาให้เรียก fetchRunData() ให้ทำงานอีกครั้ง เพื่อไปดึงข้อมูลล่าสุดมา
          fetchRunData();
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Color.fromARGB(255, 3, 5, 73),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

      // ส่วนของ body
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Center(
          child: Column(
            children: [
              Image.asset(
                'assets/images/logo.png',
                width: MediaQuery.of(context).size.width * 0.5,
                height: MediaQuery.of(context).size.width * 0.5,
              ),
              Text(
                'วิ่งกันเถอะ',
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.07,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // แสดงข่อมูลที่ดึงมาจาก Supabase
              Expanded(
                child: ListView.separated(
                    itemCount: runData?.length ?? 0,
                    separatorBuilder: (context, index) => Divider(),
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () async {
                          // เปิดไปหน้า UpdateDeleteRunUI แบบย้อนกลับได้
                          // และตอนย้อนกลับมาอย่าลืมไปดึงข้อมูลมาใหม่
                          // เปิดไปแล้วอย่าลืมส่งข้อมูลของรายการนั้นไปด้วย
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UpdateDeleteRunUI(
                                runUDShow: runData![index],
                              ),
                            ),
                          );

                          // เมื่อย้อนกลับมาแล้วไปดึงข้อมูลมาใหม่
                          fetchRunData();
                        },
                        title: Text(
                          // runData![index].runWhere!,
                          'วิ่งที่ไหน: ${runData![index].runWhere}',
                        ),
                        subtitle: Text(
                          'วิ่งไปเท่าไหร่: ${runData![index].runDistance} กม.',
                        ),
                        trailing: Icon(
                          Icons.info,
                          color: Colors.red,
                        ),
                        leading: runData![index].runImageUrl! == ""
                            ? Image.asset(
                                'assets/images/logo.png',
                                width: 50,
                                height: 50,
                                fit: BoxFit.cover,
                              )
                            : Image.network(
                                runData![index].runImageUrl!,
                                width: 50,
                                height: 50,
                                fit: BoxFit.cover,
                              ),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
