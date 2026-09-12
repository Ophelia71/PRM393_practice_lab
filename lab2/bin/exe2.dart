void main() {
  // List: danh sách có thứ tự
  List<int> numbers = [1, 2, 5, 3, 4, 5, 6, 7, 8];

  print("First number: ${numbers[7]}");
  print("Original list: $numbers");

  numbers.add(9);
  print("After adding 9: $numbers");

  numbers.remove(2);
  print("After removing value 2: $numbers");

  numbers.removeAt(2);
  print("After removing item at index 2: $numbers");

  // Operators: các toán tử
  int a = 5;
  int b = 7;

  print("a + b = ${a + b}");
  print("b - a = ${b - a}");
  print("a == b = ${a == b}");
  print("a > b = ${a > b}");
  print("a < b && b > 0 = ${a < b && b > 0}");

  // Set: nhóm dữ liệu không cho phép trùng lặp
  Set<int> uniqueNumbers = {1, 1, 1, 2, 3, 4};

  print("Set: $uniqueNumbers");

  // Map: lưu dữ liệu theo cặp khóa và giá trị
  Map<String, dynamic> student = {
    "name": "Ophelia",
    "age": 22,
    "isStudent": true
  };

  print("Student name: ${student["name"]}");
  print("Student age: ${student["age"]}");
  print("Is student: ${student["isStudent"]}");

  // Conditional operator ?:
  String result = a > b
      ? "a is greater than b"
      : "a is not greater than b";

  print("Comparison result: $result");
}