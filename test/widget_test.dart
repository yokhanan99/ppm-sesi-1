import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:first_flutter_app/main.dart';

void main() {
  testWidgets('increment, decrement, reset, dan validasi nilai minimum',
      (tester) async {
    await tester.pumpWidget(const MyApp());

    // Awal: 0 (genap).
    expect(find.text('0'), findsOneWidget);
    expect(find.text('Status: Angka Genap'), findsOneWidget);

    // Tambah -> 1 (ganjil).
    await tester.tap(find.text('Tambah (+)'));
    await tester.pump();
    expect(find.text('1'), findsOneWidget);
    expect(find.text('Status: Angka Ganjil'), findsOneWidget);

    // Kurang -> 0.
    await tester.tap(find.text('Kurang (-)'));
    await tester.pump();
    expect(find.text('0'), findsOneWidget);

    // Kurang saat 0 -> SnackBar muncul, nilai tetap 0.
    await tester.tap(find.text('Kurang (-)'));
    await tester.pump();
    expect(find.text('Nilai counter tidak boleh kurang dari 0!'),
        findsOneWidget);
    expect(find.text('0'), findsOneWidget);

    // Tambah dua kali lalu reset -> 0.
    await tester.tap(find.text('Tambah (+)'));
    await tester.tap(find.text('Tambah (+)'));
    await tester.pump();
    expect(find.text('2'), findsOneWidget);
    await tester.tap(find.text('Reset (0)'));
    await tester.pump();
    expect(find.text('0'), findsOneWidget);
  });
}
