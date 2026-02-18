part of 'product_bloc.dart';

abstract class ProductEventBloc extends Equatable {
  const ProductEventBloc();

  @override
  List<Object> get props => [];
}

class CreateProductEvent extends ProductEventBloc {
  final ProductRequest request;
  const CreateProductEvent({required this.request});

  @override
  List<Object> get props => [request];
}

class UpdateProductEvent extends ProductEventBloc {
  final ProductRequest request;
  const UpdateProductEvent({required this.request});

  @override
  List<Object> get props => [request];
}

class DetailProductEvent extends ProductEventBloc {
  final String id;
  const DetailProductEvent({required this.id});

  @override
  List<Object> get props => [id];
}

class ProductsEvent extends ProductEventBloc {
  @override
  List<Object> get props => [];
}
