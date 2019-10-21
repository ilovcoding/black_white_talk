import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'BaseModel.dart';

class ProviderWidget<A extends BaseModel> extends StatefulWidget {
  final A model;
  final Widget child;
  final Function(A) onModelReady;
  final Widget Function(BuildContext context, A model1, Widget child) builder;
  ProviderWidget({
    Key key,
    @required this.model,
    @required this.builder,
    this.onModelReady,
    this.child,
  }) : super(key: key);
  @override
  _ProviderWidgetState<A> createState() => _ProviderWidgetState<A>();
}

class _ProviderWidgetState<A extends BaseModel>
    extends State<ProviderWidget<A>> {
  A model;
  @override
  void initState() {
    // TODO: implement initState
    model = widget.model;
    if (widget.onModelReady != null) {
      widget.onModelReady(model);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
      return ChangeNotifierProvider<A>(
      builder: (context) => model,
      child: Consumer<A>(
        builder: widget.builder,
        child: widget.child,
      ),
    );
  }
}

class ProviderWidget2<A extends BaseModel, B extends BaseModel>
    extends StatefulWidget {
  final A model1;
  final B model2;
  final Widget child;
  final Function(A, B) onModelReady;
  final Widget Function(BuildContext context, A model1, B model2, Widget child)
      builder;
  ProviderWidget2({
    Key key,
    @required this.model1,
    @required this.model2,
    @required this.builder,
    this.child,
    this.onModelReady,
  }) : super(key: key);
  @override
  _ProviderWidget2State<A, B> createState() => _ProviderWidget2State<A, B>();
}

class _ProviderWidget2State<A extends BaseModel, B extends BaseModel>
    extends State<ProviderWidget2<A, B>> {
  A model1;
  B model2;
  @override
  void initState() {
    // TODO: implement initState
    model1 = widget.model1;
    model2 = widget.model2;
    if (widget.onModelReady != null) {
      widget.onModelReady(model1, model2);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<A>(
            builder: (context) => model1,
          ),
          ChangeNotifierProvider<B>(
            builder: (context) => model2,
          )
        ],
        child: Consumer2<A, B>(
          builder: widget.builder,
          child: widget.child,
        ));
  }
}
