void main(){
  // if/else
  int score = 90;

  if(score >= 50){
    print("Pass");
  }else{
    print("Fail");
  }

  // switch: dùng để kiểm tra một giá trị có khớp với trường hợp nào không.
  String day = "Sunday";

  switch(day){
    case "Monday":
    print("Start of the week");
    break;

    case "Sunday":
    print("Weekend");
    break;

    default: print("Another day");
  }

  // for: Vòng lặp dùng để lặp lại một việc nhiều lần.
  for(int i = 0; i < 3; i++){
    print(i);
  }

  // for-in: dùng để đi qua từng phần tử trong một danh sách.
  List<int> numbers = [10, 20, 30];

  for(int number in numbers){
    print(number);
  }

  // forEach() cũng đi qua từng phần tử trong danh sách.
  numbers.forEach((number){
    print(number);
  });

  print(add(7, 1));

  print(multiply(7, 5));
}

// Hàm thông thường
int add(int a, int b) {
  return a + b;
}

// Arrow function là cách viết ngắn của một hàm chỉ có một câu lệnh.
int multiply(int a, int b) => a * b;