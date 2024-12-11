import 'dart:io';

void main(List<String> arguments) {
  final file = File('bin/day2.input.txt');
  final lines = file.readAsLinesSync();

  int numSafe = 0;
  for (String line in lines) {
    final report = _readLineOfInts(line.split(' '));
    if (_isSafeAfterRemovingOneElement(report)) {
      numSafe++;
    }
  }

  print('Number of safe reports: $numSafe');
}

bool _isSafeAfterRemovingOneElement(List<int> report) {
  // first check the report as is
  if (_isSafe(report)) {
    return true;
  }

  // then check the report after removing each element
  for (int i = 0; i < report.length; i++) {
    final newReport = List<int>.from(report);
    newReport.removeAt(i);
    if (_isSafe(newReport)) {
      return true;
    }
  }

  return false;
}

bool _isSafe(List<int> report) {
  // iterate over each pair, starting with the first pair of ints
  bool? isNegative;
  for (int i = 0; i < report.length - 1; i += 1) {
    final a = report[i];
    final b = report[i + 1];
    final diff = _difference(a, b);
    // Any two adjacent levels differ by at least one and at most three.
    if (diff < 1 || diff > 3) {
      return false;
    }
    // The levels are either all increasing or all decreasing.
    if (isNegative == null) {
      isNegative = a > b;
    } else if (isNegative && a < b) {
      return false;
    } else if (!isNegative && a > b) {
      return false;
    }
  }

  return true;
}

int _difference(int num1, int num2) {
  if (num1 > num2) {
    return num1 - num2;
  }

  return num2 - num1;
}

List<int> _readLineOfInts(List<String> line) {
  return line.map((e) => int.parse(e)).toList();
}