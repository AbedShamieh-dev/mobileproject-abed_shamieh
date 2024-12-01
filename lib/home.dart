import 'package:flutter/material.dart';
import 'travel.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Destination destination = destinations.first;
  String totalCost = destinations.first.getTotalCost(1);
  int travelers = 1;

  void updateDestination(Destination destination) {
    setState(() {
      this.destination = destination;
      totalCost = destination.getTotalCost(travelers);
    });
  }

  void updateTravelClass(int travelClass) {
    setState(() {
      destination.travelClass = travelClass;
      totalCost = destination.getTotalCost(travelers);
    });
  }

  void updateTravelers(String value) {
    setState(() {
      travelers = int.tryParse(value) ?? 1;
      totalCost = destination.getTotalCost(travelers);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
        Text("Travel Expense Calculator", style: TextStyle(fontSize: 20.0)),
        centerTitle: true,
        leading: Icon(
          Icons.travel_explore,
          size: 30.0,
          color: Colors.red,
        ),
        elevation: 0.0,
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 10.0),
            Text("Select Destination",
                style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold)),
            SizedBox(height: 10.0),
            MyDropDownWidget(updateDestination: updateDestination),
            SizedBox(height: 10.0),
            TravelClassWidget(
                updateClass: updateTravelClass, destination: destination),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Insurance: "),
                Checkbox(
                    value: destination.insurance,
                    onChanged: (bool? value) {
                      setState(() {
                        destination.insurance = value as bool;
                        totalCost = destination.getTotalCost(travelers);
                      });
                    }),
              ],
            ),
            SizedBox(height: 10.0),
            MyTextField(updateTravelers: updateTravelers),
            SizedBox(height: 10.0),
            Text("Total Cost: \$$totalCost",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0)),
          ],
        ),
      ),
    );
  }
}
