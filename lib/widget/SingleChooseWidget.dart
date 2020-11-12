import 'package:flutter/material.dart';

class SingleChooseWidget extends StatefulWidget {
  final List<ChooseBean> list;
  final Function(ChooseBean selectItem) onChange;

  SingleChooseWidget({Key key, this.list, this.onChange}) : super(key: key);

  @override
  _SingleChooseWidgetState createState() => _SingleChooseWidgetState();
}

class _SingleChooseWidgetState extends State<SingleChooseWidget> {
  String _selectId = "";

  @override
  void initState() {
    super.initState();
    if (widget.list.length > 0) {
      _selectId = widget.list[0].getId();
      // if (widget.onChange != null) widget.onChange(widget.list[0]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.start,
      children: _items(),
    );
  }

  _items() {
    List<Widget> items = List();
    widget.list.forEach((element) {
      var item = Container(
        height: 31,
        padding: EdgeInsets.all(2),
        child: ChoiceChip(
          label: Text(
            element.getName(),
            style: TextStyle(fontSize: 14),
          ),
          selected: _selectId == element.getId(),
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          labelPadding: EdgeInsets.only(bottom: 9),
          padding: EdgeInsets.only(left: 12, right: 12, bottom: 9),
          onSelected: (selected) {
            if (_selectId == element.getId()) return;
            setState(() {
              _selectId = element.getId();
            });
            if (widget.onChange != null) widget.onChange(element);
          },
        ),
      );
      items.add(item);
    });
    return items;
  }
}

abstract class ChooseBean {
  // String _id;
  // String _name;

  // ChooseBean(this.id, this.name);

  String getId();

  String getName();

  @override
  String toString() {
    return 'ChooseBean{id: ${getId()}, name: ${getName()}';
  }
}
