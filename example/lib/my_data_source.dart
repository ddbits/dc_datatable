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
