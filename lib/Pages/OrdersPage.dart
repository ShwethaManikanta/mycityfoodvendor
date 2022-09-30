import 'dart:async';
import 'package:mycityfoodvendor/common/utils.dart';
import 'package:mycityfoodvendor/API/api.dart';
import 'package:mycityfoodvendor/model/orderhistory.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../common/common_styles.dart';
import '../service/orders_api_provider.dart';
import 'orders/components/orders_list_component.dart';

class OrdersPage extends StatefulWidget {
  @override
  _OrdersPageState createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  Timer? timer;

  @override
  void initState() {
    if (mounted) {
      timer = Timer.periodic(const Duration(seconds: 10), (timer) {
        context.read<OrderHistoryAPIProvider>().getOrders();
        context.read<OrderCancelledAPIProvider>().getOrders();
        context.read<OrdersCompletedAPIProvider>().getOrders();
      });
    }

    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: buildBody(),
    );
  }

  buildBody() {
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          TabBar(
            labelStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w800),
            unselectedLabelColor: Colors.black,
            labelColor: Colors.orangeAccent[700],
            indicatorColor: Colors.deepOrange,
            tabs: [
              Tab(
                text: ('Orders'.toUpperCase()),
              ),
              Tab(
                text: ('Completed'.toUpperCase()),
              ),
              Tab(
                text: ('Canceled'.toUpperCase()),
              ),
            ],
          ),
          Expanded(
            child: TabBarView(children: [
              OrderHistoryPage(),
              OrderCompletedPage(),
              OrderCancelledPage(),
              // listOfAllOrders1(),
              // listOfAllOrders2(),
              // listOfAllOrders3(),
            ]),
          )
        ],
      ),
    );
  }

  // listOfAllOrders1() {
  //   return FutureBuilder<OrderCancelledModel?>(
  //       future: getapi.orderHistory(context),
  //       builder: (context, snapshot) {
  //         if (snapshot.hasData) {
  //           return snapshot.data!.order_history!.isNotEmpty
  //               ? ListView.builder(
  //                   physics: BouncingScrollPhysics(),
  //                   itemCount: snapshot.data!.order_history!.length,
  //                   itemBuilder: (BuildContext context, int index) {
  //                     return Card(
  //                       margin:
  //                           EdgeInsets.symmetric(horizontal: 12, vertical: 8),
  //                       elevation: 3,
  //                       child: Column(
  //                         children: [
  //                           Padding(
  //                             padding: const EdgeInsets.all(8.0),
  //                             child: ExpansionTile(
  //                               initiallyExpanded: true,
  //                               title: Text(
  //                                 snapshot.data!.orderHistoryList![index]
  //                                     .customer_name!,
  //                                 style: TextStyle(
  //                                     color: Colors.black,
  //                                     fontSize: 18,
  //                                     fontWeight: FontWeight.w600,
  //                                     letterSpacing: 0,
  //                                     wordSpacing: 1),
  //                               ),
  //                               subtitle: Column(
  //                                 mainAxisSize: MainAxisSize.min,
  //                                 crossAxisAlignment: CrossAxisAlignment.start,
  //                                 children: [
  //                                   SizedBox(
  //                                     height: 5,
  //                                   ),
  //                                   snapshot.data!.orderHistoryList![index]
  //                                               .product_details ==
  //                                           null
  //                                       ? Text(
  //                                           'Currently items not available'
  //                                               .toUpperCase(),
  //                                           style: TextStyle(
  //                                               color: Colors.grey,
  //                                               fontSize: 12,
  //                                               fontWeight: FontWeight.w400,
  //                                               letterSpacing: 0,
  //                                               wordSpacing: 1),
  //                                         )
  //                                       : Text(
  //                                           "Products Available",
  //                                           style: TextStyle(
  //                                               color: Colors.grey,
  //                                               fontSize: 12,
  //                                               fontWeight: FontWeight.w400,
  //                                               letterSpacing: 0,
  //                                               wordSpacing: 1),
  //                                         ),
  //                                   SizedBox(
  //                                     height: 5,
  //                                   ),
  //                                   Text(
  //                                     'View Items'.toUpperCase(),
  //                                     style: TextStyle(
  //                                         color: Colors.orangeAccent[700],
  //                                         fontSize: 10,
  //                                         fontWeight: FontWeight.bold,
  //                                         letterSpacing: 0,
  //                                         wordSpacing: 1),
  //                                   ),
  //                                 ],
  //                               ),
  //                               trailing: Text(snapshot
  //                                   .data!.order_history![index].status!
  //                                   .toUpperCase()),
  //                               children: List.generate(
  //                                   snapshot.data!.order_history!.length, (i) {
  //                                 return ListTile(
  //                                   title: Text(snapshot
  //                                       .data!
  //                                       .order_history![index]
  //                                       .product_details!
  //                                       .product_name!),
  //                                   subtitle: Text('Quantity : ' +
  //                                       snapshot.data!.order_history![index]
  //                                           .product_details!.qty!),
  //                                   trailing: Text('₹ ' +
  //                                       snapshot.data!.order_history![index]
  //                                           .product_details!.price
  //                                           .toString()),
  //                                 );
  //                               }).toList(growable: true),
  //                             ),
  //                           ),
  //                           Row(
  //                             children: [
  //                               SizedBox(
  //                                 width: 8,
  //                               ),
  //                               Expanded(
  //                                 child: ElevatedButton(
  //                                     style: ElevatedButton.styleFrom(
  //                                         primary: Colors.green,
  //                                         elevation: 0,
  //                                         padding: EdgeInsets.all(10)),
  //                                     onPressed: () {
  //                                       Map param = {
  //                                         "order_id": snapshot
  //                                             .data!.orderHistoryList![index].id,
  //                                         "status": "4",
  //                                       };
  //                                       getapi.acceptcancelorder(
  //                                           context, param);
  //                                     },
  //                                     child: Text('Accept'.toUpperCase())),
  //                               ),
  //                               SizedBox(
  //                                 width: 5,
  //                               ),
  //                               Expanded(
  //                                 child: ElevatedButton(
  //                                     style: ElevatedButton.styleFrom(
  //                                         primary: Colors.red,
  //                                         elevation: 0,
  //                                         padding: EdgeInsets.all(10)),
  //                                     onPressed: () {
  //                                       showDialog(
  //                                           context: context,
  //                                           builder: (context) => dialog(
  //                                               snapshot
  //                                                   .data!
  //                                                   .orderHistoryList![index]
  //                                                   .id!));
  //                                     },
  //                                     child: Text('Cancel'.toUpperCase())),
  //                               ),
  //                               SizedBox(
  //                                 width: 8,
  //                               ),
  //                             ],
  //                           ),
  //                         ],
  //                       ),
  //                     );
  //                   },
  //                 )
  //               : Center(
  //                   child: Text("No Order list"),
  //                 );
  //         }
  //         return Center(
  //           child: CircularProgressIndicator(),
  //         );
  //       });
  // }

  // Widget dialog(String orderId) {
  //   TextEditingController cancelcontroller = TextEditingController();
  //   return Dialog(
  //     child: Container(
  //       color: Colors.white,
  //       child: Column(
  //         mainAxisSize: MainAxisSize.min,
  //         children: [
  //           SizedBox(
  //             height: 7,
  //           ),
  //           Container(
  //             padding: EdgeInsets.all(8),
  //             alignment: Alignment.center,
  //             child: Text(
  //               'Cancel Order'.toUpperCase(),
  //               style: TextStyle(
  //                 color: (Colors.orange[900])!,
  //                 fontSize: 18,
  //                 fontWeight: FontWeight.w600,
  //                 letterSpacing: 0.2,
  //                 wordSpacing: 1,
  //               ),
  //             ),
  //           ),
  //           Divider(),
  //           Padding(
  //             padding: const EdgeInsets.symmetric(horizontal: 12),
  //             child: TextFormField(
  //               maxLines: null,
  //               autofocus: true,
  //               controller: cancelcontroller,
  //               decoration: InputDecoration(
  //                 hintText: 'Write Your Reason To Cancel',
  //                 border: UnderlineInputBorder(),
  //               ),
  //               cursorColor: (Colors.orange[900])!,
  //             ),
  //           ),
  //           SizedBox(
  //             height: 5,
  //           ),
  //           Padding(
  //             padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
  //             child: Row(
  //               children: [
  //                 Expanded(
  //                   child: ElevatedButton(
  //                       style: ElevatedButton.styleFrom(
  //                           primary: Colors.red[700],
  //                           elevation: 0,
  //                           padding: EdgeInsets.all(5)),
  //                       onPressed: () {
  //                         Navigator.pop(context);
  //                       },
  //                       child: Text(
  //                         'Cancel'.toUpperCase(),
  //                         style: TextStyle(
  //                             color: Colors.white,
  //                             fontSize: 12,
  //                             fontWeight: FontWeight.bold,
  //                             letterSpacing: 0,
  //                             wordSpacing: 1),
  //                       )),
  //                 ),
  //                 SizedBox(
  //                   width: 10,
  //                 ),
  //                 Expanded(
  //                   child: ElevatedButton(
  //                       style: ElevatedButton.styleFrom(
  //                           primary: Colors.green[700],
  //                           elevation: 0,
  //                           padding: EdgeInsets.all(10)),
  //                       onPressed: () {
  //                         Map param = {
  //                           "order_id": orderId,
  //                           "status": "1",
  //                           "cancel_reson": cancelcontroller.text
  //                         };
  //                         print(param);
  //                         getapi
  //                             .acceptcancelorder(context, param)
  //                             .then((value) => Navigator.pop(context));
  //                       },
  //                       child: Text(
  //                         'Submit'.toUpperCase(),
  //                         style: TextStyle(
  //                             color: Colors.white,
  //                             fontSize: 12,
  //                             fontWeight: FontWeight.bold,
  //                             letterSpacing: 0,
  //                             wordSpacing: 1),
  //                       )),
  //                 )
  //               ],
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  // listOfAllOrders2() {
  //   return FutureBuilder<OrderCancelledModel?>(
  //       future: getapi.orderCompleted(context),
  //       builder: (context, snapshot) {
  //         if (snapshot.hasData) {
  //           return snapshot.data!.order_completed_list != null
  //               ? ListView.builder(
  //                   physics: BouncingScrollPhysics(),
  //                   itemCount: snapshot.data!.order_completed_list!.length,
  //                   itemBuilder: (BuildContext context, int index) {
  //                     return Card(
  //                       margin:
  //                           EdgeInsets.symmetric(horizontal: 12, vertical: 8),
  //                       elevation: 3,
  //                       child: Column(
  //                         children: [
  //                           Padding(
  //                             padding: const EdgeInsets.all(8.0),
  //                             child: ExpansionTile(
  //                               title: Text(
  //                                 'Akash S'.toUpperCase(),
  //                                 style: TextStyle(
  //                                     color: Colors.black,
  //                                     fontSize: 18,
  //                                     fontWeight: FontWeight.w600,
  //                                     letterSpacing: 0,
  //                                     wordSpacing: 1),
  //                               ),
  //                               subtitle: Column(
  //                                 mainAxisSize: MainAxisSize.min,
  //                                 crossAxisAlignment: CrossAxisAlignment.start,
  //                                 children: [
  //                                   SizedBox(
  //                                     height: 5,
  //                                   ),
  //                                   snapshot.data!.order_completed_list![index]
  //                                           .product_name!.isEmpty
  //                                       ? Text(
  //                                           'Currently items not available'
  //                                               .toUpperCase(),
  //                                           style: TextStyle(
  //                                               color: Colors.grey,
  //                                               fontSize: 12,
  //                                               fontWeight: FontWeight.w400,
  //                                               letterSpacing: 0,
  //                                               wordSpacing: 1),
  //                                         )
  //                                       : Text(
  //                                           "Products Available",
  //                                           style: TextStyle(
  //                                               color: Colors.grey,
  //                                               fontSize: 12,
  //                                               fontWeight: FontWeight.w400,
  //                                               letterSpacing: 0,
  //                                               wordSpacing: 1),
  //                                         ),
  //                                   SizedBox(
  //                                     height: 5,
  //                                   ),
  //                                   Text(
  //                                     'View Items'.toUpperCase(),
  //                                     style: TextStyle(
  //                                         color: Colors.orangeAccent[700],
  //                                         fontSize: 10,
  //                                         fontWeight: FontWeight.bold,
  //                                         letterSpacing: 0,
  //                                         wordSpacing: 1),
  //                                   ),
  //                                 ],
  //                               ),
  //                               // trailing: Column(
  //                               //   mainAxisSize: MainAxisSize.min,
  //                               //   crossAxisAlignment: CrossAxisAlignment.end,
  //                               //   mainAxisAlignment: MainAxisAlignment.center,
  //                               //   children: [
  //                               //     Text(
  //                               //       '₹ 600'.toUpperCase(),
  //                               //       style: TextStyle(
  //                               //         color: Colors.black,
  //                               //         fontSize: 18,
  //                               //         fontWeight: FontWeight.w400,
  //                               //         letterSpacing: 0,
  //                               //         wordSpacing: 1,
  //                               //       ),
  //                               //     ),
  //                               //     Text(
  //                               //       index % 2 != 0
  //                               //           ? 'Take-Away'.toUpperCase()
  //                               //           : 'Delivery'.toUpperCase(),
  //                               //       style: TextStyle(
  //                               //           color: Colors.black,
  //                               //           fontSize: 10,
  //                               //           fontWeight: FontWeight.bold,
  //                               //           letterSpacing: 0,
  //                               //           wordSpacing: 1),
  //                               //     ),
  //                               //   ],
  //                               // ),
  //                               children: List.generate(
  //                                   snapshot.data!.order_completed_list![index]
  //                                       .product_name!.length, (i) {
  //                                 return ListTile(
  //                                   title: Text(snapshot
  //                                       .data!
  //                                       .order_completed_list![index]
  //                                       .product_name![i]
  //                                       .name!),
  //                                   subtitle: Text('Quantity : ' +
  //                                       snapshot
  //                                           .data!
  //                                           .order_completed_list![index]
  //                                           .product_name![i]
  //                                           .quantity!),
  //                                   trailing: Text('₹ ' +
  //                                       snapshot
  //                                           .data!
  //                                           .order_completed_list![index]
  //                                           .product_name![i]
  //                                           .price
  //                                           .toString()),
  //                                 );
  //                               }).toList(growable: true),
  //                             ),
  //                           ),
  //                         ],
  //                       ),
  //                     );
  //                   },
  //                 )
  //               : Center(
  //                   child: Text("No Completed list"),
  //                 );
  //         }
  //         return Center(
  //           child: CircularProgressIndicator(),
  //         );
  //       });
  // }

  // listOfAllOrders3() {
  //   return FutureBuilder<OrderCancelledModel?>(
  //       future: getapi.orderCancelledList(context),
  //       builder: (context, snapshot) {
  //         if (snapshot.hasData) {
  //           return snapshot.data!.order_history_list != null
  //               ? ListView.builder(
  //                   physics: BouncingScrollPhysics(),
  //                   itemCount: snapshot.data!.order_history_list!.length,
  //                   itemBuilder: (BuildContext context, int index) {
  //                     return Card(
  //                       margin:
  //                           EdgeInsets.symmetric(horizontal: 12, vertical: 8),
  //                       elevation: 3,
  //                       child: Column(
  //                         children: [
  //                           Padding(
  //                             padding: const EdgeInsets.all(8.0),
  //                             child: ExpansionTile(
  //                               title: Text(
  //                                 'Akash S'.toUpperCase(),
  //                                 style: TextStyle(
  //                                     color: Colors.black,
  //                                     fontSize: 18,
  //                                     fontWeight: FontWeight.w600,
  //                                     letterSpacing: 0,
  //                                     wordSpacing: 1),
  //                               ),
  //                               subtitle: Column(
  //                                 mainAxisSize: MainAxisSize.min,
  //                                 crossAxisAlignment: CrossAxisAlignment.start,
  //                                 children: [
  //                                   SizedBox(
  //                                     height: 5,
  //                                   ),
  //                                   snapshot.data!.order_history_list![index]
  //                                           .product_name!.isEmpty
  //                                       ? Text(
  //                                           'Currently items not available'
  //                                               .toUpperCase(),
  //                                           style: TextStyle(
  //                                               color: Colors.grey,
  //                                               fontSize: 12,
  //                                               fontWeight: FontWeight.w400,
  //                                               letterSpacing: 0,
  //                                               wordSpacing: 1),
  //                                         )
  //                                       : Text(
  //                                           "Products Available",
  //                                           style: TextStyle(
  //                                               color: Colors.grey,
  //                                               fontSize: 12,
  //                                               fontWeight: FontWeight.w400,
  //                                               letterSpacing: 0,
  //                                               wordSpacing: 1),
  //                                         ),
  //                                   SizedBox(
  //                                     height: 5,
  //                                   ),
  //                                   Text(
  //                                     'View Items'.toUpperCase(),
  //                                     style: TextStyle(
  //                                         color: Colors.orangeAccent[700],
  //                                         fontSize: 10,
  //                                         fontWeight: FontWeight.bold,
  //                                         letterSpacing: 0,
  //                                         wordSpacing: 1),
  //                                   ),
  //                                 ],
  //                               ),
  //                               // trailing: Column(
  //                               //   mainAxisSize: MainAxisSize.min,
  //                               //   crossAxisAlignment: CrossAxisAlignment.end,
  //                               //   mainAxisAlignment: MainAxisAlignment.center,
  //                               //   children: [
  //                               //     Text(
  //                               //       '₹ 600'.toUpperCase(),
  //                               //       style: TextStyle(
  //                               //         color: Colors.black,
  //                               //         fontSize: 18,
  //                               //         fontWeight: FontWeight.w400,
  //                               //         letterSpacing: 0,
  //                               //         wordSpacing: 1,
  //                               //       ),
  //                               //     ),
  //                               //     Text(
  //                               //       index % 2 != 0
  //                               //           ? 'Take-Away'.toUpperCase()
  //                               //           : 'Delivery'.toUpperCase(),
  //                               //       style: TextStyle(
  //                               //           color: Colors.black,
  //                               //           fontSize: 10,
  //                               //           fontWeight: FontWeight.bold,
  //                               //           letterSpacing: 0,
  //                               //           wordSpacing: 1),
  //                               //     ),
  //                               //   ],
  //                               // ),
  //                               children: List.generate(
  //                                   snapshot.data!.order_history_list![index]
  //                                       .product_name!.length, (i) {
  //                                 return ListTile(
  //                                   title: Text(snapshot
  //                                       .data!
  //                                       .order_history_list![index]
  //                                       .product_name![i]
  //                                       .name!),
  //                                   subtitle: Text('Quantity : ' +
  //                                       snapshot
  //                                           .data!
  //                                           .order_history_list![index]
  //                                           .product_name![i]
  //                                           .quantity!),
  //                                   trailing: Text('₹ ' +
  //                                       snapshot
  //                                           .data!
  //                                           .order_history_list![index]
  //                                           .product_name![i]
  //                                           .price
  //                                           .toString()),
  //                                 );
  //                               }).toList(growable: true),
  //                             ),
  //                           ),
  //                         ],
  //                       ),
  //                     );
  //                   },
  //                 )
  //               : Center(
  //                   child: Text("No Cancel list"),
  //                 );
  //         }
  //         return Center(
  //           child: CircularProgressIndicator(),
  //         );
  //       });
  // }
}

