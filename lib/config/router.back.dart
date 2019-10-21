// import 'package:coursetable/Model/CourseModel.dart';
// import 'package:coursetable/Model/CourseTableModel.dart';
// import 'package:coursetable/pages/Course/CourseTable/CourseInfo/CourseInfo.dart';
// import 'package:coursetable/pages/Index.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// MaterialPageRoute index(context) {
//   return MaterialPageRoute(builder: (context) {
//     return Index();
//   });
// }

// MaterialPageRoute courseInfo(context, String courseName, String courseId) {
  // final courseTableModelValue = Provider.of<CourseTableModel>(context);
  // final courseModel = Provider.of<CourseModel>(context);
//   return MaterialPageRoute(builder: (context) {
//     return MultiProvider(
//       providers: [
//         Provider<CourseModel>.value(value: courseModel),
//         Provider<CourseTableModel>.value(value: courseTableModelValue),
        
//       ],
//       child: CourseInfo(
//         name: courseName,
//         id: courseId
//       ),
//     );
//   });
// }
