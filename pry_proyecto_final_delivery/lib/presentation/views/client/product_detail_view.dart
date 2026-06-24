import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../domain/entities/product.dart';
import '../../../themes/esquema_color.dart';
import '../../viewmodels/cart_viewmodel.dart';

class ProductDetailView extends StatefulWidget {
  const ProductDetailView({super.key});

  @override
  State<ProductDetailView> createState() => _ProductDetailViewState();
}

class _ProductDetailViewState extends State<ProductDetailView> {
  int _quantity = 1;

  @override
  Widget build(BuildContext context) {
    final product = ModalRoute.of(context)!.settings.arguments as Product;
    final total = product.price * _quantity;
    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 340,
                pinned: true,
                backgroundColor: Colors.white,
                leading: Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: CircleAvatar(backgroundColor: Colors.white, child: IconButton(icon: const Icon(Icons.arrow_back, color: EsquemaColor.dark), onPressed: () => Navigator.pop(context))),
                ),
                actions: [
                  CircleAvatar(backgroundColor: Colors.white, child: IconButton(onPressed: () {}, icon: const Icon(Icons.favorite_border, color: EsquemaColor.dark))),
                  const SizedBox(width: 12),
                ],
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                    color: EsquemaColor.chip,
                    child: product.imageUrl == null || product.imageUrl!.isEmpty
                        ? const Center(child: Icon(Icons.restaurant_menu, size: 120, color: EsquemaColor.muted))
                        : Image.network(product.imageUrl!, fit: BoxFit.cover, errorBuilder: (_, __, ___) => const Center(child: Icon(Icons.restaurant_menu, size: 120))),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24, 22, 24, 130),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.star_rounded, color: EsquemaColor.dark, size: 20),
                          Text(' ${product.restaurantRating.toStringAsFixed(1)} (${product.ratingCount})', style: const TextStyle(fontWeight: FontWeight.w800)),
                          const SizedBox(width: 12),
                          const Icon(Icons.storefront_rounded, color: EsquemaColor.dark, size: 18),
                          Expanded(child: Text(' ${product.restaurantDisplayName}', overflow: TextOverflow.ellipsis, style: const TextStyle(fontWeight: FontWeight.w800))),
                        ],
                      ),
                      const SizedBox(height: 18),
                      Text(product.name, style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 28, color: EsquemaColor.dark)),
                      const SizedBox(height: 8),
                      if (product.description != null && product.description!.trim().isNotEmpty)
                        Text(product.description!, style: const TextStyle(color: EsquemaColor.muted, fontSize: 17))
                      else
                        const Text('Este producto aún no tiene descripción registrada.', style: TextStyle(color: EsquemaColor.muted, fontSize: 17)),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Text('\$${product.price.toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 30, color: EsquemaColor.dark)),
                          if (product.originalPrice != null && product.originalPrice! > product.price) ...[
                            const SizedBox(width: 8),
                            Text('\$${product.originalPrice!.toStringAsFixed(2)}', style: const TextStyle(decoration: TextDecoration.lineThrough, color: EsquemaColor.muted, fontSize: 17)),
                          ],
                        ],
                      ),
                      if (product.hasDiscount) ...[
                        const SizedBox(height: 10),
                        Wrap(
                          spacing: 8,
                          children: [
                            Chip(label: Text('${product.discountPercent}% DSCTO'), backgroundColor: EsquemaColor.accent, labelStyle: const TextStyle(color: EsquemaColor.dark, fontWeight: FontWeight.w900)),
                          ],
                        ),
                      ],
                      const SizedBox(height: 26),
                      _InfoBlock(
                        title: 'Datos del local',
                        lines: [
                          'Entrega estimada: ${product.deliveryWindow}',
                          'Costo de envío: \$${product.deliveryFee.toStringAsFixed(2)}',
                          'Pedido mínimo: \$${product.minOrderAmount.toStringAsFixed(2)}',
                          'Stock disponible: ${product.stock}',
                        ],
                      ),
                      const SizedBox(height: 18),
                      const _InfoBlock(
                        title: 'Personalización',
                        lines: ['Este producto no tiene opciones configuradas en la base de datos.'],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: SafeArea(
              top: false,
              child: Container(
                padding: const EdgeInsets.fromLTRB(22, 18, 22, 18),
                decoration: const BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(color: Color(0x16000000), blurRadius: 20, offset: Offset(0, -6))]),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(color: EsquemaColor.chip, borderRadius: BorderRadius.circular(26)),
                      child: Row(
                        children: [
                          IconButton(onPressed: _quantity > 1 ? () => setState(() => _quantity--) : null, icon: const Icon(Icons.remove)),
                          Text('$_quantity', style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 18)),
                          IconButton(onPressed: _quantity < product.stock ? () => setState(() => _quantity++) : null, icon: const Icon(Icons.add)),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: product.stock <= 0
                            ? null
                            : () {
                                final cart = context.read<CartViewModel>();
                                if (!cart.canAccept(product)) {
                                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Solo puedes comprar de un local por pedido.')));
                                  return;
                                }
                                for (var i = 0; i < _quantity; i++) {
                                  cart.add(product);
                                }
                                Navigator.pop(context);
                              },
                        child: Text('Agregar  ·  \$${total.toStringAsFixed(2)}'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoBlock extends StatelessWidget {
  final String title;
  final List<String> lines;
  const _InfoBlock({required this.title, required this.lines});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: EsquemaColor.chip, borderRadius: BorderRadius.circular(18)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 18, color: EsquemaColor.dark)),
          const SizedBox(height: 8),
          ...lines.map((line) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: Text(line, style: const TextStyle(color: EsquemaColor.muted)),
              )),
        ],
      ),
    );
  }
}
