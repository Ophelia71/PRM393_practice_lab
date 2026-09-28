class Vehicle {
  String brand;
  int year;

  Vehicle(this.brand, this.year);

  void startEngine() {
    print('Khởi động động cơ của $brand, năm sản xuất: $year');
  }
}

class Car extends Vehicle {
  bool isElectric;

  Car(String brand, int year, this.isElectric) : super(brand, year);

  Car.tesla(int year) : isElectric = true, super('Tesla', year);

  @override
  void startEngine() {
    if (isElectric) {
      print('$brand $year khởi động êm ái bằng động cơ điện');
    } else {
      print('$brand $year khởi động động cơ xăng: Vroom vroom!');
    }
  }
}

void main() {
  Car normalCar = Car('Toyota', 2020, false);
  normalCar.startEngine(); 
  
  Car teslaCar = Car.tesla(2021);
  teslaCar.startEngine();
} 
