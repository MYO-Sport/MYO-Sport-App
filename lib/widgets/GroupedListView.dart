// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
typedef TGroup GroupFunction<TElement, TGroup>(TElement element);
typedef Widget ListBuilderFunction<TElement>(BuildContext context, TElement element);
typedef Widget GroupBuilderFunction<TGroup>(BuildContext context, TGroup group);

class GroupedListView<TElement, TGroup> extends StatelessWidget {

  final List<TElement> collection;
  final GroupFunction<TElement, TGroup> groupBy;
  final ListBuilderFunction<TElement> listBuilder;
  final GroupBuilderFunction<TGroup> groupBuilder;

  final List<dynamic> _flattenedList = [];

  GroupedListView(
      {
        required this.collection,
        required this.groupBy,
        required this.listBuilder,
        required this.groupBuilder}) {

    _flattenedList.addAll(Grouper<TElement, TGroup>().groupList(collection, groupBy));
    print('Flattered List: '+_flattenedList.toString());
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      reverse: true,
      itemBuilder: (context, index) {
        var element = _flattenedList[index];
        if (element is TElement) {
          return listBuilder(context, element);
        }
        return groupBuilder(context, element);
      },
      itemCount: _flattenedList.length,
    );
  }
}

class Grouper<TElement, TGroup> {
  final Map<TGroup, List<TElement>> _groupedList = {};

  List<dynamic> groupList(List<TElement> collection, GroupFunction<TElement, TGroup> groupBy) {
  
    if (collection == null) throw ArgumentError("Collection can not be null");
    if (groupBy == null) throw ArgumentError("GroupBy function can not be null");

    List flattenedList = [];
    collection.forEach((element) {
      var key = groupBy(element);
      if (!_groupedList.containsKey(key)) {
        _groupedList[key] = [];
      }
      _groupedList[key]!.add(element);
    });
    _groupedList.forEach((key, list) {
      flattenedList.addAll(list);
      flattenedList.add(key);
    });
    return flattenedList;
  }
}