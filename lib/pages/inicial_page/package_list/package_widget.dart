import 'package:flutter/material.dart';

import '../../package_view/package_view.dart';
import 'custom_list_tile.dart';

class PackageWidget extends StatefulWidget {
  final String nome;
  final String codigo;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const PackageWidget({
    Key? key,
    required this.nome,
    required this.codigo,
    this.onEdit,
    this.onDelete,
  }) : super(key: key);

  @override
  State<PackageWidget> createState() => _PackageWidgetState();
}

class _PackageWidgetState extends State<PackageWidget> {
  @override
  Widget build(BuildContext context) {
    return CustomListTile(
      lottieAssetPath: 'assets/images/wallkpackage.json',
      title: widget.nome,
      subtitle: widget.codigo,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PackageView(
              codigo: widget.codigo,
            ),
          ),
        );
      },
      onEdit: widget.onEdit!,
      onDelete: widget.onDelete!,
    );
  }
}
