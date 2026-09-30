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
      title: 'Lab 6 Responsive UI',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blue,),
      home: const GenreScreen(),
    );
  }
}

class Movie {
  final String title;
  final int year;
  final List<String> genres;
  final String posterUrl;
  final double rating;

  Movie({
    required this.title,
    required this.year,
    required this.genres,
    required this.posterUrl,
    required this.rating,
  });
}

final List<Movie> allMovies = [
  Movie(
    title: 'Avatar',
    year: 2009,
    genres: ['Action', 'Adventure', 'Sci-Fi'],
    posterUrl:
    'https://m.media-amazon.com/images/I/61OUGpUfAyL._AC_UF894,1000_QL80_.jpg',
    rating: 8.0,
  ),
  Movie(
    title: 'Inception',
    year: 2010,
    genres: ['Action', 'Drama', 'Sci-Fi'],
    posterUrl:
    'https://image.tmdb.org/t/p/original/xlaY2zyzMfkhk0HSC5VUwzoZPU1.jpg',
    rating: 8.8,
  ),
  Movie(
    title: 'Joker',
    year: 2019,
    genres: ['Drama'],
    posterUrl:
    'https://i.ebayimg.com/images/g/hWIAAOSwSgddZ-7M/s-l1200.jpg',
    rating: 8.4,
  ),
  Movie(
    title: 'Deadpool',
    year: 2016,
    genres: ['Action', 'Comedy'],
    posterUrl:
    'https://m.media-amazon.com/images/M/MV5BNzY3ZWU5NGQtOTViNC00ZWVmLTliNjAtNzViNzlkZWQ4YzQ4XkEyXkFqcGc@._V1_FMjpg_UX1000_.jpg',
    rating: 8.0,
  ),
  Movie(
    title: 'Inside Out',
    year: 2015,
    genres: ['Comedy', 'Family'],
    posterUrl:
    'https://image.tmdb.org/t/p/original/lRHE0vzf3oYJrhbsHXjIkF4Tl5A.jpg',
    rating: 8.1,
  ),
];

// -------------------- GENRE SCREEN --------------------

class GenreScreen extends StatefulWidget {
  const GenreScreen({super.key});

  @override
  State<GenreScreen> createState() => _GenreScreenState();
}

class _GenreScreenState extends State<GenreScreen> {
  // Lưu nội dung người dùng nhập trong ô search
  String searchQuery = '';

  // Lưu các thể loại đang được chọn
  Set<String> selectedGenres = {};

  // Lưu kiểu sắp xếp đang được chọn
  String selectedSort = 'A-Z';

  // Danh sách thể loại hiển thị bằng chip
  final List<String> genres = [
    'Action',
    'Adventure',
    'Comedy',
    'Drama',
    'Family',
    'Sci-Fi',
  ];

