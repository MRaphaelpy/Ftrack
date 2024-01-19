// package_state.dart
import 'package:flutter/material.dart';
import 'package:frastreio2/models/objeto_rastreio.dart';
import '../../service/service_rastreio.dart';

class PackageState {
  final RastreioService rastreioService;
  Pacote? pacote;
  final VoidCallback onStateChanged;

  PackageState({
    required this.rastreioService,
    required this.onStateChanged,
  });

  Future<void> fetchRastreio(String codigo) async {
    pacote = await rastreioService.fetchRastreio(codigo);
    onStateChanged();
  }
}
