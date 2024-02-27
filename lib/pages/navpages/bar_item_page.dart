import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../misc/colors.dart';
import '../crud_helper.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue  ,
        ),
        home: const BarPage());
  }
}
class BarPage extends StatefulWidget {
  const BarPage({Key? key}): super(key:key);

  @override
  _BarPageState createState() => _BarPageState();
}

class _BarPageState extends State<BarPage> {
  List<Map<String, dynamic>> _journals = [];
  bool _isLoading = true;

  void refreshJournals() async {
    final data = await SQLHelper.getItems();
    setState(() {
      _journals = data;
      _isLoading = false;
    });
  }

  @override
  void initState(){
    super.initState();
    refreshJournals();
    print("Number of Items ${_journals.length}");
  }
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _tripDaysController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();


  Future<void> _addItem() async  {

    await SQLHelper.createItem(
      _countryController.text,
      _tripDaysController.text,
      _priceController.text ,
    );
    refreshJournals();
    print("Number of Items ${_journals.length}");
  }
  Future<void> _updateItem(int id) async  {

    await SQLHelper.updateItem(
      id,
      _countryController.text,
      _tripDaysController.text,
      _priceController.text ,
    ) ;
    refreshJournals();
  }
  void _deleteItem(int id) async{
    await SQLHelper.deleteItem(id);
    ScaffoldMessenger.of (context).showSnackBar (const SnackBar(
      content: Text('Successfully deleted a Record !'),
    ));
    refreshJournals();
  }
  void _showForm(int? id,String country, String tripDays, String price) async{
    if (id!=null)
    {
      final existingJournal=
      _journals.firstWhere((element) => element['id']==id);
      _countryController.text = country;
      _tripDaysController.text = tripDays;
      _priceController.text = price;
    }
    showModalBottomSheet(
        elevation: 5,
        isScrollControlled: true,
        context:  context,
        builder: (_) => Container(
          padding: EdgeInsets.only(
            top:35,
            left: 35,
            right: 35,
            bottom: MediaQuery.of(context ).viewInsets.bottom+250,
          ) ,
          child: Column (
            mainAxisSize: MainAxisSize.min ,
            crossAxisAlignment: CrossAxisAlignment.end ,
            children: [
              TextField(
                controller: _countryController ,
                decoration: const InputDecoration(hintText: "Country Name"),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: _tripDaysController  ,
                decoration: const InputDecoration(hintText: "Trip Days"),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: _priceController ,
                decoration: const InputDecoration(hintText: "Price"),
              ),
              const SizedBox(
                height: 10,
              ),

              ElevatedButton(
                onPressed:  () async{
                  if (id==null){
                    await _addItem();
                  }else
                  {
                    await _updateItem(id);
                    }
                      _countryController.text = '';
                      _tripDaysController.text = '';
                        _priceController.text = '';
                        Navigator.of(context).pop();
                    },
                child: Text (id==null? 'Create New': 'Update'),
              )
            ],
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upcoming Trips'),
      ),
      body: ListView.builder(
        itemCount: _journals.length,
        itemBuilder: (context, index) => Card(
          color: Colors.lightBlue[200],
          margin: const EdgeInsets.only(top:45,right:20,left:20,) ,
          child: ListTile(
            title: Text(_journals[index]['country']),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Trip Days: ${_journals[index]['tripDays']}'),
                Text('Price: ${_journals[index]['price']}',),
              ],
            ),

            trailing: SizedBox(
              width:100,
              height: 120,
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () => _showForm(
                      _journals[index]['id'],
                      _journals[index]['country'],
                      _journals[index]['tripDays'],
                      _journals[index]['price'],
                    ),
                  ),

                  IconButton(
                      icon: const Icon (Icons.delete),
                      onPressed: () => _deleteItem(_journals[index]['id'])
                  ), // IconButton
                ],
              ),
            ),
          ), // ListTile
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showForm(null,'','',''),
        child: const Icon(Icons.add),
      ),
    );
  }
}
