import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../domain/entities/address.dart';
import '../../themes/esquema_color.dart';
import '../viewmodels/address_viewmodel.dart';
import '../viewmodels/delivery_viewmodel.dart';
import 'custom_text_field.dart';

class AddressPickerSheet extends StatefulWidget {
  final Address? selectedAddress;
  final ValueChanged<Address> onSelected;

  const AddressPickerSheet({
    super.key,
    required this.selectedAddress,
    required this.onSelected,
  });

  @override
  State<AddressPickerSheet> createState() => _AddressPickerSheetState();
}

class _AddressPickerSheetState extends State<AddressPickerSheet> {
  bool _adding = false;
  final _formKey = GlobalKey<FormState>();
  final _label = TextEditingController();
  final _addressLine = TextEditingController();
  double? _lat;
  double? _lng;

  @override
  void dispose() {
    _label.dispose();
    _addressLine.dispose();
    super.dispose();
  }

  Future<void> _captureGps() async {
    final position = await context.read<DeliveryViewModel>().getCurrentPosition();
    if (!mounted) return;
    if (position == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No se pudo obtener la ubicación GPS.')),
      );
      return;
    }
    setState(() {
      _lat = position.latitude;
      _lng = position.longitude;
    });
  }

  Future<void> _saveAddress() async {
    if (!_formKey.currentState!.validate()) return;
    if (_lat == null || _lng == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Captura la ubicación GPS para guardar la dirección.')),
      );
      return;
    }
    final address = await context.read<AddressViewModel>().createAddress(
          label: _label.text.trim(),
          addressLine: _addressLine.text.trim(),
          latitude: _lat!,
          longitude: _lng!,
          isDefault: true,
        );
    if (!mounted || address == null) return;
    widget.onSelected(address);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AddressViewModel>();
    return Container(
      constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * .82),
      padding: EdgeInsets.fromLTRB(24, 18, 24, MediaQuery.of(context).padding.bottom + 24),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: _adding ? _buildForm(vm) : _buildList(vm),
    );
  }

  Widget _buildList(AddressViewModel vm) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            const Expanded(child: Text('Elige tu dirección', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.w900, fontSize: 26, color: EsquemaColor.dark))),
            IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.close, size: 30)),
          ],
        ),
        const SizedBox(height: 12),
        if (vm.loading)
          const Padding(padding: EdgeInsets.all(28), child: Center(child: CircularProgressIndicator()))
        else if (vm.addresses.isEmpty)
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 28),
            child: Column(
              children: [
                Icon(Icons.location_off_outlined, size: 56, color: EsquemaColor.muted),
                SizedBox(height: 12),
                Text('No tienes direcciones registradas.', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.w800, color: EsquemaColor.dark)),
                SizedBox(height: 4),
                Text('Agrega una dirección para poder registrar pedidos.', textAlign: TextAlign.center, style: TextStyle(color: EsquemaColor.muted)),
              ],
            ),
          )
        else
          Flexible(
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: vm.addresses.length,
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (_, index) {
                final address = vm.addresses[index];
                final selected = widget.selectedAddress?.id == address.id || vm.selectedAddress?.id == address.id;
                return ListTile(
                  contentPadding: const EdgeInsets.symmetric(vertical: 8),
                  leading: Icon(address.isDefault ? Icons.stars_rounded : Icons.location_on_outlined, color: EsquemaColor.dark),
                  title: Text(address.label, style: const TextStyle(fontWeight: FontWeight.w900, color: EsquemaColor.dark)),
                  subtitle: Text(address.addressLine),
                  trailing: selected ? const Icon(Icons.check_circle, color: EsquemaColor.success) : null,
                  onTap: () {
                    context.read<AddressViewModel>().select(address);
                    widget.onSelected(address);
                    Navigator.pop(context);
                  },
                );
              },
            ),
          ),
        const SizedBox(height: 16),
        OutlinedButton.icon(
          onPressed: () => setState(() => _adding = true),
          icon: const Icon(Icons.add),
          label: const Text('Agregar dirección'),
        ),
      ],
    );
  }

  Widget _buildForm(AddressViewModel vm) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              IconButton(onPressed: () => setState(() => _adding = false), icon: const Icon(Icons.arrow_back)),
              const Expanded(child: Text('Nueva dirección', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.w900, fontSize: 24, color: EsquemaColor.dark))),
              const SizedBox(width: 48),
            ],
          ),
          const SizedBox(height: 14),
          CustomTextField(controller: _label, label: 'Etiqueta', validator: (value) => value != null && value.trim().length >= 2 ? null : 'Etiqueta requerida'),
          const SizedBox(height: 12),
          CustomTextField(controller: _addressLine, label: 'Dirección completa', maxLines: 2, validator: (value) => value != null && value.trim().length >= 5 ? null : 'Dirección requerida'),
          const SizedBox(height: 12),
          OutlinedButton.icon(
            onPressed: _captureGps,
            icon: const Icon(Icons.my_location),
            label: Text(_lat == null ? 'Capturar ubicación GPS' : 'GPS listo: ${_lat!.toStringAsFixed(5)}, ${_lng!.toStringAsFixed(5)}'),
          ),
          if (vm.error != null) ...[
            const SizedBox(height: 10),
            Text(vm.error!, style: const TextStyle(color: EsquemaColor.danger)),
          ],
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: vm.loading ? null : _saveAddress,
            child: vm.loading ? const SizedBox(width: 22, height: 22, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white)) : const Text('Guardar dirección'),
          ),
        ],
      ),
    );
  }
}
