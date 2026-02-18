import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:labamu/common/constants/app_colorss.dart';
import 'package:labamu/core/theme/app_colors.dart';
import 'package:labamu/core/utils/upload_picture.dart';

class BaseImagePicker extends StatefulWidget {
  const BaseImagePicker({
    super.key,
    this.label = '',
    this.validator,
    this.onChanged,
  });

  final String label;

  final String? Function(Uint8List?)? validator;
  final Function(String?)? onChanged;

  @override
  State<BaseImagePicker> createState() => _BaseImagePickerState();
}

class _BaseImagePickerState extends State<BaseImagePicker> {
  XFile? objectFile;
  final uploadService = UploadPictureService();

  Future<void> pickImage(FormFieldState<Uint8List?> field) async {
    final ImagePicker picker = ImagePicker();
    XFile? image = await picker.pickImage(source: ImageSource.gallery);
    var imageAsBytes = await image?.readAsBytes();
    var imageUrl = await _uploadAndGetFileUrl(imageAsBytes!);

    field.didChange(imageAsBytes);
    widget.onChanged?.call(imageUrl);

    setState(() {
      objectFile = image;
    });
  }

  Future<String?> _uploadAndGetFileUrl(Uint8List file) async {
    try {
      var response = await uploadService.uploadPicture(
        file: file,
        type: 'package',
      );
      final data = response.data['data'];
      final fileUrl = data['file_url'];
      return fileUrl;
    } catch (e) {
      print('Error uploading image: $e');
      return null;
    }
  }

  void delete(FormFieldState<Uint8List?> field) {
    field.didChange(null);
    widget.onChanged?.call(null);
    setState(() {
      objectFile = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label.isNotEmpty) ...[
          Text(
            widget.label,
            style: GoogleFonts.urbanist(
              color: AppColors.textSecondary,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          8.verticalSpace,
        ],
        FormField<Uint8List?>(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          builder: (field) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () => pickImage(field),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: field.hasError
                            ? AppColors.saError
                            : AppColors.borderBase,
                      ),
                    ),
                    child: Container(
                      width: double.infinity,
                      height: 140,
                      decoration: BoxDecoration(
                        color: AppColors.bgCard,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Icon(Icons.photo, color: AppColors.textTertiary),
                          2.verticalSpace,
                          Text(
                            "upload Photo",
                            style: GoogleFonts.urbanist(
                              color: AppColors.textTertiary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                if (field.value != null) ...[
                  8.verticalSpace,
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 12,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.borderBase),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: AppColors.borderBase,
                                  ),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Image.memory(
                                  field.value ?? Uint8List(1),
                                  width: 40,
                                  height: 40,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              4.horizontalSpace,
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [Text(objectFile?.name ?? '')],
                                ),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () => delete(field),
                          child: const Icon(
                            Icons.delete,
                            size: 16,
                            color: AppColors.saError,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
                if (field.hasError) ...[
                  2.verticalSpace,
                  Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: Text(
                      field.errorText ?? '',
                      style: const TextStyle(
                        color: AppColors.saError,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ],
            );
          },
          validator: widget.validator,
        ),
      ],
    );
  }
}
