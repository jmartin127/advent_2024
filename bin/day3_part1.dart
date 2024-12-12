import 'dart:io';

void main(List<String> arguments) {
  final file = File('bin/inputs/day3.input.txt');
  final lines = file.readAsLinesSync();

  int result = 0;
  for (String line in lines) {
    result += resultForLine(line);
  }

  print(result);
}

int resultForLine(String line) {
  // regex: to use (exactly): mul\(([0-9]+),([0-9]+)\)
  final regex = RegExp(r'mul\(([0-9]+),([0-9]+)\)');
  final matches = regex.allMatches(line);

  int result = 0;
  for (Match match in matches) {
    final a = int.parse(match.group(1)!);
    final b = int.parse(match.group(2)!);
    result += a * b;
  }

  return result;
}
