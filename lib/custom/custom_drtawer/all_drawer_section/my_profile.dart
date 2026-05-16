import 'package:al_barakah_e_mart/provider/token_provider/token_provider.dart';
import 'package:al_barakah_e_mart/provider/user_profile_provider.dart';
import 'package:al_barakah_e_mart/utils/all_textstyle.dart';
import 'package:al_barakah_e_mart/utils/constants.dart';
import 'package:al_barakah_e_mart/utils/custom_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  TextEditingController couponController = TextEditingController();
  final TextEditingController _AddressController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<TokenProvider>(context, listen: false).getToken();
    UserProfileProvider.isLoading = true;
    Provider.of<UserProfileProvider>(context, listen: false).getUserProfile();
  }

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<UserProfileProvider>(context).userProfileResponseModel;

    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.blueGrey,
      //   title: const Text("My Profile",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500)),
      //   centerTitle: true,
      //   leading: GestureDetector(
      //       onTap: () {
      //         Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MainScreen(),));
      //       },
      //       child: const Icon(Icons.arrow_back,color: Colors.white)),
      // ),
      body: Container(
        padding: const EdgeInsets.only(top: 40.0),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ///User Profile
                Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: SizedBox(
                            height: 100,
                            width: 100,
                            child: Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: Colors.white, width: 4,
                                      strokeAlign: BorderSide.strokeAlignOutside),
                                  boxShadow: [
                                    BoxShadow(color: Colors.grey.withOpacity(0.2),blurRadius: 16,offset:const Offset(0, 0)),
                                    BoxShadow(color: Colors.grey.withOpacity(0.2),blurRadius: 16,offset:const Offset(0, 0)),
                                  ]),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: CustomImage(
                                  path: "${data?.userProfileModel.imageName}" == ''
                                      ? null : '$baseUrl/uploads/customers/${data?.userProfileModel.imageName}',
                                  height: double.infinity,
                                  // width: 140,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Container(
                          padding: const EdgeInsets.all(15.0),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.blueGrey),
                              borderRadius: BorderRadius.circular(15.0)),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(flex: 4,child: Text("Name", style:AllTextStyle.textFieldHeadStyle)),
                                  const Expanded(flex: 1, child: Text(":")),
                                  Expanded(
                                    flex: 11,
                                    child: Container(
                                      height: 35.0,
                                      width: MediaQuery.of(context).size.width / 2,
                                      decoration: ContDecoration.contDecoration,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              Row(
                                children: [
                                  Expanded(flex: 4,child: Text("Email", style:AllTextStyle.textFieldHeadStyle)),
                                  const Expanded(flex: 1, child: Text(":")),
                                  Expanded(
                                    flex: 11,
                                    child: Container(
                                      height: 35.0,
                                      width: MediaQuery.of(context).size.width / 2,
                                      decoration: ContDecoration.contDecoration,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              Row(
                                children: [
                                  Expanded(flex: 4,child: Text("Phone", style:AllTextStyle.textFieldHeadStyle)),
                                  const Expanded(flex: 1, child: Text(":")),
                                  Expanded(
                                    flex: 11,
                                    child: Container(
                                      height: 35.0,
                                      width: MediaQuery.of(context).size.width / 2,
                                      decoration: ContDecoration.contDecoration,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              Row(
                                children: [
                                  Expanded(flex: 4,child: Text("Address", style:AllTextStyle.textFieldHeadStyle)),
                                  const Expanded(flex: 1, child: Text(":")),
                                  Expanded(
                                    flex: 11,
                                    child: SizedBox(
                                      height: 40.0,
                                      width: MediaQuery.of(context).size.width / 2,
                                      child: TextField(
                                        style: AllTextStyle.dropDownlistStyle,
                                        controller: _AddressController,
                                        decoration: InputDecoration( contentPadding: const EdgeInsets.only(left: 6),
                                            hintText: "",
                                            hintStyle: AllTextStyle.dropDownlistStyle,
                                            filled: true,
                                            fillColor: Colors.white,
                                            border: InputBorder.none,
                                            focusedBorder:TextFieldInputBorder.focusEnabledBorder,
                                            enabledBorder:TextFieldInputBorder.focusEnabledBorder
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        ///====old===
                        // Align(
                        //     alignment: Alignment.center,
                        //     child: Text(
                        //       "Id: ${data?.userProfileModel.customerCode}",
                        //       style: const TextStyle(
                        //           fontSize: 14,
                        //           fontWeight: FontWeight.w500),
                        //     )),
                        // const SizedBox(
                        //   height: 3,
                        // ),
                        // Align(
                        //     alignment: Alignment.center,
                        //     child: Text(
                        //       "Name: ${data?.userProfileModel.customerName}",
                        //       style: const TextStyle(
                        //           fontSize: 14,
                        //           fontWeight: FontWeight.w500),
                        //     )),
                        // const SizedBox(
                        //   height: 3,
                        // ),
                        // Align(
                        //     alignment: Alignment.center,
                        //     child: Text(
                        //       "Phone: ${data?.userProfileModel.customerMobile}",
                        //       style: const TextStyle(
                        //           fontSize: 14,
                        //           fontWeight: FontWeight.w500),
                        //     )),
                        // const SizedBox(
                        //   height: 3,
                        // ),
                        // Align(
                        //     alignment: Alignment.center,
                        //     child: Text(
                        //       "Email: ${data?.userProfileModel.customerEmail}",
                        //       style: const TextStyle(
                        //           fontSize: 14,
                        //           fontWeight: FontWeight.w500),
                        //     )),
                        // const SizedBox(
                        //   height: 3,
                        // ),
                        // Visibility(
                        //     visible: data?.userProfileModel.customerAddress != '',
                        //     child: Align(
                        //         alignment: Alignment.center,
                        //         child: Text(
                        //           "Address: ${data?.userProfileModel.customerAddress}",
                        //           style: const TextStyle(
                        //               fontSize: 14,
                        //               fontWeight: FontWeight.w500),
                        //         ))),
                      ],
                    ),
                    Positioned(
                      top: 0,
                      // bottom: 0,
                      // right: MediaQuery.of(context).size.width*0.20,
                      right: 5,
                      child: Center(child: ElevatedButton(onPressed: () {
                        // Navigator.push(context, MaterialPageRoute(builder: (context) => const UpdateProfile(
                        // //  userProfileModel: data!.userProfileModel,
                        // ),
                        // )).then((value){
                        //   setState(() {
                        //     Provider.of<UserProfileProvider>(context, listen: false).getUserProfile();
                        //   });
                        // });
                      },child: const Text("Update",style: TextStyle(
                        fontSize: 14,
                      ),textAlign: TextAlign.center,)),),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20.0,
                ),

                ///Apply coupon
                ///=====old====
                // Container(
                //   height: 30,
                //   width: double.infinity,
                //   color: const Color(0xff002A56),
                //   child: Center(
                //     child: Text(
                //       'Apply Coupon',
                //       style: GoogleFonts.poppins(
                //         textStyle: TextStyle(
                //           fontWeight: FontWeight.bold,
                //           fontSize: textFontSize,
                //           color: Colors.white,
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
                // const SizedBox(height: 10),
                // ///apply filed
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     Flexible(
                //       child: SizedBox(
                //         height: 40,
                //         child: TextFormField(
                //           controller: couponController,
                //           decoration: const InputDecoration(
                //             filled: true,
                //             contentPadding: EdgeInsets.only(
                //                 left: 10.0,
                //                 top: 0.0,
                //                 bottom: 0.0,
                //                 right: 0.0),
                //             fillColor: Colors.white,
                //             border: OutlineInputBorder(
                //               borderRadius: BorderRadius.only(
                //                 topLeft: Radius.circular(5),
                //                 bottomLeft: Radius.circular(5),
                //               ),
                //             ),
                //             focusedBorder:  OutlineInputBorder(
                //               borderRadius: BorderRadius.only(
                //                 topLeft: Radius.circular(5),
                //                 bottomLeft: Radius.circular(5),
                //               ),
                //             ),
                //             enabledBorder:  OutlineInputBorder(
                //               borderRadius: BorderRadius.only(
                //                 topLeft: Radius.circular(5),
                //                 bottomLeft: Radius.circular(5),
                //               ),
                //             ),
                //             hintText: "Coupon Code",
                //             hintStyle: TextStyle(fontSize: 14),
                //           ),
                //           // validator: (value) {
                //           //   if (value == null || value.isEmpty) {
                //           //     return null;
                //           //   }
                //           //   return null;
                //           // },
                //         ),
                //       ),
                //     ),
                //     SizedBox(
                //       height: 40,
                //       child: ElevatedButton(
                //         onPressed: () {
                //           ///===old===
                //           // if(couponController.text == ""){
                //           //   Utils.errorSnackBar(context, "This field is required");
                //           // }else{
                //           //   Utils.closeKeyBoard(context);
                //           //   setState(() {
                //           //     isLoading = true;
                //           //   });
                //           //   applyCoupon(userToken);
                //           // }
                //         },
                //         style: ElevatedButton.styleFrom(
                //             shape: const RoundedRectangleBorder(
                //                 borderRadius: BorderRadius.only(
                //                     topRight: Radius.circular(5),
                //                     bottomRight: Radius.circular(5)
                //                 )
                //             )
                //         ), child: isLoading
                //           ? const CircularProgressIndicator(color: Colors.white,)
                //           : const Text("Apply"),
                //       ),
                //     ),
                //   ],
                // ),
                // const SizedBox(
                //   height: 10.0,
                // ),
                //
                // GridView(
                //   shrinkWrap: true,
                //   gridDelegate:
                //   const SliverGridDelegateWithFixedCrossAxisCount(
                //     crossAxisCount: 2,
                //     crossAxisSpacing: 16,
                //     mainAxisSpacing: 16,
                //     mainAxisExtent: 150,
                //   ),
                //   physics: const NeverScrollableScrollPhysics(),
                //   children: [
                //     DCardView(
                //       index: 0,
                //       title: 'My Wallet',
                //       image: Icons.library_books_rounded,
                //       color: Colors.blue,
                //       //value: double.parse("${data?.walletBalance}").toStringAsFixed(2),
                //       value: "${data?.walletBalance}",
                //     ),
                //     DCardView(
                //       index: 1,
                //       title: 'Total',
                //       image: Icons.watch_later_outlined,
                //       color: Colors.red,
                //       value: '${data?.totalOrder}',
                //     ),
                //     DCardView(
                //       index: 2,
                //       title: 'Delivered',
                //       image: Icons.favorite,
                //       color: Colors.green,
                //       value: '${data?.totalDelivary}',
                //     ),
                //     DCardView(
                //       index: 3,
                //       title: 'Cancel',
                //       image: Icons.close,
                //       color: Colors.red,
                //       value: '${data?.totalCancel}',
                //     ),
                //   ],
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }

  ///====old====
  // applyCoupon(userToken)async{
  //
  //   String link = "${baseUrl}/api/v1/apply_coupon";
  //   try {
  //     final formData = FormData.fromMap({
  //       "token": userToken.trim(),
  //       "coupon_code": couponController.text.trim()
  //     });
  //     final response = await Dio().post(link, data: formData);
  //     var item = jsonDecode(response.data);
  //     print('apply coupon $item');
  //
  //     if (item["success"] == true) {
  //       setState(() {
  //         isLoading = false;
  //         couponController.text = "";
  //         Utils.showSnackBar(context, "${item["data"]}");
  //         Provider.of<UserProfileProvider>(context, listen: false).getUserProfile();
  //       });
  //     }else{
  //       setState(() {
  //         isLoading = false;
  //       });
  //       Utils.errorSnackBar(context, "${item['data']}");
  //     }
  //   } catch (e) {
  //     setState(() {
  //       isLoading = false;
  //     });
  //     print("Error message $e");
  //     Utils.errorSnackBar(context, "$e}");
  //   }
  //
  // }

}

class DCardView extends StatelessWidget {
  const DCardView(
      {Key? key,
      required this.index,
      required this.title,
      required this.image,
      required this.color,
      required this.value})
      : super(key: key);
  final int index;
  final String title;
  final IconData image;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      decoration: BoxDecoration(
          color: Colors.white.withAlpha(950),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
                offset: const Offset(5, 5),
                blurRadius: 3,
                color: Colors.blue.shade200,
                blurStyle: BlurStyle.inner)
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Material(
                color: color.withOpacity(0.1),
                // elevation: 1,
                shadowColor: const Color(0xFFFFFFFF),
                borderOnForeground: true,
                shape: const CircleBorder(),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  child: Icon(
                    image,
                    color: color,
                    size: 16,
                  ),
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              SizedBox(
                  child: Text(
                title,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
              ))
            ],
          ),
          const Spacer(),
          SizedBox(
              width: double.infinity,
              child: Text(
                value,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 20,
                    fontWeight: FontWeight.w500),
              )),
          const Spacer(),
          // Text(getGreenText(dashboardCardList[index].title,dashboardCardList[index].value),
          Text(
            '',
            style: TextStyle(
                color: index == 2 ? Colors.red : Colors.green,
                fontSize: 14,
                fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }
}
