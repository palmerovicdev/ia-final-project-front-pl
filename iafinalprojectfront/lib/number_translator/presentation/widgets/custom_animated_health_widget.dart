import 'package:flutter/material.dart';

class CustomAnimatedHealthWidget extends StatefulWidget {
  final double percentage;
  final void Function() onFinished;

  const CustomAnimatedHealthWidget({super.key, required this.percentage, required this.onFinished});

  @override
  _CustomAnimatedHealthWidgetState createState() => _CustomAnimatedHealthWidgetState();
}

class _CustomAnimatedHealthWidgetState extends State<CustomAnimatedHealthWidget> {
  @override
  Widget build(BuildContext context) {
    double width = widget.percentage * MediaQuery.of(context).size.width - widget.percentage * 100 <= 0 ? 0 : widget.percentage * MediaQuery.of(context).size.width - widget
        .percentage * 100;
    if (widget.percentage <= 0) {
      widget.onFinished();
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 20,
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                children: [
                  AnimatedContainer(
                    height: 20,
                    width: width,
                    duration: const Duration(milliseconds: 500),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      color: Colors.green[300],
                    ),
                    child: const Align(
                      alignment: Alignment.centerRight,
                    ),
                  ),
                  AnimatedContainer(
                    width: width,
                    height: 15,
                    duration: const Duration(milliseconds: 500),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      color: Colors.green,
                    ),
                    child: const Align(
                      alignment: Alignment.centerRight,
                    ),
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.only(left: 5.0),
                child: Icon(Icons.favorite, color: Colors.red),
              ),
            ],
          ),
        ),
      ),
    );
  }
}