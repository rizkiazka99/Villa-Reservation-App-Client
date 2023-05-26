List<DateTime> getDaysInBetween(DateTime startDate, DateTime endDate) {
  List<DateTime> days = [];

  for(var i = 0; i < endDate.difference(startDate).inDays; i++) {
    days.add(DateTime(startDate.year, startDate.month, startDate.day + i));
  }
  days.add(endDate);
  
  return days;
}