import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:it_schedule/provider/event_provider.dart';
import 'package:it_schedule/widget/tasks_widget.dart';
import 'package:it_schedule/model/event_data_source.dart';
import 'package:intl/intl.dart';

class CalendarWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final events = Provider.of<EventProvider>(context).events;
    return SfCalendar(
      view: CalendarView.month,
      dataSource: EventDataSource(events),
      initialSelectedDate: DateTime.now(),
      cellBorderColor: Colors.red,
      onLongPress: (details) {
        final provider = Provider.of<EventProvider>(context, listen: true);

        provider.setDate(details.date!);
        showModalBottomSheet(
          context: context,
          builder: (context) => TasksWidget(),
        );
      },
    );
  }
}
