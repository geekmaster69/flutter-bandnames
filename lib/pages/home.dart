import 'package:band_names/models/band.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';

import '../providers/socket_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Band> bands = [];

  @override
  void initState() {
    super.initState();
    final socketProvider = Provider.of<SocketService>(context, listen: false);
    socketProvider.socket.on('active-bands', (payload) {
      if (payload == null) return;

      bands = (payload as List).map((band) => Band.fromMap(band)).toList();

      setState(() {});
    });
  }

  @override
  void dispose() {
    final socketProvider = Provider.of<SocketService>(context, listen: false);

    socketProvider.socket.off('active-bands');

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final socketProvider = Provider.of<SocketService>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Band Names',
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 10),
            child: socketProvider.serverStatus == ServerStatus.online
                ? Icon(
                    Icons.check_circle_outline,
                    color: Colors.blue[300],
                  )
                : const Icon(
                    Icons.offline_bolt_outlined,
                    color: Colors.red,
                  ),
          )
        ],
      ),
      body: Column(
        children: [
          _makeGraph(),
          Expanded(
            child: ListView.builder(
                itemCount: bands.length,
                itemBuilder: (context, index) => _bandTile(bands[index])),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addNewBand,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _bandTile(Band band) {
    final socketProvider = Provider.of<SocketService>(context, listen: false);

    return Dismissible(
      key: Key(band.id),
      direction: DismissDirection.startToEnd,
      onDismissed: (direction) {
        if (direction == DismissDirection.startToEnd) {
          // TODO Borrar banda de DB

          socketProvider.socket.emit('delete-band', {'id': band.id});
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
          socketProvider.socket.emit('vote-band', {'id': band.id});
        },
      ),
    );
  }

  addNewBand() {
    final textController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('New Band Name'),
          content: TextField(
            controller: textController,
          ),
          actions: [
            MaterialButton(
                textColor: Colors.blue,
                onPressed: () => addbandToList(textController.text),
                child: const Text('Add'))
          ],
        );
      },
    );
  }

  void addbandToList(String name) {
    final socketProvider = Provider.of<SocketService>(context, listen: false);
    if (name.length > 1) {
      socketProvider.socket.emit('add-band', {'name': name});
    }
    Navigator.pop(context);
  }

  Widget _makeGraph() {
    Map<String, double> dataMap = {};

    for (var band in bands) {
      dataMap.putIfAbsent(band.name, () => band.vote.toDouble());
    }

    return Container(
      padding: const EdgeInsets.all(5),
    
        width: double.infinity, height: 200, child: PieChart(
          
          
          chartType: ChartType.ring,
          
         
          dataMap: dataMap));
  }
}
