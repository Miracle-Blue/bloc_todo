import 'package:bloc_todo/domain/bloc/todo_bloc.dart';
import 'package:bloc_todo/ui/pages/create_page.dart';
import 'package:bloc_todo/ui/pages/edit_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'pages/home_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TodoBloc(),
        ),
        BlocProvider(
          create: (context) => SaveButtonBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomePage(),
        routes: {
          HomePage.id: (context) => const HomePage(),
          EditPage.id: (context) => EditPage(),
          CreatePage.id: (context) => CreatePage(),
        },
      ),
    );
  }
}
