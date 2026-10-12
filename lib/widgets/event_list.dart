import 'package:flutter/material.dart';
import 'package:evently_app/common/app_data.dart';
import 'package:evently_app/common/app_strings.dart';
import 'package:evently_app/home/models/event_model.dart';
import 'package:evently_app/widgets/event_card.dart';
import 'package:evently_app/common/App_text_styles.dart';
import 'package:evently_app/theme/app_color.dart';

class EventList extends StatelessWidget {
  final String selectedCtegory;
  // The parent decides what happens when a heart is tapped
  final ValueChanged<EventModel> onFavouriteTap;

  const EventList({
    super.key,
    required this.onFavouriteTap,
    required this.selectedCtegory,
  });
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: AppData.eventsRevision,
      builder: (context, revision, child) {
        final filteredEvents = selectedCtegory == 'All'
            ? AppData.events
            : AppData.events
                  .where((event) => event.category == selectedCtegory)
                  .toList();

        return Expanded(
          child: filteredEvents.isEmpty
              ? Center(
                  child: Text(
                    AppData.events.isEmpty
                        ? AppStrings.of(context).noEventsCreated
                        : AppStrings.of(context).noEventsFound,
                    textAlign: TextAlign.center,
                  ),
                )
              : ListView.builder(
                  itemCount: filteredEvents.length,
                  itemBuilder: (context, index) {
                    final event = filteredEvents[index];

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: EventCard(
                        event: event,
                        onFavouriteTap: () => onFavouriteTap(event),
                      ),
                    );
                  },
                ),
        );
      },
    );
  }
}
