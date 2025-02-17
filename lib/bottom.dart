import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  DateTime? selectdate;
  String? selectedIndex;
  final List<String> _category = ['Food', 'Transport', 'Shopping', 'Other'];

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(15.0),
          child: StatefulBuilder(
            builder: (context, setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    decoration: const InputDecoration(labelText: "Title"),
                    controller: titleController,
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    decoration: const InputDecoration(labelText: "Amount"),
                    controller: amountController,
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 10),
                  DropdownButton<String>(
                    value: selectedIndex,
                    hint: const Text("Select Category"),
                    items: _category
                        .map((current) => DropdownMenuItem(
                              value: current,
                              child: Text(current),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedIndex = value;
                      });
                    },
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(selectdate == null
                          ? "No date chosen"
                          : DateFormat.yMd().format(selectdate!)),
                      ElevatedButton(
                        onPressed: () async {
                          DateTime? pickdate = await showDatePicker(
                            context: context,
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2026),
                          );
                          if (pickdate != null) {
                            setState(() {
                              selectdate = pickdate;
                            });
                          }
                        },
                        child: const Icon(Icons.calendar_month),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      // Handle form submission
                    },
                    child: const Icon(Icons.add),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => _showBottomSheet(context),
      child: const Text("Open Bottom Sheet"),
    );
  }
}
