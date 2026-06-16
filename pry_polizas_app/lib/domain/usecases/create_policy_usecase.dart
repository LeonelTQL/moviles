import '../../data/repositories/policy_repository.dart';
import '../entities/policy_entity.dart';

class CreatePolicyUseCase {
  final PolicyRepository repository;

  CreatePolicyUseCase(this.repository);

  Future<PolicyEntity> call(PolicyEntity policy) {
    return repository.createPolicy(policy);
  }
}
