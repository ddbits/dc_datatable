import 'package:flutter/material.dart';

import 'package:dc_datatable_paginator/dc_datatable_paginator.dart';

import 'dc_paginator.dart';

class DcDataTable extends StatefulWidget {
  final List<DataColumn> columns;
  final int pageSize;
  final int limitPages;
  final int initialPage;
  final bool paginator;
  final String labelPage;
  final String labelRecords;
  final String labelNoRecords;

  final DcDataTableController controller;

  const DcDataTable({
    Key? key,
    required this.controller,
    required this.columns,
    this.limitPages = 5,
    this.pageSize = 10,
    this.initialPage = 0,
    this.paginator = true,
    this.labelPage = 'Página',
    this.labelRecords = 'Registros',
    this.labelNoRecords = "Sem registros",
  }) : super(key: key);

  @override
  State<DcDataTable> createState() => _DcDataTableState();
}

class _DcDataTableState extends State<DcDataTable> {
  @override
  void initState() {
    super.initState();

    widget.controller.addListenerUpdateCurrentPage(() {
      setState(() {
        fetchData();
      });
    });

    widget.controller.addListenerUpdateData(() {
      setState(() {});
    });

    widget.controller.addListenerUpdateDataSelected(() {
      setState(() {});
    });

    widget.controller.addListenerUpdateSortColumnIndex(() {
      setState(() {});
    });

    widget.controller.addListenerUpdateSortAscending(() {
      setState(() {});
    });

    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: DataTable(
                    showCheckboxColumn: true,
                    headingTextStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    headingRowColor: MaterialStateColor.resolveWith(
                      (states) => Theme.of(context).colorScheme.primary,
                    ),
                    sortAscending: widget.controller.sortAscending,
                    sortColumnIndex: widget.controller.sortColumnIndex,
                    columns: widget.columns,
                    showBottomBorder: true,
                    rows: _createRows(),
                  ),
                ),
                widget.controller.data.isEmpty
                    ? Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(widget.labelNoRecords,
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)))
                    : const SizedBox(),
                widget.controller.data.isEmpty == false
                    ? DcPaginator(
                        enable: widget.paginator,
                        labelPage: widget.labelPage,
                        labelRecords: widget.labelRecords,
                        pageSize: widget.pageSize,
                        controller: widget.controller,
                        limitPages: widget.limitPages,
                      )
                    : const SizedBox(),
              ],
            )),
      ),

      //paginator
    );
  }

  _createRows() {
    List<DataRow> createRows = [];
    for (int i = 0; i < widget.controller.data.length; i++) {
      createRows.add(widget.controller.getRow(i));
    }

    return createRows;
  }

  Future<void> fetchData() async {
    // showDialog(
    //     context: context,
    //     builder: (context) {
    //       return const Center(
    //         child: CircularProgressIndicator(),
    //       );
    //     });

    setState(() {
      widget.controller.onLoadData();
    });
  }
}
