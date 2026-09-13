void main() async{
  Stream<int> numbers = Stream.fromIterable([1, 2, 3, 4, 5, 6, 7]);

  Stream<int> squares = numbers.map((number){
    return number * number;
  });

  Stream<int> evenSquares = squares.where((number){
    return number % 2 == 0;
  });

  await for (int number in evenSquares){
    print(number);
  }
}