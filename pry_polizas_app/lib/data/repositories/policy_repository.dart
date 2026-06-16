import '../../domain/entities/policy_entity.dart';
import '../datasource/policy_remote_datasource.dart';

class PolicyRepository {
  final PolicyRemoteDataSource remoteDataSource;

  PolicyRepository({required this.remoteDataSource});

  Future<List<PolicyEntity>> getPolicies() {
    return remoteDataSource.getPolicies();
  }

  Future<PolicyEntity> getPolicyByCode(String code) {
    return remoteDataSource.getPolicyByCode(code);
  }

  Future<PolicyEntity> createPolicy(PolicyEntity policy) {
    return remoteDataSource.createPolicy(policy);
  }

  Future<PolicyEntity> updatePolicy(PolicyEntity policy) {
    return remoteDataSource.updatePolicy(policy);
  }

  Future<void> deletePolicy(String code) {
    return remoteDataSource.deletePolicy(code);
  }
}
