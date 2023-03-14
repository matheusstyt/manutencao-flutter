import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../atividade_model.dart';
import '../ordem_model.dart';

class AtividadeManutencaoPage extends StatefulWidget {
  final String descricao;
  final int id;

  const AtividadeManutencaoPage({required this.descricao, required this.id});
  @override
  _AtividadeManutencaoPageState createState() => _AtividadeManutencaoPageState();
}

class _AtividadeManutencaoPageState extends State<AtividadeManutencaoPage> {
  Atividades? atividades;
  Atividades? filteratividades;
  bool NaotemAtividade = true;
  updateAtividade(){

  }
  Future<void> load() async {
    await Future.delayed(const Duration(seconds: 1));
    throw 'asdfsafd';
  }
  Future<void> getAtividadesFilter() async {
    final res = await http.get(Uri.parse('http://170.10.0.65:8000/filterAtividade/'));

    if (res.statusCode == 200) {
      final jData = json.decode(utf8.decode(res.bodyBytes));
      filteratividades = Atividades.fromJson(jData);
      for ( int i = 0 ; i <= filteratividades!.atividades.length ; i++ ){
        print('filter'+filteratividades!.atividades[i].descricao);
      }
    } else {
      throw Exception('Falha ao carregar atividades');
    }
  }
  Future<Atividades> _getAtividades() async {
    final res = await http.get(Uri.parse('http://170.10.0.65:8000/atividade/'));
    final jData = json.decode(utf8.decode(res.bodyBytes));
    atividades = Atividades.fromJson(jData);
    return Atividades.fromJson(jData);
  }

