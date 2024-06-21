import 'package:flutter/material.dart';
import 'package:jny_library_showcase/services/local/functions/shared_prefs_functions.dart';
import 'package:jny_library_showcase/services/local/jsons/book_json.dart';
import 'package:jny_library_showcase/services/local/jsons/borrowed_books_json.dart';
import 'package:jny_library_showcase/services/local/jsons/library_member_json.dart';
import 'package:jny_library_showcase/services/network/pocket_base_config.dart';
import 'package:jny_library_showcase/view_pages/showcase_view_page.dart';
import 'package:pocketbase/pocketbase.dart';

class ShowcasePage extends StatefulWidget {
  const ShowcasePage({super.key});

  @override
  State<ShowcasePage> createState() => ShowcasePageController();
}

class ShowcasePageController extends State<ShowcasePage> {
  String currentState = "NONE";

  PocketBase pb = PocketBaseConfig.pb;

  LibraryMemberData libraryMemberData = LibraryMemberData();

  List<BookDataJson> bookDataList = [];

  List<BorrowedDetailDataJson> borrowedDetailList = [];
  List<BorrowedDetailDataJson> borrowHistoryList = [];
  List<BorrowedBooksDataJson> borrowedBookList = [];

  List<Map<bool, BorrowedBooksDataJson>> returnedBookList = [];

  BookDataJson? bookData;

  @override
  void initState() {
    super.initState();

    checkIfIDAssigned();
  }

  checkIfIDAssigned() async {
    await SharedPrefsFunctions.readData('pairingID').then((idResult) {
      if(idResult != null) {
        pb.collection("testing").getOne(idResult).then((collectionResult) {
          setState(() {
            currentState = collectionResult.data['state'];
          });
        });

        listenState();
      }
    });
  }

  listenState() async {
    await pb.collection("testing").subscribe("*", (e) {
      LibraryMemberData tempLibraryMemberData = LibraryMemberData();

      List<BookDataJson> tempBookList = [];

      List<BorrowedDetailDataJson> tempBorrowedDetailList = [];
      List<BorrowedBooksDataJson> tempBorrowedBookList = [];

      List<Map<bool, BorrowedBooksDataJson>> tempReturnedBookList = [];

      List<BorrowedDetailDataJson> tempBorrowHistoryList = [];

      BookDataJson? tempBookData;

      if(e.record!.data['args'] != null) {
        if(e.record!.data['args']['library_member'] != null && e.record!.data['args']['library_member'] != {}) {
          tempLibraryMemberData = LibraryMemberData.fromJson(e.record!.data['args']['library_member']);
        }

        if(e.record!.data['state'] == "READ_RFID") {
          if(e.record!.data['args']['book_list'] != null && e.record!.data['args']['book_list'] != {}) {
            for(int i = 0; i < e.record!.data['args']['book_list'].length; i++) {
              tempBookList.add(BookDataJson.fromJson(e.record!.data['args']['book_list'][i]));
            }
          }
        } else if(e.record!.data['state'] == "SHOW_BOOK_DETAIL") {
          if(e.record!.data['args']['book_list'] != null && e.record!.data['args']['book_list'] != {}) {
            tempBookData = BookDataJson.fromJson(e.record!.data['args']['book_list']);
          }
        } else if(e.record!.data['state'] == "SHOW_RETURN" || e.record!.data['state'] == "SHOW_RENEW" || e.record!.data['state'] == "SHOW_BORROWED") {
          if(e.record!.data['args']['book_list'] != null && e.record!.data['args']['book_list'] != {}) {
            for(int i = 0; i < e.record!.data['args']['book_list'].length; i++) {
              tempBorrowedDetailList.add(BorrowedDetailDataJson.fromJson(e.record!.data['args']['book_list'][i]));
            }
          }

          if(e.record!.data['state'] == "SHOW_BORROWED") {
            if(e.record!.data['args']['history'] != null) {
              for(int i  = 0; i < e.record!.data['args']['history'].length; i++) {
                tempBorrowHistoryList.add(BorrowedDetailDataJson.fromJson(e.record!.data['args']['history'][i]));
              }
            }
          }
        } else if(e.record!.data['state'] == "SHOW_RETURN_LIST") {
          if(e.record!.data['args']['book_list'] != null && e.record!.data['args']['book_list'] != {}) {
            for(int i = 0; i < e.record!.data['args']['book_list'].length; i++) {
              tempReturnedBookList.add({
                e.record!.data['args']['book_list'][i]['scanned']: BorrowedBooksDataJson.fromJson(e.record!.data['args']['book_list'][i]['book_data'])
              });
            }
          }
        } else if(e.record!.data['state'] == "SHOW_RENEW_LIST" || e.record!.data['state'] == "SHOW_BORROWED_LIST") {
          if(e.record!.data['args']['book_list'] != null && e.record!.data['args']['book_list'] != {}) {
            for(int i = 0; i < e.record!.data['args']['book_list'].length; i++) {
              tempBorrowedBookList.add(BorrowedBooksDataJson.fromJson(e.record!.data['args']['book_list'][i]));
            }
          }
        }
      }

      setState(() {
        currentState = e.record!.data['state'];

        libraryMemberData = tempLibraryMemberData;

        bookDataList = tempBookList;

        borrowedDetailList = tempBorrowedDetailList;
        borrowedBookList = tempBorrowedBookList;

        returnedBookList = tempReturnedBookList;

        borrowHistoryList = tempBorrowHistoryList;

        bookData = tempBookData;
      });
    });
  }

  stopListen() async {
    await pb.collection("testing").unsubscribe("*");
  }

  @override
  Widget build(BuildContext context) {
    return ShowcaseViewPage(controller: this);
  }

  @override
  void dispose() {
    stopListen();

    super.dispose();
  }
}