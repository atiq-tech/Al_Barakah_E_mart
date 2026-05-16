import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomSectionPart extends StatelessWidget {
  const CustomSectionPart({Key? key,
    this.firstPart,
  }) : super(key: key);
  final String ?firstPart;
  @override
  Widget build(BuildContext context) {
    return Text('$firstPart',
          style: GoogleFonts.rambla(
            fontWeight: FontWeight.bold,
            fontSize: 16.sp,
            color: Colors.black,
            // fontStyle: FontStyle.italic,
          )
    );
  }
}
///==========old=========
// class CustomSectionPart extends StatelessWidget {
//   const CustomSectionPart({Key? key, this.firstPart, this.lastPart}) : super(key: key);
//   final String ?firstPart,lastPart;
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         Text(
//           '$firstPart',
//           style: const TextStyle(
//             fontWeight: FontWeight.bold,
//             fontSize: 17,
//             color: Colors.black,
//             // fontStyle: FontStyle.italic,
//           )
//           ,
//         ),
//         Text(
//           '$lastPart',
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             fontSize: 15,
//             color:Colors.redAccent[100],
//             decoration:TextDecoration.underline ,
//             decorationStyle:TextDecorationStyle.solid,
//           )
//           ,
//         ),
//       ],
//     );
//   }
// }



