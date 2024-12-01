import 'package:flutter/material.dart';

// List of destinations to populate the dropdown
List<Destination> destinations = [
  Destination('Paris', 2000),
  Destination('Tokyo', 3000),
  Destination('New York', 2500),
  Destination('Dubai', 1800)
];

class Destination {
  String name;
  int baseCost;
  int travelClass = 1;
  bool insurance = false;

  Destination(this.name, this.baseCost);
  String toString() {
    return "$name Base Cost: \$$baseCost";
  }

  String getTotalCost(int travelers) {
    int insuranceAmount = insurance ? 1000 * travelers : 0;
    double average = travelClass == 2 ? 1.3 : (travelClass == 3 ? 1.5 : 1);
    return ((baseCost * travelers * average) + insuranceAmount)
        .toStringAsFixed(0);
  }
}

class MyDropDownWidget extends StatefulWidget {
  final Function(Destination) updateDestination;
  const MyDropDownWidget({required this.updateDestination, super.key});

  @override
  State<MyDropDownWidget> createState() => _MyDropDownWidgetState();
}

class _MyDropDownWidgetState extends State<MyDropDownWidget> {
  @override
  Widget build(BuildContext context) {
    return DropdownMenu(
        width: 250.0,
        initialSelection: destinations[0],
        onSelected: (val) {
          setState(() {
            widget.updateDestination(val as Destination);
          });
        },
        dropdownMenuEntries: destinations
            .map<DropdownMenuEntry<Destination>>((Destination destination) {
          return DropdownMenuEntry(
              value: destination, label: destination.toString());
        }).toList());
  }
}

class TravelClassWidget extends StatefulWidget {
  final Function(int) updateClass;
  final Destination destination;
  const TravelClassWidget(
      {required this.updateClass, required this.destination, super.key});

  @override
  State<TravelClassWidget> createState() => _TravelClassWidgetState();
}

class _TravelClassWidgetState extends State<TravelClassWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Radio(
            value: 1,
            groupValue: widget.destination.travelClass,
            onChanged: (val) {
              setState(() {
                widget.updateClass(val as int);
              });
            }),
        Text("Economy", style: TextStyle(fontSize: 15.0)),
        Radio(
            value: 2,
            groupValue: widget.destination.travelClass,
            onChanged: (val) {
              setState(() {
                widget.updateClass(val as int);
              });
            }),
        Text("Business", style: TextStyle(fontSize: 15.0)),
        Radio(
            value: 3,
            groupValue: widget.destination.travelClass,
            onChanged: (val) {
              setState(() {
                widget.updateClass(val as int);
              });
            }),
        Text("First Class", style: TextStyle(fontSize: 15.0)),
      ],
    );
  }
}

class MyTextField extends StatefulWidget {
  final Function(String) updateTravelers;
  const MyTextField({required this.updateTravelers, super.key});

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300.0,
      height: 50.0,
      child: TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: "Number of travelers(Default:1)",
        ),
        onChanged: (String val) {
          setState(() {
            widget.updateTravelers(val);
          });
        },
      ),
    );
  }
}
