part of 'product_bloc.dart';

abstract class ProductStateBloc extends Equatable {
  const ProductStateBloc();
  @override
  List<Object> get props => [];
}

// all student list state
class ProductListLoading extends ProductStateBloc {}

class ProductListEmpty extends ProductStateBloc {}

class ProductListError extends ProductStateBloc {
  final String message;

  const ProductListError(this.message);

  @override
  List<Object> get props => [message];
}

class ProductListSuccess extends ProductStateBloc {
  final List<ProductEntity> products;

  const ProductListSuccess(this.products);

  @override
  List<Object> get props => [products];
}

// all student detail state
class ProductLoading extends ProductStateBloc {}

class ProductEmpty extends ProductStateBloc {}

class ProductError extends ProductStateBloc {
  final String message;

  const ProductError(this.message);

  @override
  List<Object> get props => [message];
}

class ProductSuccess extends ProductStateBloc {
  final ProductEntity products;

  const ProductSuccess(this.products);

  @override
  List<Object> get props => [products];
}

// all create product state
class CreateProductLoading extends ProductStateBloc {}

class CreateProductEmpty extends ProductStateBloc {}

class CreateProductError extends ProductStateBloc {
  final String message;

  const CreateProductError(this.message);

  @override
  List<Object> get props => [message];
}

class CreateProductSuccess extends ProductStateBloc {
  final ProductEntity products;

  const CreateProductSuccess(this.products);

  @override
  List<Object> get props => [products];
}

// all update product state
class UpdateProductLoading extends ProductStateBloc {}

class UpdateProductEmpty extends ProductStateBloc {}

class UpdateProductError extends ProductStateBloc {
  final String message;

  const UpdateProductError(this.message);

  @override
  List<Object> get props => [message];
}

class UpdateProductSuccess extends ProductStateBloc {
  final ProductEntity products;

  const UpdateProductSuccess(this.products);

  @override
  List<Object> get props => [products];
}
