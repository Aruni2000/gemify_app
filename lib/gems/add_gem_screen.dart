import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../models/gem.dart';
import 'package:gemify/gems/gem_detail_screen.dart';

class AddGemScreen extends StatefulWidget {
  const AddGemScreen({super.key});

  @override
  State<AddGemScreen> createState() => _AddGemScreenState();
}

class _AddGemScreenState extends State<AddGemScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  // Controllers
  final _gemNameController = TextEditingController();
  final _gemCodeController = TextEditingController();
  final _gemVarietyController = TextEditingController();
  final _gemHolderController = TextEditingController();
  final _previousOwnerController = TextEditingController();
  final _roughWeightController = TextEditingController();
  final _weightAfterPerformController = TextEditingController();
  final _weightAfterCutPolishController = TextEditingController();
  final _widthController = TextEditingController();
  final _heightController = TextEditingController();
  final _purchasedPriceController = TextEditingController();
  final _performingChargesController = TextEditingController();
  final _cuttingChargesController = TextEditingController();

  DateTime? _purchasedDate;
  File? _gemImage;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _gemNameController.dispose();
    _gemCodeController.dispose();
    _gemVarietyController.dispose();
    _gemHolderController.dispose();
    _previousOwnerController.dispose();
    _roughWeightController.dispose();
    _weightAfterPerformController.dispose();
    _weightAfterCutPolishController.dispose();
    _widthController.dispose();
    _heightController.dispose();
    _purchasedPriceController.dispose();
    _performingChargesController.dispose();
    _cuttingChargesController.dispose();
    super.dispose();
  }

  Future<void> _pickPurchasedDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _purchasedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF2D3142),
              onPrimary: Colors.white,
              surface: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        _purchasedDate = picked;
      });
    }
  }

  Future<void> _captureGemImage() async {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.95),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(30),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  "Add Gem Photo",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF2D3142),
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: _buildImageSourceButton(
                        icon: Icons.camera_alt,
                        label: "Camera",
                        onTap: () async {
                          Navigator.pop(context);
                          final pickedFile = await _picker.pickImage(
                            source: ImageSource.camera,
                          );
                          if (pickedFile != null) {
                            setState(() {
                              _gemImage = File(pickedFile.path);
                            });
                          }
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildImageSourceButton(
                        icon: Icons.photo_library,
                        label: "Gallery",
                        onTap: () async {
                          Navigator.pop(context);
                          final pickedFile = await _picker.pickImage(
                            source: ImageSource.gallery,
                          );
                          if (pickedFile != null) {
                            setState(() {
                              _gemImage = File(pickedFile.path);
                            });
                          }
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImageSourceButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purple.shade100, Colors.blue.shade100],
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(icon, size: 32, color: const Color(0xFF2D3142)),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFF2D3142),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _saveGem() {
    if (_formKey.currentState!.validate()) {
      final gem = Gem(
        gemName: _gemNameController.text,
        gemCode: _gemCodeController.text,
        gemVariety: _gemVarietyController.text,
        gemHolder: _gemHolderController.text,
        previousOwner: _previousOwnerController.text,
        roughWeight: double.tryParse(_roughWeightController.text) ?? 0.0,
        weightAfterPerform:
            double.tryParse(_weightAfterPerformController.text) ?? 0.0,
        weightAfterCutAndPolish:
            double.tryParse(_weightAfterCutPolishController.text) ?? 0.0,
        widthAfterCutPolish: double.tryParse(_widthController.text) ?? 0.0,
        heightAfterCutPolish: double.tryParse(_heightController.text) ?? 0.0,
        purchasedPrice: double.tryParse(_purchasedPriceController.text) ?? 0.0,
        purchasedDate: _purchasedDate ?? DateTime.now(),
        performingCharges:
            double.tryParse(_performingChargesController.text) ?? 0.0,
        cuttingCharges: double.tryParse(_cuttingChargesController.text) ?? 0.0,
        totalCost:
            (double.tryParse(_purchasedPriceController.text) ?? 0.0) +
            (double.tryParse(_performingChargesController.text) ?? 0.0) +
            (double.tryParse(_cuttingChargesController.text) ?? 0.0),
        gemImage: _gemImage?.path,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: const [
              Icon(Icons.check_circle, color: Colors.white),
              SizedBox(width: 12),
              Text("Gem Added Successfully!"),
            ],
          ),
          backgroundColor: const Color(0xFF2D3142),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          margin: const EdgeInsets.all(16),
        ),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => GemDetailScreen(gem: gem)),
      );
    }
  }

  Widget _buildTextField(
    String label,
    TextEditingController controller, {
    TextInputType keyboardType = TextInputType.text,
    IconData? icon,
    String? placeholder,
    String? suffix,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.4),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: Colors.white.withOpacity(0.5),
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.03),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: TextFormField(
              controller: controller,
              keyboardType: keyboardType,
              validator: (value) =>
                  value == null || value.isEmpty ? "Enter $label" : null,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Color(0xFF2D3142),
              ),
              decoration: InputDecoration(
                labelText: label,
                hintText: placeholder,
                suffixText: suffix,
                suffixStyle: TextStyle(
                  color: const Color(0xFF2D3142).withOpacity(0.5),
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
                labelStyle: TextStyle(
                  color: const Color(0xFF2D3142).withOpacity(0.6),
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
                hintStyle: TextStyle(
                  color: const Color(0xFF2D3142).withOpacity(0.3),
                  fontSize: 12,
                ),
                prefixIcon: icon != null
                    ? Container(
                        margin: const EdgeInsets.all(10),
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.purple.shade100,
                              Colors.blue.shade100,
                            ],
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          icon,
                          color: const Color(0xFF2D3142),
                          size: 18,
                        ),
                      )
                    : null,
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
                // Error styling - displays below the field
                errorStyle: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color: Colors.red,
                  height: 1.2,
                ),
                errorMaxLines: 2,
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide(
                    color: Colors.red.withOpacity(0.5),
                    width: 1.5,
                  ),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: const BorderSide(color: Colors.red, width: 2),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDatePickerField() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: GestureDetector(
        onTap: _pickPurchasedDate,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(14),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.4),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: Colors.white.withOpacity(0.5),
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.03),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: AbsorbPointer(
                child: TextFormField(
                  controller: TextEditingController(
                    text: _purchasedDate == null
                        ? ""
                        : "${_purchasedDate!.toLocal()}".split(" ")[0],
                  ),
                  validator: (value) => value == null || value.isEmpty
                      ? "Select purchased date"
                      : null,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF2D3142),
                  ),
                  decoration: InputDecoration(
                    labelText: "Purchased Date",
                    hintText: "Select the purchase date",
                    labelStyle: TextStyle(
                      color: const Color(0xFF2D3142).withOpacity(0.6),
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                    hintStyle: TextStyle(
                      color: const Color(0xFF2D3142).withOpacity(0.3),
                      fontSize: 12,
                    ),
                    prefixIcon: Container(
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.purple.shade100,
                            Colors.blue.shade100,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.calendar_today,
                        color: Color(0xFF2D3142),
                        size: 18,
                      ),
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                    // Error styling - displays below the field
                    errorStyle: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: Colors.red,
                      height: 1.2,
                    ),
                    errorMaxLines: 2,
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide(
                        color: Colors.red.withOpacity(0.5),
                        width: 1.5,
                      ),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: const BorderSide(color: Colors.red, width: 2),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImageCard() {
    return GestureDetector(
      onTap: _captureGemImage,
      child: Container(
        height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 15,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            children: [
              // Background
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: _gemImage == null
                        ? [Colors.purple.shade50, Colors.blue.shade50]
                        : [Colors.black26, Colors.black12],
                  ),
                ),
                child: _gemImage == null
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.7),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.add_photo_alternate,
                                size: 40,
                                color: Color(0xFF2D3142),
                              ),
                            ),
                            const SizedBox(height: 12),
                            const Text(
                              "Add Gem Photo",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF2D3142),
                              ),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              "Tap to capture or select",
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xFF2D3142).withOpacity(0.5),
                              ),
                            ),
                          ],
                        ),
                      )
                    : Image.file(
                        _gemImage!,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      ),
              ),

              // Gradient overlay when image exists
              if (_gemImage != null)
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.3),
                        ],
                      ),
                    ),
                  ),
                ),

              // Edit button when image exists
              if (_gemImage != null)
                Positioned(
                  bottom: 10,
                  right: 10,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Icon(
                              Icons.edit,
                              size: 14,
                              color: Color(0xFF2D3142),
                            ),
                            SizedBox(width: 5),
                            Text(
                              "Change",
                              style: TextStyle(
                                color: Color(0xFF2D3142),
                                fontSize: 11,
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
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, {IconData? icon}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12, top: 6),
      child: Row(
        children: [
          if (icon != null) ...[
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.purple.shade100, Colors.blue.shade100],
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, size: 16, color: const Color(0xFF2D3142)),
            ),
            const SizedBox(width: 10),
          ],
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Color(0xFF2D3142),
              letterSpacing: 0.3,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
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
          child: Column(
            children: [
              // Custom App Bar
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 10,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.arrow_back_ios_new,
                          color: Color(0xFF2D3142),
                          size: 18,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Add New Gem",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF2D3142),
                              letterSpacing: 0.3,
                            ),
                          ),
                          Text(
                            "Fill in the gem details",
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF2D3142),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Scrollable Content
              Expanded(
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildImageCard(),
                          const SizedBox(height: 20),

                          _buildSectionTitle(
                            "Gem Information",
                            icon: Icons.diamond,
                          ),
                          _buildTextField(
                            "Gem Name",
                            _gemNameController,
                            icon: Icons.diamond,
                            placeholder: "e.g. Blue Sapphire",
                          ),
                          _buildTextField(
                            "Gem Code",
                            _gemCodeController,
                            icon: Icons.qr_code,
                            placeholder: "e.g. GEM123",
                          ),
                          _buildTextField(
                            "Gem Variety",
                            _gemVarietyController,
                            icon: Icons.category,
                            placeholder: "e.g. Ceylon Sapphire",
                          ),

                          const SizedBox(height: 6),
                          _buildSectionTitle("Ownership", icon: Icons.people),
                          _buildTextField(
                            "Current Holder",
                            _gemHolderController,
                            icon: Icons.person,
                            placeholder: "e.g. John Doe",
                          ),
                          _buildTextField(
                            "Previous Owner",
                            _previousOwnerController,
                            icon: Icons.history,
                            placeholder: "e.g. Mr. Silva",
                          ),

                          const SizedBox(height: 6),
                          _buildSectionTitle(
                            "Weight Details",
                            icon: Icons.monitor_weight,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: _buildTextField(
                                  "Rough Weight",
                                  _roughWeightController,
                                  keyboardType: TextInputType.number,
                                  icon: Icons.scale,
                                  placeholder: "10.25",
                                  suffix: "ct",
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: _buildTextField(
                                  "After Perform",
                                  _weightAfterPerformController,
                                  keyboardType: TextInputType.number,
                                  icon: Icons.build_circle,
                                  placeholder: "8.75",
                                  suffix: "ct",
                                ),
                              ),
                            ],
                          ),
                          _buildTextField(
                            "After Cut & Polish",
                            _weightAfterCutPolishController,
                            keyboardType: TextInputType.number,
                            icon: Icons.auto_awesome,
                            placeholder: "7.20",
                            suffix: "ct",
                          ),

                          const SizedBox(height: 6),
                          _buildSectionTitle(
                            "Dimensions",
                            icon: Icons.straighten,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: _buildTextField(
                                  "Width",
                                  _widthController,
                                  keyboardType: TextInputType.number,
                                  icon: Icons.swap_horiz,
                                  placeholder: "5.2",
                                  suffix: "mm",
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: _buildTextField(
                                  "Height",
                                  _heightController,
                                  keyboardType: TextInputType.number,
                                  icon: Icons.height,
                                  placeholder: "7.8",
                                  suffix: "mm",
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 6),
                          _buildSectionTitle(
                            "Pricing & Charges",
                            icon: Icons.payments,
                          ),
                          _buildTextField(
                            "Purchased Price",
                            _purchasedPriceController,
                            keyboardType: TextInputType.number,
                            icon: Icons.attach_money,
                            placeholder: "50000",
                          ),
                          _buildDatePickerField(),
                          _buildTextField(
                            "Performing Charges",
                            _performingChargesController,
                            keyboardType: TextInputType.number,
                            icon: Icons.build,
                            placeholder: "1500",
                          ),
                          _buildTextField(
                            "Cutting Charges",
                            _cuttingChargesController,
                            keyboardType: TextInputType.number,
                            icon: Icons.content_cut,
                            placeholder: "2500",
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

      // Bottom Add Gem Button
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.transparent, Colors.white.withOpacity(0.8)],
          ),
        ),
        child: SafeArea(
          child: GestureDetector(
            onTap: _saveGem,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 14),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF2D3142), Color(0xFF3D4152)],
                ),
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF2D3142).withOpacity(0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.check_circle, color: Colors.white, size: 20),
                  SizedBox(width: 10),
                  Text(
                    "Add Gem",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      letterSpacing: 0.5,
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
}
