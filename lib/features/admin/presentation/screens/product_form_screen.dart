import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/network/app_exception.dart';
import '../../../../shared/widgets/app_error_widget.dart';
import '../../../../shared/widgets/loading_widget.dart';
import '../../../../shared/widgets/payment_proof_viewer.dart';
import '../providers/product_provider.dart';

class ProductFormScreen extends ConsumerStatefulWidget {
  const ProductFormScreen({super.key, this.productId});

  final int? productId;

  @override
  ConsumerState<ProductFormScreen> createState() => _ProductFormScreenState();
}

class _ProductFormScreenState extends ConsumerState<ProductFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _categoryController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _imageUrlController = TextEditingController();
  final _priceController = TextEditingController();
  final _stockController = TextEditingController();
  final _imagePicker = ImagePicker();
  XFile? _pickedImage;
  final List<String> _localCategories = [];
  bool _isSaving = false;
  bool _isInitialized = false;

  bool get _isEditMode => widget.productId != null;

  @override
  void dispose() {
    _nameController.dispose();
    _categoryController.dispose();
    _descriptionController.dispose();
    _imageUrlController.dispose();
    _priceController.dispose();
    _stockController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final detailState = _isEditMode
        ? ref.watch(productDetailProvider(widget.productId!))
        : null;
    final categoriesState = ref.watch(productCategoriesProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditMode ? 'Edit Produk' : 'Tambah Produk'),
      ),
      body:
          detailState?.when(
            loading: () => ListView(
              padding: const EdgeInsets.all(16),
              children: const [LoadingWidget.card(), LoadingWidget.card()],
            ),
            error: (error, _) => AppErrorWidget(
              error: error,
              onRetry: () =>
                  ref.invalidate(productDetailProvider(widget.productId!)),
            ),
            data: (product) {
              if (!_isInitialized) {
                _nameController.text = product.name;
                _categoryController.text = product.category;
                _descriptionController.text = product.description ?? '';
                _imageUrlController.text = product.imageUrl ?? '';
                _priceController.text = product.price.toStringAsFixed(0);
                _stockController.text = product.stock.toString();
                _isInitialized = true;
              }

              return _buildForm(context, categoriesState);
            },
          ) ??
          _buildForm(context, categoriesState),
    );
  }

  Widget _buildForm(
    BuildContext context,
    AsyncValue<List<String>> categoriesState,
  ) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _ImagePickerCard(
                imageUrl: _imageUrlController.text.trim(),
                pickedImage: _pickedImage,
                isSaving: _isSaving,
                onPickFromGallery: () => _pickImage(ImageSource.gallery),
                onPickFromCamera: () => _pickImage(ImageSource.camera),
                onRemovePickedImage: _pickedImage == null
                    ? null
                    : () => setState(() => _pickedImage = null),
              ),
              FormField<void>(
                validator: (_) => _validateImage(),
                builder: (field) {
                  if (!field.hasError) {
                    return const SizedBox.shrink();
                  }

                  return Padding(
                    padding: const EdgeInsets.only(top: 8, left: 12),
                    child: Text(
                      field.errorText!,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.error,
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _imageUrlController,
                enabled: !_isSaving,
                textInputAction: TextInputAction.next,
                onChanged: (_) => setState(() {}),
                decoration: const InputDecoration(
                  labelText: 'URL gambar',
                  prefixIcon: Icon(Icons.image_outlined),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _nameController,
                enabled: !_isSaving,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  labelText: 'Nama produk',
                  prefixIcon: Icon(Icons.local_cafe_outlined),
                ),
                validator: _required,
              ),
              const SizedBox(height: 12),
              _buildCategoryField(context, categoriesState),
              const SizedBox(height: 12),
              TextFormField(
                controller: _descriptionController,
                enabled: !_isSaving,
                minLines: 3,
                maxLines: 5,
                decoration: const InputDecoration(
                  labelText: 'Deskripsi',
                  alignLabelWithHint: true,
                  prefixIcon: Icon(Icons.notes_outlined),
                ),
                validator: _required,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _priceController,
                enabled: !_isSaving,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  labelText: 'Harga',
                  prefixText: 'Rp ',
                  prefixIcon: Icon(Icons.payments_outlined),
                ),
                validator: _requiredNumber,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _stockController,
                enabled: !_isSaving,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                textInputAction: TextInputAction.done,
                decoration: const InputDecoration(
                  labelText: 'Stok',
                  prefixIcon: Icon(Icons.inventory_2_outlined),
                ),
                validator: _requiredNumber,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _isSaving ? null : _save,
                child: _isSaving
                    ? const SizedBox.square(
                        dimension: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('Simpan'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String? _required(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Field ini wajib diisi';
    }

    return null;
  }

  String? _requiredNumber(String? value) {
    final parsed = num.tryParse(value ?? '');
    if (parsed == null) {
      return 'Field ini wajib diisi';
    }

    return null;
  }

  Widget _buildCategoryField(
    BuildContext context,
    AsyncValue<List<String>> categoriesState,
  ) {
    final categories = categoriesState.maybeWhen(
      data: (items) => items,
      orElse: () => <String>[],
    );
    final selectedCategory = _categoryController.text.trim();
    final options = {
      ...categories,
      ..._localCategories,
      if (selectedCategory.isNotEmpty) selectedCategory,
    }.toList()..sort();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        DropdownButtonFormField<String>(
          key: ValueKey(selectedCategory),
          initialValue: selectedCategory.isEmpty ? null : selectedCategory,
          items: options
              .map(
                (category) => DropdownMenuItem<String>(
                  value: category,
                  child: Text(
                    category,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              )
              .toList(),
          onChanged: _isSaving
              ? null
              : (value) => setState(() {
                  _categoryController.text = value ?? '';
                }),
          decoration: InputDecoration(
            labelText: 'Kategori',
            prefixIcon: const Icon(Icons.category_outlined),
            suffixIcon: categoriesState.isLoading
                ? const Padding(
                    padding: EdgeInsets.all(14),
                    child: SizedBox.square(
                      dimension: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  )
                : null,
          ),
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Kategori wajib dipilih';
            }

            return null;
          },
        ),
        const SizedBox(height: 8),
        Align(
          alignment: Alignment.centerLeft,
          child: TextButton.icon(
            onPressed: _isSaving ? null : _addCategory,
            icon: const Icon(Icons.add),
            label: const Text('Tambah kategori'),
          ),
        ),
      ],
    );
  }

  Future<void> _addCategory() async {
    final newCategory = await showDialog<String>(
      context: context,
      builder: (context) => const _AddCategoryDialog(),
    );

    if (newCategory == null || newCategory.isEmpty || !mounted) {
      return;
    }

    setState(() {
      if (!_localCategories.contains(newCategory)) {
        _localCategories.add(newCategory);
      }
      _categoryController.text = newCategory;
    });
  }

  String? _validateImage() {
    final imageUrl = _imageUrlController.text.trim();
    if (_pickedImage != null) {
      return null;
    }

    if (imageUrl.startsWith(RegExp(r'https?://'))) {
      return null;
    }

    if (_isEditMode && imageUrl.isNotEmpty) {
      return null;
    }

    return 'Foto produk wajib diisi';
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final image = await _imagePicker.pickImage(
        source: source,
        maxWidth: 1600,
        maxHeight: 1600,
        imageQuality: 85,
      );
      if (image == null || !mounted) {
        return;
      }

      setState(() => _pickedImage = image);
    } catch (_) {
      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Gagal memilih foto produk')),
      );
    }
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() => _isSaving = true);

    final imageUrl = _imageUrlController.text.trim();
    final data = {
      'name': _nameController.text.trim(),
      'category': _categoryController.text.trim(),
      'description': _descriptionController.text.trim(),
      if (_pickedImage == null && imageUrl.startsWith(RegExp(r'https?://')))
        'image_url': imageUrl,
      'price': double.parse(_priceController.text),
      'stock': int.parse(_stockController.text),
    };

    try {
      final repository = ref.read(productRepositoryProvider);
      if (_isEditMode) {
        await repository.updateProduct(
          widget.productId!,
          data,
          imagePath: _pickedImage?.path,
        );
        ref.invalidate(productDetailProvider(widget.productId!));
      } else {
        await repository.createProduct(data, imagePath: _pickedImage?.path);
      }

      ref.invalidate(productsProvider);
      ref.invalidate(productCategoriesProvider);

      if (mounted) {
        Navigator.of(context).pop();
      }
    } catch (error) {
      if (mounted) {
        final message = error is AppException
            ? error.message
            : 'Gagal menyimpan produk';
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(message)));
      }
    } finally {
      if (mounted) {
        setState(() => _isSaving = false);
      }
    }
  }
}

