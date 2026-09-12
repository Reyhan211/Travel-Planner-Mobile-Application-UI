import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/bottom_nav_bar.dart';
import '../data/trip_data.dart';

/// Halaman: My Trips ("My personal trips").
///
/// StatefulWidget karena sekarang menyimpan daftar trip yang sudah dibuat
/// user lewat tombol "Create". Selama daftarnya kosong, tampilkan kartu
/// ajakan (empty state). Begitu ada 1 trip, kartu itu diganti daftar trip.
class MyTripsScreen extends StatefulWidget {
  const MyTripsScreen({super.key});

  @override
  State<MyTripsScreen> createState() => _MyTripsScreenState();
}

class _MyTripsScreenState extends State<MyTripsScreen> {
  final List<Trip> _trips = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              const Text(
                'My personal\ntrips',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  height: 1.2,
                ),
              ),
              Expanded(
                child: _trips.isEmpty ? _buildEmptyState() : _buildTripList(),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 2),
    );
  }

  // ======================================================
  // KARTU AJAKAN (sebelum ada trip dibuat) — layout aslinya dipertahankan
  // ======================================================
  Widget _buildEmptyState() {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Make a personal plans\nto see the world.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Plan your next adventure, explore new places, '
              'and create memories along the way.',
              textAlign: TextAlign.center,
              style: TextStyle(color: AppColors.textSecondary, fontSize: 12),
            ),
            const SizedBox(height: 20),
            CustomButton(
              label: 'Create',
              onPressed: _openCreateTripSheet,
            ),
          ],
        ),
      ),
    );
  }

  // ======================================================
  // DAFTAR TRIP (setelah minimal 1 trip dibuat)
  // ======================================================
  Widget _buildTripList() {
    return ListView(
      children: [
        const SizedBox(height: 8),
        ..._trips.map(_buildTripCard),
        const SizedBox(height: 8),
        CustomButton(
          label: 'Buat Trip Baru',
          outlined: true,
          onPressed: _openCreateTripSheet,
        ),
      ],
    );
  }

  Widget _buildTripCard(Trip trip) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: const BoxDecoration(
              color: AppColors.surfaceLight,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.flight_takeoff,
                color: AppColors.white, size: 20),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  trip.name,
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  '${trip.city}, ${trip.country}',
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 12,
                  ),
                ),
                Text(
                  formatTripDate(trip.date),
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 12,
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
  // BOTTOM SHEET "Create a trip"
  // ======================================================
  void _openCreateTripSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.background,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => _CreateTripSheet(
        onCreate: (trip) => setState(() => _trips.add(trip)),
      ),
    );
  }
}

// ==========================================================
// Isi bottom sheet form Create Trip. Dipisah biar punya State sendiri
// (buat dropdown negara/kota & tanggal yang dipilih).
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

  List<String> get _availableCities =>
      _selectedCountry == null ? [] : (countryCities[_selectedCountry!] ?? []);

  bool get _isFormValid =>
      _nameController.text.trim().isNotEmpty &&
      _selectedCountry != null &&
      _selectedCity != null &&
      _selectedDate != null;

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now,
      lastDate: DateTime(now.year + 3),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.dark(
              primary: AppColors.white,
              onPrimary: Colors.black,
              surface: AppColors.surface,
              onSurface: AppColors.textPrimary,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) setState(() => _selectedDate = picked);
  }

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
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.surfaceLight,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Create a trip',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),

              // Trip name — pakai CustomTextField yang sudah ada di project
              const Text('Trip name',
                  style: TextStyle(color: AppColors.textPrimary, fontSize: 13)),
              const SizedBox(height: 8),
              CustomTextField(
                hintText: 'Ex: Weekend in NYC',
                icon: Icons.edit_outlined,
                controller: _nameController,
              ),
              const SizedBox(height: 18),

              // Negara
              const Text('Negara',
                  style: TextStyle(color: AppColors.textPrimary, fontSize: 13)),
              const SizedBox(height: 8),
              _buildDropdown<String>(
                hint: 'Pilih negara',
                value: _selectedCountry,
                items: countryCities.keys.toList(),
                onChanged: (value) => setState(() {
                  _selectedCountry = value;
                  _selectedCity = null;
                }),
              ),
              const SizedBox(height: 18),

              // Kota
              const Text('Kota',
                  style: TextStyle(color: AppColors.textPrimary, fontSize: 13)),
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
                  style: TextStyle(color: AppColors.textPrimary, fontSize: 13)),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: _pickDate,
                child: Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.calendar_today,
                          color: AppColors.textSecondary, size: 18),
                      const SizedBox(width: 10),
                      Text(
                        _selectedDate == null
                            ? 'Pilih tanggal'
                            : formatTripDate(_selectedDate!),
                        style: TextStyle(
                          color: _selectedDate == null
                              ? AppColors.textSecondary
                              : AppColors.textPrimary,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 28),

              // Tombol Create trip — pakai CustomButton yang sudah ada.
              // Ditambah AnimatedBuilder kecil biar tombol update tiap ngetik.
              AnimatedBuilder(
                animation: _nameController,
                builder: (context, _) {
                  return Opacity(
                    opacity: _isFormValid ? 1 : 0.4,
                    child: IgnorePointer(
                      ignoring: !_isFormValid,
                      child: CustomButton(
                        label: 'Create trip',
                        onPressed: _submit,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

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
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          isExpanded: true,
          value: value,
          hint: Text(hint,
              style: const TextStyle(color: AppColors.textSecondary)),
          icon: const Icon(Icons.keyboard_arrow_down,
              color: AppColors.textSecondary),
          dropdownColor: AppColors.surface,
          style: const TextStyle(color: AppColors.textPrimary, fontSize: 14),
          onChanged: onChanged,
          items: items
              .map((item) =>
                  DropdownMenuItem<T>(value: item, child: Text('$item')))
              .toList(),
        ),
      ),
    );
  }
}
