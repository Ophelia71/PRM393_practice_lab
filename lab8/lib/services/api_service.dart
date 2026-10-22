import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/post.dart';

// Service chỉ phụ trách gọi API và chuyển JSON thành danh sách Post.
class ApiService {
  final http.Client _client;

  // Có thể truyền Client giả khi kiểm thử; chạy thật sẽ tự tạo Client.
  ApiService({http.Client? client}) : _client = client ?? http.Client();

  Future<List<Post>> fetchPosts() async {
    final url = Uri.parse('https://jsonplaceholder.typicode.com/posts');
    final response = await _client.get(url);

    if (response.statusCode != 200) {
      throw Exception('Không tải được bài viết (HTTP ${response.statusCode}).');
    }

    // json.decode tạo List/Map của Dart; nó chưa tạo đối tượng Post.
    final data = json.decode(utf8.decode(response.bodyBytes));
    if (data is! List) {
      throw const FormatException('API không trả về danh sách bài viết.');
    }

    final posts = <Post>[];
    for (final item in data) {
      if (item is! Map<String, dynamic>) {
        throw const FormatException('Một bài viết không đúng định dạng.');
      }
      posts.add(Post.fromJson(item));
    }
    return posts;
  }

  void close() => _client.close();
}
