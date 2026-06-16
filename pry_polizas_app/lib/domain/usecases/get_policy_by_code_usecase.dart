import '../../data/repositories/policy_repository.dart';
import '../entities/policy_entity.dart';

class GetPolicyByCodeUseCase {
  final PolicyRepository repository;

  GetPolicyByCodeUseCase(this.repository);

  Future<PolicyEntity> call(String code) {
    return repository.getPolicyByCode(code);
  }
}
