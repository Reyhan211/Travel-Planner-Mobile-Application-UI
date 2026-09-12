/// Model sederhana untuk 1 trip yang dibuat user lewat "Create a trip".
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

/// Data negara & kota contoh untuk dropdown di form Create Trip.
/// Nanti bisa diganti data asli / API kalau sudah ada.
const Map<String, List<String>> countryCities = {
  'Indonesia': ['Jakarta', 'Bandung', 'Surabaya', 'Bali'],
  'Jepang': ['Tokyo', 'Osaka', 'Kyoto'],
  'Amerika Serikat': ['New York', 'Los Angeles', 'San Francisco'],
  'Prancis': ['Paris', 'Nice'],
  'Inggris': ['London', 'Manchester'],
};

/// Ubah DateTime jadi teks singkat "11 Sep 2026" tanpa perlu package intl.
String formatTripDate(DateTime date) {
  const months = [
    'Jan', 'Feb', 'Mar', 'Apr', 'Mei', 'Jun',
    'Jul', 'Agu', 'Sep', 'Okt', 'Nov', 'Des',
  ];
  return '${date.day} ${months[date.month - 1]} ${date.year}';
}
