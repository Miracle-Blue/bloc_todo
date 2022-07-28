import 'package:flutter/material.dart';

abstract class BlocBase {
  @mustCallSuper
  void dispose();
}

class BlocProvider<T extends BlocBase> extends StatefulWidget {
  final T bloc;
  final Widget child;

  const BlocProvider({
    Key? key,
    required this.child,
    required this.bloc,
  }): super(key: key);

  @override
  BlocProviderState<T> createState() => BlocProviderState<T>();

  static T of<T extends BlocBase>(BuildContext context){
    return context.findAncestorWidgetOfExactType<BlocProvider<T>>()!.bloc;
  }
}

class BlocProviderState<T> extends State<BlocProvider<BlocBase>>{
  @override
  void dispose(){
    widget.bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    return widget.child;
  }
}