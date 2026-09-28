import 'package:flutter/material.dart';

// -------------------- MAIN --------------------

void main() {
  // runApp dùng để chạy widget gốc của ứng dụng
  runApp(const MyApp());
}

// -------------------- MY APP --------------------

// MyApp là widget chính của toàn bộ ứng dụng
// Dùng StatefulWidget vì app có chức năng đổi Dark Mode
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

// Class này lưu trạng thái của MyApp
class _MyAppState extends State<MyApp> {
  bool isDark = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Ẩn chữ DEBUG ở góc phải màn hình
      debugShowCheckedModeBanner: false,

      // Theme sáng của app
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blue,
      ),

      // Theme tối của app
      darkTheme: ThemeData.dark(),

      // Nếu isDark = true thì dùng theme tối
      themeMode: isDark ? ThemeMode.dark : ThemeMode.light,

      home: HomePage(
        isDark: isDark,
        changeTheme: (value) {
          setState(() {
            isDark = value;
          });
        },
      ),
    );
  }
}

// -------------------- HOME PAGE --------------------

class HomePage extends StatelessWidget {
  final bool isDark;
  final ValueChanged<bool> changeTheme;

  const HomePage({
    super.key,
    required this.isDark,
    required this.changeTheme,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar là thanh tiêu đề ở phía trên màn hình
      appBar: AppBar(title: const Text('Lab 4 - Flutter UI Fundamentals'),),

      // ListView hiển thị danh sách các bài
      body: ListView( padding: const EdgeInsets.all(16),
        children: [
          menu(context, 'Exercise 1 - Core Widgets', const Exercise1()),
          menu(context, 'Exercise 2 - Input Controls', const Exercise2()),
          menu(context, 'Exercise 3 - Layout Demo', const Exercise3()),
          menu(context, 'Exercise 4 - App Structure & Theme', Exercise4(isDark: isDark, changeTheme: changeTheme),),
          menu(context, 'Exercise 5 - Common UI Fixes', const Exercise5()),
        ],
      ),
    );
  }

  // Dùng để tạo một item menu
  Widget menu(BuildContext context, String title, Widget screen) {
    return Card(
      child: ListTile(
        title: Text(title),
        trailing: const Icon(Icons.arrow_forward),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => screen),
          );
        },
      ),
    );
  }
}

// -------------------- EXERCISE 1 --------------------

// Exercise 1: Core Widgets (Text, Icon, Image, Card, ListTile)
class Exercise1 extends StatelessWidget {
  const Exercise1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Exercise 1 - Core Widgets')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text('Welcome to Flutter UI', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
            const SizedBox(height: 16),
            const Icon(Icons.movie, size: 70, color: Colors.blue),
            const SizedBox(height: 16),
            Image.asset('assets/images/monet.jpg', height: 160,),
            // Image.network('https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg', height: 160,),
            const SizedBox(height: 16),
            const Card(child: ListTile(leading: Icon(Icons.star), title: Text('Movie Item'), subtitle: Text('This is a sample ListTile inside a Card.'),),),
          ],
        ),
      ),
    );
  }
}

// -------------------- EXERCISE 2 --------------------

// Exercise 2: Input Widgets (Slider, Switch, RadioListTile và DatePicker)
class Exercise2 extends StatefulWidget {
  const Exercise2({super.key});

  @override
  State<Exercise2> createState() => _Exercise2State();
}

class _Exercise2State extends State<Exercise2> {
  double rating = 50;
  bool active = false;
  String genre = 'None';
  DateTime? date;

  // Hàm mở DatePicker
  void openDatePicker() async {
    DateTime? result = await showDatePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(2030),
      initialDate: DateTime.now(),
    );

    if (result != null) {
      setState(() {
        date = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Exercise 2 - Input Controls'),),
      body: Padding(padding: const EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Rating (Slider)'),
            Slider(value: rating, min: 0, max: 100, onChanged: (value) {setState(() {rating = value;});},),
            Text('Current value: ${rating.toInt()}'),
            const SizedBox(height: 16),
            SwitchListTile(title: const Text('Is movie active?'), value: active, onChanged: (value) {setState(() {active = value;});},),
            const SizedBox(height: 16),
            const Text('Genre (RadioListTile)'),
            RadioListTile(title: const Text('Action'), value: 'Action', groupValue: genre, onChanged: (value) {setState(() {genre = value.toString();});},),
            RadioListTile(title: const Text('Comedy'), value: 'Comedy', groupValue: genre, onChanged: (value) {setState(() {genre = value.toString();});},),
            Text('Selected genre: $genre'),
            const SizedBox(height: 16),
            ElevatedButton(onPressed: openDatePicker, child: const Text('Open Date Picker'),),
            const SizedBox(height: 8),
            Text(date == null ? 'No date selected' : 'Date: ${date!.day}/${date!.month}/${date!.year}',),
          ],
        ),
      ),
    );
  }
}

// -------------------- EXERCISE 3 --------------------

// Exercise 3: Layout Basics (Column, Row, Padding, SizedBox và ListView.builder)
class Exercise3 extends StatelessWidget {
  const Exercise3({super.key});

  final List<String> movies = const ['Avatar', 'Inception', 'Interstellar', 'Joker',];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercise 3 - Layout Demo'),
      ),
      body: Padding(padding: const EdgeInsets.all(16), child: Column(children: [
            const Text('Now Playing', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
            const SizedBox(height: 16),
            const Row(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.movie), SizedBox(width: 8), Text('Movie List'),],),
            const SizedBox(height: 16),
            Expanded(child:
            ListView.builder(itemCount: movies.length, itemBuilder: (context, index) {
              return
              Card(child: ListTile(leading: CircleAvatar(child: Text(movies[index][0]),),
                      title: Text(movies[index]),
                      subtitle: const Text('Sample description'),),);},),),
          ],
        ),
      ),
    );
  }
}

// -------------------- EXERCISE 4 --------------------

// Exercise 4: App Structure & Theme (Scaffold, AppBar, Body, FloatingActionButton, ThemeData)
class Exercise4 extends StatelessWidget {
  final bool isDark;
  final ValueChanged<bool> changeTheme;
  const Exercise4({super.key, required this.isDark, required this.changeTheme,});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercise 4 - App Structure'),
        actions: [
          const Text('Dark'),
          Switch(
            value: isDark,
            onChanged: changeTheme,
          ),
        ],
      ),
      body: const Center(
        child: Text('This is a simple screen with theme toggle.'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}

// -------------------- EXERCISE 5 --------------------

// Exercise 5: Common UI Fixes (sửa lỗi ListView nằm trong Column bằng Expanded)
class Exercise5 extends StatelessWidget {
  const Exercise5({super.key});
  final List<String> movies = const ['Movie A', 'Movie B', 'Movie C', 'Movie D',];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercise 5 - Common UI Fixes'),
      ),
      body: Padding(padding: const EdgeInsets.all(16), child: Column(children: [
            const Text(
              'Correct ListView inside Column using Expanded',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // Expanded giúp ListView có chiều cao hợp lệ khi nằm trong Column
            Expanded(child: ListView.builder(
                itemCount: movies.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: const Icon(Icons.movie),
                    title: Text(movies[index]),);},),),],
        ),
      ),
    );
  }
}