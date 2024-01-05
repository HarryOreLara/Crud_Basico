import 'package:teslo_shop/features/products/domain/domain.dart';

class ProductsRepositoryInfraestructure extends ProductsRepositoryDomain {
  final ProductsDatasourceDomain productsDatasourceDomain;

  ProductsRepositoryInfraestructure(this.productsDatasourceDomain);

  @override
  Future<Product> createUpdateProduct(Map<String, dynamic> productLike) {
    return productsDatasourceDomain.createUpdateProduct(productLike);
  }

  @override
  Future<Product> getProductsById(String id) {
    return productsDatasourceDomain.getProductsById(id);
  }

  @override
  Future<List<Product>> getProductsByPage({int limit = 10, int offset = 10}) {
    return productsDatasourceDomain.getProductsByPage(
        limit: limit, offset: offset);
  }

  @override
  Future<List<Product>> searchProductByTerm(String term) {
    return productsDatasourceDomain.searchProductByTerm(term);
  }
}