  @override
  Widget build(BuildContext context) {
    // MediaQuery dùng để lấy kích thước màn hình
    double screenWidth = MediaQuery.of(context).size.width;

    // Lấy danh sách phim sau khi filter và sort
    List<Movie> visibleMovies = getVisibleMovies();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Tiêu đề màn hình
              const Text(
                'Find a Movie',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 16),

              // Dòng này giúp thấy màn hình đang rộng bao nhiêu
              Text('Screen width: ${screenWidth.toInt()} px'),

              const SizedBox(height: 16),

              // -------------------- SEARCH BAR --------------------
              // TextField dùng để nhập tên phim cần tìm
              TextField(
                decoration: InputDecoration(
                  hintText: 'Search movie...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),

                // Khi người dùng nhập chữ, cập nhật searchQuery
                onChanged: (value) {
                  setState(() {
                    searchQuery = value;
                  });
                },
              ),

              const SizedBox(height: 16),

              // -------------------- GENRE CHIPS --------------------
              const Text(
                'Genres',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 8),

              // Wrap giúp các chip tự xuống dòng khi màn hình nhỏ
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: genres.map((genre) {
                  // Kiểm tra genre này có đang được chọn không
                  bool isSelected = selectedGenres.contains(genre);

                  return FilterChip(
                    label: Text(genre),
                    selected: isSelected,

                    // Bấm chip để chọn hoặc bỏ chọn genre
                    onSelected: (value) {
                      setState(() {
                        if (isSelected) {
                          selectedGenres.remove(genre);
                        } else {
                          selectedGenres.add(genre);
                        }
                      });
                    },
                  );
                }).toList(),
              ),

              const SizedBox(height: 16),

              // -------------------- SORT DROPDOWN --------------------

              Row(
                children: [
                  const Text('Sort by: '),

                  const SizedBox(width: 12),

                  // DropdownButton dùng để chọn kiểu sắp xếp
                  DropdownButton<String>(
                    value: selectedSort,
                    items: const [
                      DropdownMenuItem(value: 'A-Z', child: Text('A-Z')),
                      DropdownMenuItem(value: 'Z-A', child: Text('Z-A')),
                      DropdownMenuItem(value: 'Year', child: Text('Year')),
                      DropdownMenuItem(value: 'Rating', child: Text('Rating')),
                    ],

                    // Khi chọn sort mới thì cập nhật selectedSort
                    onChanged: (value) {
                      setState(() {
                        selectedSort = value!;
                      });
                    },
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // -------------------- RESPONSIVE MOVIE LIST --------------------

              // Expanded giúp danh sách chiếm phần còn lại của màn hình
              Expanded(
                // LayoutBuilder giúp kiểm tra chiều rộng khu vực danh sách
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    // Nếu màn hình rộng từ 800px trở lên thì dùng GridView 2 cột
                    if (constraints.maxWidth >= 800) {
                      return GridView.builder(
                        itemCount: visibleMovies.length,
                        gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 2.6,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                        ),
                        itemBuilder: (context, index) {
                          return movieCard(visibleMovies[index]);
                        },
                      );
                    }

                    // Nếu màn hình nhỏ thì dùng ListView 1 cột
                    return ListView.builder(
                      itemCount: visibleMovies.length,
                      itemBuilder: (context, index) {
                        return movieCard(visibleMovies[index]);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // -------------------- FILTER VÀ SORT --------------------

  // Hàm này lọc phim theo search + genre, sau đó sắp xếp
  List<Movie> getVisibleMovies() {
    List<Movie> result = allMovies.where((movie) {
      // Tìm theo tên phim, không phân biệt chữ hoa/thường
      bool matchSearch =
      movie.title.toLowerCase().contains(searchQuery.toLowerCase());

      // Nếu chưa chọn genre nào thì hiện tất cả
      // Nếu có chọn genre thì phim phải có ít nhất 1 genre được chọn
      bool matchGenre = selectedGenres.isEmpty ||
          movie.genres.any((genre) => selectedGenres.contains(genre));

      return matchSearch && matchGenre;
    }).toList();

    // Sắp xếp danh sách theo lựa chọn
    if (selectedSort == 'A-Z') {
      result.sort((a, b) => a.title.compareTo(b.title));
    } else if (selectedSort == 'Z-A') {
      result.sort((a, b) => b.title.compareTo(a.title));
    } else if (selectedSort == 'Year') {
      result.sort((a, b) => b.year.compareTo(a.year));
    } else if (selectedSort == 'Rating') {
      result.sort((a, b) => b.rating.compareTo(a.rating));
    }

    return result;
  }

  // -------------------- MOVIE CARD --------------------

  // Widget hiển thị một phim
  Widget movieCard(Movie movie) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Image.network(
          movie.posterUrl,
          width: 140,
          height: 210,
          fit: BoxFit.cover,

            // Nếu ảnh lỗi thì hiển thị icon lỗi ảnh
            errorBuilder: (context, error, stackTrace) {
              return const SizedBox(
                width: 100,
                height: 150,
                child: Center(
                  child: Icon(Icons.broken_image),
                ),
              );
            },
          ),

          const SizedBox(width: 12),

          // Expanded giúp phần chữ không bị tràn màn hình
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Tên phim
                  Text(
                    movie.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 6),

                  // Năm phát hành
                  Text('Year: ${movie.year}'),

                  const SizedBox(height: 6),

                  // Rating
                  Text('Rating: ${movie.rating}'),

                  const SizedBox(height: 6),

                  // Danh sách thể loại
                  Text('Genres: ${movie.genres.join(', ')}'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}