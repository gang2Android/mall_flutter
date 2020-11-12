import 'package:flutter/material.dart';

abstract class BaseState<T extends StatefulWidget> extends State<T> {
  String tag = "BaseState";

  @override
  void initState() {
    super.initState();
    print("$tag-initState");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("$tag-didChangeDependencies");
  }

  @override
  void didUpdateWidget(covariant T oldWidget) {
    super.didUpdateWidget(oldWidget);
    print("$tag-didUpdateWidget");
  }

  @override
  Widget build(BuildContext context) {
    print("$tag-build");
    return getContentWidget(context);
  }

  @override
  void reassemble() {
    super.reassemble();
    print("$tag-reassemble");
  }

  @override
  void deactivate() {
    super.deactivate();
    print("$tag-deactivate");
  }

  @override
  void dispose() {
    super.dispose();
    print("$tag-dispose");
  }

  @protected
  Widget getContentWidget(BuildContext context);
}
