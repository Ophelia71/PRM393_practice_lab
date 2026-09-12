void main() async{
  String result = await loadData();
  print(result);

  // Nullable variable với ?
  String? nickname;
 // Null-aware operator ?.
  print(nickname?.length);

  // Default value operator ??
  String displayName = nickname ?? "Guest";
  print(displayName);

  // non-null assertion operator ! (không dùng ! khi biến thật sự có thể là null)
  String? confirmedName = "Ophelia";
  print(confirmedName!.length);

  // Stream là một dòng dữ liệu. ~ chiếc băng chuyền lần lượt đưa ra các số
  Stream<int> numbers = Stream.fromIterable([1, 2, 3]);

  numbers.listen((number){
    print(number);
  });

}

Future<String> loadData() async{
  print("Loading ...");

  await Future.delayed(Duration(seconds: 1));

  return "Data loaded";
}

