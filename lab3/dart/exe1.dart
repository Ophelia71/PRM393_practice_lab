import 'dart:async';

class Product {
  int id;
  String name;
  double price;

  Product(this.id, this.name, this.price);

  @override
  String toString() {
    return 'Product{id: $id, name: $name, price: $price}';
  }
}

  class ProductRepository{
    StreamController<Product> controller = StreamController<Product>.broadcast();

    Future<List<Product>> getAll() async{
      List<Product> products =[
        Product(1, 'Laptop', 20000.0),
        Product(2, 'Mouse', 400.0),
      ];
      return products;

  }

  Stream<Product> liveAdded() => controller.stream;

  void addProduct(Product product) => controller.add(product);

  void close(){
    controller.close();
  }

}

Future<void> main() async{
  ProductRepository repo = ProductRepository();

  List<Product> products = await repo.getAll();

  print('Danh sách sản phẩm:');

  for(Product product in products){
    print(product);
  }

  repo.liveAdded().listen((Product product){
    print('Sản phẩm mới: $product');
  });

  repo.addProduct(Product(3, 'Keyboard', 500.0));

  await Future.delayed(Duration(seconds: 1));

  repo.close();
}
