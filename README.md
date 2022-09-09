## ScreenShot
![screenshot](https://user-images.githubusercontent.com/105129810/189432373-8b1fdb50-c643-4874-8b63-e4e9b2330be1.png)

## Usage

1. Add reference to pubspec.yaml.

2. Import:
```dart
import 'package:dc_datatable/dc_datatable.dart';
```

3. Create DcDataTableSource:
```dart
import 'package:dc_datatable/dc_datatable.dart';
import 'package:flutter/material.dart';
import 'model_example.dart';

class MyDataSource extends DcDataTableSource {
  @override
  List<DataColumn> get columns {
    return const [
      DataColumn(label: Text('Id')),
      DataColumn(label: Text('Name')),
      DataColumn(label: Text('Description')),
    ];
  }

  @override
  Future<DcDataTablePaged> onLoadData() async {
    List<ModelExample> dados = List.generate(10, (i) {
      i++;
      return ModelExample(
          id: i,
          name: "Name $i",
          description: "Description:  Record:$i   Page: $currentPage");
    });

    return DcDataTablePaged(data: dados, totalRecords: 110);
  }

  @override
  DataRow getRow(int i, List data, List dataSelected) {
    ModelExample model = data[i];
    return DataRow(
        cells: <DataCell>[
          DataCell(Text(model.id.toString())),
          DataCell(Text(model.name)),
          DataCell(Text(model.description)),
        ],
        selected: dataSelected.contains(model),
        onSelectChanged: (value) {
          if (dataSelected.contains(model)) {
            dataSelected.remove(model);
          } else {
            dataSelected.add(model);
          }
          debugPrint("Row Selected $i");
        });
  }
}
```


4. Add DcDataTableSource in Providers:
```dart

void main() {
  runApp(ChangeNotifierProvider(
    create: (_) => MyDataSource(),
    child: const MyApp(),
  ));
}

```


5. Get Provider and use:
```dart


MyDataSource source = Provider.of<MyDataSource>(context, listen: true);

  DcDataTable(
              labelPage: 'Page',
              labelRecords: 'Records',
              source: source,
            ),



```