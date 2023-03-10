class Ordens {
  Ordens({
    required this.ordem,
  });
  late final List<Ordem> ordem;

  Ordens.fromJson(Map<String, dynamic> json){
    ordem = List.from(json['ordem']).map((e)=>Ordem.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['ordem'] = ordem.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Ordem {
  Ordem({
    required this.id,
    required this.descricao,
    required this.dataCriacao,
    required this.tempoTotalManutencao,
    required this.frequenciaManutencao,
    required this.responsavelCriacao,
    required this.area,
    required this.tipo,
    required this.status,
    required this.mttr,
    required this.mtbf,
    required this.statusConjunto,
    required this.dataInicio,
    required this.dataFim,
    required this.color,
    required this.statusFlutter,
    required this.colorFlutter,
    required this.backFlutter
  });
  late final int id;
  late final String descricao;
  late final String dataCriacao;
  late final double tempoTotalManutencao;
  late final int frequenciaManutencao;
  late final String responsavelCriacao;
  late final String? area;
  late final int tipo;
  late final int status;
  late final double? mttr;
  late final double? mtbf;
  late final int statusConjunto;
  late final String dataInicio;
  late final String dataFim;
  late final String color;
  late final String statusFlutter;
  late final String colorFlutter;
  late final String backFlutter;

  Ordem.fromJson(Map<String, dynamic> json){
    id = json['id'];
    descricao = json['descricao'];
    dataCriacao = json['dataCriacao'];
    tempoTotalManutencao = json['tempoTotalManutencao'];
    frequenciaManutencao = json['frequenciaManutencao'];
    responsavelCriacao = json['responsavelCriacao'];
    area = json['area'];
    tipo = json['tipo'];
    status = json['status'];
    mttr = json['mttr'];
    mtbf = json['mtbf'];
    statusConjunto = json['status_conjunto'];
    dataInicio = json['data_inicio'];
    dataFim = json['data_fim'];
    color = json['color'];
    statusFlutter = json['status_flutter'];
    colorFlutter = json['color_flutter'];
    backFlutter = json['back_flutter'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['descricao'] = descricao;
    _data['dataCriacao'] = dataCriacao;
    _data['tempoTotalManutencao'] = tempoTotalManutencao;
    _data['frequenciaManutencao'] = frequenciaManutencao;
    _data['responsavelCriacao'] = responsavelCriacao;
    _data['area'] = area;
    _data['tipo'] = tipo;
    _data['status'] = status;
    _data['mttr'] = mttr;
    _data['mtbf'] = mtbf;
    _data['status_conjunto'] = statusConjunto;
    _data['data_inicio'] = dataInicio;
    _data['data_fim'] = dataFim;
    _data['color'] = color;
    _data['status_flutter'] = statusFlutter;
    _data['color_flutter'] = colorFlutter;
    _data['back_flutter'] = backFlutter;
    return _data;
  }
}