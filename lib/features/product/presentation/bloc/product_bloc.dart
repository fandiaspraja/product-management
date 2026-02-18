import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:labamu/core/local_storage/shared_preferences/shared_preferences_helper.dart';
import 'package:labamu/features/product/data/models/product_request.dart';

import 'package:labamu/features/product/domain/entity/product_entity.dart';
import 'package:labamu/features/product/domain/usecase/student_usecase.dart';
part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEventBloc, ProductStateBloc> {
  final StudentUsecase usecase;
  final SharedPreferencesHelper sharedPreferencesHelper;

  ProductBloc(this.usecase, this.sharedPreferencesHelper)
    : super(ProductListLoading()) {
    on<ProductsEvent>((event, emit) async {
      emit(ProductListLoading());

      final result = await usecase.getProducts();
      result.fold(
        (failure) {
          emit(ProductListError(failure.message));
        },
        (data) {
          emit(ProductListSuccess(data));
        },
      );
    });

    on<CreateProductEvent>((event, emit) async {
      emit(CreateProductLoading());

      final result = await usecase.createProduct(event.request);
      result.fold(
        (failure) {
          emit(CreateProductError(failure.message));
        },
        (data) {
          emit(CreateProductSuccess(data));
        },
      );
    });

    on<UpdateProductEvent>((event, emit) async {
      emit(UpdateProductLoading());

      final result = await usecase.updateProduct(event.request);
      result.fold(
        (failure) {
          emit(UpdateProductError(failure.message));
        },
        (data) {
          emit(UpdateProductSuccess(data));
        },
      );
    });

    on<DetailProductEvent>((event, emit) async {
      emit(ProductLoading());

      final result = await usecase.getProductDetail(event.id);
      result.fold(
        (failure) {
          emit(ProductError(failure.message));
        },
        (data) {
          emit(ProductSuccess(data));
        },
      );
    });
  }
}
