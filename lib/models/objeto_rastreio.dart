class Evento {
  String data;
  String hora;
  String local;
  String status;
  List<String> subStatus;

  Evento({
    required this.data,
    required this.hora,
    required this.local,
    required this.status,
    required this.subStatus,
  });

  factory Evento.fromJson(Map<String, dynamic> json) {
    return Evento(
      data: json['data'],
      hora: json['hora'],
      local: json['local'],
      status: json['status'],
      subStatus: List<String>.from(json['subStatus']),
    );
  }
}

class Pacote {
  String codigo;
  String servico;
  String host;
  int quantidade;
  List<Evento> eventos;

  Pacote({
    required this.codigo,
    required this.servico,
    required this.host,
    required this.quantidade,
    required this.eventos,
  });

  factory Pacote.fromJson(Map<String, dynamic> json) {
    List<Evento> eventosList = List<Evento>.from(
        json['eventos'].map((evento) => Evento.fromJson(evento)));

    return Pacote(
      codigo: json['codigo'],
      servico: json['servico'],
      host: json['host'],
      quantidade: json['quantidade'],
      eventos: eventosList,
    );
  }
}
