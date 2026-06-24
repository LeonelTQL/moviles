class AppUser {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String role;
  final String? avatarUrl;

  const AppUser({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.role,
    this.avatarUrl,
  });

  bool get isAdmin => role == 'admin';
  bool get isClient => role == 'cliente';
  bool get isDelivery => role == 'repartidor';
}
