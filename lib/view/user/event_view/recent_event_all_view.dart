import 'package:calebshirthum/common%20widget/custom_app_bar_widget.dart';
import 'package:flutter/material.dart';

import '../../../common widget/custom_date_format.dart';
import '../profile_view/widgets/event_card.dart';

class RecentEventAllView extends StatelessWidget {
  const RecentEventAllView({super.key});

  Color getMedalColor(String? result) {
    switch (result) {
      case "Gold":
        return Colors.amber;
      case "Silver":
        return Colors.grey;
      case "Bronze":
        return Colors.brown;
      case "DNP":
        return Colors.brown;

      default:
        return Colors.grey;
    }
  }

  Widget getMedalIcon(String? result) {
    switch (result) {
      case "Gold":
        return Image.asset(
          "assets/images/gold.png",
          width: 24,
          height: 24,
        );
      case "Silver":
        return Image.asset(
          "assets/images/silver.png",
          width: 24,
          height: 24,
        );
      case "Bronze":
        return Image.asset(
          "assets/images/bronze.png",
          width: 24,
          height: 24,
        );

      case "DNP":
        return Image.asset(
          "assets/images/bronze.png",
          width: 24,
          height: 24,
        );

      default:
        return Image.asset(
          "assets/images/dnp.png",
          width: 24,
          height: 24,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "All Events Result",
      ),
      body: ListView.builder(itemBuilder: (BuildContext context, index) {
        return EventCard(
          medalColor: getMedalColor(""),
          medalIcon: getMedalIcon(""),
          showCompetition: false,
          title: "",
          date: CustomDateFormatter.formatDate(
            "",
          ),
          division: "",
          location: "n/a",
          medalText: "",
        );
      }),
    );
  }
}
