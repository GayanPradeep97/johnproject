class ItemModel {
  String? id;
  String? name;
  String? diamansion;
  String? image;

  ItemModel({
    required this.id,
    this.name,
    this.diamansion,
    this.image,
  });

  ItemModel.fromMap(Map map) {
    id = map['id'];
    name = map['name'];
    image = map['image'];
    diamansion = map['dimention'];
  }
}
