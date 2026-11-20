import 'package:flutter/material.dart';

// ============================================================================
// DATA MAHASISWA  -->  GANTI DENGAN DATA KAMU SENDIRI
// ============================================================================
const String namaMahasiswa = 'Yokhanan Haposan Siregar';
const String nim = '20240040211';
const String programStudi = 'Teknik Informatika';
const String kelas = 'TI24D';
// ============================================================================

void main() {
  runApp(const MyApp());
}

/// Widget root aplikasi (stateless): mengatur tema dan halaman utama.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PPM Sesi 1',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        // Warna tema kustom (teal), bukan biru/ungu bawaan Flutter.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
      ),
      home: const MyHomePage(),
    );
  }
}

/// Halaman utama (stateful) karena nilai counter dapat berubah.
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // State: nilai counter saat ini.
  int _counter = 0;

  bool get _isEven => _counter % 2 == 0;

  /// Menambah counter sebesar 1.
  void _increment() {
    setState(() {
      _counter++;
    });
  }

  /// Mengurangi counter sebesar 1.
  /// Validasi: counter tidak boleh negatif -> tampilkan SnackBar peringatan.
  void _decrement() {
    if (_counter <= 0) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(
            content: Text('Nilai counter tidak boleh kurang dari 0!'),
            backgroundColor: Colors.redAccent,
            duration: Duration(seconds: 2),
          ),
        );
      return;
    }
    setState(() {
      _counter--;
    });
  }

  /// Mengembalikan counter ke 0.
  void _reset() {
    setState(() {
      _counter = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Indikator visual: genap = hijau, ganjil = oranye.
    final Color counterColor =
        _isEven ? Colors.green.shade700 : Colors.deepOrange;
    final String statusText =
        _isEven ? 'Status: Angka Genap' : 'Status: Angka Ganjil';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.colorScheme.inversePrimary,
        title: const Text(
          'PPM Sesi 1 - $namaMahasiswa ($nim)',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const _ProfileCard(),
            const SizedBox(height: 32),
            Text('Nilai Counter', style: theme.textTheme.titleMedium),
            const SizedBox(height: 8),
            // Angka counter berubah warna sesuai genap/ganjil.
            Text(
              '$_counter',
              style: theme.textTheme.displayLarge?.copyWith(
                color: counterColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              statusText,
              style: theme.textTheme.titleMedium?.copyWith(
                color: counterColor,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 32),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 12,
              runSpacing: 12,
              children: [
                FilledButton.icon(
                  onPressed: _decrement,
                  icon: const Icon(Icons.remove),
                  label: const Text('Kurang (-)'),
                ),
                OutlinedButton.icon(
                  onPressed: _reset,
                  icon: const Icon(Icons.restart_alt),
                  label: const Text('Reset (0)'),
                ),
                FilledButton.icon(
                  onPressed: _increment,
                  icon: const Icon(Icons.add),
                  label: const Text('Tambah (+)'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// Kartu identitas mahasiswa.
class _ProfileCard extends StatelessWidget {
  const _ProfileCard();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            CircleAvatar(
              radius: 32,
              backgroundColor: theme.colorScheme.primaryContainer,
              child: Icon(
                Icons.person,
                size: 36,
                color: theme.colorScheme.onPrimaryContainer,
              ),
            ),
            const SizedBox(width: 16),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _InfoRow(icon: Icons.badge, text: namaMahasiswa, bold: true),
                  SizedBox(height: 6),
                  _InfoRow(icon: Icons.numbers, text: 'NIM: $nim'),
                  SizedBox(height: 6),
                  _InfoRow(icon: Icons.school, text: programStudi),
                  SizedBox(height: 6),
                  _InfoRow(icon: Icons.groups, text: kelas),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.icon, required this.text, this.bold = false});

  final IconData icon;
  final String text;
  final bool bold;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 18, color: Theme.of(context).colorScheme.primary),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 15,
              fontWeight: bold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ],
    );
  }
}
