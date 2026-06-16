import '../../data/repositories/policy_repository.dart';

class DeletePolicyUseCase {
  final PolicyRepository repository;

  DeletePolicyUseCase(this.repository);

  Future<void> call(String code) {
    return repository.deletePolicy(code);
  }
}
