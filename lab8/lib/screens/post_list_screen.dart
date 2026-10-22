import 'package:flutter/material.dart';
import '../models/post.dart';
import '../services/api_service.dart';

class PostListScreen extends StatefulWidget {
  const PostListScreen({super.key});

  @override
  State<PostListScreen> createState() => _PostListScreenState();
}

class _PostListScreenState extends State<PostListScreen> {
  final ApiService _apiService = ApiService();
  late final Future<List<Post>> _postsFuture;

  @override
  void initState() {
    super.initState();
    // Lưu Future một lần để build() không gọi API lặp lại.
    _postsFuture = _apiService.fetchPosts();
  }

  @override
  void dispose() {
    _apiService.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Post>>(
      future: _postsFuture,
      builder: (context, snapshot) {
        // Trong lúc chờ API, hiện vòng tròn tải.
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        // Lỗi mạng, HTTP hoặc JSON đều được FutureBuilder đưa vào đây.
        if (snapshot.hasError) {
          return const Center(
            child: Text('Không tải được bài viết. Hãy kiểm tra Internet.'),
          );
        }

        final posts = snapshot.data ?? <Post>[];
        if (posts.isEmpty) {
          return const Center(child: Text('Không có bài viết nào.'));
        }

        // builder tạo các hàng cần hiển thị khi cuộn danh sách.
        return ListView.builder(
          itemCount: posts.length,
          itemBuilder: (context, index) {
            final post = posts[index];
            return ListTile(
              title: Text(post.title),
              subtitle: Text('ID: ${post.id}'),
            );
          },
        );
      },
    );
  }
}
