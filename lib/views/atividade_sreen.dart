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
  Future<void> _getAtividades() async {
    final res = await http.get(Uri.parse('http://170.10.0.65:8000/atividade'));
    final jData = json.decode(utf8.decode(res.bodyBytes));
    setState(() {
      atividades = Atividades.fromJson(jData);
    });
  }
  @override
  void initState() {
    super.initState();
    _getAtividades();
  }

  @override
  Widget build(BuildContext context) {

    return OrientationBuilder(
      builder: (context, orientation){
        return Scaffold(
          appBar: AppBar(
            title: Text('Atividade da Ordem : '),
            actions: [
              IconButton(
                icon: Icon(Icons.refresh),
                onPressed: () {
                },
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(10),
            child: ListView.builder(
                itemCount: atividades!.atividades.length,
                itemBuilder:
                    (BuildContext context, int index){
                 // Color cor = Color(int.parse(atividades!.atividades[index].colorFlutter));
                 // Color background = Color(int.parse(atividades!.atividades[index].backFlutter));
                  Color textColor = Color.fromARGB(255, 53, 53, 54);
                  String letra = atividades!.atividades[index].descricao.substring(0, 1).toUpperCase();
                  String desc = atividades!.atividades[index].descricao.substring(1);
                  desc = letra + desc;
                  if (orientation == Orientation.landscape) {
                    return listaHorizontal(context, atividades, index, desc, textColor);
                  } else {
                    return listaVertical(context, atividades!.atividades[index], index, desc, textColor);
                  }
                }),
          ),
        );
      },
    );
  }
}
listaHorizontal (context, atividades, index, desc, textColor){
  return Padding(
    padding: const EdgeInsets.all(5.0),
    child: Container(
      decoration: BoxDecoration(
        border: Border.all(
           // color: cor
        ),
        borderRadius: BorderRadius.circular(15),
       // color: background,
      ),
      //color: cor,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              desc,
              style: TextStyle( color: textColor, fontSize: 16 ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,

            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Data Criação', style: TextStyle( color: textColor),),
                Text( atividades!.atividades[index].dataCriacao, style: TextStyle( color: textColor),),
              ],
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Responsável', style: TextStyle( color: textColor),),
                Text(atividades!.atividades[index].responsavelCriacao, style: TextStyle( color: textColor),),
              ],
            ),

            Text(atividades!.atividades[index].statusFlutter, style: TextStyle( color: textColor),),
            Icon(Icons.circle),



          ],
        ),
      ),
    ),
  );
}
listaVertical (context, ordem, index, cor, background, desc, textColor){


  return Padding(
    padding: const EdgeInsets.all(5.0),
    child: InkWell(
      onTap: (){
        print(ordem.descricao);
        print(ordem.id);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AtividadeManutencaoPage( descricao: ordem.descricao as String, id: ordem.id as int),
          ),
        );

      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
              color: cor
          ),
          borderRadius: BorderRadius.circular(15),
          color: background,
        ),
        //color: cor,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      desc,
                      style: TextStyle( color: textColor, fontSize: 14 ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,

                    ),
                    Text(ordem!.statusFlutter, style: TextStyle( color: textColor),),
                    Icon(Icons.circle, color: cor,),
                  ],
                ),
              ),
              Row(

                children: [
                  Expanded(
                    child: Container(
                        decoration: const BoxDecoration(
                            border: Border(
                                top: BorderSide(
                                    color: Color.fromARGB(100, 100, 100, 100),
                                    width: 1.0
                                )

                            )
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                          child: Text('Responsável: '+ordem!.responsavelCriacao, style: TextStyle( color: textColor),),
                        )),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    ),
  );
}