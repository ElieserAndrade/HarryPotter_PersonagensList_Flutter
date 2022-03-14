import 'package:flutter/material.dart';
import 'package:harry_potter/Controller/ResponsePersonagem.dart';
import 'package:harry_potter/Model/Personagem.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Personagem>> futurePersonagem;

  List personagens = [];
  List personagensfiltrados = [];
  bool procurando = false;

  @override
  void initState() {
    futurePersonagem = Servicos().getPersonagem();
    super.initState();
  }

  void _filterTrabalhos(value) {
    setState(() {
      personagensfiltrados = personagens
          .where((json) =>
              json["name"].toLowerCase().contains(value.toLowerCase()) ||
              json["species"].toLowerCase().contains(value.toLowerCase()) ||
              json["gender"].toLowerCase().contains(value.toLowerCase()) ||
              json["house"].toLowerCase().contains(value.toLowerCase()) ||
              json["dateOfBirth"].toLowerCase().contains(value.toLowerCase()) ||
              json["yearOfBirth"].toLowerCase().contains(value.toLowerCase()) ||
              json["wizard"].toLowerCase().contains(value.toLowerCase()) ||
              json["ancestry"].toLowerCase().contains(value.toLowerCase()) ||
              json["eyeColour"].toLowerCase().contains(value.toLowerCase()) ||
              json["hairColour"].toLowerCase().contains(value.toLowerCase()) ||
              json["patronus"].toLowerCase().contains(value.toLowerCase()) ||
              json["hogwartsStudent"]
                  .toLowerCase()
                  .contains(value.toLowerCase()) ||
              json["hogwartsStaff"]
                  .toLowerCase()
                  .contains(value.toLowerCase()) ||
              json["actor"].toLowerCase().contains(value.toLowerCase()) ||
              json["alive"].toLowerCase().contains(value.toLowerCase()) ||
              json["image"].toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: procurando
            ? TextField(
                onChanged: (value) {
                  _filterTrabalhos(value);
                },
                style: const TextStyle(color: Colors.amber),
                cursorColor: Colors.amber,
                decoration: const InputDecoration(
                  hintText: "Pesquise um Personagem",
                  hintStyle: TextStyle(color: Colors.amber),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.amber),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.amber),
                  ),
                  // labelText: "Pesquise uma palavra: ",
                  fillColor: Colors.amber,
                ),
              )
            : const Text(
                'Personagens Harry Potter',
                style: TextStyle(
                    color:Colors.amber,
                    fontFamily: 'HarryPotter',
                    fontSize: 30),
              ),
        actions: <Widget>[
          procurando
              ? IconButton(
                  icon: const Icon(Icons.cancel, color: Colors.amber,),
                  onPressed: () {
                    setState(() {
                      procurando = false;
                      personagensfiltrados = personagens;
                    });
                  },
                )
              : IconButton(
                icon: const Icon(Icons.search, color: Colors.amber,),
                  onPressed: () {
                    setState(() {
                      procurando = true;
                    });
                  },
                )
        ],
      ),
      body: Center(
        child: Container(
          color: const Color.fromARGB(255, 12, 12, 12),
          child: FutureBuilder<List<Personagem>>(
              future: futurePersonagem,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return Card(
                        elevation: 8.0,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 6.0),
                        child: Container(
                          decoration: const BoxDecoration(
                              color: Color.fromRGBO(64, 75, 96, .9)),
                          child: ListTile(
                            tileColor: Colors.amber,
                            title: Text(snapshot.data![index].name,
                                style: const TextStyle(color: Colors.amber,fontFamily: 'HarryPotter', fontSize: 25 )),
                            leading: CircleAvatar(
                                backgroundImage: snapshot.data![index].image !=
                                        ""
                                    ? NetworkImage(snapshot.data![index].image)
                                    : const NetworkImage(
                                        'https://img2.gratispng.com/20180402/gdw/kisspng-null-pointer-symbol-computer-icons-pi-5ac1c0964f62d5.3135633215226471903252.jpg')),
                          ),
                        ),
                      );
                    },
                  );
                }
                return const CircularProgressIndicator();
              }),
        ),
      ),
    );
  }
}
