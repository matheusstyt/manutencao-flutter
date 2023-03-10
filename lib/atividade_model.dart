class Atividades {
  Atividades({
    required this.atividades,
  });
  late final List<Atividade> atividades;

  Atividades.fromJson(Map<String, dynamic> json){
    atividades = List.from(json['atividades']).map((e)=>Atividade.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['atividades'] = atividades.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Atividade {
  Atividade({
    required this.id,
    required this.descricao,
    required this.idConjunto,
    required this.idSubConjunto,
    required this.idPeca,
    required this.idOrdem,
    required this.manutencao,
    required this.tempoManutecao,
    required this.realizadoPor,
    required this.responsavel,
    required this.dataManutencao,
    required this.dataInicio,
    required this.dataFim,
    required this.falha,
    required this.observacao,
    required this.custo,
    required this.status,
    required this.color,
  });
  late final int id;
  late final String descricao;
  late final int? idConjunto;
  late final int? idSubConjunto;
  late final int? idPeca;
  late final int idOrdem;
  late final int manutencao;
  late final int? tempoManutecao;
  late final int realizadoPor;
  late final int responsavel;
  late final String dataManutencao;
  late final String? dataInicio;
  late final String? dataFim;
  late final int? falha;
  late final String? observacao;
  late final double? custo;
  late final int status;
  late final String color;

  Atividade.fromJson(Map<String, dynamic> json){
    id = json['id'];
    descricao = json['descricao'];
    idConjunto = null;
    idSubConjunto = null;
    idPeca = null;
    idOrdem = json['idOrdem'];
    manutencao = json['manutencao'];
    tempoManutecao = json['tempoManutecao'];
    realizadoPor = null;
    responsavel = json['responsavel'];
    dataManutencao = json['dataManutencao'];
    dataInicio = null;
    dataFim = null;
    falha = null;
    observacao = null;
    custo = null;
    status = json['status'];
    color = json['color'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['descricao'] = descricao;
    _data['idConjunto'] = idConjunto;
    _data['idSubConjunto'] = idSubConjunto;
    _data['idPeca'] = idPeca;
    _data['idOrdem'] = idOrdem;
    _data['manutencao'] = manutencao;
    _data['tempoManutecao'] = tempoManutecao;
    _data['realizadoPor'] = realizadoPor;
    _data['responsavel'] = responsavel;
    _data['dataManutencao'] = dataManutencao;
    _data['dataInicio'] = dataInicio;
    _data['dataFim'] = dataFim;
    _data['falha'] = falha;
    _data['observacao'] = observacao;
    _data['custo'] = custo;
    _data['status'] = status;
    _data['color'] = color;
    return _data;
  }
}