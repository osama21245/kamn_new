// class Categories {
//   final String name;

//   Categories(this.name);
// }

// List<Categories> categoriesList = [
//   Categories("football"),
//   Categories("Tennis"),
//   Categories("padel"),
//   Categories("basketball"),
//   Categories("Volleyball"),
//   Categories("Badminton")
// ];
class Categories {
  final String name;
  final String imageurl;

  Categories(this.name, this.imageurl);
}

List<Categories> categoriesList = [
  Categories("Football", "assets/page-1/images/football1.jpg"),
  Categories("Padel", "assets/page-1/images/paddel1.jpg"),
  Categories("Basketball", "assets/page-1/images/basket1.jpg"),
  Categories("Volleyball", "assets/page-1/images/volly1.jpg"),
  Categories("Mersal", "assets/page-1/images/mersal.jpg"),
  Categories("Swiming", "assets/page-1/images/swiming.jpg"),
];
