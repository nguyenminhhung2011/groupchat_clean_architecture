import '../repositories/api_respositoy.dart';

class GetCurrentUidUseCase {
  final ApiRespository respository;
  GetCurrentUidUseCase({required this.respository});
  Future<String> call() => respository.getCurrentUId();
}
