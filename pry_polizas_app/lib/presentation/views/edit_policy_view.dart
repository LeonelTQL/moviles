import 'package:flutter/material.dart';

import '../../domain/entities/policy_entity.dart';
import 'policy_form_view.dart';

class EditPolicyView extends StatelessWidget {
  final PolicyEntity policy;

  const EditPolicyView({super.key, required this.policy});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Editar ${policy.codigo}')),
      body: PolicyFormView(policy: policy),
    );
  }
}
