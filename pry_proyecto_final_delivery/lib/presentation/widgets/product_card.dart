import 'package:flutter/material.dart';
import '../../domain/entities/product.dart';
import '../../themes/esquema_color.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onTap;
  final VoidCallback onAdd;
  final bool compact;

  const ProductCard({super.key, required this.product, required this.onTap, required this.onAdd, this.compact = false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        width: compact ? 170 : null,
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                    child: Container(
                      width: double.infinity,
                      color: EsquemaColor.chip,
                      child: product.imageUrl == null || product.imageUrl!.isEmpty
                          ? const Center(child: Icon(Icons.restaurant, size: 58, color: EsquemaColor.muted))
                          : Image.network(product.imageUrl!, fit: BoxFit.cover, errorBuilder: (_, __, ___) => const Center(child: Icon(Icons.restaurant, size: 58))),
                    ),
                  ),
                  if (product.hasDiscount)
                    Positioned(
                      top: 10,
                      left: 10,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                        decoration: BoxDecoration(color: EsquemaColor.accent, borderRadius: BorderRadius.circular(16)),
                        child: Text('${product.discountPercent}% OFF', style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 11, color: EsquemaColor.dark)),
                      ),
                    ),
                  Positioned(
                    right: 10,
                    bottom: 10,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: IconButton(
                        onPressed: product.stock <= 0 ? null : onAdd,
                        icon: const Icon(Icons.add, color: EsquemaColor.dark),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product.name, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(fontWeight: FontWeight.w900, color: EsquemaColor.dark)),
                  const SizedBox(height: 4),
                  Text(product.restaurantDisplayName, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(color: EsquemaColor.muted, fontSize: 12)),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text('\$${product.price.toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 18, color: EsquemaColor.dark)),
                      if (product.originalPrice != null && product.originalPrice! > product.price) ...[
                        const SizedBox(width: 6),
                        Text('\$${product.originalPrice!.toStringAsFixed(2)}', style: const TextStyle(decoration: TextDecoration.lineThrough, color: EsquemaColor.muted, fontSize: 12)),
                      ],
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(Icons.star_rounded, size: 16, color: EsquemaColor.dark),
                      Text(' ${product.restaurantRating.toStringAsFixed(1)}', style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12)),
                      const Text('  ·  ', style: TextStyle(color: EsquemaColor.muted)),
                      const Icon(Icons.schedule_rounded, size: 15, color: EsquemaColor.muted),
                      Text(' ${product.deliveryWindow}', style: const TextStyle(color: EsquemaColor.muted, fontSize: 12)),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
