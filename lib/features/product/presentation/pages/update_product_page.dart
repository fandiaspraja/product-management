import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:labamu/core/utils/constants.dart';
import 'package:labamu/core/utils/custom_toast.dart';
import 'package:labamu/core/widgets/base/base_dropdown_button.dart';
import 'package:labamu/core/widgets/base/base_input.dart';
import 'package:labamu/core/widgets/custom_button_primary.dart';
import 'package:labamu/core/widgets/custom_outlined_datetime.dart';
import 'package:labamu/features/product/data/models/product_request.dart';
import 'package:labamu/features/product/domain/entity/product_entity.dart';
import 'package:labamu/features/product/presentation/bloc/product_bloc.dart';

class UpdateProductPage extends StatefulWidget {
  static const ROUTE_NAME = '/update-product';
  final ProductEntity product;

  const UpdateProductPage({super.key, required this.product});

  @override
  State<UpdateProductPage> createState() => _UpdateProductPageState();
}

class _UpdateProductPageState extends State<UpdateProductPage> {
  final formKey = GlobalKey<FormState>();
  DateTime? _selectedDate;

  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final descController = TextEditingController();
  final statusController = TextEditingController();

  // List<MajorEntity>? majors = [];

  List<DropdownOption>? items = [
    DropdownOption(value: "active", label: "Active"),
    DropdownOption(value: "draft", label: "Draft"),
  ];
  @override
  void initState() {
    super.initState();

    nameController.text = widget.product.name!;
    priceController.text = widget.product.price.toString();
    descController.text = widget.product.description!;
    statusController.text = widget.product.status!;
  }

  String generateUpdatedAt() {
    return DateTime.now().toUtc().toIso8601String();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: BlocListener<ProductBloc, ProductStateBloc>(
        listener: (context, state) {
          if (state is UpdateProductSuccess) {
            CustomToast.show(context, "Success update product");
            WidgetsBinding.instance.addPostFrameCallback((_) {
              context.pop();
            });
          }

          if (state is CreateProductError) {
            CustomToast.showError(context, state.message);
          }
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                gapH24,
                Image.asset("assets/images/labamu-icon.png", height: 100),
                gapH16,
                Text(
                  "Update Product",
                  style: GoogleFonts.urbanist(
                    // color: fontColorPrimary,
                    fontSize: 36,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                gapH16,
                BaseInput(
                  controller: nameController,
                  label: "Name",
                  hintText: "Insert Name",
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value == null || value == '') {
                      return "Name can't empty";
                    }

                    return null;
                  },
                ),
                gapH16,
                BaseInput(
                  controller: priceController,
                  label: "Price",
                  hintText: "Insert price",
                  keyboardType: TextInputType.numberWithOptions(
                    decimal: true,
                    signed: true,
                  ),
                  textInputAction: TextInputAction.done,
                  validator: (value) {
                    if (value == null || value == '') {
                      return "Price can't empty";
                    }

                    return null;
                  },
                ),
                gapH16,
                BaseInput(
                  controller: descController,
                  label: "Description",
                  hintText: "Insert description",
                  maxLines: 5,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value == null || value == '') {
                      return "Description can't empty";
                    }

                    return null;
                  },
                ),

                gapH24,
                CustomButtonPrimary(
                  onTap: () {
                    if (nameController.text.isEmpty) {
                      CustomToast.showError(context, "Name can't empty");
                      return;
                    } else if (priceController.text.isEmpty) {
                      CustomToast.showError(context, "Price can't empty");
                      return;
                    } else if (descController.text.isEmpty) {
                      CustomToast.showError(context, "Description can't empty");
                      return;
                    } else {
                      final price = int.tryParse(priceController.text);
                      if (price == null) {
                        CustomToast.showError(context, "Invalid price format");
                        return;
                      }
                      ProductRequest request = ProductRequest(
                        id: widget.product.id,
                        name: nameController.text,
                        price: price,
                        description: descController.text,
                      );

                      context.read<ProductBloc>().add(
                        UpdateProductEvent(request: request),
                      );
                    }
                    // if (emailController.text.isEmpty) {
                    //   CustomToast.showError(context, "Email can't empty");
                    //   return;
                    // } else if (passwordController.text.isEmpty) {
                    //   CustomToast.showError(context, "Password can't empty");
                    //   return;
                    // } else {
                    //   context.read<AuthBloc>().add(
                    //     LoginEvent(
                    //       email: emailController.text,
                    //       password: passwordController.text,
                    //     ),
                    //   );
                    // }
                    // context.go(OtpPage.ROUTE_NAME,
                    //     extra: isGuest);
                  },
                  title: "Update Products",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
