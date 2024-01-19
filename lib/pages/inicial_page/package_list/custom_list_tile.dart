import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../../../theme/theme.dart';
import '../../../theme/theme_provider.dart';

class CustomListTile extends StatelessWidget {
  final String lottieAssetPath;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const CustomListTile({
    Key? key,
    required this.lottieAssetPath,
    required this.title,
    required this.subtitle,
    required this.onTap,
    required this.onEdit,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData currentTheme = Provider.of<ThemeProvider>(context).currentTheme;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        shadowColor: currentTheme.shadowColor,
        elevation: 4.0,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 16.0),
                      child: Lottie.asset(
                        lottieAssetPath,
                        width: 50.0,
                        height: 50.0,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: currentTheme.textTheme.titleLarge,
                        ),
                        const SizedBox(height: 4.0),
                        Text(
                          subtitle,
                          style: currentTheme.textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.edit,
                  color: currentTheme.primaryColor,
                ),
                onPressed: onEdit,
              ),
              IconButton(
                icon: Icon(
                  Icons.delete,
                  color: currentTheme.primaryColor,
                ),
                onPressed: onDelete,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
