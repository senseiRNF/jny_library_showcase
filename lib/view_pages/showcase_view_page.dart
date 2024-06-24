import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jny_library_showcase/controllers/showcase_page_controller.dart';
import 'package:jny_library_showcase/services/local/jsons/borrowed_books_json.dart';

class ShowcaseViewPage extends StatelessWidget {
  final ShowcasePageController controller;

  const ShowcaseViewPage({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: controller.currentState != "NONE" ?
        controller.currentState == "IDLE" ?
        CarouselSlider(
          options: CarouselOptions(
            height: MediaQuery.of(context).size.height,
            viewportFraction: 1.0,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 10),
            autoPlayAnimationDuration: const Duration(seconds: 2),
            autoPlayCurve: Curves.easeInOut,
            enlargeCenterPage: true,
            scrollPhysics: const NeverScrollableScrollPhysics(),
          ),
          items: [
            Image.asset(
              "assets/images/ss_1_ls.png",
              fit: BoxFit.cover,
            ),
            Image.asset(
              "assets/images/ss_2_ls.png",
              fit: BoxFit.cover,
            ),
            Image.asset(
              "assets/images/tutorial.png",
              fit: BoxFit.cover,
            ),
          ],
        ) :
        controller.currentState == "SCAN_QR" ?
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width / 4,
          ),
          child: Image.asset(
            "assets/images/gifs/scan_qr_code.gif",
            fit: BoxFit.fitWidth,
          ),
        ) :
        controller.currentState == "READ_RFID" ?
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Container(
                color: Theme.of(context).colorScheme.primary,
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black54,
                              ),
                            ),
                            child: CachedNetworkImage(
                              imageUrl: controller.libraryMemberData.photoUrl ?? '',
                              width: MediaQuery.of(context).size.width / 6,
                              fit: BoxFit.contain,
                              errorWidget: (errContext, _, errObj) {
                                return SizedBox(
                                  width: MediaQuery.of(context).size.width / 6,
                                  child: const Icon(
                                    Icons.person,
                                    size: 200.0,
                                    color: Colors.white,
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            controller.libraryMemberData.name ?? '',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w700,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          Text(
                            controller.libraryMemberData.nis ?? controller.libraryMemberData.nik ?? '',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                            ),
                          ),
                          Text(
                            controller.libraryMemberData.className ?? controller.libraryMemberData.email ?? '',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    const Text(
                      "Total Book(s):",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                    ),
                    Text(
                      "${controller.bookDataList.length} Book",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.0),
                    child: Text(
                      "BORROW",
                      style: TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  controller.bookDataList.isNotEmpty ?
                  Expanded(
                    child: ListView.builder(
                      itemCount: controller.bookDataList.length,
                      itemBuilder: (BuildContext listContext, int index) {
                        return Card(
                          elevation: 10.0,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 30.0,
                                  height: 30.0,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).colorScheme.primary,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Center(
                                    child: Text(
                                      "${index + 1}",
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10.0,
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width / 24,
                                  child: CachedNetworkImage(
                                    imageUrl: controller.bookDataList[index].mediaPath ?? '',
                                    fit: BoxFit.contain,
                                    errorWidget: (errContext, _, errObj) {
                                      return SizedBox(
                                        width: MediaQuery.of(context).size.width / 24,
                                        child: Icon(
                                          Icons.book,
                                          size: 40.0,
                                          color: Theme.of(context).colorScheme.primary,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  width: 10.0,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: [
                                      Text(
                                        controller.bookDataList[index].title ?? 'Unknown',
                                        style: const TextStyle(
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10.0,
                                      ),
                                      Text(
                                        "ISBN/ISSN: ${controller.bookDataList[index].isbnOrIssn ?? 'Unknown'}",
                                        style: const TextStyle(
                                          fontSize: 10.0,
                                        ),
                                      ),
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'Authors: ',
                                            style: TextStyle(
                                              fontSize: 10.0,
                                            ),
                                          ),
                                          Text(
                                            controller.bookDataList[index].authorNames ?? 'Unknown',
                                            style: const TextStyle(
                                              fontSize: 10.0,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              'Publisher: ${controller.bookDataList[index].publisher ?? 'Unknown'} ',
                                              style: const TextStyle(
                                                fontSize: 10.0,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                              'Publishing Year: ${controller.bookDataList[index].publishingYear ?? 'Unknown'}',
                                              style: const TextStyle(
                                                fontSize: 10.0,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ) :
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Text(
                            'Place the book in the scanner area to continue',
                            style: TextStyle(
                              fontSize: 28.0,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Expanded(
                          child: Image.asset(
                            'assets/images/gifs/books.gif',
                            fit: BoxFit.contain,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ) :
        controller.currentState == "SHOW_RETURN" || controller.currentState == "SHOW_RENEW" ?
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Container(
                color: Theme.of(context).colorScheme.primary,
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black54,
                        ),
                      ),
                      child: CachedNetworkImage(
                        imageUrl: controller.libraryMemberData.photoUrl ?? '',
                        width: MediaQuery.of(context).size.width / 6,
                        fit: BoxFit.contain,
                        errorWidget: (errContext, _, errObj) {
                          return SizedBox(
                            width: MediaQuery.of(context).size.width / 6,
                            child: const Icon(
                              Icons.person,
                              size: 200.0,
                              color: Colors.white,
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      controller.libraryMemberData.name ?? '',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      controller.libraryMemberData.nis ?? controller.libraryMemberData.nik ?? '',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      ),
                    ),
                    Text(
                      controller.libraryMemberData.className ?? controller.libraryMemberData.email ?? '',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Text(
                      controller.currentState == "SHOW_RETURN" ? "RETURN" : "RENEW",
                      style: const TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  controller.borrowedDetailList.isNotEmpty ?
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.borrowedDetailList.length,
                      itemBuilder: (BuildContext listContext, int index) {
                        return Card(
                          elevation: 10.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  'Borrow Date: ${controller.borrowedDetailList[index].fromDate != null ? DateFormat('EEEE, dd MMMM yyyy').format(DateTime.parse(controller.borrowedDetailList[index].fromDate!)) : "Unknown"}',
                                ),
                                Text(
                                  'Return Date: ${controller.borrowedDetailList[index].untilDate != null ? DateFormat('EEEE, dd MMMM yyyy').format(DateTime.parse(controller.borrowedDetailList[index].untilDate!)) : "Unknown"}',
                                ),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      controller.borrowedDetailList[index].status ?? "-",
                                      style: TextStyle(
                                        color: Theme.of(context).colorScheme.primary,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10.0,
                                    ),
                                    Text(
                                      'Number Of Books Borrowed: ${controller.borrowedDetailList[index].books != null ? controller.borrowedDetailList[index].books!.length : "Unknown"}',
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ) :
                  const Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Currently, no books are being borrowed',
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.w700,
                          ),
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ) :
        controller.currentState == "SHOW_BORROWED" ?
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Container(
                color: Theme.of(context).colorScheme.primary,
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black54,
                        ),
                      ),
                      child: CachedNetworkImage(
                        imageUrl: controller.libraryMemberData.photoUrl ?? '',
                        width: MediaQuery.of(context).size.width / 6,
                        fit: BoxFit.contain,
                        errorWidget: (errContext, _, errObj) {
                          return SizedBox(
                            width: MediaQuery.of(context).size.width / 6,
                            child: const Icon(
                              Icons.person,
                              size: 200.0,
                              color: Colors.white,
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      controller.libraryMemberData.name ?? '',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      controller.libraryMemberData.nis ?? controller.libraryMemberData.nik ?? '',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      ),
                    ),
                    Text(
                      controller.libraryMemberData.className ?? controller.libraryMemberData.email ?? '',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.0),
                    child: Text(
                      "ACCOUNT INFORMATION",
                      style: TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Text(
                                  "BOOKS CURRENTLY BEING BORROWED",
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              controller.borrowedDetailList.isNotEmpty ?
                              Expanded(
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: controller.borrowedDetailList.length < 5 ?
                                  controller.borrowedDetailList.length : 5,
                                  itemBuilder: (BuildContext listContext, int index) {
                                    return Card(
                                      elevation: 10.0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5.0),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.stretch,
                                          children: [
                                            Text(
                                              'Borrow Date: ${controller.borrowedDetailList[index].fromDate != null ? DateFormat('EEEE, dd MMMM yyyy').format(DateTime.parse(controller.borrowedDetailList[index].fromDate!)) : "Unknown"}',
                                            ),
                                            Text(
                                              'Return Date: ${controller.borrowedDetailList[index].untilDate != null ? DateFormat('EEEE, dd MMMM yyyy').format(DateTime.parse(controller.borrowedDetailList[index].untilDate!)) : "Unknown"}',
                                            ),
                                            const SizedBox(
                                              height: 10.0,
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  controller.borrowedDetailList[index].status ?? "-",
                                                  style: TextStyle(
                                                    color: Theme.of(context).colorScheme.primary,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 10.0,
                                                ),
                                                Text(
                                                  'Number Of Books Borrowed: ${controller.borrowedDetailList[index].books != null ? controller.borrowedDetailList[index].books!.length : "Unknown"}',
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ) :
                              const Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    Text(
                                      'Currently, no books are being borrowed',
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w700,
                                      ),
                                      textAlign: TextAlign.center,
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Text(
                                  "BORROW HISTORY",
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              controller.borrowHistoryList.isNotEmpty ?
                              Expanded(
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: controller.borrowHistoryList.length < 5 ?
                                  controller.borrowHistoryList.length : 5,
                                  itemBuilder: (BuildContext listContext, int index) {
                                    return Card(
                                      elevation: 10.0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5.0),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.stretch,
                                          children: [
                                            Text(
                                              'Borrow Date: ${controller.borrowHistoryList[index].fromDate != null ? DateFormat('EEEE, dd MMMM yyyy').format(DateTime.parse(controller.borrowHistoryList[index].fromDate!)) : "Unknown"}',
                                            ),
                                            Text(
                                              'Return Date: ${controller.borrowHistoryList[index].untilDate != null ? DateFormat('EEEE, dd MMMM yyyy').format(DateTime.parse(controller.borrowHistoryList[index].untilDate!)) : "Unknown"}',
                                            ),
                                            const SizedBox(
                                              height: 10.0,
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  controller.borrowHistoryList[index].status ?? "-",
                                                  style: const TextStyle(
                                                    color: Colors.green,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 10.0,
                                                ),
                                                Text(
                                                  'Number Of Books Borrowed: ${controller.borrowHistoryList[index].books != null ? controller.borrowHistoryList[index].books!.length : "Unknown"}',
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ) :
                              const Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    Text(
                                      'There is no history to show',
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w700,
                                      ),
                                      textAlign: TextAlign.center,
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ) :
        controller.currentState == "SHOW_RETURN_LIST" ?
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Container(
                color: Theme.of(context).colorScheme.primary,
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black54,
                        ),
                      ),
                      child: CachedNetworkImage(
                        imageUrl: controller.libraryMemberData.photoUrl ?? '',
                        width: MediaQuery.of(context).size.width / 6,
                        fit: BoxFit.contain,
                        errorWidget: (errContext, _, errObj) {
                          return SizedBox(
                            width: MediaQuery.of(context).size.width / 6,
                            child: const Icon(
                              Icons.person,
                              size: 200.0,
                              color: Colors.white,
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      controller.libraryMemberData.name ?? '',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      controller.libraryMemberData.nis ?? controller.libraryMemberData.nik ?? '',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      ),
                    ),
                    Text(
                      controller.libraryMemberData.className ?? controller.libraryMemberData.email ?? '',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.0),
                    child: Text(
                      "RETURN - BOOK LIST",
                      style: TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  controller.returnedBookList.isNotEmpty ?
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.returnedBookList.length,
                      itemBuilder: (BuildContext listContext, int index) {
                        BorrowedBooksDataJson returnedBook = controller.returnedBookList[index].values.first;

                        return returnedBook.bibliography != null ?
                        Card(
                          elevation: 10.0,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 30.0,
                                  height: 30.0,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).colorScheme.primary,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Center(
                                    child: Text(
                                      "${index + 1}",
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10.0,
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width / 24,
                                  child: CachedNetworkImage(
                                    imageUrl: returnedBook.url ?? '',
                                    fit: BoxFit.contain,
                                    errorWidget: (errContext, _, errObj) {
                                      return SizedBox(
                                        width: MediaQuery.of(context).size.width / 24,
                                        child: Icon(
                                          Icons.book,
                                          size: 40.0,
                                          color: Theme.of(context).colorScheme.primary,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  width: 10.0,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: [
                                      Text(
                                        returnedBook.bibliography!.title ?? 'Unknown',
                                        style: const TextStyle(
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10.0,
                                      ),
                                      Text(
                                        "ISBN/ISSN: ${returnedBook.bibliography!.isbnOrIssn ?? 'Unknown'}",
                                        style: const TextStyle(
                                          fontSize: 10.0,
                                        ),
                                      ),
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'Authors: ',
                                            style: TextStyle(
                                              fontSize: 10.0,
                                            ),
                                          ),
                                          Text(
                                            returnedBook.bibliography != null ?
                                            returnedBook.bibliography!.authorNames ?? 'Unknown' :
                                            'Unknown',
                                            style: const TextStyle(
                                              fontSize: 10.0,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              'Publisher: ${returnedBook.bibliography != null
                                                  && returnedBook.bibliography!.publisher != null ?
                                              returnedBook.bibliography!.publisher!.name ?? 'Unknown' :
                                              "Unknown"} ',
                                              style: const TextStyle(
                                                fontSize: 10.0,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                              'Publishing Year: ${returnedBook.bibliography != null ?
                                              returnedBook.bibliography!.publishingYear ?? 'Unknown' :
                                              "Unknown"} ',
                                              style: const TextStyle(
                                                fontSize: 10.0,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  width: 10.0,
                                ),
                                controller.returnedBookList[index].keys.first == true ?
                                const Icon(
                                  Icons.check_circle,
                                  color: Colors.green,
                                ) :
                                const Icon(
                                  Icons.close,
                                  color: Colors.red,
                                ),
                              ],
                            ),
                          ),
                        ) :
                        const Material();
                      },
                    ),
                  ) :
                  const Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Currently, no books are being borrowed',
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.w700,
                          ),
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ) :
        controller.currentState == "SHOW_RENEW_LIST" || controller.currentState == "SHOW_BORROWED_LIST" ?
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Container(
                color: Theme.of(context).colorScheme.primary,
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black54,
                        ),
                      ),
                      child: CachedNetworkImage(
                        imageUrl: controller.libraryMemberData.photoUrl ?? '',
                        width: MediaQuery.of(context).size.width / 6,
                        fit: BoxFit.contain,
                        errorWidget: (errContext, _, errObj) {
                          return SizedBox(
                            width: MediaQuery.of(context).size.width / 6,
                            child: const Icon(
                              Icons.person,
                              size: 200.0,
                              color: Colors.white,
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      controller.libraryMemberData.name ?? '',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      controller.libraryMemberData.nis ?? controller.libraryMemberData.nik ?? '',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      ),
                    ),
                    Text(
                      controller.libraryMemberData.className ?? controller.libraryMemberData.email ?? '',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Text(
                      controller.currentState == "SHOW_RENEW_LIST" ? "RENEW - BOOK LIST" : "BORROWED - BOOK LIST",
                      style: const TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  controller.borrowedBookList.isNotEmpty ?
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.borrowedBookList.length,
                      itemBuilder: (BuildContext listContext, int index) {
                        return controller.borrowedBookList[index].bibliography != null ?
                        Card(
                          elevation: 10.0,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 30.0,
                                  height: 30.0,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).colorScheme.primary,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Center(
                                    child: Text(
                                      "${index + 1}",
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10.0,
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width / 24,
                                  child: CachedNetworkImage(
                                    imageUrl: controller.borrowedBookList[index].url ?? '',
                                    fit: BoxFit.contain,
                                    errorWidget: (errContext, _, errObj) {
                                      return SizedBox(
                                        width: MediaQuery.of(context).size.width / 24,
                                        child: Icon(
                                          Icons.book,
                                          size: 40.0,
                                          color: Theme.of(context).colorScheme.primary,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  width: 10.0,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: [
                                      Text(
                                        controller.borrowedBookList[index].bibliography!.title ?? 'Unknown',
                                        style: const TextStyle(
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10.0,
                                      ),
                                      Text(
                                        "ISBN/ISSN: ${controller.borrowedBookList[index].bibliography!.isbnOrIssn ?? 'Unknown'}",
                                        style: const TextStyle(
                                          fontSize: 10.0,
                                        ),
                                      ),
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'Authors: ',
                                            style: TextStyle(
                                              fontSize: 10.0,
                                            ),
                                          ),
                                          Text(
                                            controller.borrowedBookList[index].bibliography != null ?
                                            controller.borrowedBookList[index].bibliography!.authorNames ?? 'Unknown' :
                                            'Unknown',
                                            style: const TextStyle(
                                              fontSize: 10.0,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              'Publisher: ${controller.borrowedBookList[index].bibliography != null
                                                  && controller.borrowedBookList[index].bibliography!.publisher != null ?
                                              controller.borrowedBookList[index].bibliography!.publisher!.name ?? 'Unknown' :
                                              "Unknown"} ',
                                              style: const TextStyle(
                                                fontSize: 10.0,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                              'Publishing Year: ${controller.borrowedBookList[index].bibliography != null ?
                                              controller.borrowedBookList[index].bibliography!.publishingYear ?? 'Unknown' :
                                              "Unknown"} ',
                                              style: const TextStyle(
                                                fontSize: 10.0,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ) :
                        const Material();
                      },
                    ),
                  ) :
                  const Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Currently, no books are being borrowed',
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.w700,
                          ),
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ) :
        controller.currentState == "SHOW_BOOK_DETAIL" && controller.bookData != null ?
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            controller.bookData!.mediaPath != null ?
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 50.0),
                      child: SizedBox(
                        child: CachedNetworkImage(
                          imageUrl: controller.bookData!.mediaPath ?? '',
                          fit: BoxFit.contain,
                          errorWidget: (errContext, _, errObj) {
                            return SizedBox(
                              child: Icon(
                                Icons.book,
                                size: 200.0,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ) :
            const Material(),
            Expanded(
              flex: 3,
              child: Container(
                color: Theme.of(context).colorScheme.primary,
                padding: const EdgeInsets.only(left: 50),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      "INFORMATION",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 44.0,
                      ),
                    ),
                    const SizedBox(
                      height: 50.0,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              const Text(
                                "Type",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                controller.bookData!.type ?? "-",
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 30.0,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              const Text(
                                "Location",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                controller.bookData!.location ?? "-",
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              const Text(
                                "Title",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                controller.bookData!.title ?? "-",
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 30.0,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              const Text(
                                "Shelf Location",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                controller.bookData!.shelfLocation ?? "-",
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              const Text(
                                "ISBN/ISSN",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                controller.bookData!.isbnOrIssn ?? "-",
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Expanded(
                          child: Material(),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              const Text(
                                "Authors",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                controller.bookData!.authorNames ?? "-",
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Expanded(
                          child: Material(),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              const Text(
                                "Publisher",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                controller.bookData!.publisher ?? "-",
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Expanded(
                          child: Material(),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              const Text(
                                "Publishing Year",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                controller.bookData!.publishingYear ?? "-",
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Expanded(
                          child: Material(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ) :
        controller.currentState == "BORROW" ?
        Image.asset(
          "assets/images/borrow_ls.png",
          fit: BoxFit.cover,
        ) :
        controller.currentState == "RENEW" ?
        Image.asset(
          "assets/images/renew_ls.png",
          fit: BoxFit.cover,
        ) :
        controller.currentState == "RETURN" ?
        Image.asset(
            "assets/images/return_ls.png",
          fit: BoxFit.cover,
        ) :
        controller.currentState == "INFORMATION" ?
        Image.asset(
          "assets/images/information.png",
          fit: BoxFit.cover,
        ) :
        controller.currentState == "INFO_1" ?
        Image.asset(
          "assets/images/library_info_1.jpeg",
          fit: BoxFit.cover,
        ) :
        controller.currentState == "INFO_2" ?
        Image.asset(
          "assets/images/library_info_2.png",
          fit: BoxFit.cover,
        ) :
        controller.currentState == "INFO_3" ?
        Image.asset(
          "assets/images/library_info_3.png",
          fit: BoxFit.cover,
        ) :
        controller.currentState == "INFO_4" ?
        Image.asset(
          "assets/images/library_info_4.png",
          fit: BoxFit.cover,
        ) :
        controller.currentState == "INFO_5" ?
        Image.asset(
          "assets/images/library_info_5.png",
          fit: BoxFit.cover,
        ) :
        controller.currentState == "INFO_6" ?
        Image.asset(
          "assets/images/library_info_6.png",
          fit: BoxFit.cover,
        ) :
        controller.currentState == "INFO_7" ?
        Image.asset(
          "assets/images/library_info_7.png",
          fit: BoxFit.cover,
        ) :
        controller.currentState == "INFO_8" ?
        Image.asset(
          "assets/images/library_info_8.png",
          fit: BoxFit.cover,
        ) :
        const Material() :
        const Material(),
      ),
    );
  }
}