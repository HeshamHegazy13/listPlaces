import 'package:flutter/material.dart';
import 'package:listPlaces/Provider/places.dart';
import 'package:listPlaces/Screens/add_place_screen.dart';
import 'package:provider/provider.dart';

class PlacesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Places'),
        actions: [
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
              }),
        ],
      ),
      body: Consumer<GreatPlaces>(
        child: Center(
          child: Text('No Places Yet'),
        ),
        builder: (context, greatPlaces, child) => greatPlaces.items.length <= 0
            ? child
            : ListView.builder(
                itemBuilder: (context, index) => ListTile(
                  leading: CircleAvatar(
                    backgroundImage: FileImage(greatPlaces.items[index].image),
                  ),
                  title: Text(greatPlaces.items[index].title),
                  onTap: () {},
                ),
                itemCount: greatPlaces.items.length,
              ),
      ),
    );
  }
}