  @override
  void initState() {
    super.initState();
    getAtividadesFilter();
    _getAtividades();
  }
  void loadScreen(int? id){
    setState(() {
      print('foi : $id');
    });
  }
  @override
  Widget build(BuildContext context) {
    List<Atividade> atividadeslist = [];
    return OrientationBuilder(
      builder: (context, orientation){
        return Scaffold(
          appBar: AppBar(
            title: Text('Atividade da Ordem : '),
            actions: [
              IconButton(onPressed: (){}, icon: Icon(Icons.add_box_outlined)),
              IconButton(
                icon: Icon(Icons.refresh),
                  onPressed: () async {
                  },
              ),
            ],
          ),
          body: FutureBuilder(

              future: _getAtividades(),
              builder: (context, snapshot){
                if(snapshot.hasData){

                  return Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: ListView.builder(
                        itemCount: atividades!.atividades.length,
                        itemBuilder:
                            (BuildContext context, int index){
                              Color cor = Color(int.parse(atividades!.atividades[index].colorFlutter));
                              Color nextColor = Color(int.parse(atividades!.atividades[index].nextColor));
                              Color background = Color(int.parse(atividades!.atividades[index].backFlutter));
                              Color textColor = Color.fromARGB(255, 53, 53, 54);
                              String letra = atividades!.atividades[index].descricao.substring(0, 1).toUpperCase();
                              String desc = atividades!.atividades[index].descricao.substring(1);
                              desc = letra + desc;

                              // if (orientation == Orientation.landscape) {

                              if(snapshot.data?.atividades[index].idOrdem == widget.id){
                                return listaHorizontal(
                                    context,
                                    snapshot.data?.atividades[index],
                                    index,
                                    cor,
                                    background,
                                    desc,
                                    textColor,
                                    nextColor,
                                    (novoStatus) => loadScreen( novoStatus )
                                );
                              }
                              return Text('');

                          //  }
                        })
                  );
                }else if (snapshot.hasError){

                  return Center(child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      CircularProgressIndicator(),
                      Text('Tentando Conexão...', style: TextStyle(fontSize: 20),),
                      //Text("${snapshot.error}", style: TextStyle(color: Colors.red, fontSize: 30),),
                    ],
                  ));

                    //Center(child: Text("${snapshot.error}", style: TextStyle(color: Colors.red, fontSize: 30),));
                }
                return Center(child: CircularProgressIndicator());
              }),

        );
      },
    );
  }
}
Widget listaHorizontal (BuildContext context,
    atividades,
    int index,
    Color cor,
    background,
    String desc,
    Color textColor,
    Color nextColor,
    Function(int) atualizarWidget,
    ){

  String onde_descricao = '';


  if(atividades.idConjunto != null){
    onde_descricao = atividades.descricao;
  }else if(atividades.idSubConjunto != null){
    onde_descricao = atividades.descricao;
  }else if(atividades.idPeca != null){
    onde_descricao = atividades.descricao;
  }
  int status_atual = 0;
  status_atual = atividades.status;
  void atualizarStatus() {
      print('antes : $status_atual');
    if (status_atual == 1) {
      status_atual = 2;
    } else if (status_atual == 2) {
      status_atual = 3;
    } else if (status_atual == 3) {
      status_atual = 2;
    }
      print('depois : $status_atual');
  }

  Future<void> updateStatus ( int id, int new_status ) async {
    final url = Uri.parse('http://170.10.0.65:8000/atividade/$id/');
    final headers = { 'Content-Type' : 'application/json'};
    final body = {'status' : new_status};
    final jBody = json.encode(body);
    try{
      final res = await http.put(url, headers: headers, body: jBody);
      if(res.statusCode == 200){
        print('STATUS ALTERADO COM SUCESSO !');
      }else{
        print('Erro ao atualizar o status : ${res.statusCode}');
      }
    } catch (error){
      print( 'ERRO AO ATUALIZAR O STATUS : $error');
    }
  }
  return Padding(
    padding: const EdgeInsets.only(left: 16, top: 6, right: 16, bottom: 6),
    child: Container(
      decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
            color: Color.fromARGB(50, 0, 0, 0),
            spreadRadius: 1,
            blurRadius: 2,
            offset: Offset(1, 1),
          ),
          ],

        borderRadius: BorderRadius.circular(5),
        color: Color.fromARGB(255, 231, 239, 246),
      ),
      //color: cor,
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: (){
                atualizarStatus();
                updateStatus(atividades.id, status_atual);
                atualizarWidget(status_atual);
              },
              child: CircleAvatar(
                backgroundColor:  atividades.status == 4 ? Color.fromARGB( 255, 183, 183, 183 ) : nextColor,
                radius: 30.0,
                child: Icon(
                  status_atual == 1 ? Icons.play_arrow : status_atual == 2 ? Icons.pause : Icons.play_arrow,
                  color: Colors.white,
                  size: 0.64 * MediaQuery.of(context).size.width / 12,
                )
                ,
                //child: Icon( Icons.pause, color: Colors.white, size: 0.64 * MediaQuery.of(context).size.width / 12,),
              ),
            ),

            Column(

              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Manuteção: $desc',
                  style: TextStyle( color: textColor, fontSize: 16 ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,

                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Data : ${atividades.dataManutencao}'
                  ),
                )
              ],
            ),


            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Text('Realizado por : ${atividades.realizadoPor}', style: TextStyle( color: textColor),),

                    Text("Onde : ${atividades}")
                  ],
                ),
               // Text(atividades.realizadoPor, style: TextStyle( color: textColor),),
              ],
            ),

            Text(atividades.statusFlutter, style: TextStyle( color: cor, fontWeight: FontWeight.w700),),
            //Icon(Icons.circle, color: cor,),
            InkWell(
              onTap: (){
              },
              child: CircleAvatar(
                backgroundColor:  atividades.status == 4 ? Color.fromARGB( 255, 183, 183, 183 ) : Color.fromARGB( 200, 222, 68, 68 ),
                radius: 30.0,
                child: Icon( Icons.stop, color: Colors.white, size: 0.64 * MediaQuery.of(context).size.width / 12,),
              ),
            ),

          ],
        ),
      ),
    ),
  );
}