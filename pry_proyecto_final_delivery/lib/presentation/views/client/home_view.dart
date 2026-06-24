import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../domain/entities/product.dart';
import '../../../themes/esquema_color.dart';
import '../../routes/app_routes.dart';
import '../../viewmodels/address_viewmodel.dart';
import '../../viewmodels/cart_viewmodel.dart';
import '../../viewmodels/product_viewmodel.dart';
import '../../widgets/address_picker_sheet.dart';
import '../../widgets/app_bottom_nav.dart';
import '../../widgets/product_card.dart';
import '../../widgets/promo_banner.dart';
import '../../widgets/section_title.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      await context.read<ProductViewModel>().loadProducts();
      await context.read<AddressViewModel>().loadAddresses();
    });
  }

  void _openAddressSheet() {
    final addressVm = context.read<AddressViewModel>();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => AddressPickerSheet(
        selectedAddress: addressVm.selectedAddress,
        onSelected: addressVm.select,
      ),
    );
  }

  void _addProduct(Product product) {
    final ok = context.read<CartViewModel>().add(product);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(ok ? '${product.name} agregado al carrito' : 'Solo puedes comprar de un local por pedido.'),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final productsVm = context.watch<ProductViewModel>();
    final addressVm = context.watch<AddressViewModel>();
    final cart = context.watch<CartViewModel>();
    final products = productsVm.products;
    final promos = productsVm.discountedProducts.take(8).toList();
    final popular = productsVm.popularProducts;
    final categories = productsVm.categories;
    final selectedAddress = addressVm.selectedAddress;
    final addressLabel = selectedAddress == null ? 'Agregar dirección' : selectedAddress.label;

    return Scaffold(
      bottomNavigationBar: const AppBottomNav(currentIndex: 0),
      body: RefreshIndicator(
        onRefresh: () async {
          await productsVm.loadProducts();
          await addressVm.loadAddresses();
        },
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: _Header(address: addressLabel, cartCount: cart.count, onAddressTap: _openAddressSheet)),
            if (productsVm.loading)
              const SliverFillRemaining(child: Center(child: CircularProgressIndicator()))
            else if (productsVm.error != null)
              SliverFillRemaining(child: Center(child: Text(productsVm.error!)))
            else if (products.isEmpty)
              SliverFillRemaining(
                hasScrollBody: false,
                child: _EmptyHome(onReload: () => productsVm.loadProducts()),
              )
            else ...[
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (promos.isNotEmpty) ...[
                        PromoBanner(
                          title: 'Hasta ${promos.first.discountPercent}% OFF',
                          subtitle: '${promos.first.name} · ${promos.first.restaurantDisplayName}',
                          badge: 'Pedido mín. \$${promos.first.minOrderAmount.toStringAsFixed(2)}',
                          icon: Icons.local_offer_rounded,
                        ),
                        const SizedBox(height: 16),
                      ],
                      if (categories.isNotEmpty) ...[
                        const SectionTitle(title: 'Categorías'),
                        _CategoryGrid(categories: categories, onTap: (category) => Navigator.pushNamed(context, AppRoutes.search, arguments: category)),
                      ],
                      if (popular.isNotEmpty) ...[
                        SectionTitle(title: 'Los más populares', action: 'Ver todo', onAction: () => Navigator.pushNamed(context, AppRoutes.search)),
                        SizedBox(
                          height: 178,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: popular.length,
                            separatorBuilder: (_, __) => const SizedBox(width: 14),
                            itemBuilder: (_, index) => _RestaurantCard(product: popular[index]),
                          ),
                        ),
                      ],
                      const SectionTitle(title: 'Descubre estas opciones'),
                    ],
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                sliver: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 14, crossAxisSpacing: 14, childAspectRatio: .62),
                  delegate: SliverChildBuilderDelegate(
                    (_, index) {
                      final product = products[index];
                      return ProductCard(
                        product: product,
                        onTap: () => Navigator.pushNamed(context, AppRoutes.productDetail, arguments: product),
                        onAdd: () => _addProduct(product),
                      );
                    },
                    childCount: products.length,
                  ),
                ),
              ),
              if (promos.isNotEmpty)
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 28),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SectionTitle(title: 'Promociones disponibles'),
                        SizedBox(
                          height: 290,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: promos.length,
                            separatorBuilder: (_, __) => const SizedBox(width: 14),
                            itemBuilder: (_, index) => ProductCard(
                              compact: true,
                              product: promos[index],
                              onTap: () => Navigator.pushNamed(context, AppRoutes.productDetail, arguments: promos[index]),
                              onAdd: () => _addProduct(promos[index]),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final String address;
  final int cartCount;
  final VoidCallback onAddressTap;
  const _Header({required this.address, required this.cartCount, required this.onAddressTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, MediaQuery.of(context).padding.top + 18, 20, 24),
      decoration: const BoxDecoration(
        color: EsquemaColor.primary,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(26)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: onAddressTap,
                  child: Row(
                    children: [
                      Flexible(child: Text(address, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w900))),
                      const SizedBox(width: 4),
                      const Icon(Icons.keyboard_arrow_down_rounded, color: Colors.white),
                    ],
                  ),
                ),
              ),
              IconButton(onPressed: () {}, icon: const Icon(Icons.notifications_none_rounded, color: Colors.white, size: 30)),
              Stack(
                children: [
                  IconButton(onPressed: () => Navigator.pushNamed(context, AppRoutes.cart), icon: const Icon(Icons.shopping_cart_outlined, color: Colors.white, size: 30)),
                  if (cartCount > 0)
                    Positioned(
                      right: 4,
                      top: 4,
                      child: CircleAvatar(radius: 10, backgroundColor: EsquemaColor.accent, child: Text('$cartCount', style: const TextStyle(color: EsquemaColor.dark, fontSize: 11, fontWeight: FontWeight.w900))),
                    ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 18),
          InkWell(
            onTap: () => Navigator.pushNamed(context, AppRoutes.search),
            borderRadius: BorderRadius.circular(32),
            child: Container(
              height: 58,
              padding: const EdgeInsets.only(left: 20, right: 8),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(32)),
              child: const Row(
                children: [
                  Expanded(child: Text('Locales, platos y productos', style: TextStyle(color: EsquemaColor.muted, fontSize: 17))),
                  CircleAvatar(backgroundColor: EsquemaColor.primary, radius: 24, child: Icon(Icons.search_rounded, color: Colors.white)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CategoryGrid extends StatelessWidget {
  final List<String> categories;
  final ValueChanged<String> onTap;
  const _CategoryGrid({required this.categories, required this.onTap});

  IconData _iconFor(String category) {
    final value = category.toLowerCase();
    if (value.contains('sushi')) return Icons.set_meal_rounded;
    if (value.contains('burger') || value.contains('hamburg')) return Icons.lunch_dining_rounded;
    if (value.contains('bebida')) return Icons.local_drink_rounded;
    if (value.contains('postre')) return Icons.cake_rounded;
    if (value.contains('súper') || value.contains('super')) return Icons.shopping_basket_rounded;
    return Icons.restaurant_menu_rounded;
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: categories.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 14, crossAxisSpacing: 14, childAspectRatio: 1.18),
      itemBuilder: (_, index) {
        final category = categories[index];
        return InkWell(
          onTap: () => onTap(category),
          borderRadius: BorderRadius.circular(24),
          child: Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(color: EsquemaColor.chip, borderRadius: BorderRadius.circular(24)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(_iconFor(category), size: 48, color: EsquemaColor.dark),
                const SizedBox(height: 14),
                Text(category, textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 17, color: EsquemaColor.dark)),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _RestaurantCard extends StatelessWidget {
  final Product product;
  const _RestaurantCard({required this.product});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, AppRoutes.search, arguments: product.restaurantDisplayName),
      borderRadius: BorderRadius.circular(22),
      child: Container(
        width: 220,
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(22)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(22)),
              child: Container(
                height: 92,
                width: double.infinity,
                color: EsquemaColor.chip,
                child: product.restaurantCoverUrl == null
                    ? const Icon(Icons.storefront, size: 52, color: EsquemaColor.muted)
                    : Image.network(product.restaurantCoverUrl!, fit: BoxFit.cover, errorBuilder: (_, __, ___) => const Icon(Icons.storefront, size: 52)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product.restaurantDisplayName, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 16)),
                  const SizedBox(height: 4),
                  Row(children: [
                    const Icon(Icons.star_rounded, size: 16),
                    Text(' ${product.restaurantRating.toStringAsFixed(1)}  ·  ${product.deliveryWindow}', style: const TextStyle(color: EsquemaColor.muted, fontSize: 12)),
                  ]),
                  const SizedBox(height: 4),
                  Text('Envío \$${product.deliveryFee.toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.w800)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _EmptyHome extends StatelessWidget {
  final Future<void> Function() onReload;
  const _EmptyHome({required this.onReload});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(28),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.storefront_outlined, size: 78, color: EsquemaColor.muted),
          const SizedBox(height: 18),
          const Text('No hay productos disponibles', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.w900, fontSize: 24, color: EsquemaColor.dark)),
          const SizedBox(height: 8),
          const Text('Cuando el administrador cargue restaurantes, categorías y productos desde la base de datos, se mostrarán aquí.', textAlign: TextAlign.center, style: TextStyle(color: EsquemaColor.muted)),
          const SizedBox(height: 22),
          OutlinedButton.icon(onPressed: onReload, icon: const Icon(Icons.refresh), label: const Text('Actualizar')),
        ],
      ),
    );
  }
}
