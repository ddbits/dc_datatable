import 'package:flutter/material.dart';
import '../dc_datatable.dart';

class DcDataTablePaginator extends StatelessWidget {
  final bool enable;
  final int pageSize;
  final int initialPage;
  final int totalRecords;
  final int limitPages;
  final String labelPage;
  final String labelRecords;
  final DcDataTableSource controller;

  const DcDataTablePaginator({
    Key? key,
    this.pageSize = 10,
    this.totalRecords = 0,
    this.limitPages = 10,
    this.enable = false,
    this.labelPage = 'Page',
    this.labelRecords = 'Records',
    this.initialPage = 1,
    required this.controller,
  }) : super(key: key);

  int get maxPageSize => (totalRecords / pageSize).ceil();

  @override
  Widget build(BuildContext context) {
    //
    if (enable == false) return Container();

    return Container(
      margin: const EdgeInsets.all(10.0),
      child: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Column(
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DcDatableButton(
                  onPressed: controller.currentPage != 0 ? _first : null,
                  child: const Icon(Icons.first_page),
                ),
                DcDatableButton(
                  onPressed: controller.currentPage > 0 ? _prev : null,
                  child: const Icon(Icons.chevron_left),
                ),
                ..._generateButtonList(),
                DcDatableButton(
                  onPressed:
                      controller.currentPage + 1 >= maxPageSize ? null : _next,
                  child: const Icon(Icons.chevron_right),
                ),
                DcDatableButton(
                  onPressed: (controller.currentPage != maxPageSize - 1)
                      ? _last
                      : null,
                  child: const Icon(Icons.last_page),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                  '$labelRecords: $totalRecords   $labelPage: ${controller.currentPage + 1}/$maxPageSize',
                  style: const TextStyle(fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }

  _first() {
    controller.currentPage = 0;

    // onPageChange?.call(controller.currentPage);
  }

  _last() {
    controller.currentPage = maxPageSize - 1;
    // onPageChange?.call(controller.currentPage);
  }

  _prev() {
    controller.currentPage--;
    // onPageChange?.call(controller.currentPage);
  }

  _next() {
    controller.currentPage++;
    //   onPageChange?.call(controller.currentPage);
  }

  _navigateToPage(int index) {
    index = index;
    controller.currentPage = index;
    //  onPageChange?.call(index);
  }

  List<Widget> _generateButtonList() {
    List<Widget> buttons = [];

    int pageSize = limitPages;
    int pageStart = 0;
    int pageEnd = maxPageSize;
    int currentPage = controller.currentPage + 1;

    if (limitPages < maxPageSize) {
      int group = (currentPage / pageSize).ceil();
      if (group == 0) group = 1;
      int limiteFim = (group * pageSize);
      int pageStart = (limiteFim - pageSize);
      int pageEnd = limiteFim;

      if (pageEnd > maxPageSize) pageEnd = maxPageSize;

      for (int x = pageStart; x < pageEnd; x++) {
        buttons.add(_buildPageButton(x));
      }
    } else {
      for (int x = pageStart; x < pageEnd; x++) {
        buttons.add(_buildPageButton(x));
      }
    }

    return buttons;
  }

  
  Widget _buildPageButton(int index) => DcDatableButton(
        onPressed: () => _navigateToPage(index),
        selected: _selected(index),
        child: Text((index + 1).toString(),
            maxLines: 1,
            style: TextStyle(
                color: _selected(index) ? Colors.white : Colors.black87)),
      );

  
  bool _selected(index) => index == controller.currentPage;
}
