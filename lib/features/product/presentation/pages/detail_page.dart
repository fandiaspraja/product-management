import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:labamu/core/theme/app_colors.dart';
import 'package:labamu/core/utils/constants.dart';
import 'package:labamu/features/product/domain/entity/product_entity.dart';
import 'package:labamu/features/product/presentation/bloc/product_bloc.dart';
import 'package:labamu/features/product/presentation/pages/update_product_page.dart';

class DetailPage extends StatefulWidget {
  static const ROUTE_NAME = '/detail';

  final String id;

  const DetailPage({super.key, required this.id});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  ProductEntity? products;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      context.read<ProductBloc>().add(DetailProductEvent(id: widget.id));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Product Detail Page", style: GoogleFonts.urbanist()),
        leading: BackButton(
          onPressed: () {
            context.pop();
          },
        ),
      ),
      body: BlocBuilder<ProductBloc, ProductStateBloc>(
        builder: (context, state) {
          if (state is ProductLoading) {
            // return const Center(child: CircularProgressIndicator());
          }
          if (state is ProductError) {
            return Center(child: Text(state.message));
          }
          if (state is ProductSuccess) {
            products = state.products;
          }

          if (products == null) return const SizedBox();

          return SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// =====================
                  /// AVATAR
                  /// =====================
                  Center(
                    child: CircleAvatar(
                      radius: 48,
                      backgroundColor: Colors.blue.shade100,
                      child: Text(
                        (products?.name?.isNotEmpty ?? false)
                            ? products!.name!.substring(0, 1).toUpperCase()
                            : "-",
                        style: const TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  Center(
                    child: Text(
                      products?.name ?? "-",
                      style: GoogleFonts.urbanist(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  /// =====================
                  /// INFO CARD
                  /// =====================
                  _infoCard(
                    title: "Product Detail",
                    children: [
                      _infoRow("Name", products?.name),
                      _infoRow("Price", products?.price.toString()),
                      _infoRow("Description", products?.description),
                      _infoRow("Status", products?.status),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: "Edit Products",
        onPressed: () {
          context.push(UpdateProductPage.ROUTE_NAME, extra: products).then((_) {
            context.read<ProductBloc>().add(DetailProductEvent(id: widget.id));
          });
        },
        child: const Icon(Icons.edit),
      ),
    );
  }

  /// =====================
  /// WIDGETS
  /// =====================

  Widget _infoCard({required String title, required List<Widget> children}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        // color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.urbanist(
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 12),
          ...children,
        ],
      ),
    );
  }

  Widget _infoRow(String title, String? value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          SizedBox(
            width: 110,
            child: Text(
              title,
              style: TextStyle(
                // color: Colors.grey.shade600,
                fontSize: 13,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value ?? "-",
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
