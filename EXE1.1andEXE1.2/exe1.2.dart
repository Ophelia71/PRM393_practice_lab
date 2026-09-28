abstract class Employee {
  String name;

  Employee(this.name);

  void work();
}

mixin CheckInAbility on Employee {
  void checkIn() {
    print('$name đã điểm danh.');
  }
}

class Developer extends Employee with CheckInAbility {
  Developer(String name) : super(name);

  @override
  void work() {
    print('$name đang viết code.');
  }
}

void main() {
  List<Developer> teamA = [Developer('Ophelia'), Developer('Bob')];
  List<Developer> teamB = [Developer('Charlie'), Developer('Diana')];
  List<Developer> allStaff = [...teamA, ...teamB];

  for (Developer staff in allStaff) {
    staff.checkIn();
  }
}
