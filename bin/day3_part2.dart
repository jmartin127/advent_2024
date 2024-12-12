import 'dart:io';

void main(List<String> arguments) {
  final file = File('bin/inputs/day3.input.txt');
  final lines = file.readAsLinesSync();

  // combine all lines, by removing new lines
  final line = lines.join();
  int result = resultForLine(line);

  print(result);
}

int resultForLine(String line) {
  // find the index of each "don't()" string in the line
  final dontIndexes = _findIndexes(line, 'don\'t()');
  print('Don\'t indexes: $dontIndexes');
  final doIndexes = _findIndexes(line, 'do()');
  print('Do indexes: $doIndexes');

  // regex: to use (exactly): mul\(([0-9]+),([0-9]+)\)
  final regex = RegExp(r'mul\(([0-9]+),([0-9]+)\)');
  final matches = regex.allMatches(line);

  int result = 0;
  for (Match match in matches) {
    // check if the match is enabled
    final int indexOfMatch = match.start;
    print('Match index: $indexOfMatch');
    // find the largest index in the dont list which is still less than the match index
    final int largestDontIndex = dontIndexes.lastWhere((index) => index < indexOfMatch, orElse: () => -1);
    // find the largest index in the do list which is still less than the match index
    final int largestDoIndex = doIndexes.lastWhere((index) => index < indexOfMatch, orElse: () => -1);
    // if the don't index is greater, skip
    if (largestDontIndex > largestDoIndex) {
      print('Skipping match at index $indexOfMatch, largest don\'t index: $largestDontIndex, largest do index: $largestDoIndex');
      continue;
    }

    final a = int.parse(match.group(1)!);
    final b = int.parse(match.group(2)!);
    result += a * b;
  }

  return result;
}

List<int> _findIndexes(String line, String pattern) {
  final indexes = <int>[];
  for (int i = 0; i < line.length; i++) {
    if (line.startsWith(pattern, i)) {
      indexes.add(i);
    }
  }
  return indexes;
}
