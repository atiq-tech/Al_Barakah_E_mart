import 'package:al_barakah_e_mart/all_api_provider/brand_wise_products_provider.dart';
import 'package:al_barakah_e_mart/all_api_provider/get_brands_provider.dart';
import 'package:al_barakah_e_mart/screens/brand_wise_product/sub_brands_product.dart';
import 'package:al_barakah_e_mart/screens/main/main_screen.dart';
import 'package:al_barakah_e_mart/utils/constants.dart';
import 'package:al_barakah_e_mart/utils/custom_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class BrandsWiseAllItemsScreen extends StatefulWidget {
  const BrandsWiseAllItemsScreen({super.key});

  @override
  State<BrandsWiseAllItemsScreen> createState() => _BrandsWiseAllItemsScreenState();
}

class _BrandsWiseAllItemsScreenState extends State<BrandsWiseAllItemsScreen> {

  @override
  void initState() {
    Provider.of<GetBrandsProvider>(context,listen: false).getGetBrands();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final allBrandsData = Provider.of<GetBrandsProvider>(context).getBrandslist;
    print("AllBrands length is===> ${allBrandsData.length}");
    return Scaffold(
      appBar: AppBar(
        backgroundColor: scaffoldColor,
        scrolledUnderElevation: 0,
        leading: IconButton(
          onPressed: () {
            //Navigator.pop(context);
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MainScreen(),
                ));
          },
          icon: const Icon(
            Icons.arrow_back,
            size: 25,
            color: Colors.black87,
          ),
        ),
        title: Text(
          "All Brands",
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontStyle: FontStyle.italic,
            letterSpacing: 1,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: const EdgeInsets.all(10.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 10.0, 
            mainAxisSpacing: 10.0,
            mainAxisExtent: 100,
          ),
        itemCount: allBrandsData.length, 
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              Provider.of<BrandWiseProductsProvider>(context,listen: false).getBrandWiseProducts("${allBrandsData[index].brandSiNo}");
              Navigator.push(context, MaterialPageRoute(builder: (context) => SubBrandsProduct(
                brandsName: allBrandsData[index].brandName,
                brandsId: "${allBrandsData[index].brandSiNo}",
              ),));
            },
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
                side: BorderSide(color: appbuttonColor, width: 1.5),
              ),
              child: Container(
                  width: 120.0,
                  decoration: BoxDecoration(
                     borderRadius: BorderRadius.circular(5.0),
                    border: Border.all(color: Colors.orange.shade700,width: 1.5),
                  ),
                  child: SizedBox(
                  width: 70.0,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomImage(
                      path: "${imageUrl}/uploads/brand/${allBrandsData[index].image}",
                      fit: BoxFit.fitWidth,
                      height: 70.0,
                    ),
                  ),
                ),
              ),
            ),
          );
         },
        ),
      )
    );
  }
}
