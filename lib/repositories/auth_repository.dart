import '../api_service/api_service.dart';
import '../api_service/base_response.dart';
import '../api_service/endpoints.dart';
import '../models/user_model.dart';

class AuthRepository {
  final ApiService<UserModel> apiService;

  AuthRepository({required this.apiService});

  Future<BaseResponse<UserModel>> login(String email, String password) async {
    final data = {
      'email': email,
      'password': password,
    };
    return await apiService.postData(Endpoints.login, data, UserModel.fromJson);
  }

  Future<BaseResponse<UserModel>> signUp(
    String name,
    String email,
    String password,
    String mobile,
    String mobileIntro,
    String countryId,
    // String governorateId,
    // String cityId,
  ) async {
    final data = {
      'name': name,
      'email': email,
      'password': password,
      'mobile': mobile,
      'mobile_intro': mobileIntro,
      'country_id': countryId,
    };
    return await apiService.postData(Endpoints.signUp, data, UserModel.fromJson);
  }

  Future<BaseResponse<UserModel>> verifyEmail(String activeCode) async {
    final data = {
      'code': activeCode,
    };
    return await apiService.postData(Endpoints.verifyEmail, data, UserModel.fromJson);
  }

  Future<BaseResponse<UserModel>> resendActivationCode() async {
    return await apiService.postData(Endpoints.resendActivationCode, {}, UserModel.fromJson);
  }

  Future<BaseResponse<UserModel>> addCompany(
    String title,
    //String email,
    String companyTypeId,
    String mobile,
    String website,
    String countryId,
    //String governorateId,
    //String cityId,
    String taxOffice,
    String license,
    String description,
  ) async {
    final data = {
      'title': title,
      //'email': email,
      'tax_number': mobile,
      'company_type_id': companyTypeId,
      'country_id': countryId,
      //'governorate_id': governorateId,
      //'city_id': cityId,
      'website': website,
      'tax_office': taxOffice,
      'description': description,
    };
    return await apiService.postWithImage(Endpoints.addCompany, data, "license", license, UserModel.fromJson);
  }
}