class _AddCategoryDialog extends StatefulWidget {
  const _AddCategoryDialog();

  @override
  State<_AddCategoryDialog> createState() => _AddCategoryDialogState();
}

class _AddCategoryDialogState extends State<_AddCategoryDialog> {
  final _controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Tambah kategori'),
      content: Form(
        key: _formKey,
        child: TextFormField(
          controller: _controller,
          autofocus: true,
          textInputAction: TextInputAction.done,
          decoration: const InputDecoration(
            labelText: 'Nama kategori',
            prefixIcon: Icon(Icons.category_outlined),
          ),
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Nama kategori wajib diisi';
            }

            return null;
          },
          onFieldSubmitted: (_) => _submit(),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Batal'),
        ),
        ElevatedButton(onPressed: _submit, child: const Text('Tambah')),
      ],
    );
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      Navigator.of(context).pop(_controller.text.trim());
    }
  }
}

class _ImagePickerCard extends StatelessWidget {
  const _ImagePickerCard({
    required this.imageUrl,
    required this.pickedImage,
    required this.isSaving,
    required this.onPickFromGallery,
    required this.onPickFromCamera,
    required this.onRemovePickedImage,
  });

  final String imageUrl;
  final XFile? pickedImage;
  final bool isSaving;
  final VoidCallback onPickFromGallery;
  final VoidCallback onPickFromCamera;
  final VoidCallback? onRemovePickedImage;

