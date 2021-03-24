import 'package:flutter/material.dart';
import 'package:flutter_demo2/screen/account/account_page.dart';
import 'package:flutter_demo2/screen/homePage/cupertino_home_scaffold.dart';
import 'package:flutter_demo2/screen/homePage/tab_item.dart';

import 'jobs/job_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  TabItem _currentTab = TabItem.jobs ;

  Map<TabItem , WidgetBuilder> get widgetBuilder {
    return {
      TabItem.jobs: (_) => JobsPage() ,
      TabItem.entries :(_) => Container() ,
      TabItem.account :(_) => AccountPage() ,
    };
  }

  void _select (TabItem tabItem)
  {
    setState(() {
      _currentTab = tabItem ;
    });
  }
  @override
  Widget build(BuildContext context) {
    return CupertinoHomeScaffold(
      currentTab: _currentTab,
      onSelectedTab: _select,
      widgetBuilders: widgetBuilder,
    );
  }
}
