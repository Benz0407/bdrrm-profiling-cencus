import 'package:mobile/census/sql_helper.dart';
import 'package:flutter/material.dart';
import 'package:mobile/screens/main_screen.dart';

class CensusMain extends StatelessWidget {
  const CensusMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        // Remove the debug banner
        debugShowCheckedModeBanner: false,
        title: 'CENSUS DATA',
        theme: ThemeData(
          dialogBackgroundColor: Color.fromARGB(255, 148, 205, 231),
        ),
        home: const HomePage());
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // All journals
  List<Map<String, dynamic>> _journals = [];

  bool  _isLoading = true;
  // This function is used to fetch all data from the database
  void _refreshJournals() async {
    final data = await SQLHelper.getItems();
    setState(() {
      _journals = data;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _refreshJournals(); // Loading the diary when the app starts
  }

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _civilstatusController = TextEditingController();
  final TextEditingController _occupationController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _birthdateController = TextEditingController();

  // This function will be triggered when the floating button is pressed
  // It will also be triggered when you want to update an item
  void _showForm(int? id) async {
    if (id != null) {
      // id == null -> create new item
      // id != null -> update an existing item
      final existingJournal =
          _journals.firstWhere((element) => element['id'] == id);
      _nameController.text = existingJournal['name'];
      _addressController.text = existingJournal['address'];
      _civilstatusController.text = existingJournal['civilstatus'];
      _occupationController.text = existingJournal['occupation'];
      _genderController.text = existingJournal['gender'];
      _ageController.text = existingJournal['age'].toString();
      _birthdateController.text = existingJournal['birthdate'].toString();
    }
    showModalBottomSheet(
        context: context,
        elevation: 5,
        isScrollControlled: true,
        builder: (_) => Container(
              padding: EdgeInsets.only(
                top: 15,
                left: 15,
                right: 15,
                // this will prevent the soft keyboard from covering the text fields
                bottom: MediaQuery.of(context).viewInsets.bottom + 200,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextField(
                    controller: _nameController,
                    decoration: const InputDecoration(hintText: 'Name'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: _addressController,
                    decoration: const InputDecoration(hintText: 'Address'),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: _civilstatusController,
                    decoration: const InputDecoration(hintText: 'Civil Status'),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: _occupationController,
                    decoration: const InputDecoration(hintText: 'Occupation'),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: _genderController,
                    decoration: const InputDecoration(hintText: 'Gender'),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: _ageController,
                    decoration: const InputDecoration(hintText: 'Age'),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: _birthdateController,
                    decoration: const InputDecoration(hintText: 'BirthDate'),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      // Save new journal
                      if (id == null) {
                        await _addItem();
                      }

                      if (id != null) {
                        await _updateItem(id);
                      }

                      // Clear the text fields
                      _nameController.text = '';
                      _addressController.text = '';
                      _civilstatusController.text = '';
                      _occupationController.text = '';
                      _genderController.text = '';
                      _ageController.text = '';
                      _birthdateController.text = '';

                      // Close the bottom sheet
                      Navigator.of(context).pop();
                    },
                    child: Text(id == null ? 'Create New' : 'Update'),
                  )
                ],
              ),
            ));
  }

// Insert a new journal to the database
  Future<void> _addItem() async {
    int age = int.tryParse(_ageController.text) ?? 0;
    int birthdate = int.tryParse(_birthdateController.text) ?? 0;
    await SQLHelper.createItem(
        _nameController.text,
        _addressController.text,
        _civilstatusController.text,
        _occupationController.text,
        _genderController.text,
        age,
        birthdate);
    _refreshJournals();
  }

  // Update an existing journal
  Future<void> _updateItem(int id) async {
    int age = int.tryParse(_ageController.text) ?? 0;
    int birthdate = int.tryParse(_birthdateController.text) ?? 0;
    await SQLHelper.updateItem(
        id,
        _nameController.text,
        _addressController.text,
        _civilstatusController.text,
        _occupationController.text,
        _genderController.text,
        age,
        birthdate);
    _refreshJournals();
  }

  // Delete an item
  void _deleteItem(int id) async {
    await SQLHelper.deleteItem(id);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Successfully deleted a data!'),
    ));
    _refreshJournals();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CENSUS DATA'),
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MainScreen()),
            );
          },
        ),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: _journals.length,
              itemBuilder: (context, index) => Card(
                color: Colors.lightBlue.shade50,
                margin: const EdgeInsets.all(15),
                child: ListTile(
                    title: Text(_journals[index]['name']),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(_journals[index]['address']),
                        Text(_journals[index]['civilstatus']),
                        Text(_journals[index]['occupation']),
                        Text(_journals[index]['gender']),
                        Text(_journals[index]['age'].toString()),
                        Text(_journals[index]['birthdate'].toString())
                      ],
                    ),
                    trailing: SizedBox(
                      width: 100,
                      child: Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () => _showForm(_journals[index]['id']),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () =>
                                _deleteItem(_journals[index]['id']),
                          ),
                        ],
                      ),
                    )),
              ),
            ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => _showForm(null),
      ),
    );
  }
}
