import '../../data/repositories/policy_repository.dart';
import '../entities/policy_entity.dart';

class GetPoliciesUseCase {
  final PolicyRepository repository;

  GetPoliciesUseCase(this.repository);

  Future<List<PolicyEntity>> call() {
    return repository.getPolicies();
  }
}
