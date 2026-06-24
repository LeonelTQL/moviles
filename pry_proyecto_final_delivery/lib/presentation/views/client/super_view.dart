import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../themes/esquema_color.dart';
import '../../routes/app_routes.dart';
import '../../viewmodels/cart_viewmodel.dart';
import '../../viewmodels/product_viewmodel.dart';
import '../../widgets/app_bottom_nav.dart';
import '../../widgets/product_card.dart';

class SuperView extends StatefulWidget {
  const SuperView({super.key});

  @override
  State<SuperView> createState() => _SuperViewState();
}

class _SuperViewState extends State<SuperView> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<ProductViewModel>().loadProducts(search: 'bebida'));
  }

  @override
  Widget build(BuildContext context) {
    final products = context.watch<ProductViewModel>().products;
    return Scaffold(
      appBar: AppBar(title: const Text('Súper'), actions: [IconButton(onPressed: () => Navigator.pushNamed(context, AppRoutes.cart), icon: const Icon(Icons.shopping_cart_outlined))]),
      bottomNavigationBar: const AppBottomNav(currentIndex: 1),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(color: EsquemaColor.chip, borderRadius: BorderRadius.circular(24)),
            child: const Row(children: [
              Icon(Icons.shopping_basket_rounded, size: 54, color: EsquemaColor.dark),
              SizedBox(width: 16),
              Expanded(child: Text('Productos de mercado y acompañantes. Sin productos restringidos ni ventas reguladas.', style: TextStyle(fontWeight: FontWeight.w800))),
            ]),
          ),
          const SizedBox(height: 22),
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
