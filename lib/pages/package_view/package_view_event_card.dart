import 'package:flutter/material.dart';
import '../../models/objeto_rastreio.dart';

class PackageEventCard extends StatelessWidget {
  final Evento evento;

  const PackageEventCard({Key? key, required this.evento}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxWidth: 400,
        maxHeight: 200, 
      ),
      child: Card(
        elevation: 3,
        margin: const EdgeInsets.all(8),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                evento.status,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Data: ${evento.data} Hora: ${evento.hora} Local: ${evento.local}',
              ),
              const SizedBox(height: 8),
              Text(
                'SubStatus: ${evento.subStatus.join(', ')}',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
