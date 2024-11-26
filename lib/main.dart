// import 'package:flutter/material.dart';
// import 'package:lsh_smartshelf_3/widgets/my_custom_container.dart';
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         body: MyCustomContainer(), // my_custom_container.dart의 MyCustomContainer 호출
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:lsh_smartshelf_3/widgets/my_custom_container2.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: MyCustomContainer(), // my_custom_container.dart의 MyCustomContainer 호출
      ),
    );
  }
}
