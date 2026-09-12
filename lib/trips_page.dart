import 'package:flutter/material.dart';

// Warna-warna yang dipakai di halaman ini
const Color kCardBackground = Color(0xFF1C1C1C);
const Color kFieldBackgroundTrips = Color(0xFF262626);
const Color kSubtitleColorTrips = Color(0xFF9C9C9C);

// ======================================================
// Data negara & kota contoh. Nanti bisa diganti API/data asli.
// ======================================================
const Map<String, List<String>> kCountryCities = {
  'Indonesia': ['Jakarta', 'Bandung', 'Surabaya', 'Bali'],
  'Jepang': ['Tokyo', 'Osaka', 'Kyoto'],
  'Amerika Serikat': ['New York', 'Los Angeles', 'San Francisco'],
  'Prancis': ['Paris', 'Nice'],
  'Inggris': ['London', 'Manchester'],
};

/// Model sederhana untuk 1 trip yang sudah dibuat
class Trip {
  final String name;
  final String country;
  final String city;
  final DateTime date;

  const Trip({
    required this.name,
    required this.country,
    required this.city,
    required this.date,
  });
}

/// Ubah DateTime jadi teks "11 Sep 2026" tanpa perlu package tambahan
String formatTripDate(DateTime date) {
  const months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'Mei',
    'Jun',
    'Jul',
    'Agu',
    'Sep',
    'Okt',
    'Nov',
    'Des',
  ];
  return '${date.day} ${months[date.month - 1]} ${date.year}';
}

/// Halaman "My personal trips"
class TripsPage extends StatefulWidget {
  const TripsPage({super.key});

  @override
  State<TripsPage> createState() => _TripsPageState();
}

