import '../models/post_model.dart';
import '../services/post_api_service.dart';

class PostRepository {
  final PostApiService _apiService = PostApiService();

  Future<PostModel> createNewPost(PostModel newPost) async {
    // 1. Lấy dữ liệu Model biến thành Map (toJson)
    final postMap = newPost.toJson();
    
    // 2. Gửi qua Service
    final responseData = await _apiService.createPost(postMap);
    
    // 3. Trả về Object đã được Server cấp ID
    return PostModel.fromJson(responseData);
  }
}