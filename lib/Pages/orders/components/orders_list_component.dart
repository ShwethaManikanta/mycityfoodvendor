import 'package:mycityfoodvendor/common/common_styles.dart';
import 'package:mycityfoodvendor/model/orderhistory.dart';
import 'package:mycityfoodvendor/service/orders_api_provider.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../API/api.dart';
import '../../../common/utils.dart';

class OrdersOngoingDeliveryListCompontent extends StatefulWidget {
  const OrdersOngoingDeliveryListCompontent(
      {Key? key, required this.orderHistory})
      : super(key: key);
  final OrderHistory orderHistory;
  @override
  State<OrdersOngoingDeliveryListCompontent> createState() =>
      _OrdersOngoingDeliveryListCompontentState();
}

class _OrdersOngoingDeliveryListCompontentState
    extends State<OrdersOngoingDeliveryListCompontent> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      elevation: 6,
      clipBehavior: Clip.hardEdge,
      shadowColor: Colors.green[300],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(color: Colors.green[700], boxShadow: [
              BoxShadow(
                  color: Colors.purple[200]!,
                  offset: Offset(0, 1),
                  blurRadius: 3),
            ]),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Home Delivery",
                        style: CommonStyles.textDataWhite18(),
                      ),
                      Utils.getSizedBox(height: 5),
                      Text(
                        "#OID0" + widget.orderHistory.id!,
                        style: CommonStyles.textDataWhite13(),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  child: Container(
                      height: 100,
                      width: 100,
                      decoration: new BoxDecoration(
                        image: new DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(
                              "assets/images/deliveryboy2.png"),
                        ),
                      )),
                ),
              ],
            ),
          ),
          ExpansionTile(
            initiallyExpanded: true,
            title: Column(
              children: [
                Row(
                  children: [
                    // Text(
                    //   orderHistoryModel.orderHistory![index].status!,
                    //   style: TextStyle(
                    //       color: Colors.black,
                    //       fontSize: 18,
                    //       fontWeight: FontWeight.w600,
                    //       letterSpacing: 0,
                    //       wordSpacing: 1),
                    // ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text(
                      widget.orderHistory.customerName!.customerName!,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0,
                          wordSpacing: 1),
                    ),
                  ],
                ),
              ],
            ),
            subtitle: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 5,
                ),
                Text(
                  "#C2BPDOID0" + widget.orderHistory.id!,
                  style: TextStyle(
                      color: Colors.black54,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 0,
                      wordSpacing: 1),
                ),
                SizedBox(
                  height: 5,
                ),
                widget.orderHistory.productDetails == null
                    ? Text(
                        'Currently items not available'.toUpperCase(),
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 0,
                            wordSpacing: 1),
                      )
                    : Text(
                        "Products Available",
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 0,
                            wordSpacing: 1),
                      ),
                SizedBox(
                  height: 5,
                ),
                Text(widget.orderHistory.status!.toUpperCase()),
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
            trailing: Column(
              children: [
                Neumorphic(
                    style: NeumorphicStyle(
                        shape: NeumorphicShape.concave,
                        boxShape: NeumorphicBoxShape.roundRect(
                            BorderRadius.circular(14)),
                        depth: 8,
                        lightSource: LightSource.topLeft,
                        color: Colors.grey),
                    child: IconButton(
                      icon: Icon(
                        Icons.phone,
                        color: Colors.white,
                      ),
                      onPressed: () async {
                        launchCaller(widget.orderHistory.customerName!.mobile!);
                      },
                    )),
              ],
            ),
            children:
                List.generate(widget.orderHistory.productDetails!.length, (i) {
              return ListTile(
                title:
                    Text(widget.orderHistory.productDetails![i].productName!),
                subtitle: Text('Quantity : ' +
                    widget.orderHistory.productDetails![i].qty!),
                trailing: Text('₹ ' +
                    widget.orderHistory.productDetails![i].price.toString()),
              );
            }).toList(growable: true),
          ),
          // getProperButton(orderHistoryModel.orderHistory![index].status!)
          Visibility(
              visible: widget.orderHistory.status! == "Ordered",
              child: getAcceptRejectButton()),
          Visibility(
              visible: widget.orderHistory.status! == "Ongoing",
              child: getCompleteButton()),
        ],
      ),
    );
  }

  getCompleteButton() {
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
                    "order_id": widget.orderHistory.id,
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

  getAcceptRejectButton() {
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
                  "order_id": widget.orderHistory.id,
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
                  primary: Colors.deepPurple,
                  elevation: 0,
                  padding: EdgeInsets.all(10)),
              onPressed: () async {
                await showDialog(
                    context: context,
                    builder: (context) => dialog(widget.orderHistory.id!));
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
                  color: (Colors.deepPurple)!,
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
                cursorColor: (Colors.deepPurple)!,
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
                            primary: Colors.orange[700],
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
                            primary: Colors.green[800],
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

//Ongoing Order TakwAway And Dining Model

class OrdersOngoingTakeAwayComponent extends StatefulWidget {
  const OrdersOngoingTakeAwayComponent({Key? key, required this.orderHistory})
      : super(key: key);
  final OrderHistory orderHistory;
  @override
  State<OrdersOngoingTakeAwayComponent> createState() =>
      _OrdersOngoingTakeAwayComponentState();
}

class _OrdersOngoingTakeAwayComponentState
    extends State<OrdersOngoingTakeAwayComponent> {
  bool dining = true;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      elevation: 5,
      clipBehavior: Clip.hardEdge,
      shadowColor: Colors.blue[200],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(color: Colors.purple[900], boxShadow: [
              BoxShadow(
                  color: Colors.blue[500]!,
                  offset: Offset(0, 0.75),
                  blurRadius: 5),
            ]),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        dining ? "Dining" : "Take Away",
                        style: CommonStyles.textDataWhite18(),
                      ),
                      Utils.getSizedBox(height: 5),
                      Text(
                        "#OID0" + widget.orderHistory.id!,
                        style: CommonStyles.textDataWhite13(),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  child: dining
                      ? Container(
                          height: 100,
                          width: 150,
                          decoration: new BoxDecoration(
                            image: new DecorationImage(
                                fit: BoxFit.contain,
                                image: AssetImage(
                                    "assets/icons/diningfamily2.jpg")),
                          ))
                      : Container(
                          height: 100,
                          width: 100,
                          decoration: new BoxDecoration(
                            image: new DecorationImage(
                              fit: BoxFit.fill,
                              image: AssetImage("assets/icons/take_away.png"),
                            ),
                          )),
                ),
              ],
            ),
          ),
          ExpansionTile(
            initiallyExpanded: true,
            title: Column(
              children: [
                Row(
                  children: [
                    Text(
                      widget.orderHistory.customerName!.customerName!,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0,
                          wordSpacing: 1),
                    ),
                  ],
                ),
              ],
            ),
            subtitle: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 5,
                ),
                widget.orderHistory.productDetails == null
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
                Text(widget.orderHistory.status!.toUpperCase()),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'View Items'.toUpperCase(),
                  style: TextStyle(
                      color: Colors.deepPurple,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0,
                      wordSpacing: 1),
                ),
              ],
            ),
            trailing: Column(
              children: [
                Neumorphic(
                    style: NeumorphicStyle(
                        shape: NeumorphicShape.concave,
                        boxShape: NeumorphicBoxShape.roundRect(
                            BorderRadius.circular(12)),
                        depth: 8,
                        lightSource: LightSource.topLeft,
                        color: Colors.grey[500]),
                    child: IconButton(
                      icon: Icon(
                        Icons.phone,
                        color: Colors.red,
                      ),
                      onPressed: () async {
                        launchCaller(widget.orderHistory.customerName!.mobile!);
                      },
                    )),
              ],
            ),
            children:
                List.generate(widget.orderHistory.productDetails!.length, (i) {
              return ListTile(
                title:
                    Text(widget.orderHistory.productDetails![i].productName!),
                subtitle: Text('Quantity : ' +
                    widget.orderHistory.productDetails![i].qty!),
                trailing: Text('₹ ' +
                    widget.orderHistory.productDetails![i].price.toString()),
              );
            }).toList(growable: true),
          ),
          // getProperButton(orderHistoryModel.orderHistory![index].status!)
          Visibility(
              visible: widget.orderHistory.status! == "Ordered",
              child: getAcceptRejectButton()),
          Visibility(
              visible: widget.orderHistory.status! == "Ongoing",
              child: getCompleteButton()),
        ],
      ),
    );
  }

  getCompleteButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Colors.green[800],
                    elevation: 0,
                    padding: EdgeInsets.all(8)),
                onPressed: () async {
                  Map param = {
                    "order_id": widget.orderHistory.id,
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

  getAcceptRejectButton() {
    return Row(
      children: [
        SizedBox(
          width: 8,
        ),
        Expanded(
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: Colors.green[800],
                  elevation: 0,
                  padding: EdgeInsets.all(10)),
              onPressed: () async {
                Map param = {
                  "order_id": widget.orderHistory.id,
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
                  primary: Colors.deepPurple,
                  elevation: 0,
                  padding: EdgeInsets.all(10)),
              onPressed: () async {
                await showDialog(
                    context: context,
                    builder: (context) => dialog(widget.orderHistory.id!));
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
                  color: (Colors.deepPurple)!,
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
                cursorColor: (Colors.deepPurple)!,
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
                            primary: Colors.deepPurple,
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
                            primary: Colors.green[800],
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
