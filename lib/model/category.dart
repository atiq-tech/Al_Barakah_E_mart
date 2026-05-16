class Category {
  const Category(this.icon, this.title, this.id);
  final String icon;
  final String title;
  final String id;
}

final homeCategries = <Category>[
  const Category('CategoryIcon/SliderHome/manman.png', 'Man', 'Man'),
  const Category('CategoryIcon/SliderHome/womanwoman.png', 'Woman', 'Woman'),
  const Category('CategoryIcon/SliderHome/girlsgirls.png', 'Girls', 'Girls'),
  const Category('CategoryIcon/SliderHome/boyesboyes.png', 'Boys', 'Boys'),
  const Category('CategoryIcon/SliderHome/kidskids.png', 'Kids', 'Kids'),
  const Category('CategoryIcon/SliderHome/offersoffers.png', 'Others', 'Others'),
];
