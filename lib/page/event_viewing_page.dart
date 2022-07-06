import 'dart:math';
import 'package:it_schedule/page/event_editing_page.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:flutter/material.dart';
import 'package:it_schedule/model/event.dart';
import 'package:it_schedule/utils.dart';
import 'package:it_schedule/provider/event_provider.dart';
import 'package:provider/provider.dart';

class EventViewingPage extends StatefulWidget {
  final Event event;

  const EventViewingPage({
    Key? key,
    required this.event,
  }) : super(key: key);

  @override 
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      leading: CloseButton(),
      actions: [
        buildViewingActions(context, event),
    ]),
    body: ListView(
      padding: EdgeInsets.all(32),
      children: <Widget> [
        buildDateTime(event),
        SizedBox(height: 32,),
        Text(
          event.title,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 24),
        Text(
          event.description,
          style: TextStyle(color: Colors.white, fontSize: 18),
        )
      ],
    )
  );

  Widget buildDateTime(Event event){
    return Column(children: [children: [
      buildDate(event)
    ]])
  }
  
  List<Widget> buildViewingActions(BuildContext context, Event event) {
    IconButton(
      icon: Icons(Icons.edit),
      onPressed: () => Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => EventEditingPage(event: event,))
      ),);
    IconButton(
      icon: Icon(Icons.delete),
      onPressed: () {
        final provider = Provider.of<EventProvider>(context, listen: false),
        provider.deleteEvent(event);
      },
      )

  }
}


