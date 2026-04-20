import '../models/user_model.dart';
import '../services/user_api_service.dart';

class UserRepository {
  final UserApiService _apiService = UserApiService();

  Future<UserModel> getUser() async {
    final rawData = await _apiService.fetchUser();
    return UserModel.fromJson(rawData);
  }

  Future<UserModel> updateUser(UserModel user) async {
    final rawData = await _apiService.updateUser(user.toJson());
    return UserModel.fromJson(rawData);
  }
}