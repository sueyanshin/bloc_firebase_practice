import 'package:bloc_test/bloc_page/bloc_event.dart';
import 'package:bloc_test/bloc_page/bloc_page.dart';
import 'package:bloc_test/bloc_page/bloc_state.dart';
import 'package:bloc_test/firebase_options.dart';
import 'package:bloc_test/home.dart';
import 'package:bloc_test/login_screen.dart';
import 'package:bloc_test/sign_up_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MultiBlocProvider(providers: [
    BlocProvider<BlocPage>(create: (BuildContext context) => BlocPage())
  ], child: const MyHomePage()));
}

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       theme: ThemeData(useMaterial3: true),
//       debugShowCheckedModeBanner: false,
//       home: const MyHomePage(),
//     );
//   }
// }

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<BlocPage>(context).add(LoginEvent());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: Scaffold(
        body: BlocBuilder<BlocPage, BlocState>(
          builder: (BuildContext context, state) {
            if (state is LoginState) {
              return const LoginScreen();
            } else if (state is SignUpState) {
              return const SignUpScreen();
            } else if (state is HomeState) {
              return const HomePage();
            } else {
              return const HomePage();
            }
          },
        ),
      ),
    );
  }
}
