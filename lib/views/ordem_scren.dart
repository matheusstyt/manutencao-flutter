import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../ordem_model.dart';
import 'atividade_sreen.dart';

class OrdemManutencaoPage extends StatefulWidget {
  @override

  _OrdemManutencaoPageState createState() => _OrdemManutencaoPageState();
}

class _OrdemManutencaoPageState extends State<OrdemManutencaoPage> {
  Ordens? ordens;
  Future<void> load() async {
    await Future.delayed(const Duration(seconds: 1));
    throw 'asdfsafd';
  }
  Future<Ordens> _getOrdens() async {
    final res = await http.get(Uri.parse('http://170.10.0.65:8000/ordem'));
    final jData = json.decode(utf8.decode(res.bodyBytes));
    ordens = Ordens.fromJson(jData);
    return Ordens.fromJson(jData);
  }

  @override
  void initState() {
    super.initState();
    //_getOrdens();
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation){
        return Scaffold(
          appBar: AppBar(
            title: Text('Ordens de Manutenção'),
            actions: [
              IconButton(
                icon: Icon(Icons.qr_code),
                onPressed: () async{
                  final res = await http.get(Uri.parse('http://170.10.0.65:8000/ordem'));
                  final jData = json.decode(utf8.decode(res.bodyBytes));
                  // Ação ao clicar no ícone de QR Code
                  print(Ordens.fromJson(jData));
                  //ordens = Ordens.fromJson(jData);

                },
              ),
              IconButton(
                icon: Icon(Icons.refresh),
                onPressed: () {
                  this._getOrdens();
                },
              ),
              IconButton(
                icon: Icon(Icons.logout),
                onPressed: () {
                  this._getOrdens();
                },
              ),
            ],
          ),
          body: FutureBuilder(
              future:_getOrdens(),
              builder: (context, snapshot) {
              if( snapshot.hasData ){
                return Padding(
                  padding: const EdgeInsets.all(10),
                  child: ListView.builder(
                      itemCount: snapshot.data?.ordem.length,
                      itemBuilder:
                          (BuildContext context, int index){
                            print(snapshot.data?.ordem[index].descricao);
                            String? colorFlutter = snapshot.data?.ordem[1].colorFlutter;
                            String? backFlutter = snapshot.data?.ordem[index].backFlutter;
                            Color? cor = Color(int.parse(colorFlutter!));
                            Color? background = Color(int.parse(backFlutter!));
                            Color textColor = Color.fromARGB(255, 53, 53, 54);
                            String? letra = snapshot.data?.ordem[index].descricao.substring(0, 1).toUpperCase();
                            String? desc = snapshot.data?.ordem[index].descricao.substring(1);
                            desc = '$letra$desc';
                            if (orientation == Orientation.landscape) {
                              return listaHorizontal(context, snapshot.data?.ordem[index], index, cor, background, desc, textColor);
                            } else {
                              return listaVertical(context, snapshot.data?.ordem[index], index, cor, background, desc, textColor);
                            }
                      }),
                );
              }else if (snapshot.hasError) {
                return Center(child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    CircularProgressIndicator(),
                    Text('Tentando Conexão...', style: TextStyle(fontSize: 20),),
                    //Text("${snapshot.error}", style: TextStyle(color: Colors.red, fontSize: 30),),
                  ],
                ));
              }
              return Center(child: CircularProgressIndicator());
          },

          )
        );
      },
    );
  }
}
listaHorizontal (context, ordens, index, cor, background, desc, textColor){
  return Padding(
    padding: const EdgeInsets.all(5.0),
    child: InkWell(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AtividadeManutencaoPage( descricao: ordens.descricao as String, id: ordens.id as int),
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
                  Text( ordens.dataCriacao, style: TextStyle( color: textColor),),
                ],
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Responsável', style: TextStyle( color: textColor),),
                  Text(ordens.responsavelCriacao, style: TextStyle( color: textColor),),
                ],
              ),

              Text(ordens.statusFlutter, style: TextStyle( color: textColor),),
              Icon(Icons.circle, color: cor,),



            ],
          ),
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
                          child: Text('Responsável: '+ordem.responsavelCriacao, style: TextStyle( color: textColor),),
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