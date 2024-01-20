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
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(
                "assets/images/packagewidget.json",
                height: 100,
              ),
              SizedBox(height: 10),
              Container(
                constraints: BoxConstraints(
                  maxWidth: 300,
                ),
                child: Text(
                  'Seu pacote está em: ${widget.local}',
                  style: TextStyle(fontSize: 15),
                  softWrap: true,
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
