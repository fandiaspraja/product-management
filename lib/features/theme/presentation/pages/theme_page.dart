import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:labamu/core/theme/app_colors.dart';
import 'package:labamu/core/utils/constants.dart';
import 'package:labamu/features/theme/presentation/bloc/theme_bloc.dart';
import 'package:labamu/features/theme/presentation/widgets/theme_tile.dart';

class ThemePage extends StatefulWidget {
  static const ROUTE_NAME = '/theme';

  const ThemePage({super.key});

  @override
  State<ThemePage> createState() => _ThemePageState();
}

class _ThemePageState extends State<ThemePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Change Theme", style: GoogleFonts.urbanist()),
        leading: BackButton(
          onPressed: () {
            context.pop();
          },
        ),
      ),
      body: BlocBuilder<ThemeBloc, ThemeStateBloc>(
        builder: (context, state) {
          ThemeMode currentTheme = ThemeMode.system;

          if (state is ThemeLoaded) {
            currentTheme = state.themeMode;
          }

          return Column(
            children: [
              ThemeTile(
                title: 'System Default',
                icon: Icons.brightness_auto,
                selected: currentTheme == ThemeMode.system,
                onTap: () {
                  context.read<ThemeBloc>().add(
                    const ChangeThemeEvent(ThemeMode.system),
                  );
                },
              ),
              ThemeTile(
                title: 'Light Mode',
                icon: Icons.light_mode,
                selected: currentTheme == ThemeMode.light,
                onTap: () {
                  context.read<ThemeBloc>().add(
                    const ChangeThemeEvent(ThemeMode.light),
                  );
                },
              ),
              ThemeTile(
                title: 'Dark Mode',
                icon: Icons.dark_mode,
                selected: currentTheme == ThemeMode.dark,
                onTap: () {
                  context.read<ThemeBloc>().add(
                    const ChangeThemeEvent(ThemeMode.dark),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
