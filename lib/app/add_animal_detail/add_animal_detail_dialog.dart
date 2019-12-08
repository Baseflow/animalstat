import 'package:flutter/material.dart';
import 'package:livestock/app/add_animal_detail/widgets/add_animal_detail_header.dart';

class AddAnimalDetailDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 0.0,
      backgroundColor: Colors.white,
      child: AddAnimalDetailHeader(
        onClose: () => Navigator.of(context).pop(),
      ),
    );
  }
}
