/// Maps season name to matching months
List<int> getMonthsForSeason(String season) {
  switch (season) {
    case "Summer":
      return [12, 1, 2];
    case "Autumn":
      return [3, 4, 5];
    case "Winter":
      return [6, 7, 8];
    case "Spring":
      return [9, 10, 11];
    default:
      return [];
  }
}

/// Given a full date range and selected season/year, return a trimmed seasonal range
Map<String, DateTime> getDateRangeForSeason(DateTime fullStart,
    DateTime fullEnd, String? season, String? selectedYear) {
  final validMonths = season != null ? getMonthsForSeason(season) : [];

  // Optional year handling
  if (selectedYear != null) {
    final year = int.tryParse(selectedYear);
    if (year != null) {
      final yearStart = DateTime(year, 1, 1);
      final yearEnd = DateTime(year, 12, 31);
      fullStart = yearStart.isAfter(fullStart) ? yearStart : fullStart;
      fullEnd = yearEnd.isBefore(fullEnd) ? yearEnd : fullEnd;
    }
  }

  // No season selected? Return full (or year-limited) range
  if (validMonths.isEmpty) {
    return {"start": fullStart, "end": fullEnd};
  }

  // Trim start to the first valid month
  DateTime start = fullStart;
  while (!validMonths.contains(start.month)) {
    start = start.add(const Duration(days: 1));
    if (start.isAfter(fullEnd)) break;
  }

  // Trim end to the last valid month
  DateTime end = fullEnd;
  while (!validMonths.contains(end.month)) {
    end = end.subtract(const Duration(days: 1));
    if (end.isBefore(start)) break;
  }

  return {"start": start, "end": end};
}
