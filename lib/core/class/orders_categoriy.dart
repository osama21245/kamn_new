class OrdersCategories {
  final String name;
  final String imageurl;

  OrdersCategories(this.name, this.imageurl);
}

List<OrdersCategories> ordersCategoriyList = [
  OrdersCategories("Coaches", "assets/page-1/images/coaches-gyms.png"),
  OrdersCategories("Gyms", "assets/page-1/images/gym1.jpg"),
  OrdersCategories("Medical", "assets/page-1/images/profile.png"),
  OrdersCategories("Sports shop", "assets/page-1/images/sports_player.png"),
  OrdersCategories("Nutrition", "assets/page-1/images/orthopedist.png"),
  OrdersCategories("Grounds", "assets/page-1/images/ground.jpg"),
];
