import 'package:flutter/material.dart';

import 'package:dc_datatable_paginator/dc_datatable.dart';

import 'dc_datatable_paged.dart';
import 'dc_datatable_paginator.dart';

class DcDataTable extends StatelessWidget {
  final int pageSize;
  final bool paginator;
  final String labelPage;
  final String labelRecords;
  final String labelNoRecords;
  final DcDataTableSource source;

  const DcDataTable({
    Key? key,
    this.pageSize = 10,
    this.paginator = true,
    this.labelPage = 'Página',
    this.labelRecords = 'Registros',
    this.labelNoRecords = "Sem registros",
    required this.source,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    source.load();

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
                    sortAscending: source.sortAscending,
                    sortColumnIndex: source.sortColumnIndex,
                    columns: source.columns,
                    showBottomBorder: true,
                    rows: source.rows,
                  ),
                ),
                //source.hasData() ? const SizedBox() : Text(labelNoRecords),
                DcDataTablePaginator(
                  enable: paginator,
                  labelPage: labelPage,
                  labelRecords: labelRecords,
                  pageSize: pageSize,
                  initialPage: source.currentPage,
                  totalRecords: source.totalRecords,
                  controller: source,
                ),
              ],
            )),
      ),

      //paginator
    );
  }
}
