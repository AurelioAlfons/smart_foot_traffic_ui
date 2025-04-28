// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:smart_foot_traffic_ui/components/summary_board.dart';
import 'package:smart_foot_traffic_ui/components/calendar_dropdown.dart'; // 👈 Import the separated CalendarDropdown
import '../components/heatmap_view.dart';

class PersistentHeatmapView extends StatefulWidget {
  final String url;

  const PersistentHeatmapView({required this.url, super.key});

  @override
  State<PersistentHeatmapView> createState() => _PersistentHeatmapViewState();
}

class _PersistentHeatmapViewState extends State<PersistentHeatmapView> {
  @override
  Widget build(BuildContext context) {
    return HeatmapView(url: widget.url);
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? selectedTrafficType;
  String? selectedDate;
  String? selectedTime;
  String? selectedSeason;

  String? heatmapUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(90),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 20,
                spreadRadius: 2,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            toolbarHeight: 90,
            title: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset('assets/images/council_logo.png', height: 160),
                  const Spacer(),
                  _buildAppBarButton("Home"),
                  _buildAppBarButton("Location"),
                  _buildAppBarButton("Transport"),
                  _buildAppBarButton("Map"),
                  _buildAppBarButton("About"),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.yellow[700],
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 14),
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    onPressed: () {},
                    child: const Text("Register Now →"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            const SizedBox(height: 10),
            SizedBox(
              height: 100,
              child: SingleChildScrollView(
                clipBehavior: Clip.none,
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    const SizedBox(width: 16),
                    _buildDropdown(
                        "Traffic Type",
                        ["Pedestrian", "Vehicle", "Cyclist"],
                        selectedTrafficType,
                        (value) => setState(() => selectedTrafficType = value)),
                    const SizedBox(width: 16),
                    _buildDatePickerButton(),
                    const SizedBox(width: 16),
                    _buildDropdown(
                        "Time",
                        ["12:00:00", "13:00:00"],
                        selectedTime,
                        (value) => setState(() => selectedTime = value)),
                    const SizedBox(width: 16),
                    _buildDropdown(
                        "Season",
                        ["Summer", "Autumn", "Winter", "Spring"],
                        selectedSeason,
                        (value) => setState(() => selectedSeason = value)),
                    const SizedBox(width: 16),
                    SizedBox(
                      height: 45,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.indigo[900],
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 12),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          elevation: 4,
                        ),
                        onPressed: generateHeatmap,
                        child: const Text("Generate →"),
                      ),
                    ),
                    const SizedBox(width: 16),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    flex: 5,
                    child: Container(
                      margin: const EdgeInsets.all(12),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 2),
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
                      ),
                      child: heatmapUrl == null
                          ? const Center(
                              child: Text(
                                "No Map",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          : PersistentHeatmapView(
                              url: heatmapUrl!,
                              key: ValueKey(heatmapUrl),
                            ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      margin:
                          const EdgeInsets.only(top: 12, right: 12, bottom: 12),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 2),
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
                      ),
                      child: const SummaryBoard(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdown(String label, List<String> items, String? selectedValue,
      ValueChanged<String?> onChanged) {
    return Container(
      height: 45,
      decoration: BoxDecoration(
        color: Colors.yellow[700],
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedValue,
          hint: Text(label,
              style: const TextStyle(
                  color: Colors.black, fontWeight: FontWeight.w600)),
          dropdownColor: Colors.yellow[700],
          iconEnabledColor: Colors.black,
          style:
              const TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
          items: items
              .map(
                  (value) => DropdownMenuItem(value: value, child: Text(value)))
              .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  Widget _buildDatePickerButton() {
    return CalendarDropdown(
      onDateSelected: (pickedDate) {
        setState(() {
          selectedDate =
              "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
        });
      },
    );
  }

  Widget _buildAppBarButton(String label) {
    return TextButton(
      onPressed: () {},
      child: Text(
        label,
        style: const TextStyle(
            color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500),
      ),
    );
  }

  void generateHeatmap() {
    setState(() {
      heatmapUrl =
          "https://science.howstuffworks.com/environmental/earth/geophysics/map.htm"
          "?type=$selectedTrafficType"
          "&date=$selectedDate"
          "&time=$selectedTime"
          "&season=$selectedSeason";
    });

    print("Generate clicked with selections:");
    print("Traffic Type: $selectedTrafficType");
    print("Date: $selectedDate");
    print("Time: $selectedTime");
    print("Season: $selectedSeason");
  }
}
