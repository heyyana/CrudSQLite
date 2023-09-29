import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbFilme {
  late Database db;

  Future open() async {
    // Get a location using getDatabasesPath

    var databasesPath = await getDatabasesPath();

    String path = join(databasesPath, 'bdcines.db');

    //join is from path package

    print(
        path); //output /data/user/0/com.testapp.flutter.testapp/databases/demo.db

    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table

      await db.execute(''' 

                  CREATE TABLE IF NOT EXISTS cine (  

                        id primary key, 

                        nome varchar(50) not null, 
                        genero varchar(50) not null, 
                        diretor varchar(50) not null, 
                        ano varchar(4) not null,
                        roll_no int not null 
                    ); 

                    //create more table here 

                 

                ''');

      print("Tabela Criada com Sucesso!");
    });
  }

  //método de consulta de dados

  Future<Map<dynamic, dynamic>?> getCines(int rollno) async {
    List<Map> maps =
        await db.query('cines', where: 'roll_no = ?', whereArgs: [rollno]);

    //getting student data with roll no.

    if (maps.length > 0) {
      return maps.first;
    }

    return null;
  }
}
