import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }
}

// -------------------- MODEL --------------------

// Class Movie dùng để lưu thông tin phim
class Movie {
  final String title;
  final String image;
  final String overview;
  final double rating;
  final List<String> genres;
  final List<String> trailers;

  Movie({
    required this.title,
    required this.image,
    required this.overview,
    required this.rating,
    required this.genres,
    required this.trailers,
  });
}
// Dữ liệu tĩnh, không gọi API
List<Movie> movies = [
  Movie(
    title: 'Dune: Part Two',
    image: 'assets/images/dune.jpeg',
    overview:
    'Paul Atreides unites with Chani and the Fremen while seeking revenge.',
    rating: 8.6,
    genres: ['Sci-Fi', 'Adventure', 'Drama'],
    trailers: ['Official Trailer #1', 'IMAX Sneak Peek'],
  ),
  Movie(
    title: 'Deadpool & Wolverine',
    image: 'assets/images/deadpool.jpeg',
    overview:
    'Wade Wilson teams up with Wolverine for a multiverse mission.',
    rating: 8.3,
    genres: ['Action', 'Comedy'],
    trailers: ['Red Band Trailer', 'Behind the Scenes'],
  ),
];

// -------------------- HOME SCREEN --------------------

// Màn hình danh sách phim
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Thanh tiêu đề
      appBar: AppBar(title: const Text('Movies'),),

      // Hiển thị danh sách phim
      body: ListView.builder(padding: const EdgeInsets.all(16), itemCount: movies.length, itemBuilder: (context, index) {
      // Lấy phim hiện tại trong danh sách
          Movie movie = movies[index];
          return Card(
            child: ListTile(leading: Image.asset(movie.image, width: 70, height: 50, fit: BoxFit.cover,),
            title: Text(movie.title),
            subtitle: Text('☆ ${movie.rating} • ${movie.genres.join(', ')}',),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context) => DetailScreen(movie: movie),),);},
            ),
          );
        },
      ),
    );
  }
}

// -------------------- DETAIL SCREEN --------------------

// Màn hình chi tiết phim
class DetailScreen extends StatefulWidget {
  final Movie movie;
  const DetailScreen({
    super.key,
    required this.movie,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  bool favorite = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.movie.title),),
      // SingleChildScrollView giúp màn hình cuộn được
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Ảnh poster lớn
            Image.asset(widget.movie.image, width: double.infinity, height: 220, fit: BoxFit.cover,),

            const SizedBox(height: 16),

            // Tên phim
            Padding(padding: const EdgeInsets.all(16),
              child: Text(widget.movie.title, style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold,),),
            ),

            // Hiển thị genres bằng Chip
            Padding(padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Wrap(spacing: 8, children: widget.movie.genres.map((genre) {
                  return Chip(label: Text(genre));
                }).toList(),
              ),
            ),

            const SizedBox(height: 16),

            // Nội dung mô tả phim
            Padding(padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(widget.movie.overview, style: const TextStyle(fontSize: 16),),),

            const SizedBox(height: 16),

            // Các nút Favorite, Rate, Share
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // Nút Favorite có thể bật/tắt
                IconButton(icon: Icon(favorite ? Icons.favorite : Icons.favorite_border,),
                  onPressed: () {setState(() {favorite = !favorite;});},
                ),

                // Nút Rate
                IconButton(icon: const Icon(Icons.star), onPressed: () {},),

                // Nút Share
                IconButton(icon: const Icon(Icons.share), onPressed: () {},),
              ],
            ),

            const Padding(padding: EdgeInsets.all(16),
              child: Text('Trailers', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),)),

            // Danh sách trailers
            ListView.builder(shrinkWrap: true, physics: const NeverScrollableScrollPhysics(), itemCount: widget.movie.trailers.length, itemBuilder: (context, index) {
              return ListTile(leading: const Icon(Icons.play_circle), title: Text(widget.movie.trailers[index]),);
              },
            ),
          ],
        ),
      ),
    );
  }
}