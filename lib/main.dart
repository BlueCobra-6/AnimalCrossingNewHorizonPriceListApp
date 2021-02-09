import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  static const String _title = 'Animal Crossing Price List';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
        home: new ListAnimalPage(title: _title),
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
  Future<List<Animal>> _future;
  TextEditingController searchController = new TextEditingController();

  List<Animal> allAnimals = List<Animal>();
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

    _future = fetchAnimals(context);
    _typeFilters.addAll(AnimalType.values);
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
      case 1:
        if(_sortAsc) {
          searchedAnimals.sort((a, b) => a.name.compareTo(b.name));
        } else {
          searchedAnimals.sort((a, b) => b.name.compareTo(a.name));
        }
        break;
      case 2:
        if(_sortAsc) {
          searchedAnimals.sort((a, b) => a.price.compareTo(b.price));
        } else {
          searchedAnimals.sort((a, b) => b.price.compareTo(a.price));
        }
        break;
      case 3:
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

  Future<List<Animal>> fetchAnimals(BuildContext context) async {
    final data = await DefaultAssetBundle
        .of(context)
        .loadString('data/data.json');
    print("fetched animal data");

    return compute(parseAnimals, data);
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
                          label: Text("Insect"),
                          selected: _typeFilters.contains(AnimalType.insect),
                          onSelected: (bool value) {
                            setState(() {
                              updateFilter(AnimalType.insect, value);
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
                child: FutureBuilder(
                  future: _future,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      print(snapshot.error);
                    }

                    if(!snapshot.hasData) {
                      return Center(child: CircularProgressIndicator());
                    }

                    if(snapshot.hasData) {
                      allAnimals = snapshot.data;
                      filterSearchAndSortResults();
                      return DataTable(
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
                      );
                    }

                    return Center();
                  }
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
  String iconFilename;
  String name;
  int price;
  AnimalType type;
  DatesAvailable datesAvailable;

  Animal({this.iconFilename, this.name, this.price, this.type}) {
    this.icon = Image(image: AssetImage('images/' + this.iconFilename + '.png'));
  }

  Animal.fromJson(Map<String, dynamic> json)
      : iconFilename = json['iconFilename'],
        name = json['name'],
        price = json['price'],
        type = parseAnimalType(json['type'])
  {
    this.icon = Image(image: AssetImage('images/' + this.iconFilename + '.png'));
  }

  Map<String, dynamic> toJson() =>
  {
    'iconFilename': iconFilename,
    'name': name,
    'price': price,
    'type': type,
  };
}

enum AnimalType {
  other,
  insect,
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

AnimalType parseAnimalType(String type) {
  switch (type) {
    case "insect":
      return AnimalType.insect;
    case "sea":
      return AnimalType.sea;
    case "fish":
      return AnimalType.fish;
    default:
      return AnimalType.other;
  }
}

List<Animal> parseAnimals(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Animal>((json) => Animal.fromJson(json)).toList();
}