import 'package:flutter/material.dart';

class DragBox extends StatefulWidget {
  final bool simpleType;
  final String label;
  final DragBoxState dragBoxState = DragBoxState();

  DragBox(this.label, [this.simpleType = true]);

  @override
  DragBoxState createState() => dragBoxState;
}

class DragBoxState extends State<DragBox> {
  Offset position = Offset(0.0, 0.0);
  bool visibility = true;

  setVisibility(bool visibility) {
    setState(() {
      this.visibility = visibility;
    });
  }

  @override
  void initState() {
    super.initState();
    visibility = widget.simpleType;
  }

  @override
  Widget build(BuildContext context) {
    return visibility
        ? Draggable(
            data: widget.label,
            child: Container(
              width: 40.0,
              height: 35.0,
              decoration: getSimpleDecoration(),
              child: Center(
                child: Text(
                  widget.label,
                  style: TextStyle(
                    color: Colors.black54,
                    decoration: TextDecoration.none,
                    fontSize: 20.0,
                  ),
                ),
              ),
            ),
            onDragCompleted: () {
              setState(() {
                visibility = !visibility;
              });
            },
            childWhenDragging: getDotPoint(),
            feedback: Container(
              width: 50.0,
              height: 50.0,
              decoration: getSimpleDecoration(),
              child: Center(
                child: Text(
                  widget.label,
                  style: TextStyle(
                    color: Colors.white,
                    decoration: TextDecoration.none,
                    fontSize: 18.0,
                  ),
                ),
              ),
            ),
          )
        : getDotPoint();
  }

  getSimpleDecoration() {
    return BoxDecoration(
        border: Border.all(color: Colors.black54),
        borderRadius: BorderRadius.all(Radius.circular(11)),
        color: Color(0x22000000));
  }

  getTransparentDecoration() {
    return BoxDecoration(
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.all(Radius.circular(11)),
        color: Color(0x00ffffff));
  }

  Widget getDotPoint() {
    return Container(
      width: 40.0,
      height: 35.0,
      child: Center(
        child: Container(
          color: Colors.black54,
          width: 5,
          height: 5,
        ),
      ),
    );
  }
}
