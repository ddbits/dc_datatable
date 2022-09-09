import 'package:dc_datatable/dc_datatable.dart';
import 'package:flutter/material.dart';

import 'model_example.dart';
import 'my_data_source.dart';
// ignore: depend_on_referenced_packages
import 'package:provider/provider.dart';

class MyHomePage extends StatelessWidget {
  final String title;

  const MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MyDataSource source = Provider.of<MyDataSource>(context, listen: true);

    //ValueListenableBuilder

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DcDataTable(
              labelPage: 'Page',
              labelRecords: 'Records',
              source: source,
            ),
            ElevatedButton(
                onPressed: () {
                  source.currentPage = 7;
                },
                child: const Text("Test"))
          ],
        ),
      ),
    );

    //record search simulation in an api
  }

  loadDataApi() {
    //service get data from backend
    Future.delayed(const Duration(seconds: 2));
    List<ModelExample> dados = List.generate(10, (i) {
      return ModelExample(
          id: i, name: "Name $i", description: "Description $i");
    });

    return dados;
  }
} //end class