class OrderHistoryPage extends StatefulWidget {
  const OrderHistoryPage({Key? key}) : super(key: key);

  @override
  _OrderHistoryPageState createState() => _OrderHistoryPageState();
}

class _OrderHistoryPageState extends State<OrderHistoryPage> {
  @override
  void initState() {
    print("Hello from initstate orders page");
    if (context.read<OrderHistoryAPIProvider>().orderHistoryResponse == null) {
      context.read<OrderHistoryAPIProvider>().getOrders();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return body();
  }

  body() {
    final orderHistoryAPIProvider =
        Provider.of<OrderHistoryAPIProvider>(context);
    if (orderHistoryAPIProvider.ifLoading) {
      return SizedBox(
          height: 400,
          width: deviceWidth(context),
          child: Utils.getLoadingCenter25());
    } else if (orderHistoryAPIProvider.error) {
      return SizedBox(
          height: 400,
          width: deviceWidth(context),
          child: Utils.showErrorMessage(orderHistoryAPIProvider.errorMessage));
    } else if (orderHistoryAPIProvider.orderHistoryResponse!.status == "0") {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Utils.showErrorMessage(
              orderHistoryAPIProvider.orderHistoryResponse!.message!),
          Utils.getSizedBox(height: 10),
          MaterialButton(
            onPressed: () async {
              showLoading(context);
              await context.read<OrderHistoryAPIProvider>().getOrders();
              Navigator.of(context).pop();
            },
            color: Colors.green,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Text(
              "Refresh",
              style: CommonStyles.whiteText12BoldW500(),
            ),
          )
        ],
      );
    } else {
      final orderHistoryModel = orderHistoryAPIProvider.orderHistoryResponse!;
      if (orderHistoryModel.orderHistory!.isEmpty) {
        return Utils.showErrorMessage("List Empty");
      }
      return ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: orderHistoryModel.orderHistory!.length,
        // .data!.order_history!.length,
        itemBuilder: (BuildContext context, int index) {
          return OrdersOngoingTakeAwayComponent(
            orderHistory: orderHistoryModel.orderHistory![index],
          );
          // return OrdersOngoingDeliveryListCompontent(
          //   orderHistory: orderHistoryModel.orderHistory![index],
          // );
        },
      );
    }
  }

  // getProperButton(String status) {
  //   switch (status) {
  //     case "Ongoing":

  //     case "Ordered":
  //       return getAcceptRejectButton(context);
  //   }
  // }

  getCompleteButton(BuildContext context,
      OngoingOrderResponseModel orderHistoryModel, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                    elevation: 0,
                    padding: EdgeInsets.all(10)),
                onPressed: () async {
                  Map param = {
                    "order_id": orderHistoryModel.orderHistory![index].id,
                    "status": "2",
                  };
                  showLoading(context);
                  await getapi.acceptcancelorder(context, param);
                  await context.read<OrderHistoryAPIProvider>().getOrders();
                  context.read<OrdersCompletedAPIProvider>().getOrders();
                  Navigator.of(context).pop();
                },
                child: Text('Complete Order'.toUpperCase())),
          ),
        ],
      ),
    );
  }

  launchCaller(String phoneNumber) async {
    final url = "tel://$phoneNumber";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  getAcceptRejectButton(BuildContext context,
      OngoingOrderResponseModel orderHistoryModel, int index) {
    return Row(
      children: [
        SizedBox(
          width: 8,
        ),
        Expanded(
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                  elevation: 0,
                  padding: EdgeInsets.all(10)),
              onPressed: () async {
                Map param = {
                  "order_id": orderHistoryModel.orderHistory![index].id,
                  "status": "4",
                };
                await getapi.acceptcancelorder(context, param);
                context.read<OrderHistoryAPIProvider>().getOrders();
              },
              child: Text('Accept'.toUpperCase())),
        ),
        SizedBox(
          width: 5,
        ),
        Expanded(
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: Colors.red,
                  elevation: 0,
                  padding: EdgeInsets.all(10)),
              onPressed: () async {
                await showDialog(
                    context: context,
                    builder: (context) =>
                        dialog(orderHistoryModel.orderHistory![index].id!));
              },
              child: Text('Cancel'.toUpperCase())),
        ),
        SizedBox(
          width: 8,
        ),
      ],
    );
  }

  Widget dialog(String orderId) {
    TextEditingController cancelcontroller = TextEditingController();
    return Dialog(
      child: Container(
        color: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 7,
            ),
            Container(
              padding: EdgeInsets.all(8),
              alignment: Alignment.center,
              child: Text(
                'Cancel Order'.toUpperCase(),
                style: TextStyle(
                  color: (Colors.orange[900])!,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.2,
                  wordSpacing: 1,
                ),
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: TextFormField(
                maxLines: null,
                autofocus: true,
                controller: cancelcontroller,
                decoration: InputDecoration(
                  hintText: 'Write Your Reason To Cancel',
                  border: UnderlineInputBorder(),
                ),
                cursorColor: (Colors.orange[900])!,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.red[700],
                            elevation: 0,
                            padding: EdgeInsets.all(5)),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Cancel'.toUpperCase(),
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0,
                              wordSpacing: 1),
                        )),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.green[700],
                            elevation: 0,
                            padding: EdgeInsets.all(10)),
                        onPressed: () {
                          Map param = {
                            "order_id": orderId,
                            "status": "3",
                            "cancel_reson": cancelcontroller.text
                          };
                          print(param);
                          getapi
                              .acceptcancelorder(context, param)
                              .whenComplete(() {
                            context.read<OrderHistoryAPIProvider>().getOrders();
                            Navigator.pop(context);
                          });
                        },
                        child: Text(
                          'Submit'.toUpperCase(),
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0,
                              wordSpacing: 1),
                        )),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OrderCompletedPage extends StatefulWidget {
  const OrderCompletedPage({Key? key}) : super(key: key);

  @override
  _OrderCompletedPageState createState() => _OrderCompletedPageState();
}

