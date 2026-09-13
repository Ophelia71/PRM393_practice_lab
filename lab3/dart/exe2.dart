
import 'dart:convert';

class User{
  String name;
  String email;

  User(this.name, this.email);

  User.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        email = json['email'];

  @override
  String toString() {
    return 'User{name: $name, email: $email}';
  }
}

class UserRepository{
  Future<List<User>> getUser() async{
    String jsonData = '''
    [
      {
         "name": "Ophelia",
         "email": "Ophelia@gmail.com"
      },
      {
          "name": "Faker",
          "email": "Faker@gmail.com"
      }
    ]
    ''';

    List<dynamic> data = jsonDecode(jsonData);

    List<User> users = [];

    for(dynamic item in data){
      users.add(User.fromJson(item));
    }
    return users;
  }
}

Future<void> main() async{
  UserRepository repo = UserRepository();

  List<User> users = await repo.getUser();

  print('Danh sách user:');

  for(User user in users){
    print(user);
  }
}

