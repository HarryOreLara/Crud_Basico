import 'package:dio/dio.dart';
import 'package:teslo_shop/config/constants/enviroments.dart';
import 'package:teslo_shop/features/products/domain/domain.dart';
import 'package:teslo_shop/features/products/infraestructure/mappers/product_mapper.dart';

class ProductsDatasourceInfraestructure extends ProductsDatasourceDomain {
  late final Dio dio;
  final String accesToken;

  ProductsDatasourceInfraestructure({required this.accesToken})
      : dio = Dio(BaseOptions(
            baseUrl: Enviroment.apiUrl,
            headers: {'Authorization': 'Bearer $accesToken'}));

  @override
  Future<Product> createUpdateProduct(Map<String, dynamic> productLike) {
    // TODO: implement createUpdateProduct
    throw UnimplementedError();
  }

  @override
  Future<Product> getProductsById(String id) {
    // TODO: implement getProductsById
    throw UnimplementedError();
  }

  @override
  Future<List<Product>> getProductsByPage(
      {int limit = 10, int offset = 10}) async {
    final response =
        await dio.get<List>('/products?limit=$limit&offset=$offset');
    final List<Product> products = [];

    for (final product in response.data ?? []) {
      products.add(ProductMapper.jsonToEntity(product));
    }
    return products;
  }

  @override
  Future<List<Product>> searchProductByTerm(String term) {
    // TODO: implement searchProductByTerm
    throw UnimplementedError();
  }
}
