import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterchatdemo/chatRoom/index.dart';
import 'package:flutterchatdemo/constants/constants.dart';
import 'package:flutterchatdemo/search/index.dart';
import 'package:flutterchatdemo/validator/validator.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({
    Key key,
    @required SearchBloc searchBloc,
  })  : _searchBloc = searchBloc,
        super(key: key);

  SearchBloc _searchBloc;

  @override
  SearchScreenState createState() {
    return SearchScreenState();
  }
}

class SearchScreenState extends State<SearchScreen> {
  SearchScreenState();
  Validators validators;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              child: Column(
                children: <Widget>[
                  Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                              child: TextField(
                            controller: searchController,
                            decoration:
                                InputDecoration(hintText: "Search User"),
                          )),
                          GestureDetector(
                              onTap: () {
                                widget._searchBloc.add(SearchBtnEvent(
                                    query: searchController.text));
                                print("Search Pressed");
                              },
                              child: Icon(
                                Icons.search,
                              ))
                        ],
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  Divider(),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
            BlocListener<SearchBloc, SearchState>(
              bloc: widget._searchBloc,
              listener: (context, state) {
                if (state is SearchMsgtoChatState) {
                  navigateTopage(context, ChatRoomPage());
                }
              },
              child: BlocBuilder<SearchBloc, SearchState>(
                  bloc: widget._searchBloc,
                  builder: (
                    BuildContext context,
                    SearchState currentState,
                  ) {
                    if (currentState is SearchInitialState) {
                      return searchInitialWidget();
                    }
                    if (currentState is SearchingState) {
                      return searchingWidget();
                    }
                    if (currentState is SearchFailureState) {
                      return searchFailedWidget();
                    }
                    if (currentState is SearchSuccesState) {
                      return searchSuccesWidget(
                          currentState.querySnap, widget._searchBloc);
                    }
                    if (currentState is SearchMsgtoChatState) {
                      return Container();
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }

  Widget SearchList(QuerySnapshot querySnap, searchBloc) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: querySnap.documents.length,
        itemBuilder: (context, index) {
          return SearchTile(
            searchBloc: searchBloc,
            userName: querySnap.documents[index].data["name"],
            userEmail: querySnap.documents[index].data["email"],
          );
        });
  }

  Widget searchInitialWidget() {
    return Text("Search User");
  }

  Widget searchingWidget() {
    // userDataBase.getUserByUserName(searchController.text).than((val) {
    //   setState(() {
    //     searchSnapshot = val;
    //   });
    // });
    return CircularProgressIndicator();
  }

  Widget searchFailedWidget() {
    return Center(child: Text("No User Found"));
  }

  Widget searchSuccesWidget(QuerySnapshot querySnap, searchBloc) {
    print(querySnap.documents.toString());
    return querySnap != null
        ? SearchList(querySnap, searchBloc)
        : Text("No Data found");
  }
}

class SearchTile extends StatelessWidget {
  final String userName;
  final String userEmail;
  final SearchBloc searchBloc;
  const SearchTile({Key key, this.userName, this.userEmail, this.searchBloc})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      width: double.maxFinite,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            children: <Widget>[Text(userName), Text(userEmail)],
          ),
          GestureDetector(
            onTap: () {
              searchBloc.add(SearchMsgBtnPressedEvent(userName: userName));
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                  color: tPrimaryLightColors,
                  borderRadius: BorderRadius.circular(20)),
              child: Text("Message"),
            ),
          )
        ],
      ),
    );
  }
}
