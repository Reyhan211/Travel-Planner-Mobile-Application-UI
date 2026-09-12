/// Model sederhana untuk satu tempat/destinasi.
/// Semua data di file ini statis (dummy), karena fokus tugas adalah UI,
/// bukan koneksi ke backend/API.
class Destination {
  final String name;
  final String location;
  final String imageUrl;
  final String description;

  const Destination({
    required this.name,
    required this.location,
    required this.imageUrl,
    required this.description,
  });
}

class Hotel {
  final String name;
  final String location;
  final String price;
  final String imageUrl;

  const Hotel({
    required this.name,
    required this.location,
    required this.price,
    required this.imageUrl,
  });
}

class Restaurant {
  final String name;
  final String location;
  final String description;
  final String imageUrl;

  const Restaurant({
    required this.name,
    required this.location,
    required this.description,
    required this.imageUrl,
  });
}

// Data dummy dipakai ulang di beberapa screen (Explore, Detail, dst).
const List<Destination> destinations = [
  Destination(
    name: 'Santorini, Greece',
    location: 'Greece',
    imageUrl:
        'https://i.pinimg.com/736x/1b/65/c4/1b65c4da9067baccd3d96fd7c7f514fa.jpg',
    description:
        'Pulau vulkanik dengan rumah putih khas dan pemandangan matahari terbenam '
        'paling terkenal di Laut Aegea. Cocok buat kamu yang suka suasana tenang '
        'dan pemandangan laut yang dramatis.',
  ),
  Destination(
    name: 'Kyoto, Japan',
    location: 'Japan',
    imageUrl:
        'https://i.pinimg.com/1200x/33/45/03/334503537aedff5a7528aee06b0dfda4.jpg',
    description:
        'Kota bersejarah di Jepang dengan ribuan kuil, kuil gerbang torii merah, '
        'dan suasana tradisional yang masih terjaga hingga sekarang.',
  ),
  Destination(
    name: 'Los Angeles, USA',
    location: 'California, USA',
    imageUrl:
        'https://i.pinimg.com/1200x/ee/bc/47/eebc47757a02b05e467d54e85e16815a.jpg',
    description:
        'Kota besar di California yang terkenal dengan Hollywood, pantai, dan '
        'kehidupan hiburan kelas dunia.',
  ),
  Destination(
    name: 'Hollywood, USA',
    location: 'California, USA',
    imageUrl:
        'https://i.pinimg.com/1200x/ab/00/25/ab00250c98b2c4ebe2a5120d95d6b54b.jpg',
    description:
        'Rumah bagi industri perfilman Amerika, dengan Walk of Fame dan '
        'papan tanda Hollywood yang ikonik.',
  ),
  Destination(
    name: 'Amalfi Coast, Italy',
    location: 'Italy',
    imageUrl:
        'https://i.pinimg.com/1200x/87/58/89/875889aab3ecf12e069f8f53d4c34b23.jpg',
    description:
        'Garis pantai indah di selatan Italia dengan desa-desa berwarna-warni '
        'yang menempel di tebing curam.',
  ),
  Destination(
    name: 'Maldives',
    location: 'Maldives',
    imageUrl:
        'https://i.pinimg.com/1200x/1a/80/56/1a8056e047fa67b6478016edc5a9b28f.jpg',
    description:
        'Gugusan pulau tropis dengan air laut jernih dan resort di atas air, '
        'destinasi favorit untuk bulan madu.',
  ),
];

const List<Hotel> hotels = [
  Hotel(
    name: 'Hotel Nikko Narita',
    location: 'Tokyo, Japan',
    price: '\$100/night',
    imageUrl:
        'https://i.pinimg.com/1200x/21/90/1f/21901f4274d3925fceefd373a49d79c5.jpg',
  ),
  Hotel(
    name: 'Shinjuku Grand Hotel',
    location: 'Tokyo, Japan',
    price: '\$120/night',
    imageUrl:
        'https://i.pinimg.com/1200x/a0/65/b5/a065b59538f50222d74ed2cec8d2d635.jpg',
  ),
  Hotel(
    name: 'Kyoto Garden Inn',
    location: 'Kyoto, Japan',
    price: '\$90/night',
    imageUrl:
        'https://i.pinimg.com/1200x/13/be/5c/13be5cca7eac2e85250f9cda94bb1df4.jpg',
  ),
  Hotel(
    name: 'Osaka Bay Resort',
    location: 'Osaka, Japan',
    price: '\$110/night',
    imageUrl:
        'https://i.pinimg.com/736x/1a/ff/5e/1aff5e2eba84b50f2a15b2d6a15a6c8d.jpg',
  ),
];

const List<Restaurant> restaurants = [
  Restaurant(
    name: 'Kaiten Sushi Toriton',
    location: 'Tokyo, Japan',
    description: 'Restoran sushi lokal populer dengan bahan segar setiap hari.',
    imageUrl:
        'https://i.pinimg.com/736x/d7/4f/90/d74f90436d96f94a89313be5a7849c3e.jpg',
  ),
  Restaurant(
    name: 'Ginza Kagari',
    location: 'Tokyo, Japan',
    description: 'Terkenal dengan ramen ayam creamy khas Ginza.',
    imageUrl:
        'https://i.pinimg.com/1200x/08/16/44/0816445bd07ec0b314507ded50f31c71.jpg',
  ),
  Restaurant(
    name: 'Udon Maruka',
    location: 'Tokyo, Japan',
    description: 'Udon buatan tangan dengan kuah kaldu turun-temurun.',
    imageUrl:
        'https://i.pinimg.com/736x/68/8f/64/688f64301ab2637431b546fcb152f695.jpg',
  ),
  Restaurant(
    name: 'Osaka Takoyaki House',
    location: 'Osaka, Japan',
    description: 'Takoyaki renyah di luar, lembut di dalam, khas Osaka.',
    imageUrl:
        'https://i.pinimg.com/1200x/0e/59/1c/0e591ce2975127ecd26b06e29add329c.jpg',
  ),
];

// Data mata uang untuk Currency Converter dipindah ke lib/data/currency_data.dart
