import 'package:flutter/material.dart';

class FechaPicker extends StatefulWidget {
  final TextEditingController fechaController;
  final bool isEditing;
  const FechaPicker(this.fechaController, this.isEditing, {super.key});

  @override
  State<FechaPicker> createState() => _FechaPickerState();
}

class _FechaPickerState extends State<FechaPicker> {
  DateTime? _fecha;

  @override
  Widget build(BuildContext context) {
    return TextField(
      enabled: widget.isEditing,
      readOnly: true,
      controller: widget.fechaController,
      decoration: InputDecoration(icon: Icon(Icons.date_range_rounded)),
      keyboardType: TextInputType.datetime,
      onTap: () => _fechanacimiento(context),
    );
  }

  Future<void> _fechanacimiento(BuildContext context) async {
    DateTime? fechapicked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );

    if (fechapicked != null && fechapicked != _fecha) {
      setState(() {
        _fecha = fechapicked;

        String d = fechapicked.day.toString().padLeft(2, '0');
        String m = fechapicked.month.toString().padLeft(2, '0');
        String y = fechapicked.year.toString();

        widget.fechaController.text = '$d/$m/$y';
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
