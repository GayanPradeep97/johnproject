class ItemModel {
  String? id;
  String? name;
  String? diamansion;
  String? image;
  String? catagory;

  ItemModel({
    required this.id,
    this.name,
    this.diamansion,
    this.image,
    this.catagory,
  });

  ItemModel.fromMap(Map map) {
    id = map['id'];
    name = map['name'];
    image = map['image'];
    diamansion = map['dimention'];
    catagory = map['catagory'];
  }
}
