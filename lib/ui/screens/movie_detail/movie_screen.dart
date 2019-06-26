import 'package:flutter/material.dart';
import 'package:flutter_base/ui/screens/movie_detail/tabs/movie_first_tab.dart';
import 'package:flutter_base/ui/screens/movie_detail/tabs/movie_second_tab.dart';
import 'package:flutter_base/ui/screens/movie_detail/tabs/movie_third_tab.dart';
import 'package:flutter_base/utilities/app_colors.dart';
import 'package:flutter_base/utilities/app_dimens.dart';

class MovieScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MovieScreenState();
  }
}

class _MovieScreenState extends State<MovieScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  PageController _pageController = PageController(initialPage: 0);
  var _isPageCanChanged = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(
      length: 3,
      vsync: this,
    );
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        _onPageChange(_tabController.index, p: _pageController);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: PreferredSize(
        child: AppBar(
          title: Text('Movies'),
        ),
        preferredSize: Size.fromHeight(AppDimens.appBarHeight),
      ),
      body: SafeArea(
        child: _buildBodyWidget(),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  ///Build widget
  Widget _buildBodyWidget() {
    return Scaffold(
      body: PageView(
        children: [
          new MovieFirstTab(),
          new MovieSecondTab(),
          new MovieThirdTab(),
        ],
        controller: _pageController,
        onPageChanged: (index) {
          if (_isPageCanChanged) {
            _onPageChange(index);
          }
        },
      ),
      bottomNavigationBar: SafeArea(
        child: TabBar(
          controller: _tabController,
          tabs: [
            _buildTabWidget(Icon(Icons.home), 'First'),
            _buildTabWidget(Icon(Icons.perm_identity), 'Second'),
            _buildTabWidget(Icon(Icons.category), 'Third'),
          ],
          labelColor: AppColors.mainColor,
          labelStyle: TextStyle(
            fontWeight: FontWeight.normal,
          ),
          unselectedLabelColor: Colors.grey,
          indicator: BoxDecoration(color: Colors.transparent),
          labelPadding: EdgeInsets.all(0.0),
          indicatorWeight: 0.0,
        ),
      ),
    );
  }

  Widget _buildTabWidget(Icon icon, String text) {
    return Tab(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.all(2.0),
              decoration: BoxDecoration(
                  border: Border(
                top: BorderSide(color: Colors.grey, width: 0.5),
              )),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  icon,
                  Expanded(
                      child: Center(
                    child: Text(
                      text,
                      style: TextStyle(fontSize: 10.0),
                    ),
                  )),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  ///Controller
  void _onPageChange(int index, {PageController p, TabController t}) async {
    if (p != null) {
      _isPageCanChanged = false;
      await _pageController.animateToPage(index,
          duration: Duration(milliseconds: 200), curve: Curves.ease);
      _isPageCanChanged = true;
    } else {
      _tabController.animateTo(index);
    }
  }
}
