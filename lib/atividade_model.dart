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
    required this.statusFlutter,
    required this.colorFlutter,
    required this.backFlutter,
    required this.nextColor

  });
  late final int id;
  late final String descricao;
  late final int? idConjunto;
  late final int? idSubConjunto;
  late final int? idPeca;
  late final int idOrdem;
  late final int? manutencao;
  late final int? tempoManutecao;
  late final String realizadoPor;
  late final String responsavel;
  late final String dataManutencao;
  late final String? dataInicio;
  late final String? dataFim;
  late final int? falha;
  late final String? observacao;
  late final double? custo;
  late final int status;
  late final String color;
  late final String? statusFlutter;
  late final String colorFlutter;
  late final String backFlutter;
  late final String nextColor;

  Atividade.fromJson(Map<String, dynamic> json){
    id = json['id']?? 0;
    descricao = json['descricao']?? '';
    idConjunto = json['idConjunto']?? 0;
    idSubConjunto = json['idSubConjunto']?? 0;
    idPeca = json['idPeca']?? 0?? '';
    idOrdem = json['idOrdem']?? 0;
    manutencao = json['manutencao']?? 0;
    tempoManutecao = json['tempoManutecao']?? 0;
    realizadoPor = json['realizadoPorstring']?? '';
    responsavel = json['responsavelstring']?? '';
    dataManutencao = json['dataManutencao']?? '';
    dataInicio = json['dataInicio']?? '';
    dataFim = json['dataFim']?? '';
    falha = json['falha']?? 0;
    observacao = json['observacao']?? '';
    custo = json['custo']?? 0;
    status = json['status']?? 0;
    color = json['color'];
    statusFlutter = json['status_flutter'];
    colorFlutter = json['color_flutter'];
    backFlutter = json['back_flutter'];
    nextColor = json['next_color'];
  }
  static Atividades fromMap(Map<String, dynamic> map) {
    List<Atividade> atividades = [];

    if (map['atividades'] != null) {
      for (var atividadeMap in map['atividades']) {
        Atividade atividade = Atividade(
          id: atividadeMap['id'],
          descricao: atividadeMap['descricao'],
          idConjunto: atividadeMap['id_conjunto'],
          idSubConjunto: atividadeMap['id_sub_conjunto'],
          idPeca: atividadeMap['id_peca'],
          idOrdem: atividadeMap['id_ordem'],
          manutencao: atividadeMap['manutencao'],
          tempoManutecao: atividadeMap['tempo_manutencao'],
          realizadoPor: atividadeMap['realizado_por_string'],
          responsavel: atividadeMap['responsavel_string'],
          dataManutencao: atividadeMap['data_manutencao'],
          dataInicio: atividadeMap['data_inicio'],
          dataFim: atividadeMap['data_fim'],
          falha: atividadeMap['falha'],
          observacao: atividadeMap['observacao'],
          custo: atividadeMap['custo'],
          status: atividadeMap['status'],
          color: atividadeMap['color'],
          statusFlutter: atividadeMap['status_flutter'],
          colorFlutter: atividadeMap['color_flutter'],
          backFlutter: atividadeMap['back_flutter'],
          nextColor: atividadeMap['next_color'],
        );
        atividades.add(atividade);
      }
    }
    return Atividades(atividades: atividades);
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
    _data['realizadoPorstring'] = realizadoPor;
    _data['responsavelstring'] = responsavel;
    _data['dataManutencao'] = dataManutencao;
    _data['dataInicio'] = dataInicio;
    _data['dataFim'] = dataFim;
    _data['falha'] = falha;
    _data['observacao'] = observacao;
    _data['custo'] = custo;
    _data['status'] = status;
    _data['color'] = color;
    _data['status_flutter'] = statusFlutter;
    _data['color_flutter'] = colorFlutter;
    _data['back_flutter'] = backFlutter;
    _data['next_color'] = nextColor;
    return _data;
  }
}