import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:labamu/features/product/presentation/bloc/product_bloc.dart';

Future<void> showLogoutDialog(BuildContext context) {
  final studentBloc = context.read<ProductBloc>();

  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (dialogContext) {
      final theme = Theme.of(dialogContext);

      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: theme.dialogBackgroundColor,
        title: const Text("Logout"),
        content: const Text("Are you sure want to logout?"),
        actionsPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext);
            },
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () {
              Navigator.pop(dialogContext);

              /// clear student + token

              /// go to login
              // context.go(LoginPage.ROUTE_NAME);
            },
            child: const Text("Logout"),
          ),
        ],
      );
    },
  );
}
