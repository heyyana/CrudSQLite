import 'package:flutter/material.dart';
import 'package:appcrudsqlite/data/dbCine.dart';

class Add extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Add();
  }
}

class _Add extends State<Add> {
  TextEditingController nome = TextEditingController();
  TextEditingController genero = TextEditingController();
  TextEditingController diretor = TextEditingController();
  TextEditingController ano = TextEditingController();
  TextEditingController roll_no = TextEditingController();

  //test editing controllers for form

  DbFilme mydb = DbFilme(); //mydb new object from db.dart

  @override
  void initState() {
    mydb.open(); //initilization database
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Adicionar Filme"),
        ),
        body: Container(
          padding: EdgeInsets.all(30),
          child: Column(
            children: [
              TextField(
                controller: nome,
                decoration: const InputDecoration(
                  hintText: "Nome",
                ),
              ),
              TextField(
                controller: genero,
                decoration: const InputDecoration(
                  hintText: "Genero do filme",
                ),
              ),
              TextField(
                controller: diretor,
                decoration: const InputDecoration(
                  hintText: "Diretor",
                ),
              ),
              TextField(
                controller: ano,
                decoration: const InputDecoration(
                  hintText: "Ano",
                ),
              ),
              TextField(
                controller: roll_no,
                decoration: const InputDecoration(
                  hintText: "Código",
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    mydb.db.rawInsert(
                        "INSERT INTO cine(nome, genero, diretor, ano, roll_no) VALUES (?, ?, ?, ?, ?);",
                        [
                          nome.text,
                          genero.text,
                          diretor.text,
                          ano.text,
                          roll_no.text
                        ]); //add student from form to database

                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Filme Adicionado")));

                    nome.text = "";
                    genero.text = "";
                    diretor.text = "";
                    ano.text = "";
                    roll_no.text = "";
                  },
                  child: Text("Salvar")),
            ],
          ),
        ));
  }
}