class _TripsPageState extends State<TripsPage> {
  // Semua trip yang sudah dibuat. Kosong = tampilkan kartu ajakan buat trip.
  final List<Trip> _trips = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),

              // Tombol back
              IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                padding: EdgeInsets.zero,
                alignment: Alignment.centerLeft,
              ),
              const SizedBox(height: 12),

              // Judul halaman
              const Text(
                'My personal\ntrips',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 32),

              // Kalau belum ada trip -> tampilkan kartu ajakan.
              // Kalau sudah ada -> tampilkan daftar trip + tombol tambah.
              Expanded(
                child: _trips.isEmpty ? _buildEmptyState() : _buildTripList(),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNav(context),
    );
  }

  // ======================================================
  // KARTU KOSONG (sebelum ada trip dibuat)
  // ======================================================
  Widget _buildEmptyState() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      decoration: BoxDecoration(
        color: kCardBackground,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Make a personal plans\nto see the world.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              height: 1.3,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Plan your next adventure, explore new\nplaces, and create memories along the way.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: kSubtitleColorTrips,
              fontSize: 13,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 28),
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              onPressed: _openCreateTripSheet,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(26),
                ),
              ),
              child: const Text(
                'Create',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ======================================================
  // DAFTAR TRIP (setelah minimal 1 trip dibuat)
  // ======================================================
  Widget _buildTripList() {
    return ListView(
      children: [
        ..._trips.map(_buildTripCard),
        const SizedBox(height: 12),
        // Tombol buat nambah trip baru lagi
        SizedBox(
          width: double.infinity,
          height: 52,
          child: OutlinedButton.icon(
            onPressed: _openCreateTripSheet,
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white,
              side: const BorderSide(color: kFieldBackgroundTrips),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(26),
              ),
            ),
            icon: const Icon(Icons.add, size: 20),
            label: const Text(
              'Buat Trip Baru',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ],
    );
  }

  // Kartu untuk 1 trip yang sudah dibuat
  Widget _buildTripCard(Trip trip) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: kCardBackground,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: const BoxDecoration(
              color: kFieldBackgroundTrips,
              shape: BoxShape.circle,
            ),
            child:
                const Icon(Icons.flight_takeoff, color: Colors.white, size: 22),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  trip.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${trip.city}, ${trip.country}',
                  style: const TextStyle(
                    color: kSubtitleColorTrips,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  formatTripDate(trip.date),
                  style: const TextStyle(
                    color: kSubtitleColorTrips,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ======================================================
  // BOTTOM SHEET "Create a trip" (nama, negara, kota, tanggal)
  // ======================================================
  void _openCreateTripSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF141414),
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => _CreateTripSheet(
        onCreate: (trip) {
          setState(() => _trips.add(trip));
        },
      ),
    );
  }

  // ======================================================
  // BOTTOM NAVIGATION (sama seperti di Home)
  // ======================================================
  Widget _buildBottomNav(BuildContext context) {
    final items = [
      (Icons.explore_outlined, 'Explore'),
      (Icons.location_on_outlined, 'Nearby'),
      (Icons.favorite, 'My Trips'), // aktif -> pakai versi filled
      (Icons.calculate_outlined, 'Calculator'),
      (Icons.person_outline, 'Profile'),
    ];
    const int activeIndex = 2;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: const BoxDecoration(
        color: Color(0xFF0E0E0E),
        border: Border(top: BorderSide(color: kCardBackground, width: 1)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(items.length, (index) {
          final bool isSelected = index == activeIndex;
          final (icon, label) = items[index];
          return GestureDetector(
            onTap: () {
              if (index == 0) {
                Navigator.of(context).pop();
              }
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  icon,
                  color: isSelected ? Colors.white : kSubtitleColorTrips,
                  size: 22,
                ),
                const SizedBox(height: 4),
                Text(
                  label,
                  style: TextStyle(
                    color: isSelected ? Colors.white : kSubtitleColorTrips,
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}

// ==========================================================
// WIDGET TERPISAH: isi bottom sheet form "Create a trip"
// Dipisah supaya punya State sendiri (buat dropdown & date picker)
// ==========================================================
class _CreateTripSheet extends StatefulWidget {
  final void Function(Trip trip) onCreate;

  const _CreateTripSheet({required this.onCreate});

  @override
  State<_CreateTripSheet> createState() => _CreateTripSheetState();
}

class _CreateTripSheetState extends State<_CreateTripSheet> {
  final _nameController = TextEditingController();

  String? _selectedCountry;
  String? _selectedCity;
  DateTime? _selectedDate;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  // Ambil daftar kota sesuai negara yang dipilih
  List<String> get _availableCities {
    if (_selectedCountry == null) return [];
    return kCountryCities[_selectedCountry!] ?? [];
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now,
      lastDate: DateTime(now.year + 3),
      builder: (context, child) {
        // Biar date picker-nya ikut tema gelap
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Colors.white,
              onPrimary: Colors.black,
              surface: Color(0xFF1C1C1C),
              onSurface: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() => _selectedDate = picked);
    }
  }

  bool get _isFormValid =>
      _nameController.text.trim().isNotEmpty &&
      _selectedCountry != null &&
      _selectedCity != null &&
      _selectedDate != null;

  void _submit() {
    if (!_isFormValid) return;
    widget.onCreate(
      Trip(
        name: _nameController.text.trim(),
        country: _selectedCountry!,
        city: _selectedCity!,
        date: _selectedDate!,
      ),
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    // Biar form gak ketutup keyboard
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Padding(
      padding: EdgeInsets.only(bottom: bottomInset),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Garis kecil di atas sheet (handle)
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: kFieldBackgroundTrips,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              const Text(
                'Create a trip',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),

              // Trip name
              const Text('Trip name',
                  style: TextStyle(color: Colors.white, fontSize: 13)),
              const SizedBox(height: 8),
              TextField(
                controller: _nameController,
                onChanged: (_) => setState(() {}),
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Ex: Weekend in NYC',
                  hintStyle: const TextStyle(color: kSubtitleColorTrips),
                  filled: true,
                  fillColor: kFieldBackgroundTrips,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                ),
              ),
              const SizedBox(height: 18),

              // Negara
              const Text('Negara',
                  style: TextStyle(color: Colors.white, fontSize: 13)),
              const SizedBox(height: 8),
              _buildDropdown<String>(
                hint: 'Pilih negara',
                value: _selectedCountry,
                items: kCountryCities.keys.toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedCountry = value;
                    _selectedCity = null; // reset kota kalau negara ganti
                  });
                },
              ),
              const SizedBox(height: 18),

              // Kota
              const Text('Kota',
                  style: TextStyle(color: Colors.white, fontSize: 13)),
              const SizedBox(height: 8),
              _buildDropdown<String>(
                hint: _selectedCountry == null
                    ? 'Pilih negara dulu'
                    : 'Pilih kota',
                value: _selectedCity,
                items: _availableCities,
                onChanged: _selectedCountry == null
                    ? null
                    : (value) => setState(() => _selectedCity = value),
              ),
              const SizedBox(height: 18),

              // Tanggal
              const Text('Tanggal',
                  style: TextStyle(color: Colors.white, fontSize: 13)),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: _pickDate,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                  decoration: BoxDecoration(
                    color: kFieldBackgroundTrips,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.calendar_today,
                          color: kSubtitleColorTrips, size: 18),
                      const SizedBox(width: 10),
                      Text(
                        _selectedDate == null
                            ? 'Pilih tanggal'
                            : formatTripDate(_selectedDate!),
                        style: TextStyle(
                          color: _selectedDate == null
                              ? kSubtitleColorTrips
                              : Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 28),

              // Tombol Create trip
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: _isFormValid ? _submit : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    disabledBackgroundColor: kFieldBackgroundTrips,
                    foregroundColor: Colors.black,
                    disabledForegroundColor: kSubtitleColorTrips,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(26),
                    ),
                  ),
                  child: const Text(
                    'Create trip',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Dropdown pill generik (dipakai buat negara & kota)
  Widget _buildDropdown<T>({
    required String hint,
    required T? value,
    required List<T> items,
    required ValueChanged<T?>? onChanged,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: kFieldBackgroundTrips,
        borderRadius: BorderRadius.circular(14),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          isExpanded: true,
          value: value,
          hint: Text(hint, style: const TextStyle(color: kSubtitleColorTrips)),
          icon:
              const Icon(Icons.keyboard_arrow_down, color: kSubtitleColorTrips),
          dropdownColor: kFieldBackgroundTrips,
          style: const TextStyle(color: Colors.white, fontSize: 14),
          onChanged: onChanged,
          items: items
              .map((item) => DropdownMenuItem<T>(
                    value: item,
                    child: Text('$item'),
                  ))
              .toList(),
        ),
      ),
    );
  }
}
