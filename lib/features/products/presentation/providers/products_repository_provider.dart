import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teslo_shop/features/auth/presentation/providers/auth_provider.dart';
import 'package:teslo_shop/features/products/domain/repositories/products_repository_domain.dart';
import 'package:teslo_shop/features/products/infraestructure/datasources/products_datasource_infra.dart';
import 'package:teslo_shop/features/products/infraestructure/repositories/products_repository_infra.dart';

final productsRepositoryProvider = Provider<ProductsRepositoryDomain>((ref) {
  final accesToken = ref.watch(authProvider).user?.token ?? '';
  final productsRepository = ProductsRepositoryInfraestructure(
      ProductsDatasourceInfraestructure(accesToken: accesToken));
  return productsRepository;
});
