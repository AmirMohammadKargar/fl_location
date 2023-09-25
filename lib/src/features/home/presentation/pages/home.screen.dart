import 'package:fl_location/src/features/home/presentation/managers/home.manager.dart';
import 'package:fl_location/src/shared/widgets/other/conditional_builder.widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeManager>();
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              controller.logout();
            },
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: SafeArea(
        child: Center(
          child: GetBuilder<HomeManager>(
            builder: (_) => ConditionalBuilder(
              condition: controller.position != null,
              firstStateChild: () => Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Lat: ${controller.position!.latitude}'),
                  Text('Lang: ${controller.position!.longitude}')
                ],
              ),
              secondStateChild: () => const CircularProgressIndicator(),
            ),
          ),
        ),
      ),
    );
  }
}
