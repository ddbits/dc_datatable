import 'package:flutter/material.dart';

class DcDataTableController {
  late BuildContext context;

  final ValueNotifier<int> _totalRecords = ValueNotifier(0);
  int get totalRecords => _totalRecords.value;
  set totalRecords(int value) => _totalRecords.value = value;

  final ValueNotifier<List> _data = ValueNotifier([]);
  List get data => _data.value;
  set data(List value) => _data.value = value;

  final ValueNotifier<List> _dataSelected = ValueNotifier([]);
  List get dataSelected => _dataSelected.value;
  set dataSelected(List value) => _dataSelected.value = value;

  final ValueNotifier<int> _currentPage = ValueNotifier(0);
  int get currentPage => _currentPage.value;
  set currentPage(int value) => _currentPage.value = value;

  final ValueNotifier<bool> _sortAscending = ValueNotifier(false);
  get sortAscending => _sortAscending.value;
  set sortAscending(value) => _sortAscending.value = value;

  final ValueNotifier<int> _sortColumnIndex = ValueNotifier(0);
  get sortColumnIndex => _sortColumnIndex.value;
  set sortColumnIndex(sortColumnIndex) =>
      _sortColumnIndex.value = sortColumnIndex;

  int pageSize = 0;
  int initialPage = 0;
  bool paginator = true;

  DcDataTableController(this.context);

  DataRow getRow(int rowIndex) {
    return const DataRow(cells: <DataCell>[DataCell(Text("none"))]);
  }

  void onLoadData() async {
    data = [];
    totalRecords = 0;
  }

  void addListenerUpdateCurrentPage(Function() f) {
    _currentPage.addListener(f);
  }

  void addListenerUpdateData(Function() f) {
    _data.addListener(f);
  }

  void addListenerUpdateTotalRecords(Function() f) {
    _totalRecords.addListener(f);
  }

  void addListenerUpdateDataSelected(Function() f) {
    _dataSelected.addListener(f);
  }

  void addListenerUpdateSortColumnIndex(Function() f) {
    _sortColumnIndex.addListener(f);
  }

  void addListenerUpdateSortAscending(Function() f) {
    _sortAscending.addListener(f);
  }

  static int compareString(bool ascending, String value1, String value2) =>
      ascending ? value1.compareTo(value2) : value2.compareTo(value1);
}
