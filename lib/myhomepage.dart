

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // const MyHomePage({Key? key}) : super(key: key);
  var dataController=TextEditingController();
  late Box box;
  var txtData;
  var txtData_KeyValue;

  @override
  void initState() {
    createbox();
    // TODO: implement initState
    super.initState();
  }
  createbox() async{
    box =await Hive.openBox('dbbox');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            child: Column(
              children: [
                StatefulBuilder(
                  builder: (context, setState) {
                  return Card(
                      elevation: 10,
                      child: Padding(
                        padding: const EdgeInsets.all(13.0),
                        child: Container(child: Text('${txtData}\n ${txtData_KeyValue}')),
                      ));
                },),
                SizedBox(height: 20,),
                TextFormField(
                  controller: dataController,
                  decoration: InputDecoration(
                    hintText: 'Enter some data...',
                    border: OutlineInputBorder()
                  ),
                ),
                SizedBox(height: 20,),
                ElevatedButton(onPressed: () {
                      //It will add data in list wise.
                  box.add(dataController.text);

                      //It will add data using Key.
                  box.put('name', '${dataController.text}');
                  setState(() {

                  });
                }, child: Wrap(
                  // alignment: WrapAlignment.start,
                  crossAxisAlignment: WrapCrossAlignment.center,

                  children: [
                  Icon(Icons.add),
                  Text('  Add data')],)),
                SizedBox(height: 20,),
                ElevatedButton(onPressed: () {
                    //In order to update data, try to add data on same key.
                    //It will overwrite data with previous one.
                  txtData_KeyValue=box.put('name', dataController.text);

                }, child: Wrap(
                  // alignment: WrapAlignment.start,
                  crossAxisAlignment: WrapCrossAlignment.center,

                  children: [
                    Icon(Icons.update),
                    Text('  Update data')],)),
                SizedBox(height: 20,),
                ElevatedButton(onPressed: () {
                      //It will get data in list wise.. Here we get index 0 value.
                  txtData= box.getAt(0);
                      // Here we get all the values of list by converting into Map.
                  txtData= box.toMap();

                      //It will get value using Key
                  txtData_KeyValue=box.get('name');
                  print('Value is =$txtData');
                  setState(() {

                  });
                }, child: Wrap(
                  // alignment: WrapAlignment.start,
                  crossAxisAlignment: WrapCrossAlignment.center,

                  children: [
                    Icon(Icons.read_more),
                    Text('  Read data')],)),

                SizedBox(height: 20,),

                ElevatedButton(onPressed: () {
                      //It will delete data by Key Value.
                  box.delete('name');
                }, child: Wrap(
                  // alignment: WrapAlignment.start,
                  crossAxisAlignment: WrapCrossAlignment.center,

                  children: [
                    Icon(Icons.delete),
                    Text('  Delete data')],)),

                SizedBox(height: 20,),

                ElevatedButton(onPressed: () {

                      //It will delete box by key
                      //Here Box Name==Table Name
                  Hive.box('dbbox').clear();

                }, child: Wrap(
                  // alignment: WrapAlignment.start,
                  crossAxisAlignment: WrapCrossAlignment.center,

                  children: [
                    Icon(Icons.delete),
                    Text('  Delete Whole Box data')],)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