class _OrderCompletedPageState extends State<OrderCompletedPage> {
  @override
  void initState() {
    if (context.read<OrdersCompletedAPIProvider>().orderComepletedResponse ==
        null) {
      context.read<OrdersCompletedAPIProvider>().getOrders();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return body();
  }

  body() {
    final orderCompletedAPIProvider =
        Provider.of<OrdersCompletedAPIProvider>(context);
    if (orderCompletedAPIProvider.ifLoading) {
      return SizedBox(
          height: 400,
          width: deviceWidth(context),
          child: Utils.getLoadingCenter25());
    } else if (orderCompletedAPIProvider.error) {
      return SizedBox(
          height: 400,
          width: deviceWidth(context),
          child:
              Utils.showErrorMessage(orderCompletedAPIProvider.errorMessage));
    } else if (orderCompletedAPIProvider.orderComepletedResponse!.status ==
        "0") {
      return Utils.showErrorMessage(
          orderCompletedAPIProvider.orderComepletedResponse!.message!);
    } else {
      final orderCompletedModel =
          orderCompletedAPIProvider.orderComepletedResponse!;
      if (orderCompletedModel.orderCompletedList!.isEmpty) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Utils.showErrorMessage("List Empty"),
            Utils.getSizedBox(height: 10),
            MaterialButton(
              onPressed: () async {
                showLoading(context);
                await context.read<OrdersCompletedAPIProvider>().getOrders();
                Navigator.of(context).pop();
              },
              color: Colors.green,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Text(
                "Refresh",
                style: CommonStyles.whiteText12BoldW500(),
              ),
            )
          ],
        );
      }

