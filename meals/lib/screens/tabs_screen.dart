import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/screens/categories_screen.dart';
import 'package:meals/screens/favorites_screen.dart';
import 'package:meals/widgets/main_drawer.dart';

class TabsScreen extends StatefulWidget {
  final List<Meal> favoriteMeals;
  TabsScreen(this.favoriteMeals);

  _TabsScreenState createState() => _TabsScreenState();
}

// class _TabsScreenState extends State<TabsScreen> { //using DefaultTabController ie. in Tab bar top
//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 2,
//       initialIndex: 0,
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text('Meals'),
//           bottom: TabBar(
//             tabs: <Widget>[
//               Tab(
//                 icon: Icon(Icons.category),
//                 text: 'Categories',
//               ),
//               Tab(icon: Icon(Icons.star), text: 'Favorites,')
//             ],
//           ),
//         ),
//         body: TabBarView(
//           children: <Widget>[CategoriesScreen(), FavoritesScreen()],
//         ),
//       ),
//     );
//   }
// }

class _TabsScreenState extends State<TabsScreen> {
  List<Map<String, Object>> _pages;
  int _selectedPageIndex = 0;
  @override
  void initState() {
    super.initState();
    _pages = [
      {"page": CategoriesScreen(), "title": "Categories"},
      {"page": FavoritesScreen(widget.favoriteMeals), "title": "Favorites"}
    ];
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    //For bottom Nav Bar need to use Stateful
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          title: Text(_pages[_selectedPageIndex]["title"]),
        ),
        drawer: MainDrawer(),
        body: _pages[_selectedPageIndex]["page"],
        bottomNavigationBar: BottomNavigationBar(
            onTap: _selectPage,
            backgroundColor: Theme.of(context).primaryColor,
            unselectedItemColor: Colors.white,
            selectedItemColor: Theme.of(context).accentColor,
            currentIndex: _selectedPageIndex,
            // type: BottomNavigationBarType.shifting,
            items: [
              BottomNavigationBarItem(
                  // backgroundColor: Theme.of(context).primaryColor,
                  icon: Icon(Icons.category),
                  title: Text('Categories')),
              BottomNavigationBarItem(
                  // backgroundColor: Theme.of(context).primaryColor,
                  icon: Icon(Icons.star),
                  title: Text('Favorites')),
            ]),
      ),
    );
  }
}
