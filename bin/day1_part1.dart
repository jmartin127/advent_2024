import 'dart:io';

void main(List<String> arguments) {
  final file = File('bin/day1.input.txt');
  final lines = file.readAsLinesSync();

  // load the 2 lists
  final list1 = <int>[];
  final list2 = <int>[];
  for (String line in lines) {
    final parts = _removeBlankSrings(line.split(' '));
    final num1 = int.parse(parts[0]);
    final num2 = int.parse(parts[1]);
    list1.add(num1);
    list2.add(num2);
  }

  // sort each list smallest to largest
  list1.sort();
  list2.sort();

  // find the distance between each element in each list
  int totalDiff = 0;
  for (int i = 0; i < list1.length; i++) {
    final diff = _difference(list1[i], list2[i]);
    totalDiff += diff;
  }
  
  print('Total difference: $totalDiff');
}

List<String> _removeBlankSrings(List<String> list) {
  return list.where((element) => element.isNotEmpty).toList();
}

int _difference(int num1, int num2) {
  if (num1 > num2) {
    return num1 - num2;
  }

  return num2 - num1;
}
