import 'package:flutter/material.dart';
import 'package:flutter_run_tracker_app/views/splash_screen_ui.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// -------------------------------------

Future<void> main() async {
  // ----------- กำหนดค่าของ Supabase ที่จะทำงานด้วย-------------------------
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://rrzmlwmisgnblsqtbxgz.supabase.co',
    publishableKey: 'sb_publishable_TBq8CLE9cQ5MZt1pa2dBPA_xAXE3FVM',
  );
  // -------------------------------------
  runApp(
    const FlutterRunTracker(),
  );
}

class FlutterRunTracker extends StatefulWidget {
  const FlutterRunTracker({super.key});

  @override
  State<FlutterRunTracker> createState() => _FlutterRunTrackerState();
}

class _FlutterRunTrackerState extends State<FlutterRunTracker> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreenUI(),
      theme: ThemeData(
          textTheme: Theme.of(context).textTheme.apply(
                fontFamily: GoogleFonts.kanit().fontFamily,
                fontFamilyFallback: GoogleFonts.kanit().fontFamilyFallback,
              )),
    );
  }
}
