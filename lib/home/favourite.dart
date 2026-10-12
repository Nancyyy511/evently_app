import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:evently_app/common/app_data.dart';
import 'package:evently_app/common/app_strings.dart';
import 'package:evently_app/home/models/event_model.dart';
import 'package:evently_app/widgets/event_card.dart';
import 'package:evently_app/widgets/custom_text_field.dart';
import 'package:evently_app/theme/app_color.dart';
import 'package:evently_app/common/App_text_styles.dart';

class FavouriteScreen extends StatefulWidget {
  // Comes from LayoutScreen so Home and Favourite share the same state
  final ValueChanged<EventModel> onFavouriteTap;

  const FavouriteScreen({super.key, required this.onFavouriteTap});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  final TextEditingController searchController = TextEditingController();
  String searchQuery = '';

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final strings = AppStrings.of(context);

    final textColor = isDark
        ? AppColors.darkTextColor
        : AppColors.lightTextColor;

    final mainColor = isDark
        ? AppColors.mainColorDark
        : AppColors.mainColorlight;

    final favouriteEvents = AppData.events.where((event) {
      final matchesFavourite = event.isFavourite;
      final query = searchQuery.trim().toLowerCase();
      final matchesSearch =
          event.caption.toLowerCase().contains(query) ||
          event.category.toLowerCase().contains(query);

      return matchesFavourite && matchesSearch;
    }).toList();

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBgColor : AppColors.lightBgColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Column(
            children: [
              //Search
              CustomTextField(
                controller: searchController,
                hintText: strings.searchForEvent,
                suffixIcon: Padding(
                  padding: const EdgeInsets.all(12),
                  // The SVG stroke is mainColorlight; tint it per theme
                  child: SvgPicture.asset(
                    AppData.search,
                    width: 24,
                    height: 24,
                    colorFilter: ColorFilter.mode(mainColor, BlendMode.srcIn),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    searchQuery = value;
                  });
                },
              ),
              SizedBox(height: 16),

              //favourite event
              Expanded(
                child: favouriteEvents.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.favorite_border,
                              size: 64,
                              color: mainColor,
                            ),
                            SizedBox(height: 16),
                            Text(
                              searchQuery.isEmpty
                                  ? strings.noFavourites
                                  : strings.noMatchingEvents,
                              style: AppTextStyles.styleW600S18(
                                color: textColor,
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        itemCount: favouriteEvents.length,
                        itemBuilder: (context, index) {
                          final event = favouriteEvents[index];

                          return Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: EventCard(
                              event: event,
                              onFavouriteTap: () =>
                                  widget.onFavouriteTap(event),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
