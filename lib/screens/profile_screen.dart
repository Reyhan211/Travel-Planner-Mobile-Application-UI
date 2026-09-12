import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_button.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/page_transitions.dart';
import 'signin_screen.dart';

/// Halaman: Profile.
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // ============================================================
  // GANTI DATA PROFIL DI SINI SESUAI KEBUTUHANMU
  // ============================================================
  String _name = 'Muhammad Faiz';
  String _joined = 'Joined Sept 2026';
  String _description =
      'Suka jalan-jalan dan mencoba kuliner baru di setiap kota yang dikunjungi.';
  String _location = 'Surabaya, Indonesia';
  String _email = 'faiz@gmail.com';
  String _phone = '+62123456789';
  // ============================================================

  File? _profileImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? picked = await _picker.pickImage(
        source: source,
        maxWidth: 800,
        imageQuality: 85,
      );
      if (picked != null) {
        setState(() {
          _profileImage = File(picked.path);
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal mengambil foto: $e')),
        );
      }
    }
  }

  void _showImageSourceSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 12),
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.textSecondary,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 12),
              ListTile(
                leading: const Icon(Icons.photo_camera_outlined,
                    color: AppColors.white),
                title: const Text('Ambil dari Kamera',
                    style: TextStyle(color: AppColors.textPrimary)),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library_outlined,
                    color: AppColors.white),
                title: const Text('Pilih dari Galeri',
                    style: TextStyle(color: AppColors.textPrimary)),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.gallery);
                },
              ),
              if (_profileImage != null)
                ListTile(
                  leading: const Icon(Icons.delete_outline, color: Colors.red),
                  title: const Text('Hapus Foto',
                      style: TextStyle(color: Colors.red)),
                  onTap: () {
                    setState(() => _profileImage = null);
                    Navigator.pop(context);
                  },
                ),
              const SizedBox(height: 8),
            ],
          ),
        );
      },
    );
  }

  void _showEditFieldDialog({
    required String label,
    required String currentValue,
    required void Function(String) onSave,
    TextInputType keyboardType = TextInputType.text,
  }) {
    final controller = TextEditingController(text: currentValue);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.surface,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Text('Edit $label',
              style: const TextStyle(color: AppColors.textPrimary)),
          content: TextField(
            controller: controller,
            keyboardType: keyboardType,
            autofocus: true,
            style: const TextStyle(color: AppColors.textPrimary),
            decoration: InputDecoration(
              labelText: label,
              labelStyle: const TextStyle(color: AppColors.textSecondary),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: AppColors.border),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: AppColors.white),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Batal',
                  style: TextStyle(color: AppColors.textSecondary)),
            ),
            TextButton(
              onPressed: () {
                if (controller.text.trim().isNotEmpty) {
                  setState(() => onSave(controller.text.trim()));
                }
                Navigator.pop(context);
              },
              child: const Text('Simpan',
                  style: TextStyle(color: AppColors.white)),
            ),
          ],
        );
      },
    );
  }

  void _showEditProfileDialog() {
    final nameController = TextEditingController(text: _name);
    final descController = TextEditingController(text: _description);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.surface,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Text('Edit Profil',
              style: TextStyle(color: AppColors.textPrimary)),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  style: const TextStyle(color: AppColors.textPrimary),
                  decoration: InputDecoration(
                    labelText: 'Nama',
                    labelStyle: const TextStyle(color: AppColors.textSecondary),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: AppColors.border),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: AppColors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                TextField(
                  controller: descController,
                  maxLines: 3,
                  style: const TextStyle(color: AppColors.textPrimary),
                  decoration: InputDecoration(
                    labelText: 'Deskripsi',
                    labelStyle: const TextStyle(color: AppColors.textSecondary),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: AppColors.border),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: AppColors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Batal',
                  style: TextStyle(color: AppColors.textSecondary)),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _name = nameController.text.trim().isEmpty
                      ? _name
                      : nameController.text.trim();
                  _description = descController.text.trim().isEmpty
                      ? _description
                      : descController.text.trim();
                });
                Navigator.pop(context);
              },
              child: const Text('Simpan',
                  style: TextStyle(color: AppColors.white)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Text('Profile', style: TextStyle(color: AppColors.white)),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          children: [
            const SizedBox(height: 12),
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 34,
                    backgroundColor: AppColors.surface,
                    backgroundImage: _profileImage != null
                        ? FileImage(_profileImage!) as ImageProvider
                        : const AssetImage('assets/images/default_avatar.png'),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: _showImageSourceSheet,
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          shape: BoxShape.circle,
                          border:
                              Border.all(color: AppColors.background, width: 2),
                        ),
                        child: const Icon(Icons.camera_alt,
                            color: AppColors.background, size: 14),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(_name,
                    style: const TextStyle(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.bold,
                        fontSize: 17)),
                const SizedBox(width: 6),
                GestureDetector(
                  onTap: _showEditProfileDialog,
                  child: const Icon(Icons.edit,
                      size: 16, color: AppColors.textSecondary),
                ),
              ],
            ),
            Text(_joined,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: AppColors.textSecondary, fontSize: 12)),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Description',
                      style: TextStyle(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w600,
                          fontSize: 13)),
                  const SizedBox(height: 6),
                  Text(
                    _description,
                    style: const TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 12,
                        height: 1.5),
                  ),
                  const SizedBox(height: 12),
                  _ProfileInfoRow(
                    icon: Icons.location_on_outlined,
                    text: _location,
                    onEdit: () => _showEditFieldDialog(
                      label: 'Lokasi',
                      currentValue: _location,
                      onSave: (value) => _location = value,
                    ),
                  ),
                  const SizedBox(height: 8),
                  _ProfileInfoRow(
                    icon: Icons.email_outlined,
                    text: _email,
                    onEdit: () => _showEditFieldDialog(
                      label: 'Email',
                      currentValue: _email,
                      keyboardType: TextInputType.emailAddress,
                      onSave: (value) => _email = value,
                    ),
                  ),
                  const SizedBox(height: 8),
                  _ProfileInfoRow(
                    icon: Icons.phone_outlined,
                    text: _phone,
                    onEdit: () => _showEditFieldDialog(
                      label: 'Nomor HP',
                      currentValue: _phone,
                      keyboardType: TextInputType.phone,
                      onSave: (value) => _phone = value,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text('General',
                style: TextStyle(color: AppColors.textSecondary, fontSize: 12)),
            _ProfileMenuTile(label: 'Settings', onTap: () {}),
            _ProfileMenuTile(label: 'Change Password', onTap: () {}),
            const SizedBox(height: 16),
            const Text('Support',
                style: TextStyle(color: AppColors.textSecondary, fontSize: 12)),
            _ProfileMenuTile(label: 'Need Help?', onTap: () {}),
            _ProfileMenuTile(label: 'Privacy Policy', onTap: () {}),
            const SizedBox(height: 24),
            CustomButton(
              label: 'Log out',
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                  fadeTransition(const SignInScreen()),
                  (route) => false,
                );
              },
            ),
            const SizedBox(height: 90),
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 4),
    );
  }
}

class _ProfileInfoRow extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback? onEdit;
  const _ProfileInfoRow({required this.icon, required this.text, this.onEdit});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 16, color: AppColors.textSecondary),
        const SizedBox(width: 8),
        Expanded(
          child: Text(text,
              style:
                  const TextStyle(color: AppColors.textPrimary, fontSize: 12)),
        ),
        if (onEdit != null)
          GestureDetector(
            onTap: onEdit,
            child: const Icon(Icons.edit,
                size: 14, color: AppColors.textSecondary),
          ),
      ],
    );
  }
}

class _ProfileMenuTile extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  const _ProfileMenuTile({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(label,
          style: const TextStyle(color: AppColors.textPrimary, fontSize: 14)),
      trailing: const Icon(Icons.chevron_right, color: AppColors.textSecondary),
      onTap: onTap,
    );
  }
}
