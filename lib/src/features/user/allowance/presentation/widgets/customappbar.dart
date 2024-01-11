import 'package:flutter/material.dart';
import 'package:iconamoon/iconamoon.dart';
import 'package:page_transition/page_transition.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  // final Icon icon;
  // final Widget page;
  final String image;
  final String title;
  final double height;
  // final TabController tabController;
  // final List<Widget>? tabs;
  const CustomAppBar({
    super.key,
    // required this.icon,
    // required this.page,
    required this.image,
    required this.title,
    this.height = 170,
    // this.tabs,
  });
  @override
  Widget build(BuildContext context) {
    return AppBar(
      // backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(60),
        ),
      ),
      leading: Container(
        // color: Colors.amber,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        alignment: Alignment.topLeft,
        child: GestureDetector(
          onTap: () {
            Navigator.pop(
              context,
            );
          },
          child: const Icon(
            IconaMoon.arrowLeft2,
            size: 40,
          ),
        ),
      ),

      // ),

      leadingWidth: 100, // default is 56
      automaticallyImplyLeading: false,
      flexibleSpace: Stack(
        children: [
          Image.asset(
            "assets/images/$image",
            // repeat: ImageRepeat.noRepeat,
            fit: BoxFit.fill,
            width: double.infinity,
          ),
          Positioned(
              top: 140,
              left: 30,
              child: Text(
                title,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ))
        ],

        // background:
        // title: Text('mds'),
      ),
      // foregroundColor: Colors.amber,
      // forceMaterialTransparency: false,
      excludeHeaderSemantics: false,
      toolbarHeight: height,
      // bottom: tabs != null
      //     ? PreferredSize(
      //         preferredSize: Size.fromHeight(
      //             height), // Provide the height of the AppBar here
      //         child:
      //             // padding: const EdgeInsets.all(30.0),
      //             Column(
      //           children: [
      //             Align(
      //               alignment: Alignment.bottomRight,
      //               child: InkWell(
      //                 borderRadius: BorderRadius.circular(30.0),
      //                 onTap: () {
      //                   // Navigator.push(
      //                   //   context,
      //                   //   PageTransition(
      //                   //     duration: Durations.medium1,
      //                   //     type: PageTransitionType.rightToLeft,
      //                   //     child: const MedicalBefitsAddList(),
      //                   //   ),
      //                   // );
      //                 },
      //                 child: Container(
      //                   // color: Colors.amber,
      //                   decoration: BoxDecoration(
      //                     color: Color(0xffff99ca),
      //                     borderRadius: BorderRadius.circular(30.0),
      //                   ),
      //                   padding: EdgeInsets.symmetric(
      //                       horizontal:
      //                           MediaQuery.of(context).devicePixelRatio * 6,
      //                       vertical:
      //                           MediaQuery.of(context).devicePixelRatio * 3),
      //                   // shape: Border.all(width: 2),
      //                   // onPressed: () => {},
      //                   // fillColor: ,
      //                   child: Text(
      //                     '+ เพิ่มรายการ',
      //                     style: TextStyle(color: Colors.white),
      //                   ),
      //                 ),
      //               ),
      //             ),
      //             TabBar(
      //               tabs: tabs!,
      //               isScrollable: true,
      //             ),
      //           ],
      //           // ),
      //         ),
      //       )
      //     : null,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
