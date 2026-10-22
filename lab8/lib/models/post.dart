// Model giữ hai thông tin sẽ hiển thị trên mỗi hàng của danh sách.
class Post {
  final int id;
  final String title;

  const Post({required this.id, required this.title});

  // Đọc một object JSON và tạo ra một Post có kiểu dữ liệu rõ ràng.
  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(id: json['id'] as int, title: json['title'] as String);
  }
}
