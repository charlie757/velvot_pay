import 'package:intl/intl.dart';

class TimeFormat{

 static String convertToReadableFormat(String isoDateString) {
    DateTime dateTime = DateTime.parse(isoDateString,).toLocal();
    final DateFormat formatter = DateFormat('hh:mma \'on\' dd MMM yyyy');
    // Format the DateTime object
    String formattedDate = formatter.format(dateTime,);

    formattedDate = formattedDate.replaceAll('AM', 'am').replaceAll('PM', 'pm');

    return formattedDate;
  }

 static String convertTransaction(String isoDateString) {
   DateTime dateTime = DateTime.parse(isoDateString,).toLocal();
   final DateFormat formatter = DateFormat('MMM dd, yyyy, hh:mma');
   // Format the DateTime object
   String formattedDate = formatter.format(dateTime,);

   formattedDate = formattedDate.replaceAll('AM', 'am').replaceAll('PM', 'pm');

   return formattedDate;
 }

  static String getCommentTime(String isoDateString) {
    DurationDifference difference = calculateDetailedDifference(isoDateString);

    List<String> parts = [];
    if (difference.years > 0) {
      parts.add("${difference.years} year${difference.years > 1 ? 's' : ''}");
    }
    if (difference.years<=0&&difference.months > 0) {
      parts.add("${difference.months} month${difference.months > 1 ? 's' : ''}");
    }
    if (difference.years<=0&&difference.months<=0&& difference.days > 0) {
      parts.add("${difference.days} day${difference.days > 1 ? 's' : ''}");
    }
    if (difference.years<=0&&difference.months<=0&&difference.days<=0&&difference.hours > 0) {
      parts.add("${difference.hours} hour${difference.hours > 1 ? 's' : ''}");
    }
    if (difference.years<=0&&difference.months<=0&&difference.days<=0&&difference.hours<=0&&difference.minutes > 0) {
      parts.add("${difference.minutes} minute${difference.minutes > 1 ? 's' : ''}");
    }
    if (difference.years<=0&&difference.months<=0&&difference.days<=0&&difference.hours<=0&&difference.minutes<=0&&difference.seconds > 0) {
      parts.add("${difference.seconds} second${difference.seconds > 1 ? 's' : ''}");
    }

    // Join the parts into a single string, handling the case where there are no differences.
    return parts.isNotEmpty ? parts.join(', ') : "just now";
  }

}

class DurationDifference {
  final int years;
  final int months;
  final int days;
  final int hours;
  final int minutes;
  final int seconds;

  DurationDifference({
    required this.years,
    required this.months,
    required this.days,
    required this.hours,
    required this.minutes,
    required this.seconds,
  });
}

/// Function to calculate the detailed difference between a given date and the current date
DurationDifference calculateDetailedDifference(String isoDateString) {
  try {
    // Parse the ISO string to DateTime object
    DateTime givenDate = DateTime.parse(isoDateString).toLocal();

    // Get the current date
    DateTime now = DateTime.now();

    // Calculate initial differences
    int yearDiff = now.year - givenDate.year;
    int monthDiff = now.month - givenDate.month;
    int dayDiff = now.day - givenDate.day;
    int hourDiff = now.hour - givenDate.hour;
    int minuteDiff = now.minute - givenDate.minute;
    int secondDiff = now.second - givenDate.second;

    // Adjust for negative differences in months
    if (monthDiff < 0) {
      yearDiff -= 1;
      monthDiff += 12;
    }

    // Adjust for negative differences in days
    if (dayDiff < 0) {
      monthDiff -= 1;
      // Get the previous month's last date to calculate days
      DateTime lastMonthDate = DateTime(now.year, now.month - 1);
      dayDiff += daysInMonth(lastMonthDate.year, lastMonthDate.month);
    }

    // Adjust for negative differences in hours
    if (hourDiff < 0) {
      dayDiff -= 1;
      hourDiff += 24;
    }

    // Adjust for negative differences in minutes
    if (minuteDiff < 0) {
      hourDiff -= 1;
      minuteDiff += 60;
    }

    // Adjust for negative differences in seconds
    if (secondDiff < 0) {
      minuteDiff -= 1;
      secondDiff += 60;
    }

    // Return the detailed difference
    return DurationDifference(
      years: yearDiff,
      months: monthDiff,
      days: dayDiff,
      hours: hourDiff,
      minutes: minuteDiff,
      seconds: secondDiff,
    );
  } catch (e) {
    print("Error parsing date: $e");
    return DurationDifference(
      years: 0,
      months: 0,
      days: 0,
      hours: 0,
      minutes: 0,
      seconds: 0,
    );
  }
}

/// Function to calculate the number of days in a given month and year
int daysInMonth(int year, int month) {
  List<int> daysInMonths = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];

  // Adjust for leap years
  if (month == 2 && isLeapYear(year)) {
    return 29;
  }
  return daysInMonths[month - 1];
}

/// Function to check if a given year is a leap year
bool isLeapYear(int year) {
  if (year % 4 == 0) {
    if (year % 100 == 0) {
      if (year % 400 == 0) {
        return true;
      }
      return false;
    }
    return true;
  }
  return false;
}
