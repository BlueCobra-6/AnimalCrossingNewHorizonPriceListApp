import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  static const String _title = 'Flutter Code Sample';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
        home: new ListAnimalPage(title: 'Animal Crossing'),
    );
  }
}

class ListAnimalPage extends StatefulWidget {
  ListAnimalPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ListPersonPageState createState() => _ListPersonPageState();
}

class _ListPersonPageState extends State<ListAnimalPage> {
  TextEditingController searchController = new TextEditingController();

  List<Animal> allAnimals = Animal.getAnimals();
  List<Animal> filteredAnimals = List<Animal>();
  List<Animal> searchedAnimals = List<Animal>();

  String searchFilter = "";
  List<AnimalType> _typeFilters = <AnimalType>[];

  bool _sortAsc;
  int _sortColumnIndex;

  bool advancedFilterVisibility;

  @override
  void initState() {
    _sortAsc = true;
    _sortColumnIndex = 0;
    advancedFilterVisibility = false;
    filteredAnimals.addAll(allAnimals);
    searchedAnimals.addAll(allAnimals);
    _typeFilters.addAll(AnimalType.values);
    searchedAnimals.sort((a, b) => a.name.compareTo(b.name));
    super.initState();
  }

  void updateFilter(AnimalType type, bool add) {
    if (add) {
      _typeFilters.add(type);
    } else {
      _typeFilters.removeWhere((AnimalType t) {
        return t == type;
      });
    }
  }

  void filterResults() {
    filteredAnimals = allAnimals.where((i) => _typeFilters.contains(i.type)).toList();
  }

  void searchResults() {
    if (searchFilter.isNotEmpty) {
      searchedAnimals = filteredAnimals.where((i) =>
          i.name.toLowerCase().contains(searchFilter)).toList();
    } else {
      searchedAnimals = filteredAnimals.where((i) => true).toList();
    }
  }

  void sortResults() {
    switch (_sortColumnIndex) {
      case 0:
        if(_sortAsc) {
          searchedAnimals.sort((a, b) => a.name.compareTo(b.name));
        } else {
          searchedAnimals.sort((a, b) => b.name.compareTo(a.name));
        }
        break;
      case 1:
        if(_sortAsc) {
          searchedAnimals.sort((a, b) => a.price.compareTo(b.price));
        } else {
          searchedAnimals.sort((a, b) => b.price.compareTo(a.price));
        }
        break;
      case 2:
        if(_sortAsc) {
          searchedAnimals.sort((a, b) => a.type.index.compareTo(b.type.index));
        } else {
          searchedAnimals.sort((a, b) => b.type.index.compareTo(a.type.index));
        }
        break;
    }
  }

