import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pizzafooddelivery/pages/home_page.dart';
// Positioned(
// bottom: 0,
// child: Transform.rotate(
// angle: -math.pi/2,
// alignment: Alignment.topLeft,
// child: Row(
// children: [
// buildMenu("vegetables"),
// buildMenu("chicken"),
// buildMenu("beef"),
// buildMenu("Other"),
// ],
//عمل الأسماء عامودي
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.reemKufiTextTheme(
          Theme.of(context).textTheme
        )
      ),
      home: HomePage(),
    );
  }
}


