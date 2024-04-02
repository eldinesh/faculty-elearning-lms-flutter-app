import 'package:flutter/material.dart';

class GridPagination extends StatefulWidget {
  const GridPagination({super.key});

  @override
  State<GridPagination> createState() => _GridPaginationState();
}

class _GridPaginationState extends State<GridPagination> {
  List<String> data = List.generate(100, (index) => "Item $index");
  int pageSize = 20;
  int currentPage = 1;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        // When the user reaches the end of the GridView, load the next page
        if (currentPage < (data.length / pageSize).ceil()) {
          setState(() {
            currentPage++;
          });
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  List<String> getPageData(int currentPage, int pageSize) {
    int startIndex = (currentPage - 1) * pageSize;
    int endIndex = startIndex + pageSize;
    return data.sublist(startIndex, endIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("GridView Pagination"),
      ),
      body: Column(
        children: [
          Expanded(
            child: GridView.count(
              controller: _scrollController,
              crossAxisCount: 2,
              children: getPageData(currentPage, pageSize).map((item) {
                return Card(
                  child: Center(
                    child: Text(
                      item,
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
