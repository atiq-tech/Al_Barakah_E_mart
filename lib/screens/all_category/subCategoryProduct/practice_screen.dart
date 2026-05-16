import 'package:al_barakah_e_mart/utils/constants.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class PracticeScreen extends StatefulWidget {
  const PracticeScreen({super.key});

  @override
  State<PracticeScreen> createState() => _PracticeScreenState();
}

class _PracticeScreenState extends State<PracticeScreen> {
  final List<List<String>> carouselData = [
    ['image1.jpg', 'image2.jpg', 'image3.jpg', 'image4.jpg'],
    ['image5.jpg', 'image6.jpg', 'image7.jpg', 'image8.jpg'],
    // Add more sets of images as needed
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true,title: const Text("Practice")),
      body: Container(
        padding: const EdgeInsets.all(10.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Number of items per row
          ),
          itemCount: productSubCategoryList.length,
          itemBuilder: (BuildContext context, int index) {
            return CarouselSlider.builder(
              itemCount: productSubCategoryList.length,
              options: CarouselOptions(
                height: 200.0,
               // enlargeCenterPage: true,
                viewportFraction: 1.1,
                aspectRatio: 16/9,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 2),
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
              ),
              itemBuilder: (BuildContext context, int innerIndex, _) {
                return Container(
                  margin: const EdgeInsets.all(5.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.asset(
                      '${productSubCategoryList[index]["image"]}',
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
