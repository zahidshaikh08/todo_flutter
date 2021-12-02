import 'dart:async';
import 'dart:math';
import 'dart:typed_data';

import 'package:intl/intl.dart';

extension IntExtension on int {
  String timestampToString(String? formatted) {
    var format = DateFormat(formatted ?? 'MM-dd-yy HH:mm:ss');
    var date = DateTime.fromMillisecondsSinceEpoch(this);
    return format.format(date);
  }

  double toDouble() => double.parse(toString());
}

extension DoubletExtension on double {
  int toInt() {
    return int.parse(toString());
  }
}

extension ObjectExtention on Object? {
  int toInt() => int.parse(toString());

  double toDouble() => double.parse(toString());

  bool get isNotNull => this != null;

  bool get isNull => this == null;
}

extension DynamicExt on dynamic {
  bool get isSuccess => this != null && this.status == true;

  bool get isFailed => this != null && this.status == false;
}

extension RandomOfDigits on Random {
  int nextIntOfDigits(int digitCount) {
    assert(1 <= digitCount && digitCount <= 9);
    int min = digitCount == 1 ? 0 : pow(10, digitCount - 1).toInt();
    int max = pow(10, digitCount).toInt();
    return (min + nextInt(max - min)).toInt();
  }
}

extension MapExtention<V> on Map {
  V addIt(String key, dynamic value) => update(key, (dynamic k) => value, ifAbsent: () => value);

  Object? valueFor({required String keyPath}) {
    final keysSplit = keyPath.split('.');
    final thisKey = keysSplit.removeAt(0);
    final thisValue = this[thisKey];
    if (keysSplit.isEmpty) {
      return thisValue;
    } else if (thisValue is Map) {
      return thisValue.valueFor(keyPath: keysSplit.join('.'));
    }
  }
}

extension BooleanExt on bool? {
  bool get isNullOrFalse => this == null || this == false;
}

extension TakeFor<T> on Stream<T> {
  // Stream<DateTime> source() => Stream.periodic(
  //       const Duration(milliseconds: 500),
  //       (_) => DateTime.now(),
  //     );
  //
  // void testIt() async {
  //   await for (final dateTime in source().takeFor(
  //     const Duration(seconds: 4),
  //   )) {
  //     print('date time is $dateTime');
  //   }
  // }

  Stream<T> takeFor(Duration duration) {
    final upTo = DateTime.now().add(duration);
    return takeWhile((_) {
      final now = DateTime.now();
      return now.isBefore(upTo) | now.isAtSameMomentAs(upTo);
    });
  }
}

extension Duplicates<T> on List<T> {
  void addAllByAvoidingDuplicates(Iterable<T> values) => replaceRange(0, length, {
        ...([...this] + [...values])
      });

  int get numberOfDuplicates => length - {...this}.length;

  bool get containsDuplicates => numberOfDuplicates > 0;

  List<T> get uniques => [
        ...{...this}
      ];

  List<T> get clone => [...this];

  void removeDuplicates() => replaceRange(0, length, uniques);

  List<T> get duplicates => [
        for (var i = 0; i < length; i++) [...this].skip(i + 1).contains(this[i]) ? this[i] : null
      ].whereType<T>().toList();

  int get size => length;

  Uint8List toByteArray() => Uint8List.fromList(toList() as List<int>);

  List<T> toUnmodifiable() => List.unmodifiable(this);
}

extension BigIntExt on BigInt {
  num toEthereum() => (toDouble()) / 1000000000000000000;
}

extension ListOfInt on List<int> {
  Uint8List toByteArray() => Uint8List.fromList(this);
}

extension StringExtension on String {
  String sCap() {
    if (!isEmptyORNull) {
      return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
    } else {
      return this;
    }
  }

  String wordCap() {
    return isEmptyORNull
        ? ""
        : toLowerCase().split(' ').map((word) {
            final String leftText = (word.length > 1) ? word.substring(1, word.length) : '';
            return word[0].toUpperCase() + leftText;
          }).join(' ');
  }

  String commaCap() {
    return toLowerCase().split(',').map((word) {
      final String leftText = (word.length > 1) ? word.substring(1, word.length) : '';
      return word[0].toUpperCase() + leftText;
    }).join(', ');
  }

  String justifyContent() {
    String newQuery = "";
    final kList = split(" ");
    for (var element in kList) {
      if (element.removeSpaces().isNotEmpty) {
        newQuery += " $element";
      }
    }
    if (newQuery.isEmpty) {
      newQuery = this;
    }
    return newQuery.trim();
  }

  String removeSpaces() => replaceAll(RegExp(r"\s+\b|\b\s"), "");

  String addQMark() => this + "?";

  String removeQMark() => replaceAll("?", "");

  bool get isEmptyORNull => isEmpty || removeSpaces().isEmpty;

  int toInt() => int.tryParse(this) ?? 0;

  double toDouble() => double.tryParse(this) ?? 0.0;

  Uri toUri() => Uri.parse(this);

  Uint8List toIntArray() => Uint8List.fromList(codeUnits);

  String? toMap() {
    var re = RegExp(r'(?<={)(.*)(?=})');
    var match = re.firstMatch(this);
    return match?.group(0);
  }
}
