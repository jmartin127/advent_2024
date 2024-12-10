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

  // iterate over list 1
  int similarityScore = 0;
  for (int val in list1) {
    // find how many times val occurs in list 2
    final count = list2.where((element) => element == val).length;
    similarityScore += (val * count);
  }

  print('Similarity score: $similarityScore');
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
