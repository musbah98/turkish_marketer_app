import '../api_service/api_service.dart';
import '../api_service/base_response.dart';
import '../api_service/endpoints.dart';
import '../models/registration_info_model.dart';

class RegistrationInfoRepository {
  final ApiService<RegistrationInfoModel> apiService;

  RegistrationInfoRepository({required this.apiService});

  Future<BaseResponse<RegistrationInfoModel>> getSignUpInfo() async {
    return await apiService.fetchData(Endpoints.signUp, RegistrationInfoModel.fromJson);
  }

  Future<BaseResponse<RegistrationInfoModel>> getAddCompanyInfo() async {
    return await apiService.fetchData(Endpoints.addCompany, RegistrationInfoModel.fromJson);
  }
}
