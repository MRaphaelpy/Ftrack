import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class PackageLocalWidget extends StatefulWidget {
  final String local;

  PackageLocalWidget({
    required this.local,
  });

  @override
  _PackageLocalWidgetState createState() => _PackageLocalWidgetState();
}

class _PackageLocalWidgetState extends State<PackageLocalWidget>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              "assets/images/packagewidget.json",
              height: 150,
            ),
            SizedBox(height: 10),
            Text(
              'Seu pacote está em: ${widget.local}',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
