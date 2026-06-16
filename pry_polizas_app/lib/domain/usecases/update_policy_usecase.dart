import '../../data/repositories/policy_repository.dart';
import '../entities/policy_entity.dart';

class UpdatePolicyUseCase {
  final PolicyRepository repository;

  UpdatePolicyUseCase(this.repository);

  Future<PolicyEntity> call(PolicyEntity policy) {
    return repository.updatePolicy(policy);
  }
}
