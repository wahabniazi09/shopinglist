class Shop {
  late String itemName;
  late String price;
  late bool isDone;

  Shop({required this.itemName, required this.price, required this.isDone});

  Shop.fromJson(Map<dynamic, dynamic> json)
      : itemName = json['itemName'] as String,
        price = json['price'] as String,
        isDone = json['isDone'] as bool;

  Map<dynamic, dynamic> toJson() =>
      <dynamic, dynamic>{
        'itemName':itemName, 
        'price': price, 
        'isDone': isDone
        };

  Map<String, dynamic> toMap() =>
      <String, dynamic>{
        'itemName': itemName, 
        'price': price, 
        'isDone': isDone
        };
}
