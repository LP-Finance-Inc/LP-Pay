// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:flutter_vector_icons/flutter_vector_icons.dart';
// import 'package:community_material_icon/community_material_icon.dart';
// import 'package:auto_size_text/auto_size_text.dart';
// import 'package:lp_finance/Screens/withdraw_ecrypto.dart';
// import 'package:lp_finance/modules/tabsview/tabs_view.dart';


// class WithdrawalAddress extends StatelessWidget {
//   const WithdrawalAddress({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Theme.of(context).backgroundColor,
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Container(
//               padding: EdgeInsets.only(
//                 top: 40,
//                 left: 10,
//                 bottom: 20,
//                 right: 10,
//               ),
//               width: MediaQuery.of(context).size.width,
//               height: 100,
//               decoration: BoxDecoration(
//                 color: Theme.of(context).backgroundColor,
//               ),
//               // height: ,
//               child: ListTile(
//                 leading: GestureDetector(
//                   onTap: () {
//                     Get.to(TabsView());
//                   },
//                   child: Icon(
//                     Icons.arrow_back_ios,
//                     color: Colors.white,
//                   ),
//                 ),
//                 title: Text(
//                   'Withdraw',
//                   style: TextStyle(
//                     color: Colors.white,
//                   ),
//                 ),
//                 trailing: Icon(
//                   Icons.refresh,
//                   color: Colors.white,
//                 ),
//               ),
//               // Row(
//               //   mainAxisAlignment: MainAxisAlignment.start,
//               //   children: [
//               //     Icon(
//               //       Icons.arrow_back_ios,
//               //       color: Colors.white,
//               //     ),
//               //     SizedBox(
//               //       width: 50,
//               //     ),
//               //     Text(
//               //       'Withdraw',
//               //       style: TextStyle(
//               //         color: Colors.white,
//               //       ),
//               //     ),
//               //   ],
//               // ),
//             ),
//             Container(
//               // padding: EdgeInsets.all(15),
//               width: MediaQuery.of(context).size.width,
//               height: MediaQuery.of(context).size.height - 100,
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 // borderRadius: BorderRadius.only(
//                 //   topLeft: Radius.circular(30),
//                 //   topRight: Radius.circular(30),
//                 // ),
//               ),
//               child: SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     Row(
//                       children: [
//                         Container(
//                           decoration: BoxDecoration(
//                             color: Theme.of(context).primaryColor,
//                           ),
//                           child: Container(
//                             height: 50,
//                             width: MediaQuery.of(context).size.width * 0.5,
//                             padding: EdgeInsets.all(15),
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.only(
//                                 // topLeft: Radius.circular(30),
//                                 topRight: Radius.circular(30),
//                               ),
//                             ),
//                             child: Text(
//                               'Address',
//                               textAlign: TextAlign.center,
//                               style: TextStyle(
//                                 color: Theme.of(context).primaryColor,
//                               ),
//                             ),
//                           ),
//                         ),
//                         Container(
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                           ),
//                           child: Container(
//                             height: 50,
//                             width: MediaQuery.of(context).size.width * 0.5,
//                             padding: EdgeInsets.all(15),
//                             decoration: BoxDecoration(
//                               color: Theme.of(context).primaryColor,
//                               borderRadius: BorderRadius.only(
//                                 bottomLeft: Radius.circular(30),
//                                 topLeft: Radius.circular(-30),
//                               ),
//                             ),
//                             child: InkWell(
//                               onTap: () {
//                                 Get.toNamed('/withdrawecrypto');
//                               },
//                               child: Text(
//                                 'e - Crypto',
//                                 textAlign: TextAlign.center,
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(15.0),
//                       child: Column(
//                         children: [
//                           SizedBox(
//                             height: 50,
//                           ),
//                           Align(
//                             alignment: Alignment.centerLeft,
//                             child: Text(
//                               'Asset',
//                               textAlign: TextAlign.start,
//                               style: TextStyle(
//                                 color: Colors.black45,
//                               ),
//                             ),
//                           ),
//                           SizedBox(
//                             height: 10,
//                           ),
//                           Container(
//                             // margin: EdgeInsets.only(left: 15, right: 15),
//                             padding: EdgeInsets.only(left: 20, right: 20),
//                             width: MediaQuery.of(context).size.width,
//                             height: 50,
//                             decoration: BoxDecoration(
//                                 color: Theme.of(context)
//                                     .primaryColor
//                                     .withOpacity(0.15),
//                                 borderRadius: BorderRadius.circular(20)),
//                             child: DropdownButton(
//                               isExpanded: true, //Add this property
//                               items: <DropdownMenuItem<dynamic>>[
//                                 DropdownMenuItem(
//                                   child: Row(
//                                     // mainAxisAlignment: MainAxisAlignment.,
//                                     children: [
//                                       Icon(
//                                         CommunityMaterialIcons.bitcoin,
//                                         color: Colors.yellow[700],
//                                         size: 40,
//                                       ),
//                                       SizedBox(
//                                         width: 15,
//                                       ),
//                                       Text(
//                                         'BTC',
//                                         style: TextStyle(
//                                             fontWeight: FontWeight.bold,
//                                             // fontSize: 14,
//                                             color:
//                                                 Theme.of(context).primaryColor),
//                                       )
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           SizedBox(
//                             height: 20,
//                           ),
//                           Container(
//                             // margin: EdgeInsets.only(left: 15, right: 15),
//                             padding: EdgeInsets.only(
//                                 left: 20, right: 20, top: 20, bottom: 20),
//                             width: MediaQuery.of(context).size.width,
//                             height: 200,
//                             decoration: BoxDecoration(
//                                 color: Theme.of(context)
//                                     .primaryColor
//                                     .withOpacity(0.15),
//                                 borderRadius: BorderRadius.circular(20)),
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               children: [
//                                 AutoSizeText(
//                                   'You can withdraw up to BTC 8772.384568',
//                                   presetFontSizes: [18, 20],
//                                   style: TextStyle(
//                                       fontWeight: FontWeight.bold,
//                                       // fontSize: 14,
//                                       color: Theme.of(context).primaryColor),
//                                 ),
//                                 SizedBox(
//                                   height: 10,
//                                 ),
//                                 AutoSizeText(
//                                   'You can only withdraw asset from the savings wallet',
//                                   textAlign: TextAlign.center,
//                                   presetFontSizes: [18, 20],
//                                   style: TextStyle(
//                                       // fontWeight: FontWeight.bold,
//                                       // fontSize: 14,
//                                       color: Theme.of(context).primaryColor),
//                                 ),
//                                 AutoSizeText(
//                                   'Go to Manage wallets if you want to transfer assets before the withdrawal',
//                                   textAlign: TextAlign.center,
//                                   presetFontSizes: [18, 20],
//                                   style: TextStyle(
//                                       // fontWeight: FontWeight.bold,
//                                       // fontSize: 14,
//                                       color: Theme.of(context).primaryColor),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           SizedBox(
//                             height: 20,
//                           ),
//                           Align(
//                             alignment: Alignment.centerLeft,
//                             child: Text(
//                               'Withdrawal Address',
//                               textAlign: TextAlign.start,
//                               style: TextStyle(
//                                 color: Colors.black45,
//                               ),
//                             ),
//                           ),
//                           SizedBox(
//                             height: 10,
//                           ),
//                           Container(
//                             // margin: EdgeInsets.only(left: 15, right: 15),
//                             padding: EdgeInsets.only(left: 20, right: 20),
//                             width: MediaQuery.of(context).size.width,
//                             alignment: Alignment.bottomCenter,
//                             height: 50,
//                             decoration: BoxDecoration(
//                                 color: Theme.of(context)
//                                     .primaryColor
//                                     .withOpacity(0.15),
//                                 borderRadius: BorderRadius.circular(20)),
//                             child: TextFormField(
//                               decoration: InputDecoration(
//                                 hintStyle: TextStyle(
//                                   fontSize: 14,
//                                   color: Color(0xff2C3D57).withOpacity(0.46),
//                                 ),
//                                 border: InputBorder.none,
//                                 focusedBorder: InputBorder.none,
//                                 enabledBorder: InputBorder.none,
//                                 errorBorder: InputBorder.none,
//                                 disabledBorder: InputBorder.none,
//                                 contentPadding: EdgeInsets.all(10),
//                                 suffixIcon: Icon(
//                                   CommunityMaterialIcons.qrcode,
//                                   color: Theme.of(context).primaryColor,
//                                 ),
//                               ),
//                               keyboardType: TextInputType.text,
//                             ),
//                           ),
//                           SizedBox(
//                             height: 20,
//                           ),
//                           Align(
//                             alignment: Alignment.centerLeft,
//                             child: Text(
//                               'Destination Tag',
//                               textAlign: TextAlign.start,
//                               style: TextStyle(
//                                 color: Colors.black45,
//                               ),
//                             ),
//                           ),
//                           SizedBox(
//                             height: 10,
//                           ),
//                           Container(
//                             // margin: EdgeInsets.only(left: 15, right: 15),
//                             padding: EdgeInsets.only(left: 20, right: 20),
//                             width: MediaQuery.of(context).size.width,
//                             alignment: Alignment.bottomCenter,
//                             height: 50,
//                             decoration: BoxDecoration(
//                                 color: Theme.of(context)
//                                     .primaryColor
//                                     .withOpacity(0.15),
//                                 borderRadius: BorderRadius.circular(20)),
//                             child: TextFormField(
//                               decoration: InputDecoration(
//                                 hintText: '(optional)',
//                                 hintStyle: TextStyle(
//                                   fontSize: 14,
//                                   color: Color(0xff2C3D57).withOpacity(0.46),
//                                 ),
//                                 border: InputBorder.none,
//                                 focusedBorder: InputBorder.none,
//                                 enabledBorder: InputBorder.none,
//                                 errorBorder: InputBorder.none,
//                                 disabledBorder: InputBorder.none,
//                                 contentPadding: EdgeInsets.all(10),
//                               ),
//                               keyboardType: TextInputType.text,
//                             ),
//                           ),
//                           SizedBox(
//                             height: 20,
//                           ),
//                           Align(
//                             alignment: Alignment.centerLeft,
//                             child: Text(
//                               'Withdrawal Amount',
//                               textAlign: TextAlign.start,
//                               style: TextStyle(
//                                 color: Colors.black45,
//                               ),
//                             ),
//                           ),
//                           SizedBox(
//                             height: 10,
//                           ),
//                           Container(
//                             // margin: EdgeInsets.only(left: 15, right: 15),
//                             padding: EdgeInsets.only(left: 5, right: 5),
//                             width: MediaQuery.of(context).size.width,
//                             alignment: Alignment.bottomCenter,
//                             height: 50,
//                             decoration: BoxDecoration(
//                                 color: Theme.of(context)
//                                     .primaryColor
//                                     .withOpacity(0.15),
//                                 borderRadius: BorderRadius.circular(20)),
//                             child: TextFormField(
//                               decoration: InputDecoration(
//                                 hintText: '0.0020 - 50 \t Max',
//                                 hintStyle: TextStyle(
//                                   fontStyle: FontStyle.italic,
//                                   fontSize: 14,
//                                   color: Color(0xff2C3D57).withOpacity(0.46),
//                                 ),
//                                 border: InputBorder.none,
//                                 focusedBorder: InputBorder.none,
//                                 enabledBorder: InputBorder.none,
//                                 errorBorder: InputBorder.none,
//                                 disabledBorder: InputBorder.none,
//                                 contentPadding: EdgeInsets.all(10),
//                                 prefixIcon: Icon(CommunityMaterialIcons.bitcoin,
//                                     size: 30, color: Colors.yellow[700]),
//                                 // suffixIcon: Text(
//                                 //   'Max',
//                                 //   textAlign: TextAlign.center,
//                                 //   style: TextStyle(
//                                 //     fontStyle: FontStyle.italic,
//                                 //     fontSize: 14,
//                                 //     color: Color(0xff2C3D57).withOpacity(0.46),
//                                 //   ),
//                                 // ),
//                               ),
//                               keyboardType: TextInputType.text,
//                             ),
//                           ),
//                           SizedBox(
//                             height: 40,
//                           ),
//                           Container(
//                             padding: EdgeInsets.all(5),
//                             margin: EdgeInsets.only(
//                               right: 10,
//                               left: 10,
//                               bottom: 10,
//                               top: 20,
//                             ),
//                             width: MediaQuery.of(context).size.width,
//                             child: TextButton(
//                               onPressed: () {
//                                 // Get.toNamed('/withdraw');
//                               },
//                               child: Text(
//                                 'Send'.toUpperCase(),
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 14,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ),
//                             decoration: BoxDecoration(
//                                 color: Theme.of(context).primaryColor,
//                                 borderRadius: BorderRadius.circular(20)),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget currency() {
//     return Container(
//       height: 40,
//       width: 40,
//       decoration: BoxDecoration(
//           color: Colors.yellow[700], borderRadius: BorderRadius.circular(50)),
//       child:
//           Icon(MaterialCommunityIcons.bitcoin, color: Colors.white, size: 30),
//     );
//   }
// }
