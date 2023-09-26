import 'package:flutter/material.dart';

import 'package:appcrudsqlite/data/dbCine.dart';

class EditCine extends StatefulWidget {
  int rollno;

  EditCine({required this.rollno}); //constructor for class

  @override
  State<StatefulWidget> createState() {
    return _EditCine();
  }
}

class _EditCine extends State<EditCine> {
  TextEditingController nome = TextEditingController();
  TextEditingController genero = TextEditingController();
  TextEditingController diretor = TextEditingController();
  TextEditingController ano = TextEditingController();
  TextEditingController roll_no = TextEditingController();

  DbFilme mydb = new DbFilme();

  @override
  void initState() {
    mydb.open();

    Future.delayed(Duration(milliseconds: 500), () async {
      var data = await mydb.getCines(
          widget.rollno); //widget.rollno is passed paramater to this class

      if (data != null) {
        nome.text = data["titulo"];
        genero.text = data["genero"];
        diretor.text = data["diretor"];
        ano.text = data["ano"];
        roll_no.text = data["roll_no"].toString();

        setState(() {});
      } else {
        print("Não encontrado dados com roll no: " + widget.rollno.toString());
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Editar Filme"),
        ),
        body: Container(
          padding: EdgeInsets.all(30),
          child: Column(
            children: [
              TextField(
                controller: nome,
                decoration: InputDecoration(
                  hintText: "Título",
                ),
              ),
              TextField(
                controller: genero,
                decoration: InputDecoration(
                  hintText: "Genero",
                ),
              ),
              TextField(
                controller: diretor,
                decoration: InputDecoration(
                  hintText: "Diretor",
                ),
              ),
              TextField(
                controller: ano,
                decoration: InputDecoration(
                  hintText: "Ano",
                ),
              ),
              TextField(
                controller: roll_no,
                decoration: InputDecoration(
                  hintText: "Roll No.",
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    mydb.db.rawInsert(
                        "UPDATE cine SET nome = ?, genero = ?, diretor = ?, ano = ?, roll_no = ? WHERE roll_no = ?",
                        [
                          nome.text,
                          genero.text,
                          diretor.text,
                          ano.text,
                          roll_no.text,
                          widget.rollno
                        ]);

                    //update table with roll no.

                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Filme Alterado!")));
                  },
                  child: Text("Alterar Filme")),
            ],
          ),
        ));
  }
}