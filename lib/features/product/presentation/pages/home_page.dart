import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:labamu/core/network/network_info.dart';
import 'package:labamu/core/theme/app_colors.dart';
import 'package:labamu/core/utils/constants.dart';
import 'package:labamu/core/utils/custom_toast.dart';
import 'package:labamu/features/product/domain/entity/product_entity.dart';
import 'package:labamu/features/product/presentation/bloc/product_bloc.dart';
import 'package:labamu/features/product/presentation/pages/detail_page.dart';
import 'package:labamu/features/product/presentation/pages/create_product_page.dart';
import 'package:labamu/features/product/presentation/widgets/home_drawer_content.dart';
import 'package:labamu/features/product/presentation/widgets/product_card.dart';
import 'package:labamu/features/theme/presentation/pages/theme_page.dart';
import 'package:labamu/injection.dart';

class HomePage extends StatefulWidget {
  static const ROUTE_NAME = '/home';

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ProductEntity> products = [];
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;
  bool _isOffline = false;

  @override
  void initState() {
    super.initState();

    final networkInfo = locator<NetworkInfo>();
    // Check initial status
    networkInfo.isConnected.then((connected) {
      if (mounted) {
        setState(() {
          _isOffline = !connected;
        });
      }
    });

    // Listen for changes
    _connectivitySubscription = networkInfo.onConnectivityChanged.listen((
      results,
    ) {
      final isOffline = results.contains(ConnectivityResult.none);
      if (_isOffline != isOffline) {
        setState(() {
          _isOffline = isOffline;
        });
        if (!_isOffline) {
          CustomToast.show(context, "Online. Syncing data...");
          context.read<ProductBloc>().add(ProductsEvent());
        }
      }
    });

    Future.delayed(Duration.zero, () {
      context.read<ProductBloc>().add(ProductsEvent());
    });
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProductBloc, ProductStateBloc>(
      listener: (context, state) {},
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Products Page", style: GoogleFonts.urbanist()),
        ),
        drawerScrimColor: Colors.transparent,
        drawer: Drawer(
          backgroundColor: Theme.of(context).colorScheme.surface,
          child: const HomeDrawerContent(),
        ),

        body: BlocBuilder<ProductBloc, ProductStateBloc>(
          builder: (context, state) {
            if (state is ProductListSuccess) {
              products = state.products;
            }

            return RefreshIndicator(
              onRefresh: () async {
                context.read<ProductBloc>().add(ProductsEvent());
              },
              child: SafeArea(
                child: Column(
                  children: [
                    if (_isOffline)
                      Container(
                        width: double.infinity,
                        color: Colors.red,
                        padding: const EdgeInsets.all(8),
                        child: const Text(
                          "You are offline. Changes will be synced when online.",
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    gapH16,
                    Expanded(
                      child: ListView.builder(
                        itemCount: products.length,
                        padding: EdgeInsets.all(16),
                        itemBuilder: (context, index) {
                          var item = products[index];

                          return ProductCard(
                            product: item,
                            onTap: () {
                              context.push(
                                DetailPage.ROUTE_NAME,
                                extra: item.id,
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          tooltip: "Add Products",
          onPressed: () {
            context.push(CreateProductPage.ROUTE_NAME).then((_) {
              context.read<ProductBloc>().add(ProductsEvent());
            });
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
