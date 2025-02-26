import 'package:turkish_marketer/models/lookup_model.dart';

import '../api_service/api_service.dart';
import '../api_service/base_response.dart';
import '../api_service/endpoints.dart';

class LookupRepository {
  final ApiService<LookupModel> apiService;

  LookupRepository({required this.apiService});

  Future<BaseResponse<LookupModel>> getOptionsByType({required String type, required int id}) async {
    return await apiService.fetchData(Endpoints.getOptions, LookupModel.fromJson, data: {"type": type, "id": id});
  }
}
