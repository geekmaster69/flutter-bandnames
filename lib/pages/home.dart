import 'package:band_names/models/band.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Band> bands = [
    Band(id: '1', name: 'Maeallica', vote: 5),
    Band(id: '2', name: 'Queen', vote: 2),
    Band(id: '3', name: 'Heroes del silencio', vote: 3),
    Band(id: '3', name: 'Bon Jovi', vote: 6),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Band Names',
        ),
      ),
      body: ListView.builder(
          itemCount: bands.length,
          itemBuilder: (context, index) => _bandTile(bands[index])),
      floatingActionButton: FloatingActionButton(
        onPressed: addNewBand,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _bandTile(Band band) => Dismissible(
        key: Key(band.id),
        direction: DismissDirection.startToEnd,
        onDismissed: (direction) {
          if(direction == DismissDirection.startToEnd){
            // TODO Borrar banda de DB
            

          }
          
        },
        background: Container(
          padding: const EdgeInsets.only(left: 10),
          color: Colors.red,
          child: const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Delete Band',
                style: TextStyle(color: Colors.white),
              )),
        ),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.blue[100],
            child: Text(band.name.substring(0, 2)),
          ),
          title: Text(band.name),
          trailing: Text(
            '${band.vote}',
            style: const TextStyle(fontSize: 20),
          ),
          onTap: () {
            print(band.name);
          },
        ),
      );

  addNewBand() {
    final textController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('New Band Name'),
          content: TextField(
            controller: textController,
          ),
          actions: [
            MaterialButton(
                child: Text('Add'),
                textColor: Colors.blue,
                onPressed: () => addbandToList(textController.text))
          ],
        );
      },
    );
  }

  void addbandToList(String name) {
    if (name.length > 1) {
      bands.add(Band(id: DateTime.now().toString(), name: name, vote: 0));
      setState(() {});
    }

    Navigator.pop(context);
  }
}
