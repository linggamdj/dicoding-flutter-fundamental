import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/commons/style.dart';
import 'package:restaurant_app/provider/scheduling_provider.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
          ),
        ),
        backgroundColor: primaryColor,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Settings',
        ),
      ),
      body: Container(
        margin: const EdgeInsets.all(10),
        child: Material(
          child: ListTile(
            title: Text(
              'Scheduling Restaurant',
              style: primaryTextStyle.copyWith(
                fontWeight: semiBold,
                fontSize: 16,
              ),
            ),
            trailing: Consumer<SchedulingProvider>(
              builder: (context, scheduled, _) {
                return Switch.adaptive(
                  value: scheduled.isScheduled,
                  onChanged: (value) async {
                    scheduled.scheduledRestaurant(value);
                  },
                  activeTrackColor: switchColor,
                  activeColor: primaryColor,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
