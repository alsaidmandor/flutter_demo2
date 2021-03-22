import 'package:flutter/material.dart';
import 'package:flutter_demo2/screen/homePage/empty_content.dart';

typedef ItemWidgetBuilder<T> = Widget Function(BuildContext context, T item);

/*
* ListItemBuilder
* - Handles different Ui states
* - works with different data types
* {the Builder pattern }
*  -- Great for writing reusable code
* - Used widely in flutter
* */
class ListItemBuilder<T> extends StatelessWidget {
  ListItemBuilder({
    @required this.snapshot,
    @required this.itemBuilder,
  });

  final AsyncSnapshot<List<T>> snapshot;

  final ItemWidgetBuilder<T> itemBuilder;

  @override
  Widget build(BuildContext context) {
    if (snapshot.hasData) {
      final List<T> items = snapshot.data;
      if (items.isNotEmpty) {
        return _buildList(items);
      } else {
        return EmptyContent();
      }
    } else if (snapshot.hasError) {
      return EmptyContent(
        title: 'Something went wrong',
        message: 'can\'t load items right now',
      );
    }
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildList(List<T> items) {
    return ListView.separated(
        itemCount: items.length + 2,
        separatorBuilder: (context, index) => Divider(height: 0.5,),
        itemBuilder: (context, index) {
          if(index == 0 || index == items.length + 1)
            {
              return Container() ;
            }
          return itemBuilder(context, items[index -1]);
        });
  }
}
