// import 'package:flutter/material.dart';
// import 'package:gap/gap.dart';
// import 'package:orsolum_delivery/constant/asset_const.dart';
// import 'package:orsolum_delivery/constant/color_const.dart';
// import 'package:phosphor_flutter/phosphor_flutter.dart';
//
// class ChatScreen extends StatelessWidget {
//   const ChatScreen({super.key});
//
//   final bool isChatEmpty = true;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Chat with Customer"),
//         centerTitle: true,
//         actionsPadding: EdgeInsets.only(right: 16),
//         actions: [IconButton(onPressed: () {}, icon: Icon(Icons.call))],
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: Container(
//               decoration: BoxDecoration(
//                 image: DecorationImage(
//                   image: AssetImage(AssetConst.chatBackground),
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//           ),
//
//           Container(
//             height: 90,
//             width: double.infinity,
//             decoration: BoxDecoration(
//               color: Colors.white,
//               border: Border(top: BorderSide(color: ColorConst.neutralShade10)),
//             ),
//             alignment: Alignment.center,
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16.0),
//               child: Row(
//                 children: [
//                   Icon(Icons.camera_alt),
//                   const Gap(14),
//                   Icon(Icons.attach_file),
//                   const Gap(14),
//                   Expanded(
//                     child: Theme(
//                       data: ThemeData(
//                         inputDecorationTheme: InputDecorationTheme(
//                           border: InputBorder.none,
//                           filled: true,
//                           fillColor: ColorConst.grey100,
//                         ),
//                       ),
//                       child: TextField(
//                         decoration: InputDecoration(
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(30.0),
//                             borderSide: BorderSide.none,
//                           ),
//                           contentPadding: EdgeInsets.symmetric(
//                             horizontal: 16.0,
//                             vertical: 12.0,
//                           ),
//                           hintText: "Type your message",
//                           hintStyle: TextStyle(
//                             color: ColorConst.neutralShade40,
//                           ),
//                           filled: true,
//                           fillColor: ColorConst.grey100,
//                         ),
//                       ),
//                     ),
//                   ),
//                   const Gap(14),
//                   Icon(PhosphorIconsFill.paperPlaneRight),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:orsolum_delivery/constant/asset_const.dart';
import 'package:orsolum_delivery/constant/color_const.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  final bool isChatEmpty = true;

  Widget _buildQuickReplyButton(String text) {
    return Container(
      height: 45,
      width: 280,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(8),
          bottomLeft: Radius.circular(8),
          bottomRight: Radius.circular(8),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            color: Colors.black87,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chat with Customer"),
        centerTitle: true,
        actionsPadding: const EdgeInsets.only(right: 16),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.call))],
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AssetConst.chatBackground),
                  fit: BoxFit.cover,
                ),
              ),
              child:
                  isChatEmpty
                      ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(height: 40),
                            // Logo
                            Image.asset(
                              'assets/logo/orsolum_text_logo.png',
                              width: 120,
                              height: 120,
                              fit: BoxFit.contain,
                            ),

                            const SizedBox(height: 30),

                            // Welcome text
                            Text(
                              "Welcome to Orsolum",
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const SizedBox(height: 15),

                            // Description text
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 40,
                              ),
                              child: Text(
                                "Chat with your customer\nabout delivery details and location updates",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  height: 1.4,
                                ),
                              ),
                            ),

                            const SizedBox(height: 40),

                            // Quick reply buttons
                            _buildQuickReplyButton("I'm nearby your location"),
                            const SizedBox(height: 12),
                            _buildQuickReplyButton(
                              "Please confirm your address",
                            ),
                            const SizedBox(height: 12),
                            _buildQuickReplyButton(
                              "I'll be there in 10 minutes",
                            ),

                            const SizedBox(height: 40),
                          ],
                        ),
                      )
                      : ListView(
                        padding: const EdgeInsets.all(16),
                        children: const [],
                      ),
            ),
          ),

          Container(
            height: 90,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(top: BorderSide(color: ColorConst.neutralShade10)),
            ),
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  const Icon(Icons.camera_alt),
                  const Gap(14),
                  const Icon(Icons.attach_file),
                  const Gap(14),
                  Expanded(
                    child: Theme(
                      data: ThemeData(
                        inputDecorationTheme: InputDecorationTheme(
                          border: InputBorder.none,
                          filled: true,
                          fillColor: ColorConst.grey100,
                        ),
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16.0,
                            vertical: 12.0,
                          ),
                          hintText: "Type your message",
                          hintStyle: TextStyle(
                            color: ColorConst.neutralShade40,
                          ),
                          filled: true,
                          fillColor: ColorConst.grey100,
                        ),
                      ),
                    ),
                  ),
                  const Gap(14),
                  const Icon(PhosphorIconsFill.paperPlaneRight),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
