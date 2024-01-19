// Arquivo: event_list.dart
// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

import 'package_view_event_card.dart';

class EventList extends StatelessWidget {
  final _packageState;

  const EventList(this._packageState, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _packageState.pacote?.eventos.length ?? 0,
      itemBuilder: (context, index) {
        final evento = _packageState.pacote?.eventos[index];
        return PackageEventCard(evento: evento!);
      },
    );
  }
}