      return ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: orderCompletedModel.orderCompletedList!.length,
        // .data!.order_history!.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            elevation: 3,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ExpansionTile(
                    initiallyExpanded: true,
                    title: Text(
                      orderCompletedModel
                              .orderCompletedList![index].customerName ??
                          "NA",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0,
                          wordSpacing: 1),
                    ),
                    subtitle: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 5,
                        ),
                        orderCompletedModel.orderCompletedList![index]
                                    .productDetails ==
                                null
                            ? Text(
                                'Currently items not available'.toUpperCase(),
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: 0,
                                    wordSpacing: 1),
                              )
                            : Text(
                                "Products Available",
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: 0,
                                    wordSpacing: 1),
                              ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'View Items'.toUpperCase(),
                          style: TextStyle(
                              color: Colors.orangeAccent[700],
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0,
                              wordSpacing: 1),
                        ),
                      ],
                    ),
                    trailing: Text(orderCompletedModel
                        .orderCompletedList![index].status!
                        .toUpperCase()),
                    children: List.generate(
                        orderCompletedModel.orderCompletedList![index]
                            .productDetails!.length, (i) {
                      return ListTile(
                        title: Text(orderCompletedModel
                            .orderCompletedList![index]
                            .productDetails![i]
                            .productName!),
                        subtitle: Text('Quantity : ' +
                            orderCompletedModel.orderCompletedList![index]
                                .productDetails![i].qty!),
                        trailing: Text('₹ ' +
                            orderCompletedModel.orderCompletedList![index]
                                .productDetails![i].price
                                .toString()),
                      );
                    }).toList(growable: true),
                  ),
                ),
                // Row(
                //   children: [
                //     SizedBox(
                //       width: 8,
                //     ),
                //     Expanded(
                //       child: ElevatedButton(
                //           style: ElevatedButton.styleFrom(
                //               primary: Colors.green,
                //               elevation: 0,
                //               padding: EdgeInsets.all(10)),
                //           onPressed: () async {
                //             Map param = {
                //               "order_id": orderCompletedModel
                //                   .order_completed_list![index].id,
                //               "status": "4",
                //             };
                //             await getapi.acceptcancelorder(context, param);
                //             context
                //                 .read<OrdersCompletedAPIProvider>()
                //                 .getOrders();
                //           },
                //           child: Text('Accept'.toUpperCase())),
                //     ),
                //     SizedBox(
                //       width: 5,
                //     ),
                //     Expanded(
                //       child: ElevatedButton(
                //           style: ElevatedButton.styleFrom(
                //               primary: Colors.red,
                //               elevation: 0,
                //               padding: EdgeInsets.all(10)),
                //           onPressed: () {
                //             showDialog(
                //                 context: context,
                //                 builder: (context) => dialog(orderCompletedModel
                //                     .order_completed_list![index].id!));
                //           },
                //           child: Text('Cancel'.toUpperCase())),
                //     ),
                //     SizedBox(
                //       width: 8,
                //     ),
                //   ],
                // ),
              ],
            ),
          );
        },
      );
    }
  }

  Widget dialog(String orderId) {
    TextEditingController cancelcontroller = TextEditingController();
    return Dialog(
      child: Container(
        color: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 7,
            ),
            Container(
              padding: EdgeInsets.all(8),
              alignment: Alignment.center,
              child: Text(
                'Cancel Order'.toUpperCase(),
                style: TextStyle(
                  color: (Colors.orange[900])!,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.2,
                  wordSpacing: 1,
                ),
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: TextFormField(
                maxLines: null,
                autofocus: true,
                controller: cancelcontroller,
                decoration: InputDecoration(
                  hintText: 'Write Your Reason To Cancel',
                  border: UnderlineInputBorder(),
                ),
                cursorColor: (Colors.orange[900])!,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.red[700],
                            elevation: 0,
                            padding: EdgeInsets.all(5)),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Cancel'.toUpperCase(),
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0,
                              wordSpacing: 1),
                        )),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.green[700],
                            elevation: 0,
                            padding: EdgeInsets.all(10)),
                        onPressed: () {
                          Map param = {
                            "order_id": orderId,
                            "status": "1",
                            "cancel_reson": cancelcontroller.text
                          };
                          print(param);
                          getapi
                              .acceptcancelorder(context, param)
                              .then((value) => Navigator.pop(context));
                        },
                        child: Text(
                          'Submit'.toUpperCase(),
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0,
                              wordSpacing: 1),
                        )),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OrderCancelledPage extends StatefulWidget {
  const OrderCancelledPage({Key? key}) : super(key: key);

  @override
  _OrderCancelledPageState createState() => _OrderCancelledPageState();
}

