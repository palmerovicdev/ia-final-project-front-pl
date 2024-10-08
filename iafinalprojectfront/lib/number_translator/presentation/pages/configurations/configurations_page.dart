import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/service_locator/service_locator.dart';
import '../../../../theme/presentation/bloc/theme_selector_cubit.dart';
import '../../../../theme/presentation/widgets/wrap_theme_selector_widget.dart';
import '../../bloc/configurations/configurations_cubit.dart';

class ConfigurationsPage extends StatelessWidget {
  const ConfigurationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final height = MediaQuery.of(context).size.height;
    final cubit = context.read<ConfigurationsCubit>();
    final controller = cubit.controller;

    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Text(tr('configurations_page_title'),
              style: const TextStyle(fontSize: 20)),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.pop();
          },
        ),
        actions: [
          BlocBuilder<ThemeSelectorCubit, ThemeSelectorState>(
              builder: (context, state) {
            final isDarkMode =
                (state as ThemeSelectorInitial).themeMode == ThemeMode.dark;
            return IconButton(
                onPressed: () => context
                    .read<ThemeSelectorCubit>()
                    .changeTheme(isDarkMode ? ThemeMode.light : ThemeMode.dark),
                icon: Icon(isDarkMode ? Icons.light_mode : Icons.dark_mode));
          })
        ],
        toolbarHeight: height * 0.1,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildHotsPotIpAddressConfiguration(themeData, cubit, controller),
            const Gap(20),
            DropdownMenu(
              enableSearch: true,
              controller: TextEditingController(text: tr('current_language')),
              width: MediaQuery.of(context).size.width - 20,
              dropdownMenuEntries: [
                DropdownMenuEntry(
                  value: 'es',
                  label: tr('spanish_language'),
                ),
                DropdownMenuEntry(
                  value: 'en',
                  label: tr('english_language'),
                ),
              ],
              onSelected: (value) {
                serviceLocator
                    .get<ConfigurationsCubit>()
                    .changeLanguage(value == 'es');
              },
            ),
            const Gap(15),
            SizedBox(
              width: MediaQuery.of(context).size.width - 20,
              height: 100,
              child: const WrapThemeSelectorWidget(),
            ),
          ],
        ),
      ),
    );
  }

  ExpansionTile buildHotsPotIpAddressConfiguration(ThemeData themeData,
      ConfigurationsCubit cubit, TextEditingController controller) {
    return ExpansionTile(
      tilePadding: const EdgeInsets.symmetric(horizontal: 10),
      leading: Icon(Icons.route_outlined, color: themeData.colorScheme.primary),
      title: Text(tr('hotspot_ip_address_label'),
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16,
          )),
      subtitle: Text(tr('input_your_hotspot_ip_address')),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: SizedBox(
            height: 58,
            child: BlocBuilder<ConfigurationsCubit, ConfigurationsState>(
              builder: (context, state) {
                final state = cubit.state as ConfigurationsInitial;
                return TextFormField(
                  controller: controller..text = state.hotspotAddress,
                  textAlignVertical: TextAlignVertical.center,
                  cursorHeight: 22,
                  decoration: InputDecoration(
                    suffix: IconButton(
                      icon:
                          const Icon(Icons.save, color: Colors.lightBlueAccent),
                      onPressed: () => cubit.setBaseUrl(controller.text, () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            duration: const Duration(seconds: 1),
                            content: Text(
                              '${tr('the_base_has_been_changed')} ${state.hotspotAddress}',
                              style: themeData.textTheme.bodyLarge?.copyWith(
                                color: themeData.colorScheme.onSecondary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: themeData.colorScheme.secondary,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: themeData.colorScheme.secondary,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        )
      ],
    );
  }
}
