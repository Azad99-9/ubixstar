import 'package:flutter/material.dart';

class WidgetSelection extends StatefulWidget {
  const WidgetSelection({super.key});

  @override
  State<WidgetSelection> createState() => _WidgetSelectionState();
}

class _WidgetSelectionState extends State<WidgetSelection> {
  List<String> widgets = ['Text Widget', 'Image Widget', 'Button Widget'];
  List<int> selectedWidgets = [];

  List<bool> widgetSelection = [false, false, false];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(child: Scaffold(
        body: Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 60),
        child: Container(
          width: double.infinity,
          color: Color(0xFF90EE90).withOpacity(0.4),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: List.generate(widgets.length, (index) {
                return SelectionWidget(
                    title: widgets[index],
                    index: index,
                    isSelected: false,
                    selectedWidgets: selectedWidgets,
                    );
              })),
        ),
      ),
    )), onWillPop: () async {
      print(selectedWidgets);
      Navigator.pop(context, selectedWidgets);
      return true;
    });
  }
}

class SelectionWidget extends StatefulWidget {
  final String title;
  bool isSelected;

  final int index;
  List<int> selectedWidgets;

  SelectionWidget(
      {required this.title,
      required this.isSelected,
      required this.selectedWidgets,
      required this.index});

  @override
  _SelectinWidgetState createState() => _SelectinWidgetState();
}

class _SelectinWidgetState extends State<SelectionWidget> {
  bool _selected = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 30, 0, 30),
      width: MediaQuery.of(context).size.width * 0.5,
      child: Container(
        color: Color(0xFFADADAD).withOpacity(0.5),
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            InkWell(
              child: Container(
                padding: EdgeInsets.all(4),
                color: Colors.white,
                child: CircleAvatar(
                  radius: 15,
                  backgroundColor: _selected
                      ? Color(0xFF90EE90).withOpacity(0.8)
                      : Color(0xFFADADAD).withOpacity(0.5),
                ),
              ),
              onTap: () {
                setState(() {
                  _selected = !_selected;
                  if (_selected) widget.selectedWidgets.add(widget.index);
                  else widget.selectedWidgets.remove(widget.index);
                  print(widget.selectedWidgets);
                });
              },
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(6),
                child: Text(
                  widget.title,
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
