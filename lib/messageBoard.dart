import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

class messageBoard extends StatefulWidget {
  final String board;
  const messageBoard({super.key, required this.board});
  @override
  State<messageBoard> createState() => _messageBoardState(board);
}

class _messageBoardState extends State<messageBoard> {
  late String board = '';
  _messageBoardState(this.board);

  late final CollectionReference _messageBoard =
      FirebaseFirestore.instance.collection(board);

  final TextEditingController _messageController = TextEditingController();

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$board Message Board'),
      ),
      body: StreamBuilder(
        stream: _messageBoard.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            return ListView.builder(
              itemCount: streamSnapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot documentSnapshot =
                    streamSnapshot.data!.docs[index];
                return Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    title: Text(documentSnapshot['message']),
                  ),
                );
              },
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
