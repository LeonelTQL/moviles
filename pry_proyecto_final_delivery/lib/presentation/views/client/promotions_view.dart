import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../themes/esquema_color.dart';
import '../../routes/app_routes.dart';
import '../../viewmodels/cart_viewmodel.dart';
import '../../viewmodels/product_viewmodel.dart';
import '../../widgets/app_bottom_nav.dart';
import '../../widgets/product_card.dart';
import '../../widgets/promo_banner.dart';

class PromotionsView extends StatefulWidget {
  const PromotionsView({super.key});

  @override
  State<PromotionsView> createState() => _PromotionsViewState();
}

class _PromotionsViewState extends State<PromotionsView> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<ProductViewModel>().loadProducts());
  }

  @override
  Widget build(BuildContext context) {
    final productsVm = context.watch<ProductViewModel>();
    final products = productsVm.discountedProducts;
    final top = products.isNotEmpty ? products.first : null;
    return Scaffold(
      appBar: AppBar(title: const Text('Promociones'), actions: [IconButton(onPressed: () => Navigator.pushNamed(context, AppRoutes.cart), icon: const Icon(Icons.shopping_cart_outlined))]),
      bottomNavigationBar: const AppBottomNav(currentIndex: 2),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          if (top != null) ...[
            PromoBanner(
              title: '${top.discountPercent}% OFF',
              subtitle: '${top.name} · ${top.restaurantDisplayName}',
              badge: 'Pedido mín. \$${top.minOrderAmount.toStringAsFixed(2)}',
              icon: Icons.percent_rounded,
            ),
            const SizedBox(height: 22),
          ],
          const Text('Promos disponibles', style: TextStyle(fontSize: 26, fontWeight: FontWeight.w900, color: EsquemaColor.dark)),
          const SizedBox(height: 16),
          if (productsVm.loading)
            const Padding(padding: EdgeInsets.all(40), child: Center(child: CircularProgressIndicator()))
          else if (products.isEmpty)
            const Padding(
              padding: EdgeInsets.all(34),
              child: Center(child: Text('No hay promociones activas en la base de datos.')),
            )
          else
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: products.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 14, crossAxisSpacing: 14, childAspectRatio: .62),
              itemBuilder: (_, index) => ProductCard(
                product: products[index],
                onTap: () => Navigator.pushNamed(context, AppRoutes.productDetail, arguments: products[index]),
                onAdd: () => context.read<CartViewModel>().add(products[index]),
              ),
            ),
        ],
      ),
    );
  }
}
