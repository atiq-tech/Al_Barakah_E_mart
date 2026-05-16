import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:al_barakah_e_mart/all_api_provider/get_category_provider.dart';
import 'package:al_barakah_e_mart/footer_section/about_section.dart';
import 'package:al_barakah_e_mart/model/category.dart';
import 'package:al_barakah_e_mart/screens/all_category/subCategoryProduct/sub_category_product.dart';
import 'package:al_barakah_e_mart/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';


class All_CateGory_Page extends StatefulWidget {
  const All_CateGory_Page({Key? key}) : super(key: key);

  @override
  State<All_CateGory_Page> createState() => _All_CateGory_PageState();
}

class _All_CateGory_PageState extends State<All_CateGory_Page> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
    Provider.of<GetCategoriesProvider>(context,listen: false).getGetCategories();
  });
  }

  @override
  Widget build(BuildContext context) {
    final allGetCategorieslist = Provider.of<GetCategoriesProvider>(context).getCategorieslist;
    print("All Categories List: ${allGetCategorieslist.length}");
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: EdgeInsets.all(10.r),
            sliver: SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, 
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                childAspectRatio: 1.0,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(context,
                        MaterialPageRoute(
                          builder: (context) => SubCategoryProduct(
                            categoryName: allGetCategorieslist[index].productCategoryName,
                            categoryId: "${allGetCategorieslist[index].productCategorySlNo}",
                          ),
                        ),
                      );
                    },
                    child: Card(
                      elevation: 6,
                      child: Column(
                        children: [
                         Expanded(
                          flex: 2,
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10.r),
                              topRight: Radius.circular(10.r),
                            ),
                            child: SizedBox(
                              height: 125.h,
                              width: double.infinity,
                              child: Image.network(
                                "$imageUrl${allGetCategorieslist[index].image}",
                                fit: BoxFit.fill,
                                loadingBuilder: (context, child, loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return Center(
                                    child: SizedBox(
                                      height: 25,
                                      width: 25,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                      ),
                                    ),
                                  );
                                },
                                errorBuilder: (context, error, stackTrace) {
                                  return const Center(
                                    child: Icon(Icons.broken_image, size: 40),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                          height: 75.h,
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(horizontal: 2.w),
                          child: Center(
                            child: Text(
                                allGetCategorieslist[index].productCategoryName,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                           ),
                          ),
                        )
                      ],
                     ),
                    )
                  );
                },
                childCount: allGetCategorieslist.length,
              ),
            ),
          ),
          const SliverToBoxAdapter(child: BigBuyFooter())
        ],
      ),
    );
  }
  late final List<Category> categories = homeCategries;
}

























// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:al_barakah_e_mart/all_api_provider/child_categories_provider.dart';
// import 'package:al_barakah_e_mart/all_api_provider/get_category_provider.dart';
// import 'package:al_barakah_e_mart/footer_section/about_section.dart';
// import 'package:al_barakah_e_mart/model/category.dart';
// import 'package:al_barakah_e_mart/screens/all_category/subCategoryProduct/sub_category_product.dart';
// import 'package:al_barakah_e_mart/utils/constants.dart';
// import 'package:al_barakah_e_mart/utils/custom_image.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:provider/provider.dart';


// class All_CateGory_Page extends StatefulWidget {
//   const All_CateGory_Page({Key? key}) : super(key: key);

//   @override
//   State<All_CateGory_Page> createState() => _All_CateGory_PageState();
// }

// class _All_CateGory_PageState extends State<All_CateGory_Page> {
//   @override
//   void initState() {
//     Provider.of<GetCategoriesProvider>(context,listen: false).getGetCategories();
//     // TODO: implement initState
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final allGetCategorieslist = Provider.of<GetCategoriesProvider>(context).getCategorieslist;
//     return SafeArea(
//       child: CustomScrollView(
//         slivers: [
//           SliverPadding(
//             padding: EdgeInsets.all(10.r),
//             sliver: SliverGrid(
//               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 3, 
//                 mainAxisSpacing: 8,
//                 crossAxisSpacing: 8,
//                 childAspectRatio: 1.2,
//               ),
//               delegate: SliverChildBuilderDelegate(
//                 (context, index) {
//                   return InkWell(
//                     onTap: () {
//                       Provider.of<ChildCategoriesProvider>(context, listen: false).getChildCategories("${allGetCategorieslist[index].id}");
//                       Navigator.push(context,
//                         MaterialPageRoute(
//                           builder: (context) => SubCategoryProduct(
//                             categoryName: allGetCategorieslist[index].name,
//                             categoryId: "${allGetCategorieslist[index].id}",
//                           ),
//                         ),
//                       );
//                     },
//                     child: Card(
//                       elevation: 5,
//                       child: Container(
//                         padding: EdgeInsets.all(3.r),
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(10.r),
//                           border: Border.all(color: Colors.grey.shade300, width: 1.w),
//                         ),
//                         child: Column(
//                           children: [
//                             Expanded(
//                               child: CustomImage(
//                                 path: "$BaseUrl${allGetCategorieslist[index].image}",
//                                 fit: BoxFit.fill,
//                               ),
//                             ),
//                             Container(
//                               height: 30.h,
//                               alignment: Alignment.center,
//                               child: Text(
//                                 allGetCategorieslist[index].name,
//                                 textAlign: TextAlign.center,
//                                 style: GoogleFonts.poppins(
//                                   fontSize: 10.sp,
//                                   fontWeight: FontWeight.w500,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//                 childCount: allGetCategorieslist.length,
//               ),
//             ),
//           ),
//           const SliverToBoxAdapter(child: BigBuyFooter())
//         ],
//       ),
//     );
//   }
//   late final List<Category> categories = homeCategries;
// }
