import 'package:flutter/material.dart';

import 'dc_paged.dart';

abstract class DcSource<T> extends ChangeNotifier {
  //
  List<DataColumn> _columns = const [DataColumn(label: Text('None'))];

  List<DataColumn> get columns => _columns;
  set columns(List<DataColumn> value) {
    _columns = value;
    notifyListeners();
  }

  List _data = [];
  List get data => _data;

  List _dataSelected = [];
  List get dataSelected => _dataSelected;
  set dataSelected(List value) {
    _dataSelected = value;
    notifyListeners();
  }

  Future<DcPaged> onLoadData();

  load() async {
    DcPaged paged = await onLoadData();
    _totalRecords = paged.totalRecords;
    _data = paged.data;
    notifyListeners();
  }

  int _currentPage = 0;

  get currentPage => _currentPage;

  set currentPage(value) {
    _currentPage = value;
    load();
  }

  int _totalRecords = 0;
  get totalRecords => _totalRecords;

  List<DataRow> get rows {
    List<DataRow> createRows = [];
    for (int i = 0; i < _data.length; i++) {
      createRows.add(getRow(i, _data, _dataSelected));
    }

    return createRows;
  }

  bool _sortAscending = false;
  bool get sortAscending => _sortAscending;

  set sortAscending(bool value) {
    _sortAscending = value;
    load();
  }

  int _sortColumnIndex = 0;
  int get sortColumnIndex => _sortColumnIndex;

  set sortColumnIndex(int value) {
    _sortColumnIndex = value;
    load();
  }

  bool hasData() {
    if (totalRecords() == 0) return false;
    if (totalRecords() > 0) return true;
    return false;
  }

  DataRow getRow(int i, List data, List dataSelected);
}