  void filterSearchAndSortResults() {
    filterResults();
    searchResults();
    sortResults();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          searchFilter = value;
                          filterSearchAndSortResults();
                        });
                      },
                      controller: searchController,
                      decoration: InputDecoration(
                          labelText: "Search",
                          hintText: "Search",
                          prefixIcon: Icon(Icons.search),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(25.0)))),
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () {
                      setState(() {
                        advancedFilterVisibility = !advancedFilterVisibility;
                      });
                    },
                    icon: Icon(Icons.filter_list, size: 18),
                    label: Text("FILTER"),
                  ),
                ]
              )
            ),
            Visibility(
              visible: advancedFilterVisibility,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Type"),
                        ),
                        FilterChip(
                          label: Text("Bug"),
                          selected: _typeFilters.contains(AnimalType.bug),
                          onSelected: (bool value) {
                            setState(() {
                              updateFilter(AnimalType.bug, value);
                              filterSearchAndSortResults();
                            });
                          },
                        ),
                        FilterChip(
                          label: Text("Fish"),
                          selected: _typeFilters.contains(AnimalType.fish),
                          onSelected: (bool value) {
                            setState(() {
                              updateFilter(AnimalType.fish, value);
                              filterSearchAndSortResults();
                            });
                          },
                        ),
                        FilterChip(
                          label: Text("Sea"),
                          selected: _typeFilters.contains(AnimalType.sea),
                          onSelected: (bool value) {
                            setState(() {
                              updateFilter(AnimalType.sea, value);
                              filterSearchAndSortResults();
                            });
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: DataTable(
                  sortAscending: _sortAsc,
                  sortColumnIndex: _sortColumnIndex,
                  columns: [
                    DataColumn(
                      label: Text("Icon", style: TextStyle(fontSize: 16)),
                      numeric: false,
                    ),
                    DataColumn(
                      label: Text("Name", style: TextStyle(fontSize: 16)),
                      numeric: false,
                      onSort: (columnIndex, sortAscending) {
                        setState(() {
                          if (columnIndex == _sortColumnIndex) {
                            _sortAsc = sortAscending;
                          } else {
                            _sortColumnIndex = columnIndex;
                            _sortAsc = true;
                          }
                          filterSearchAndSortResults();
                        });
                      },
                    ),
                    DataColumn(
                      label: Text("Price", style: TextStyle(fontSize: 16)),
                      numeric: true,
                      onSort: (columnIndex, sortAscending) {
                        setState(() {
                          if (columnIndex == _sortColumnIndex) {
                            _sortAsc = sortAscending;
                          } else {
                            _sortColumnIndex = columnIndex;
                            _sortAsc = true;
                          }
                          filterSearchAndSortResults();
                        });
                      },
                    ),
                    DataColumn(
                      label: Text("Type", style: TextStyle(fontSize: 16)),
                      numeric: false,
                      onSort: (columnIndex, sortAscending) {
                        setState(() {
                          if (columnIndex == _sortColumnIndex) {
                            _sortAsc = sortAscending;
                          } else {
                            _sortColumnIndex = columnIndex;
                            _sortAsc = true;
                          }
                          filterSearchAndSortResults();
                        });
                      },
                    ),
                  ],
                  rows: searchedAnimals
                      .map(
                        (avenger) => DataRow(
    //                    selected: selectedAvengers.contains(avenger),
                        cells: [
                          DataCell(
                            avenger.icon,
                          ),
                          DataCell(
                            Text(avenger.name),
    //                        onTap: () {
    //                          print('Selected ${avenger.name}');
    //                        },
                          ),
                          DataCell(
                            Text(avenger.price.toString()),
                          ),
                          DataCell(
                            Text(avenger.type.toShortString()),
                          ),
                        ]),
                  )
                      .toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class Animal {
  Image icon;
  String iconName;
  String name;
  int price;
  AnimalType type;
  DatesAvailable datesAvailable;

  Animal({this.iconName, this.name, this.price, this.type}) {
    this.icon = Image(image: AssetImage(this.iconName));
  }

  static List<Animal> getAnimals() {
    return <Animal>[
      Animal(iconName: 'images/Fish6.png', name: "Koi", price: 4000, type: AnimalType.fish),
      Animal(iconName: 'images/Ins12.png',name: "Wasp", price: 2500, type: AnimalType.bug),
      Animal(iconName: 'images/Hitode.png',name: "Sea Star", price: 500, type: AnimalType.sea),
      Animal(iconName: 'images/Namako.png',name: "Sea Cucumber", price: 500, type: AnimalType.sea),
      Animal(iconName: 'images/Fish1.png',name: "Carp", price: 300, type: AnimalType.fish),
      Animal(iconName: 'images/Fish2.png',name: "Dace", price: 240, type: AnimalType.fish),
      Animal(iconName: 'images/Fish3.png',name: "Crucian Carp", price: 160, type: AnimalType.fish),
      Animal(iconName: 'images/Fish5.png',name: "Pale Chub", price: 160, type: AnimalType.fish),
      Animal(iconName: 'images/Fish7.png',name: "Bitterling", price: 900, type: AnimalType.fish),
      Animal(iconName: 'images/Fish8.png',name: "Goldfish", price: 1300, type: AnimalType.fish),
      Animal(iconName: 'images/Fish9.png',name: "Pop-eyed Goldfish", price: 1300, type: AnimalType.fish),
      Animal(iconName: 'images/Fish10.png',name: "Ranchu Goldfish", price: 4500, type: AnimalType.fish),
      Animal(iconName: 'images/Fish11.png',name: "Killifish", price: 300, type: AnimalType.fish),
      Animal(iconName: 'images/Fish12.png',name: "Crawfish", price: 200, type: AnimalType.fish),
      Animal(iconName: 'images/Fish13.png',name: "Soft-shelled Turtle", price: 3750, type: AnimalType.fish),
      Animal(iconName: 'images/Fish14.png',name: "Snapping Turtle", price: 5000, type: AnimalType.fish),
      Animal(iconName: 'images/Fish64.png', name: "Tadpole", price: 100, type: AnimalType.fish),
      Animal(iconName: 'images/Fish16.png',name: "Frog", price: 120, type: AnimalType.fish),
      Animal(iconName: 'images/Fish17.png',name: "Freshwater Goby", price: 400, type: AnimalType.fish),
      Animal(iconName: 'images/Fish18.png',name: "Loach", price: 400, type: AnimalType.fish),
      Animal(iconName: 'images/Fish19.png',name: "Catfish", price: 800, type: AnimalType.fish),
      Animal(iconName: 'images/Fish20.png',name: "Giant Snakehead", price: 5500, type: AnimalType.fish),
      Animal(iconName: 'images/Fish21.png',name: "Bluegill", price: 180, type: AnimalType.fish),
    ];
  }
}

enum AnimalType {
  bug,
  fish,
  sea,
}

class DatesAvailable {
  DateTimeRange january;
  DateTimeRange february;
  DateTimeRange march;
  DateTimeRange april;
  DateTimeRange may;
  DateTimeRange june;
  DateTimeRange july;
  DateTimeRange august;
  DateTimeRange september;
  DateTimeRange october;
  DateTimeRange november;
  DateTimeRange december;
}

extension ParseToString on AnimalType {
  String toShortString() {
    return this.toString().split('.').last;
  }
}