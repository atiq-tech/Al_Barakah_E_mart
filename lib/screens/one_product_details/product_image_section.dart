import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:photo_view/photo_view.dart';
import 'package:al_barakah_e_mart/all_api_model/products_details_model.dart';
import 'package:al_barakah_e_mart/utils/constants.dart';
import 'package:al_barakah_e_mart/utils/custom_image.dart';

class ProductImageSection extends StatefulWidget {
  final Product product;
  final String imageUrl;

  const ProductImageSection({
    super.key,
    required this.product,
    required this.imageUrl,
  });

  @override
  State<ProductImageSection> createState() => _ProductImageSectionState();
}

class _ProductImageSectionState extends State<ProductImageSection> {
  late String selectedImage;

  @override
  void initState() {
    super.initState();
    selectedImage = widget.product.thumImage ?? "";
  }

  void openZoomImage(String imagePath) {
  showDialog(
    context: context,
    barrierColor: Colors.black87,
    builder: (_) => Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 40.h),
      child: SizedBox(
        height: 300.h, 
        width: double.infinity,
        child: Stack(
          children: [
            /// 🔍 ZOOM IMAGE
            ClipRRect(
              borderRadius: BorderRadius.circular(10.r),
              child: PhotoView(
                imageProvider: NetworkImage("${widget.imageUrl}$imagePath"),
                backgroundDecoration: const BoxDecoration(color: Color.fromARGB(255, 170, 206, 180)),
              ),
            ),

            /// ❌ CLOSE BUTTON
            Positioned(
              bottom: 5.h,
              right: 5.r,
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 5.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.r),color: Colors.red
                  ),
                  child: Text("Close", style: TextStyle(color: Colors.white, fontSize: 11.sp, fontWeight: FontWeight.bold)),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

  @override
  Widget build(BuildContext context) {
    final product = widget.product;

    return Padding(
      padding: EdgeInsets.all(10.r),
      child: Column(
        children: [

          /// 🔝 MAIN IMAGE
          GestureDetector(
            onTap: () => openZoomImage(selectedImage),
            child: SizedBox(
              height: 300.h,
              width: double.infinity,
              child: CustomImage(
                path: "${widget.imageUrl}$selectedImage",
                fit: BoxFit.fill,
              ),
            ),
          ),

          SizedBox(height: 10.h),

          /// 🔽 THUMBNAILS
          product.multipleImg.isEmpty
              ? SizedBox(
                  height: 60.h,
                  width: 60.w,
                  child: CustomImage(
                    path: "${widget.imageUrl}${product.thumImage}",
                    fit: BoxFit.fill,
                  ),
                )
              : SizedBox(
                  height: 60.h,
                  child: ListView.builder(
                    itemCount: product.productImages.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final img = product.productImages[index].image;

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedImage = img!;
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.only(top: 10.h, left: 10.w, right: 5.w),
                          height: 60.h,
                          width: 60.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6.r),
                            border: Border.all(
                              color: selectedImage == img
                                  ? applineColor
                                  : Colors.grey.shade300,
                              width: 2,
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.r),
                            child: CustomImage(
                              path: "${widget.imageUrl}$img",
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
        ],
      ),
    );
  }
}