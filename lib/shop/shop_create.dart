import 'package:flutter/material.dart';
import 'dart:ui';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:gemify/shop/shop_info.dart';

class ShopCreateScreen extends StatefulWidget {
  const ShopCreateScreen({super.key});

  @override
  State<ShopCreateScreen> createState() => _ShopCreateScreenState();
}

class _ShopCreateScreenState extends State<ShopCreateScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _shopNameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _websiteController = TextEditingController();
  final TextEditingController _aboutController = TextEditingController();

  File? _bannerImage;
  final ImagePicker _picker = ImagePicker();

  @override
  void dispose() {
    _shopNameController.dispose();
    _addressController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _websiteController.dispose();
    _aboutController.dispose();
    super.dispose();
  }

  Future<void> _pickBannerImage() async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1920,
        maxHeight: 1080,
        imageQuality: 85,
      );

      if (pickedFile != null) {
        setState(() {
          _bannerImage = File(pickedFile.path);
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.error_outline, color: Colors.white),
              const SizedBox(width: 12),
              Text('Error picking image: ${e.toString()}'),
            ],
          ),
          backgroundColor: Colors.red.shade600,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          margin: const EdgeInsets.all(16),
        ),
      );
    }
  }

  void _removeBannerImage() {
    setState(() {
      _bannerImage = null;
    });
  }

  void _saveShop() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Row(
            children: [
              Icon(Icons.check_circle, color: Colors.white),
              SizedBox(width: 12),
              Text(
                'Shop created successfully!',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ],
          ),
          backgroundColor: Colors.green.shade600,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          margin: const EdgeInsets.all(16),
          duration: const Duration(seconds: 2),
        ),
      );

      // Navigate to ShopInfoScreen with the entered data
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ShopInfoScreen(
            shopName: _shopNameController.text,
            address: _addressController.text,
            phone: _phoneController.text,
            email: _emailController.text,
            website: _websiteController.text,
            about: _aboutController.text,
            bannerImage: _bannerImage,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.arrow_back_ios_new,
                  color: Color(0xFF2D3142),
                  size: 18,
                ),
              ),
            ),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Create Your Shop',
          style: TextStyle(
            color: Color(0xFF2D3142),
            fontWeight: FontWeight.w700,
            fontSize: 20,
            letterSpacing: 0.3,
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFFE8EAF6),
              const Color(0xFFF3E5F5),
              const Color(0xFFE1F5FE),
              const Color(0xFFFCE4EC),
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Banner Image Upload Section - Full Width at Top
                  _buildBannerUploadSection(),

                  // Form Content with padding
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Shop Name
                        _buildInputField(
                          controller: _shopNameController,
                          label: 'Shop Name',
                          hint: 'Enter your shop name',
                          icon: Icons.store,
                          validator: (value) =>
                              value!.isEmpty ? 'Please enter shop name' : null,
                        ),

                        const SizedBox(height: 16),

                        // Address
                        _buildInputField(
                          controller: _addressController,
                          label: 'Address',
                          hint: 'Enter shop address',
                          icon: Icons.location_on_outlined,
                          validator: (value) =>
                              value!.isEmpty ? 'Please enter address' : null,
                        ),

                        const SizedBox(height: 16),

                        // Phone
                        _buildInputField(
                          controller: _phoneController,
                          label: 'Phone Number',
                          hint: 'Enter contact number',
                          icon: Icons.phone_outlined,
                          keyboardType: TextInputType.phone,
                          validator: (value) => value!.isEmpty
                              ? 'Please enter phone number'
                              : null,
                        ),

                        const SizedBox(height: 16),

                        // Email
                        _buildInputField(
                          controller: _emailController,
                          label: 'Email',
                          hint: 'Enter email address',
                          icon: Icons.email_outlined,
                          keyboardType: TextInputType.emailAddress,
                        ),

                        const SizedBox(height: 16),

                        // Website
                        _buildInputField(
                          controller: _websiteController,
                          label: 'Website',
                          hint: 'Enter website URL (optional)',
                          icon: Icons.language,
                          keyboardType: TextInputType.url,
                        ),

                        const SizedBox(height: 16),

                        // About Store
                        _buildInputField(
                          controller: _aboutController,
                          label: 'About Store',
                          hint: 'Tell us about your shop...',
                          icon: Icons.description_outlined,
                          maxLines: 5,
                        ),

                        const SizedBox(height: 32),

                        // Submit Button
                        SizedBox(
                          width: double.infinity,
                          height: 56,
                          child: ElevatedButton(
                            onPressed: _saveShop,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF2D3142),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              elevation: 8,
                              shadowColor: Colors.black.withOpacity(0.3),
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.check_circle_outline,
                                  color: Colors.white,
                                  size: 22,
                                ),
                                SizedBox(width: 12),
                                Text(
                                  "Create Shop",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBannerUploadSection() {
    return Container(
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.7),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: _bannerImage == null
          ? InkWell(
              onTap: _pickBannerImage,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color(0xFF2D3142).withOpacity(0.2),
                    width: 2,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.purple.shade200,
                            Colors.blue.shade200,
                          ],
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.add_photo_alternate_outlined,
                        size: 40,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Add Shop Banner',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF2D3142),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Tap to upload an image',
                      style: TextStyle(
                        fontSize: 13,
                        color: const Color(0xFF2D3142).withOpacity(0.5),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            )
          : Stack(
              children: [
                // Banner Image
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: FileImage(_bannerImage!),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // Overlay with actions
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withOpacity(0.3),
                        Colors.transparent,
                        Colors.black.withOpacity(0.5),
                      ],
                    ),
                  ),
                ),
                // Action buttons
                Positioned(
                  top: 12,
                  right: 12,
                  child: Row(
                    children: [
                      // Change image button
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: IconButton(
                              icon: const Icon(
                                Icons.edit,
                                color: Colors.white,
                                size: 20,
                              ),
                              onPressed: _pickBannerImage,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      // Remove image button
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.red.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: IconButton(
                              icon: const Icon(
                                Icons.delete_outline,
                                color: Colors.white,
                                size: 20,
                              ),
                              onPressed: _removeBannerImage,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Image indicator
                Positioned(
                  bottom: 12,
                  left: 12,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.check_circle,
                              color: Colors.white,
                              size: 16,
                            ),
                            SizedBox(width: 6),
                            Text(
                              'Banner Added',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    TextInputType? keyboardType,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xFF2D3142),
              letterSpacing: 0.2,
            ),
          ),
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.7),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: TextFormField(
                controller: controller,
                keyboardType: keyboardType,
                maxLines: maxLines,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF2D3142),
                ),
                decoration: InputDecoration(
                  hintText: hint,
                  hintStyle: TextStyle(
                    color: const Color(0xFF2D3142).withOpacity(0.4),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                  prefixIcon: Container(
                    padding: const EdgeInsets.all(12),
                    child: Icon(
                      icon,
                      color: const Color(0xFF2D3142).withOpacity(0.5),
                      size: 22,
                    ),
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: maxLines > 1 ? 16 : 18,
                  ),
                  alignLabelWithHint: maxLines > 1,
                  errorStyle: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.red,
                    height: 1.2,
                  ),
                  errorMaxLines: 2,
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(
                      color: Colors.red.withOpacity(0.5),
                      width: 1.5,
                    ),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(color: Colors.red, width: 2),
                  ),
                ),
                validator: validator,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
