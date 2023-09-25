import 'package:flutter/material.dart';

typedef FunctionChidBuilderCallBack = Widget Function();

class ConditionalBuilder extends StatelessWidget {
  final bool condition;
  final FunctionChidBuilderCallBack firstStateChild;
  final FunctionChidBuilderCallBack secondStateChild;
  const ConditionalBuilder(
      {Key? key,
      required this.condition,
      required this.firstStateChild,
      required this.secondStateChild})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return condition ? firstStateChild.call() : secondStateChild.call();
  }
}
