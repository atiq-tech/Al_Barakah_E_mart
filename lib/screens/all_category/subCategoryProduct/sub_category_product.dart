
import 'package:al_barakah_e_mart/all_api_model/get_category_model.dart';
import 'package:al_barakah_e_mart/screens/all_category/subCategoryProduct/sub_category_individual_products.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:al_barakah_e_mart/utils/all_textstyle.dart';
import 'package:al_barakah_e_mart/utils/constants.dart';

class SubCategoryProduct extends StatefulWidget {
  const SubCategoryProduct({
    Key? key,
    required this.categoryId,
    required this.categoryName,
    required this.subCategoryList,
  }) : super(key: key);

  final String? categoryId;
  final String? categoryName;
  final List<SubCategory> subCategoryList;

  @override
  State<SubCategoryProduct> createState() => _SubCategoryProductState();
}

class _SubCategoryProductState extends State<SubCategoryProduct> {

bool isLoading = true;
@override
void initState() {
  super.initState();

  print("wwwwwwwwwwww categoryId==${widget.categoryId}");

  Future.delayed(const Duration(milliseconds: 800), () {

    setState(() {
      isLoading = false;
    });

  });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: scaffoldColor,
        scrolledUnderElevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back, size: 25.r, color: Colors.black87),
        ),
        title: Text(
          "${widget.categoryName}",
          style: AllTextStyle.getTitleTextStyle(),
        ),
      ),

      body: isLoading
    ? const Center(
        child: CircularProgressIndicator(),
      )
    : widget.subCategoryList.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.category,color: Colors.red,size: 50.r),
                  Text("Category is empty",style: AllTextStyle.nofoundTextStyle),
                ],
              ),
            )

          : GridView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: widget.subCategoryList.length,
              gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
                mainAxisExtent: 120,
              ),
              itemBuilder: (context, index) {
                final subCategory = widget.subCategoryList[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SubCategoryIndividualProducts(
                      categoryName: subCategory.name,
                      categoryId: "${subCategory.categoryId}",
                    )));
                  },
                  child: Card(
                    elevation: 5,
                    child: Column(
                      children: [
                        Expanded(
                          flex: 3,
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                            ),
                  
                            child: SizedBox(
                              width: double.infinity,
                              child: Image.network(
                                "$imageUrl${subCategory.image}",
                                fit: BoxFit.cover,
                                errorBuilder:(context, error, stackTrace) {
                                  return const Icon(
                                    Icons.broken_image,
                                    size: 50,
                                    color: Colors.grey,
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            width: double.infinity,
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 5,
                            ),
                  
                            decoration: BoxDecoration(
                              color: appBarColor,
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                              ),
                            ),
                  
                            child: Text(
                              "${subCategory.name}",
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}















// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:provider/provider.dart';
// import 'package:al_barakah_e_mart/all_api_provider/child_categories_provider.dart';
// import 'package:al_barakah_e_mart/screens/all_category/subCategoryProduct/sub_category_individual_products.dart';
// import 'package:al_barakah_e_mart/utils/all_textstyle.dart';
// import 'package:al_barakah_e_mart/utils/constants.dart';

// class SubCategoryProduct extends StatefulWidget {
//   const SubCategoryProduct({
//     Key? key,
//     required this.categoryId,
//     this.categoryName,
//   }) : super(key: key);

//   final String? categoryId;
//   final String? categoryName;

//   @override
//   State<SubCategoryProduct> createState() => _SubCategoryProductState();
// }

// class _SubCategoryProductState extends State<SubCategoryProduct> {

//   @override
//   void initState() {
//      print("wwwwwwwwwwww categoryId==${widget.categoryId}");
//     super.initState();
//     ChildCategoriesProvider.isChildCategoriesLoading = true;

//     Provider.of<ChildCategoriesProvider>(context, listen: false)
//         .getChildCategories(widget.categoryId);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: scaffoldColor,
//         scrolledUnderElevation: 0,
//         leading: IconButton(
//           onPressed: () => Navigator.pop(context),
//           icon: Icon(Icons.arrow_back, size: 25.r, color: Colors.black87),
//         ),
//         title: Text(
//           "${widget.categoryName}",
//           style: AllTextStyle.getTitleTextStyle(),
//         ),
//       ),

//       body: Consumer<ChildCategoriesProvider>(
//         builder: (context, provider, _) {

//           /// ===== LOADING =====
//           if (ChildCategoriesProvider.isChildCategoriesLoading) {
//             return const Center(child: CircularProgressIndicator());
//           }

//           final model = provider.childCategoriesModel;

//           /// ===== EMPTY =====
//           if (model == null || model.children.isEmpty) {
//             return Center(
//               child: Text(
//                 "No Sub Categories Found",
//                 style: TextStyle(
//                   color: Colors.red.shade600,
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             );
//           }

//           final children = model.children;

//           /// ===== GRID =====
//           return GridView.builder(
//             padding: const EdgeInsets.all(10),
//             itemCount: children.length,
//             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 3,
//               crossAxisSpacing: 8,
//               mainAxisSpacing: 8,
//               mainAxisExtent: 130,
//             ),
//             itemBuilder: (context, index) {

//               final item = children[index];
//               final imagePath = item.image;

//               return GestureDetector(
//                 onTap: () {
//                   Navigator.push(context, MaterialPageRoute(builder: (context) => SubCategoryIndividualProducts(
//                     categoryName: item.productCategoryName,
//                     categoryId: "${item.productCategorySlNo}",
//                   )));
//                 },
//                 child: Card(
//                   elevation: 4,
//                   child: Column(
//                     children: [

//                       /// IMAGE
//                       Expanded(
//                         flex: 2,
//                         child: ClipRRect(
//                           borderRadius: BorderRadius.vertical(
//                             top: Radius.circular(8.r),
//                           ),
//                           child: imagePath != null && imagePath.toString().isNotEmpty
//                               ? Image.network(
//                                   "${imageUrl}$imagePath",
//                                   width: double.infinity,
//                                   fit: BoxFit.fill,
//                                   errorBuilder: (_, __, ___) =>
//                                       _noImage(),
//                                 )
//                               : _noImage(),
//                         ),
//                       ),

//                       /// NAME
//                       Expanded(
//                         child: Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 4),
//                           child: Center(
//                             child: Text(
//                               item.productCategoryName ?? "",
//                               textAlign: TextAlign.center,
//                               maxLines: 2,
//                               overflow: TextOverflow.ellipsis,
//                               style: TextStyle(
//                                 fontSize: 11.sp,
//                                 fontWeight: FontWeight.w500,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }

//   Widget _noImage() {
//     return Container(
//       color: Colors.grey.shade200,
//       child: const Center(
//         child: Icon(Icons.image_not_supported_outlined,
//             size: 40, color: Colors.grey),
//       ),
//     );
//   }
// }
