import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_options.dart';
import 'homepage.dart';
//import 'package:splashscreen/splashscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(title: 'HomePage'),
      debugShowCheckedModeBanner: false,
    );
  }
}

/*
class SplashScreen extends StatelessWidget {
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 6,
      navigateAfterSeconds: new MyHomePage(),
      title: new Text(
        'GeeksForGeeks',
        textScaleFactor: 2,
      ),
      image: new Image.network(
          'https://www.geeksforgeeks.org/wp-content/uploads/gfg_200X200.png'),
      loadingText: Text("Loading"),
      photoSize: 100.0,
      loaderColor: Colors.blue,
    );
  }
}
*/
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _SignInPage();
}

class _SignInPage extends State<MyHomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late final CollectionReference _user =
      FirebaseFirestore.instance.collection('users');
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool signSheet = false;

  void _signOut() async {
    await _auth.signOut();
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Signed out successfully'),
    ));
  }

  Future<void> addUser() async {
    await _user.add({
      "firstName": _firstNameController.text,
      "lastName": _lastNameController.text,
      'registration': DateTime.now(),
      "role": 'Guest',
    });
  }

  void _signUp() async {
    try {
      addUser();
      await _auth.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      setState(() {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Account created successfully'),
        ));
      });
    } catch (e) {
      setState(() {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Account creation failed'),
        ));
      });
    }
  }

  void _signIn() async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      setState(() {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Signed in successfully'),
        ));
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => homepage()));
      });
    } catch (e) {
      setState(() {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Sign in failed'),
        ));
      });
    }
  }

  void _signUpForm() {
    showModalBottomSheet(
      context: context,
      elevation: 5,
      isScrollControlled: true,
      builder: (_) => Container(
        padding: EdgeInsets.fromLTRB(
          15,
          15,
          15,
          MediaQuery.of(context).viewInsets.bottom + 80,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextFormField(
              controller: _firstNameController,
              decoration: const InputDecoration(labelText: 'First Name'),
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _lastNameController,
              decoration: const InputDecoration(labelText: 'Last Name'),
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
            ElevatedButton(
              child: Text('Create Account'),
              onPressed: () {
                _signUp();
                _firstNameController.text = '';
                _lastNameController.text = '';
                _emailController.text = '';
                _passwordController.text = '';
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _signInForm() {
    showModalBottomSheet(
      context: context,
      elevation: 5,
      isScrollControlled: true,
      builder: (_) => Container(
        padding: EdgeInsets.fromLTRB(
          15,
          15,
          15,
          MediaQuery.of(context).viewInsets.bottom + 80,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
            ElevatedButton(
              child: Text('Sign In'),
              onPressed: () {
                _signIn();
                _emailController.text = '';
                _passwordController.text = '';
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Message Board App'),
          backgroundColor: Colors.lightGreen,
        ),
        body: Center(
            child: Column(children: [
          ElevatedButton(
              child: const Text('Sign Up'),
              onPressed: () {
                signSheet = false;
                _signUpForm();
              }),
          ElevatedButton(
              child: const Text('Sign In'),
              onPressed: () {
                signSheet = true;
                _signInForm();
              }),
        ])));
  }
}
