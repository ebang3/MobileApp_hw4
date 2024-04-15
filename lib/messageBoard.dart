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
  final String board, email;
  const messageBoard({super.key, required this.board, required this.email});
  @override
  State<messageBoard> createState() => _messageBoardState(board, email);
}

class _messageBoardState extends State<messageBoard> {
  late final String board, email;
  _messageBoardState(this.board, this.email);

  late final CollectionReference _messageBoard =
      FirebaseFirestore.instance.collection(board);

  final TextEditingController _messageController = TextEditingController();

  Future<void> _sendMessage([DocumentSnapshot? documentSnapshot]) async {
    await _messageBoard
        .add({"message": _messageController.text, "time": DateTime.now()});
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$board Message Board'),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: _messageBoard.snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                if (streamSnapshot.hasData) {
                  return ListView.builder(
                    reverse: true,
                    itemCount: streamSnapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final DocumentSnapshot documentSnapshot =
                          streamSnapshot.data!.docs[index];
                      return Card(
                        margin: const EdgeInsets.all(10),
                        child: ListTile(
                            title: Text(documentSnapshot['message']),
                            subtitle: Text(email),
                            trailing: Text(
                                documentSnapshot['time'].toDate().toString())),
                      );
                    },
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
          TextField(
            controller: _messageController,
            decoration: InputDecoration(
              hintText: 'Enter a message',
              suffixIcon: IconButton(
                onPressed: () {
                  _sendMessage();
                  _messageController.text = '';
                },
                icon: const Icon(Icons.send),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
