import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../models/gem.dart';
import 'package:gemify/gems/gem_detail_screen.dart';

class AddGemScreen extends StatefulWidget {
  const AddGemScreen({super.key});

  @override
  State<AddGemScreen> createState() => _AddGemScreenState();
}

class _AddGemScreenState extends State<AddGemScreen> {
  final _formKey = GlobalKey<FormState>();

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
  File? _gemImage; // Store captured image
  final ImagePicker _picker = ImagePicker();

  @override
  void dispose() {
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
    );
    if (picked != null) {
      setState(() {
        _purchasedDate = picked;
      });
    }
  }

  Future<void> _captureGemImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _gemImage = File(pickedFile.path);
      });
    }
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

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Gem Added Successfully!")));

      Navigator.push(
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
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        validator: (value) =>
            value == null || value.isEmpty ? "Enter $label" : null,
        decoration: InputDecoration(
          labelText: label,
          hintText: placeholder,
          prefixIcon: icon != null ? Icon(icon, color: Colors.blue) : null,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.blue),
          ),
        ),
      ),
    );
  }

  Widget _buildDatePickerField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: GestureDetector(
        onTap: _pickPurchasedDate,
        child: AbsorbPointer(
          child: TextFormField(
            controller: TextEditingController(
              text: _purchasedDate == null
                  ? ""
                  : "${_purchasedDate!.toLocal()}".split(" ")[0],
            ),
            validator: (value) =>
                value == null || value.isEmpty ? "Select purchased date" : null,
            decoration: InputDecoration(
              labelText: "Purchased Date",
              hintText: "Select the purchase date",
              prefixIcon: const Icon(Icons.calendar_today, color: Colors.blue),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Colors.blue),
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
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        color: Colors.grey.shade200,
        child: Container(
          height: 180,
          alignment: Alignment.center,
          child: _gemImage == null
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.camera_alt, size: 40, color: Colors.blue),
                    SizedBox(height: 8),
                    Text("Tap to Add Gem Photo"),
                  ],
                )
              : ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.file(
                    _gemImage!,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add New Gem"),
        backgroundColor: Colors.blue.shade700,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionTitle("Gem Photo"),
              _buildImageCard(),

              _buildSectionTitle("Gem Info"),
              _buildTextField(
                "Gem Name",
                _gemNameController,
                icon: Icons.diamond,
                placeholder: "e.g. Blue Sapphire",
              ),
              _buildTextField(
                "Gem Code",
                _gemCodeController,
                icon: Icons.code,
                placeholder: "e.g. GEM123",
              ),
              _buildTextField(
                "Gem Variety",
                _gemVarietyController,
                icon: Icons.category,
                placeholder: "e.g. Ceylon Sapphire",
              ),
              _buildTextField(
                "Gem Holder",
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

              _buildSectionTitle("Gem Weights"),
              Row(
                children: [
                  Expanded(
                    child: _buildTextField(
                      "Rough Weight",
                      _roughWeightController,
                      keyboardType: TextInputType.number,
                      icon: Icons.monitor_weight,
                      placeholder: "e.g. 10.25 ct",
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildTextField(
                      "After Perform",
                      _weightAfterPerformController,
                      keyboardType: TextInputType.number,
                      icon: Icons.monitor_weight,
                      placeholder: "e.g. 8.75 ct",
                    ),
                  ),
                ],
              ),
              _buildTextField(
                "After Cut & Polish",
                _weightAfterCutPolishController,
                keyboardType: TextInputType.number,
                icon: Icons.monitor_weight,
                placeholder: "e.g. 7.20 ct",
              ),

              _buildSectionTitle("Dimensions"),
              _buildTextField(
                "Width After Cut & Polish",
                _widthController,
                keyboardType: TextInputType.number,
                icon: Icons.swap_horiz,
                placeholder: "e.g. 5.2 mm",
              ),
              _buildTextField(
                "Height After Cut & Polish",
                _heightController,
                keyboardType: TextInputType.number,
                icon: Icons.height,
                placeholder: "e.g. 7.8 mm",
              ),

              _buildSectionTitle("Price & Charges"),
              _buildTextField(
                "Purchased Price",
                _purchasedPriceController,
                keyboardType: TextInputType.number,
                icon: Icons.attach_money,
                placeholder: "e.g. 50000",
              ),
              _buildDatePickerField(),
              _buildTextField(
                "Performing Charges",
                _performingChargesController,
                keyboardType: TextInputType.number,
                icon: Icons.build,
                placeholder: "e.g. 1500",
              ),
              _buildTextField(
                "Cutting Charges",
                _cuttingChargesController,
                keyboardType: TextInputType.number,
                icon: Icons.cut,
                placeholder: "e.g. 2500",
              ),

              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _saveGem,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade700,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    "Add Gem",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
