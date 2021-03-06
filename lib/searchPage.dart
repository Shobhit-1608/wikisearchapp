import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wikisearchapp/widgets/shimmerImage.dart';
import 'package:wikisearchapp/wiki_model/wikiservice.dart';

import 'diff_services/nextPage.dart';
import 'diff_services/searchListGenerate.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  CatalogService catalogService = CatalogService();
  WikiModel results = WikiModel();
  final _searchController = TextEditingController();
  String query = '';

  void searchWiki(String query) async {
    var infoData = await catalogService.searchWiki(query);
    WikiModel infoFetched = WikiModel.fromJson(infoData);
    setState(() {
      results = infoFetched;
    });
  }

  @override
  Widget build(BuildContext context) {
    var searchResultData = results.query;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        textTheme: Theme.of(context).textTheme,
        toolbarHeight: 175.0,
        elevation: 0.0,
        bottom: PreferredSize(
          child: Column(
            children: [
              ListTile(
                leading: InkWell(
                  child: SvgPicture.asset('assets/images/Back.svg'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                title: Text(
                  "Search...",
                  style: TextStyle(
                    fontSize: 30.0,
                    color: Color(0xff5E56E7),
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  textInputAction: TextInputAction.search,
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search',
                    hintStyle: TextStyle(
                      color: Color(0xFFA0A0A0),
                    ),
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Theme.of(context).accentColor),
                    ),
                    filled: true,
                    fillColor: Color(0xFFF0F0F6),
                    focusColor: Color(0xFFF0F0F6),
                    prefixIcon: Hero(
                      tag: 'search',
                      child: SvgPicture.asset(
                        'assets/images/Search.svg',
                        fit: BoxFit.none,
                      ),
                    ),
                    suffixIcon: query.isNotEmpty
                        ? InkWell(
                            child: SvgPicture.asset(
                              'assets/images/Cancel.svg',
                              fit: BoxFit.none,
                            ),
                            onTap: () {
                              _searchController.clear();
                              setState(() {
                                query = '';
                              });
                              // searchBooks();
                            },
                          )
                        : null,
                  ),
                  onChanged: (value) {
                    setState(() {
                      // results.clear();
                      query = '';
                      query = value;
                    });
                    query.isEmpty ? print('Empty') : searchWiki(query);
                    // query.isEmpty ? print('Empty') : print(query);
                  },
                  onSubmitted: (value) {
                    setState(() {
                      // results.clear();
                      query = value;
                    });
                    query.isEmpty ? print('Empty') : searchWiki(query);
                    // query.isEmpty ? print('Empty') : print(query);
                  },
                ),
              ),
            ],
          ),
          preferredSize: Size.fromHeight(175),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
            height: height * 0.7,
            child: query.isNotEmpty
                ? results.query != null
                    ? ListView.builder(
                        shrinkWrap: true,
                        itemCount: results.query!.pages!.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(10),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: ListTile(
                                  onTap: () {
                                    launchURL(
                                      searchResultData!.pages![index].url,
                                    );
                                  },
                                  tileColor: Colors.white,
                                  contentPadding: EdgeInsets.all(12),
                                  leading: searchResultData!
                                              .pages![index].thumbnail !=
                                          null
                                      ? searchResultData.pages![index] != null
                                          ? CacheImage(
                                              url: searchResultData
                                                  .pages![index]
                                                  .thumbnail!
                                                  .source,
                                            )
                                          : Image.asset(
                                              'assets/images/wiki.png')
                                      : Image.asset('assets/images/wiki.png'),
                                  subtitle: Text(
                                    searchResultData.pages![index].terms != null
                                        ? searchResultData.pages![index].terms!
                                            .description![0]
                                        : "Description not available",
                                  ),
                                  title: Text(
                                    results.query!.pages![index].title,
                                    style:
                                        Theme.of(context).textTheme.headline6,
                                  ),
                                  isThreeLine: true,
                                ),
                              ),
                            ),
                          );
                        })
                    : Center(
                        child: CircularProgressIndicator(),
                      )
                : Center(
                    child: Container(
                        child: Column(
                      children: [
                        Image.asset(
                          'assets/images/wikipedia.png',
                          width: 200,
                          height: 200,
                        ),
                        Text('not found'),
                      ],
                    )),
                  )),
      ),

    );
  }
}
