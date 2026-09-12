class Car{
  String brand;

  Car(this.brand);

  // Named constructor là constructor có tên riêng. Nó giúp tạo object theo một cách đặc biệt.
  Car.mclaren() : brand = "McLaren F1";


  void start(){
    print("$brand starts racing");
  }
}

class ElectricCar extends Car{
  ElectricCar(String brand) : super(brand);

  // @override nghĩa là class con viết lại method của class cha.
  @override
  void start(){
    print("$brand starts silently");
  }


}

void main(){
  Car car = Car("F1 racing car");

  Car racingCar = Car.mclaren();

  ElectricCar electricCar = ElectricCar("Tesla");


  print(car.brand);
  car.start();
  print(racingCar.brand);
  racingCar.start();
  print(electricCar.brand);
  electricCar.start();
}
