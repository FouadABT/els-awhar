import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart' hide TextDirection;
import 'package:awhar_client/awhar_client.dart';
import '../layouts/dashboard_layout.dart';
import '../core/theme/admin_colors.dart';
import '../controllers/promos_controller.dart';

/// Promo form screen for creating/editing promos
class PromoFormScreen extends StatefulWidget {
  final Promo? promo;

  const PromoFormScreen({super.key, this.promo});

  @override
  State<PromoFormScreen> createState() => _PromoFormScreenState();
}

class _PromoFormScreenState extends State<PromoFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late final PromosController _controller;

  // Form controllers
  late TextEditingController _titleEnController;
  late TextEditingController _titleArController;
  late TextEditingController _titleFrController;
  late TextEditingController _titleEsController;
  late TextEditingController _descriptionEnController;
  late TextEditingController _descriptionArController;
  late TextEditingController _descriptionFrController;
  late TextEditingController _descriptionEsController;
  late TextEditingController _imageUrlController;
  late TextEditingController _actionValueController;
  late TextEditingController _priorityController;

  // Form values
  List<String> _selectedRoles = ['client'];
  String _actionType = 'none';
  bool _isActive = true;
  DateTime? _startDate;
  DateTime? _endDate;

  bool get isEditing => widget.promo != null;

  @override
  void initState() {
    super.initState();
    _controller = Get.find<PromosController>();
    _initControllers();
  }

  void _initControllers() {
    final promo = widget.promo;

    _titleEnController = TextEditingController(text: promo?.titleEn ?? '');
    _titleArController = TextEditingController(text: promo?.titleAr ?? '');
    _titleFrController = TextEditingController(text: promo?.titleFr ?? '');
    _titleEsController = TextEditingController(text: promo?.titleEs ?? '');
    _descriptionEnController =
        TextEditingController(text: promo?.descriptionEn ?? '');
    _descriptionArController =
        TextEditingController(text: promo?.descriptionAr ?? '');
    _descriptionFrController =
        TextEditingController(text: promo?.descriptionFr ?? '');
    _descriptionEsController =
        TextEditingController(text: promo?.descriptionEs ?? '');
    _imageUrlController = TextEditingController(text: promo?.imageUrl ?? '');
    _actionValueController =
        TextEditingController(text: promo?.actionValue ?? '');
    _priorityController =
        TextEditingController(text: (promo?.priority ?? 0).toString());

    if (promo != null) {
      _selectedRoles =
          promo.targetRoles.split(',').map((r) => r.trim()).toList();
      _actionType = promo.actionType;
      _isActive = promo.isActive;
      _startDate = promo.startDate;
      _endDate = promo.endDate;
    }
  }

  @override
  void dispose() {
    _titleEnController.dispose();
    _titleArController.dispose();
    _titleFrController.dispose();
    _titleEsController.dispose();
    _descriptionEnController.dispose();
    _descriptionArController.dispose();
    _descriptionFrController.dispose();
    _descriptionEsController.dispose();
    _imageUrlController.dispose();
    _actionValueController.dispose();
    _priorityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DashboardLayout(
      title: isEditing ? 'Edit Promo' : 'Create Promo',
      actions: [
        OutlinedButton(
          onPressed: () => Get.back(),
          child: const Text('Cancel'),
        ),
        const SizedBox(width: 12),
        Obx(() => ElevatedButton.icon(
              onPressed: _controller.isActionLoading.value ? null : _savePromo,
              icon: _controller.isActionLoading.value
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                          strokeWidth: 2, color: Colors.white),
                    )
                  : const Icon(Icons.save, size: 18),
              label: Text(isEditing ? 'Update' : 'Create'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AdminColors.primary,
                foregroundColor: Colors.white,
              ),
            )),
      ],
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Left Column - Main Info
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionCard(
                      title: 'Basic Information',
                      children: [
                        _buildTextField(
                          controller: _titleEnController,
                          label: 'Title (English) *',
                          hint: 'Enter promo title in English',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Title is required';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: _buildTextField(
                                controller: _titleArController,
                                label: 'Title (Arabic)',
                                hint: 'العنوان بالعربية',
                                textDirection: TextDirection.rtl,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: _buildTextField(
                                controller: _titleFrController,
                                label: 'Title (French)',
                                hint: 'Titre en français',
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: _buildTextField(
                                controller: _titleEsController,
                                label: 'Title (Spanish)',
                                hint: 'Título en español',
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        _buildTextField(
                          controller: _descriptionEnController,
                          label: 'Description (English)',
                          hint: 'Enter promo description',
                          maxLines: 2,
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: _buildTextField(
                                controller: _descriptionArController,
                                label: 'Description (Arabic)',
                                hint: 'الوصف بالعربية',
                                textDirection: TextDirection.rtl,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: _buildTextField(
                                controller: _descriptionFrController,
                                label: 'Description (French)',
                                hint: 'Description en français',
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: _buildTextField(
                                controller: _descriptionEsController,
                                label: 'Description (Spanish)',
                                hint: 'Descripción en español',
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    _buildSectionCard(
                      title: 'Banner Image',
                      children: [
                        _buildTextField(
                          controller: _imageUrlController,
                          label: 'Image URL *',
                          hint: 'https://example.com/banner.jpg',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Image URL is required';
                            }
                            if (!value.startsWith('http')) {
                              return 'Please enter a valid URL';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        // Image Preview
                        Container(
                          height: 150,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: AdminColors.backgroundLight,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: AdminColors.borderLight),
                          ),
                          child: _imageUrlController.text.isNotEmpty
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    _imageUrlController.text,
                                    fit: BoxFit.cover,
                                    errorBuilder: (_, __, ___) => Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.broken_image,
                                              size: 40,
                                              color: AdminColors.error),
                                          const SizedBox(height: 8),
                                          Text('Failed to load image',
                                              style: TextStyle(
                                                  color: AdminColors.error)),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              : Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.image,
                                          size: 40,
                                          color:
                                              AdminColors.textSecondaryLight),
                                      const SizedBox(height: 8),
                                      Text('Image preview',
                                          style: TextStyle(
                                              color: AdminColors
                                                  .textSecondaryLight)),
                                    ],
                                  ),
                                ),
                        ),
                        const SizedBox(height: 8),
                        TextButton.icon(
                          onPressed: () => setState(() {}), // Refresh preview
                          icon: const Icon(Icons.refresh, size: 16),
                          label: const Text('Refresh Preview'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 24),
              // Right Column - Settings
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionCard(
                      title: 'Target Audience',
                      children: [
                        _buildCheckboxTile('Client', 'client'),
                        _buildCheckboxTile('Driver', 'driver'),
                        _buildCheckboxTile('Store', 'store'),
                      ],
                    ),
                    const SizedBox(height: 24),
                    _buildSectionCard(
                      title: 'Action Settings',
                      children: [
                        _buildDropdown(
                          label: 'Action Type',
                          value: _actionType,
                          items: const [
                            DropdownMenuItem(
                                value: 'none', child: Text('No Action')),
                            DropdownMenuItem(
                                value: 'link', child: Text('External Link')),
                            DropdownMenuItem(
                                value: 'screen', child: Text('App Screen')),
                            DropdownMenuItem(
                                value: 'store', child: Text('Store Profile')),
                            DropdownMenuItem(
                                value: 'driver', child: Text('Driver Profile')),
                            DropdownMenuItem(
                                value: 'service',
                                child: Text('Service Details')),
                          ],
                          onChanged: (value) =>
                              setState(() => _actionType = value!),
                        ),
                        if (_actionType != 'none') ...[
                          const SizedBox(height: 16),
                          _buildTextField(
                            controller: _actionValueController,
                            label: _getActionValueLabel(),
                            hint: _getActionValueHint(),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 24),
                    _buildSectionCard(
                      title: 'Display Settings',
                      children: [
                        _buildTextField(
                          controller: _priorityController,
                          label: 'Priority',
                          hint: 'Higher = shown first',
                          keyboardType: TextInputType.number,
                        ),
                        const SizedBox(height: 16),
                        SwitchListTile(
                          title: Text('Active',
                              style: GoogleFonts.inter(fontSize: 14)),
                          value: _isActive,
                          onChanged: (value) =>
                              setState(() => _isActive = value),
                          contentPadding: EdgeInsets.zero,
                          activeColor: AdminColors.success,
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    _buildSectionCard(
                      title: 'Schedule',
                      children: [
                        _buildDatePicker(
                          label: 'Start Date',
                          value: _startDate,
                          onChanged: (date) =>
                              setState(() => _startDate = date),
                        ),
                        const SizedBox(height: 16),
                        _buildDatePicker(
                          label: 'End Date',
                          value: _endDate,
                          onChanged: (date) => setState(() => _endDate = date),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionCard(
      {required String title, required List<Widget> children}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AdminColors.surfaceElevatedLight,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AdminColors.borderLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AdminColors.textPrimaryLight,
            ),
          ),
          const SizedBox(height: 16),
          ...children,
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    String? hint,
    int maxLines = 1,
    TextInputType? keyboardType,
    TextDirection textDirection = TextDirection.ltr,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      textDirection: textDirection,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      ),
    );
  }

  Widget _buildCheckboxTile(String label, String role) {
    return CheckboxListTile(
      title: Text(label, style: GoogleFonts.inter(fontSize: 14)),
      value: _selectedRoles.contains(role),
      onChanged: (value) {
        setState(() {
          if (value == true) {
            _selectedRoles.add(role);
          } else {
            _selectedRoles.remove(role);
          }
        });
      },
      contentPadding: EdgeInsets.zero,
      controlAffinity: ListTileControlAffinity.leading,
      activeColor: AdminColors.primary,
    );
  }

  Widget _buildDropdown({
    required String label,
    required String value,
    required List<DropdownMenuItem<String>> items,
    required void Function(String?) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: GoogleFonts.inter(
                fontSize: 12, color: AdminColors.textSecondaryLight)),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: value,
          items: items,
          onChanged: onChanged,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          ),
        ),
      ],
    );
  }

  Widget _buildDatePicker({
    required String label,
    required DateTime? value,
    required void Function(DateTime?) onChanged,
  }) {
    final dateFormat = DateFormat('MMM d, yyyy');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: GoogleFonts.inter(
                fontSize: 12, color: AdminColors.textSecondaryLight)),
        const SizedBox(height: 8),
        InkWell(
          onTap: () async {
            final picked = await showDatePicker(
              context: context,
              initialDate: value ?? DateTime.now(),
              firstDate: DateTime.now().subtract(const Duration(days: 365)),
              lastDate: DateTime.now().add(const Duration(days: 365 * 2)),
            );
            onChanged(picked);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            decoration: BoxDecoration(
              border: Border.all(color: AdminColors.borderLight),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    value != null ? dateFormat.format(value) : 'Not set',
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      color: value != null
                          ? AdminColors.textPrimaryLight
                          : AdminColors.textSecondaryLight,
                    ),
                  ),
                ),
                const Icon(Icons.calendar_today, size: 18),
                if (value != null) ...[
                  const SizedBox(width: 8),
                  InkWell(
                    onTap: () => onChanged(null),
                    child: const Icon(Icons.clear, size: 18),
                  ),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }

  String _getActionValueLabel() {
    switch (_actionType) {
      case 'link':
        return 'URL';
      case 'screen':
        return 'Route Name';
      case 'store':
        return 'Store ID';
      case 'driver':
        return 'Driver User ID';
      case 'service':
        return 'Service ID';
      default:
        return 'Value';
    }
  }

  String _getActionValueHint() {
    switch (_actionType) {
      case 'link':
        return 'https://example.com';
      case 'screen':
        return '/client/explore';
      case 'store':
        return '123';
      case 'driver':
        return '456';
      case 'service':
        return '789';
      default:
        return '';
    }
  }

  Future<void> _savePromo() async {
    if (!_formKey.currentState!.validate()) return;

    if (_selectedRoles.isEmpty) {
      Get.snackbar('Error', 'Please select at least one target role');
      return;
    }

    final targetRoles = _selectedRoles.join(',');
    final priority = int.tryParse(_priorityController.text) ?? 0;

    bool success;
    if (isEditing) {
      success = await _controller.updatePromo(
        promoId: widget.promo!.id!,
        titleEn: _titleEnController.text,
        titleAr:
            _titleArController.text.isNotEmpty ? _titleArController.text : null,
        titleFr:
            _titleFrController.text.isNotEmpty ? _titleFrController.text : null,
        titleEs:
            _titleEsController.text.isNotEmpty ? _titleEsController.text : null,
        descriptionEn: _descriptionEnController.text.isNotEmpty
            ? _descriptionEnController.text
            : null,
        descriptionAr: _descriptionArController.text.isNotEmpty
            ? _descriptionArController.text
            : null,
        descriptionFr: _descriptionFrController.text.isNotEmpty
            ? _descriptionFrController.text
            : null,
        descriptionEs: _descriptionEsController.text.isNotEmpty
            ? _descriptionEsController.text
            : null,
        imageUrl: _imageUrlController.text,
        targetRoles: targetRoles,
        actionType: _actionType,
        actionValue: _actionValueController.text.isNotEmpty
            ? _actionValueController.text
            : null,
        priority: priority,
        isActive: _isActive,
        startDate: _startDate,
        endDate: _endDate,
      );
    } else {
      success = await _controller.createPromo(
        titleEn: _titleEnController.text,
        titleAr:
            _titleArController.text.isNotEmpty ? _titleArController.text : null,
        titleFr:
            _titleFrController.text.isNotEmpty ? _titleFrController.text : null,
        titleEs:
            _titleEsController.text.isNotEmpty ? _titleEsController.text : null,
        descriptionEn: _descriptionEnController.text.isNotEmpty
            ? _descriptionEnController.text
            : null,
        descriptionAr: _descriptionArController.text.isNotEmpty
            ? _descriptionArController.text
            : null,
        descriptionFr: _descriptionFrController.text.isNotEmpty
            ? _descriptionFrController.text
            : null,
        descriptionEs: _descriptionEsController.text.isNotEmpty
            ? _descriptionEsController.text
            : null,
        imageUrl: _imageUrlController.text,
        targetRoles: targetRoles,
        actionType: _actionType,
        actionValue: _actionValueController.text.isNotEmpty
            ? _actionValueController.text
            : null,
        priority: priority,
        isActive: _isActive,
        startDate: _startDate,
        endDate: _endDate,
      );
    }

    if (success) {
      Get.back();
      Get.snackbar(
        'Success',
        isEditing ? 'Promo updated successfully' : 'Promo created successfully',
        backgroundColor: AdminColors.success,
        colorText: Colors.white,
      );
    } else {
      Get.snackbar(
        'Error',
        _controller.errorMessage.value,
        backgroundColor: AdminColors.error,
        colorText: Colors.white,
      );
    }
  }
}