  @override
  Widget build(BuildContext context) {
    final hasUrl = imageUrl.isNotEmpty;

    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 180,
            child: pickedImage != null
                ? Image.file(File(pickedImage!.path), fit: BoxFit.cover)
                : hasUrl
                ? CachedNetworkImage(
                    imageUrl: resolveBackendAssetUrl(imageUrl),
                    fit: BoxFit.cover,
                    errorWidget: (_, __, ___) => const _ImageEmptyPreview(),
                  )
                : const _ImageEmptyPreview(),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              alignment: WrapAlignment.spaceBetween,
              children: [
                FilledButton.tonalIcon(
                  onPressed: isSaving ? null : onPickFromGallery,
                  icon: const Icon(Icons.photo_library_outlined),
                  label: const Text('Galeri'),
                ),
                FilledButton.tonalIcon(
                  onPressed: isSaving ? null : onPickFromCamera,
                  icon: const Icon(Icons.photo_camera_outlined),
                  label: const Text('Kamera'),
                ),
                if (pickedImage != null)
                  TextButton.icon(
                    onPressed: isSaving ? null : onRemovePickedImage,
                    icon: const Icon(Icons.close),
                    label: const Text('Hapus'),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ImageEmptyPreview extends StatelessWidget {
  const _ImageEmptyPreview();

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.image_outlined,
            size: 44,
            color: Theme.of(context).colorScheme.secondary,
          ),
          const SizedBox(height: 8),
          Text(
            'Pilih foto produk',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
