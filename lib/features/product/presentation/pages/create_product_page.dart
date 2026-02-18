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
import 'package:labamu/features/product/presentation/bloc/product_bloc.dart';

class CreateProductPage extends StatefulWidget {
  static const ROUTE_NAME = '/create-product';

  const CreateProductPage({super.key});

  @override
  State<CreateProductPage> createState() => _CreateProductPageState();
}

class _CreateProductPageState extends State<CreateProductPage> {
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
          if (state is CreateProductSuccess) {
            CustomToast.show(context, "Success add new student");
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
                Image.asset("assets/images/labamu-logo.png", height: 100),
                gapH16,
                Text(
                  "Insert Product",
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
                gapH16,
                BaseDropdownButton(
                  value: statusController.text.isEmpty
                      ? null
                      : statusController.text,
                  label: "Status",
                  hintText: "Choose Status",
                  items: items,
                  onChanged: (value) {
                    setState(() {
                      statusController.text = value ?? "";
                    });
                  },
                  validator: (value) {
                    if (value == null || value == '') {
                      return "Error";
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
                    } else if (descController.text.isEmpty) {
                      CustomToast.showError(context, "Price can't empty");
                      return;
                    } else if (priceController.text.isEmpty) {
                      CustomToast.showError(context, "Description can't empty");
                      return;
                    } else if (statusController.text.isEmpty) {
                      CustomToast.showError(context, "Status can't empty");
                      return;
                    } else {
                      final price = int.tryParse(priceController.text);
                      if (price == null) {
                        CustomToast.showError(context, "Invalid price format");
                        return;
                      }

                      ProductRequest request = ProductRequest(
                        name: nameController.text,
                        price: price,
                        description: descController.text,
                      );

                      context.read<ProductBloc>().add(
                        CreateProductEvent(request: request),
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
                  title: "Create Products",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
