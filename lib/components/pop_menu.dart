import 'package:flutter/material.dart';

class CustomPopMenu extends StatefulWidget {
  const CustomPopMenu({Key? key}) : super(key: key);

  @override
  _CustomPopMenuState createState() => _CustomPopMenuState();
}

class _CustomPopMenuState extends State<CustomPopMenu> {
  final GlobalKey<PopupMenuButtonState<int>> _menuKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        key: _menuKey,
        itemBuilder: (context) => [
              PopupMenuItem(
                child: Text("First"),
                value: 1,
              ),
              PopupMenuItem(
                child: Text("Second"),
                value: 2,
              )
            ]);
  }
}


// PopupMenuButton(
//             elevation: 20.0,
//             color: Colors.white,
//             shape: const RoundedRectangleBorder(
//               borderRadius: BorderRadius.all(
//                 Radius.circular(11.0),
//               ),
//             ),
//             icon: const CircleAvatar(child: Icon(Icons.more_horiz)),
//             itemBuilder: (context) => [
//               PopupMenuItem(
//                   child: Container(
//                 // padding: const EdgeInsets.only(top: 50.0),
//                 width: 200.h,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
                    // const Icon(
                    //   Icons.delete,
                    //   color: Color(0xFF282828),
                    // ),
//                     Text(
//                       'Edit Post',
//                       style: TextStyle(
//                         fontFamily: 'SF Pro Text',
//                         fontStyle: FontStyle.normal,
//                         fontWeight: FontWeight.w500,
//                         fontSize: 16.sp,
//                         color: const Color(0xFF282828),
//                       ),
//                     ),
//                     const Icon(
//                       Icons.arrow_forward_ios,
//                       color: Color(0xFFBDBDBD),
//                     )
//                   ],
//                 ),
//               )),
//             ],
//           ),