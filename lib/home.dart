import 'package:expenses_tracker/expanses.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Home_Page extends StatefulWidget {
  const Home_Page({super.key});

  @override
  State<Home_Page> createState() => _Home_PageState();
}

class _Home_PageState extends State<Home_Page> {
  List<Expanses> _expanses = [];

  final List<String> _catagory = [
    'Food',
    'Entertaiment',
    'Shopping',
    'Transport'
  ];

  String selectedIndex = 'Food';
  DateTime? selectdate;

  TextEditingController titleController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  addToList(String title, double amount, String catagory, DateTime date) {
    if (titleController.text.isNotEmpty &&
        amountController.text.isNotEmpty &&
        selectdate != null) {
      setState(() {
        _expanses.add(Expanses(
            title: titleController.text,
            amount: double.parse(amountController.text),
            catagory: selectedIndex,
            date: selectdate as DateTime));
      });
    } else {
      return;
    }
  }

  showbottom(BuildContext context) {
    print(_expanses);
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(hintText: 'Enter Title'),
                controller: titleController,
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                decoration: InputDecoration(hintText: 'Enter Amount'),
                controller: amountController,
              ),
              const SizedBox(
                height: 10,
              ),
              DropdownButton<String>(
                  value: selectedIndex,
                  items: _catagory
                      .map((current) => DropdownMenuItem(
                            child: Text(current),
                            value: current,
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedIndex = value!;
                    });
                  }),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(selectdate == null
                      ? "No date Choosen"
                      : DateFormat.yMd()
                          .format(selectdate as DateTime)
                          .toString()),
                  ElevatedButton(
                      onPressed: () {
                        showDatePicker(
                                context: context,
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2026))
                            .then((pickdate) {
                          if (pickdate == null) {
                            return;
                          }
                          setState(() {
                            selectdate = pickdate;
                          });
                        });
                        print(selectdate);
                        print(_expanses);
                      },
                      child: Icon(Icons.calendar_month))
                ],
              ),
              ElevatedButton(
                  onPressed: () {
                    addToList(
                        titleController.text,
                        double.parse(amountController.text),
                        selectedIndex,
                        selectdate as DateTime);
                    Navigator.pop(context);
                  },
                  child: const Icon(Icons.add))
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        centerTitle: true,
        title: const Text('Expenses Tracker',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Colors.cyan,
                    borderRadius: BorderRadius.circular(10)),
                child: const Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Text(
                    'Total \$5000',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _expanses.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 15,
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Text(_expanses[index].catagory),
                    ),
                    title: Text(
                      _expanses[index].title,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    subtitle: Text(_expanses[index].date.toString()),
                    trailing:
                        IconButton(onPressed: () {}, icon: Icon(Icons.delete)),
                  ),
                );
              },
            ),
          )
        ],
      ),
      floatingActionButton: ElevatedButton(
        onPressed: () => showbottom(context),
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.cyan,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15))),
      ),
    );
  }
}