class _OrderCancelledPageState extends State<OrderCancelledPage> {
  @override
  void initState() {
    if (context.read<OrderCancelledAPIProvider>().orderCancelledResponse ==
        null) {
      context.read<OrderCancelledAPIProvider>().getOrders();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return body();
  }

  body() {
    final orderCancelledAPIProvider =
        Provider.of<OrderCancelledAPIProvider>(context);
    if (orderCancelledAPIProvider.ifLoading) {
      return SizedBox(
          height: 400,
          width: deviceWidth(context),
          child: Utils.getLoadingCenter25());
    } else if (orderCancelledAPIProvider.error) {
      return SizedBox(
          height: 400,
          width: deviceWidth(context),
          child:
              Utils.showErrorMessage(orderCancelledAPIProvider.errorMessage));
    } else if (orderCancelledAPIProvider.orderCancelledResponse!.status ==
        "0") {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Utils.showErrorMessage(
              orderCancelledAPIProvider.orderCancelledResponse!.message!),
          Utils.getSizedBox(height: 10),
          MaterialButton(
            onPressed: () async {
              showLoading(context);
              await context.read<OrderCancelledAPIProvider>().getOrders();
              Navigator.of(context).pop();
            },
            color: Colors.green,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Text(
              "Refresh",
              style: CommonStyles.whiteText12BoldW500(),
            ),
          )
        ],
      );
    } else {
      final orderCancelledModel =
          orderCancelledAPIProvider.orderCancelledResponse!;
      if (orderCancelledModel.orderHistoryList!.isEmpty) {
        return Scaffold(
          body: RefreshIndicator(
              onRefresh: () async {
                await context.read<OrderCancelledAPIProvider>().getOrders();
              },
              child: Utils.showErrorMessage("List Empty")),
        );
      }

      return Scaffold(
        body: RefreshIndicator(
          onRefresh: () async {
            await context.read<OrderCancelledAPIProvider>().getOrders();
          },
          // triggerMode: RefreshIndicatorTriggerMode.onEdge,

          child: ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: orderCancelledModel.orderHistoryList!.length,
            // .data!.order_history!.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                elevation: 3,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ExpansionTile(
                        initiallyExpanded: true,
                        title: Text(
                          orderCancelledModel
                              .orderHistoryList![index].customerName!,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0,
                              wordSpacing: 1),
                        ),
                        subtitle: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 5,
                            ),
                            orderCancelledModel.orderHistoryList![index]
                                        .productDetails ==
                                    null
                                ? Text(
                                    'Currently items not available'
                                        .toUpperCase(),
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        letterSpacing: 0,
                                        wordSpacing: 1),
                                  )
                                : Text(
                                    "Products Available",
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        letterSpacing: 0,
                                        wordSpacing: 1),
                                  ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              'View Items'.toUpperCase(),
                              style: TextStyle(
                                  color: Colors.orangeAccent[700],
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0,
                                  wordSpacing: 1),
                            ),
                          ],
                        ),
                        trailing: Text(orderCancelledModel
                            .orderHistoryList![index].status!
                            .toUpperCase()),
                        children: List.generate(
                            orderCancelledModel.orderHistoryList![index]
                                .productDetails!.length, (i) {
                          return ListTile(
                            title: Text(orderCancelledModel
                                .orderHistoryList![index]
                                .productDetails![i]
                                .productName!),
                            subtitle: Text('Quantity : ' +
                                orderCancelledModel.orderHistoryList![index]
                                    .productDetails![i].qty!),
                            trailing: Text('₹ ' +
                                orderCancelledModel.orderHistoryList![index]
                                    .productDetails![i].price
                                    .toString()),
                          );
                        }).toList(growable: true),
                      ),
                    ),
                    // Row(
                    //   children: [
                    //     SizedBox(
                    //       width: 8,
                    //     ),
                    //     Expanded(
                    //       child: ElevatedButton(
                    //           style: ElevatedButton.styleFrom(
                    //               primary: Colors.green,
                    //               elevation: 0,
                    //               padding: EdgeInsets.all(10)),
                    //           onPressed: () {
                    //             Map param = {
                    //               "order_id": orderCancelledModel
                    //                   .order_history_list![index].id,
                    //               "status": "4",
                    //             };
                    //             getapi.acceptcancelorder(context, param);
                    //           },
                    //           child: Text('Accept'.toUpperCase())),
                    //     ),
                    //     SizedBox(
                    //       width: 5,
                    //     ),
                    //     Expanded(
                    //       child: ElevatedButton(
                    //           style: ElevatedButton.styleFrom(
                    //               primary: Colors.red,
                    //               elevation: 0,
                    //               padding: EdgeInsets.all(10)),
                    //           onPressed: () {
                    //             showDialog(
                    //                 context: context,
                    //                 builder: (context) => dialog(
                    //                     orderCancelledModel
                    //                         .order_history_list![index].id!));
                    //           },
                    //           child: Text('Cancel'.toUpperCase())),
                    //     ),
                    //     SizedBox(
                    //       width: 8,
                    //     ),
                    //   ],
                    // ),
                  ],
                ),
              );
            },
          ),
        ),
      );
    }
  }

  Widget dialog(String orderId) {
    TextEditingController cancelcontroller = TextEditingController();
    return Dialog(
      child: Container(
        color: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 7,
            ),
            Container(
              padding: EdgeInsets.all(8),
              alignment: Alignment.center,
              child: Text(
                'Cancel Order'.toUpperCase(),
                style: TextStyle(
                  color: (Colors.orange[900])!,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.2,
                  wordSpacing: 1,
                ),
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: TextFormField(
                maxLines: null,
                autofocus: true,
                controller: cancelcontroller,
                decoration: InputDecoration(
                  hintText: 'Write Your Reason To Cancel',
                  border: UnderlineInputBorder(),
                ),
                cursorColor: (Colors.orange[900])!,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.red[700],
                            elevation: 0,
                            padding: EdgeInsets.all(5)),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Cancel'.toUpperCase(),
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0,
                              wordSpacing: 1),
                        )),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.green[700],
                            elevation: 0,
                            padding: EdgeInsets.all(10)),
                        onPressed: () {
                          Map param = {
                            "order_id": orderId,
                            "status": "1",
                            "cancel_reson": cancelcontroller.text
                          };
                          print(param);
                          getapi
                              .acceptcancelorder(context, param)
                              .then((value) => Navigator.pop(context));
                        },
                        child: Text(
                          'Submit'.toUpperCase(),
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0,
                              wordSpacing: 1),
                        )),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
