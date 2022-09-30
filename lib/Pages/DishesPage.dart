import 'package:mycityfoodvendor/common/common_styles.dart';
import 'package:mycityfoodvendor/common/utils.dart';
import 'package:mycityfoodvendor/service/menu_list_api_provider.dart';
import 'package:flutter/material.dart';
import 'package:mycityfoodvendor/API/api.dart';
import 'package:provider/provider.dart';
import '../model/menu_list_model.dart';

class DishesPage extends StatefulWidget {
  @override
  _DishesPageState createState() => _DishesPageState();
}

class _DishesPageState extends State<DishesPage> {
  bool status = false;
  bool searchEmpty = true;
  final searchKey = GlobalKey<FormState>();
  final searchController = TextEditingController();

  List<ProductList>? productList = [];

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() {
    if (context.read<MenuListAPIProvider>().menuListResponseModel == null) {
      context.read<MenuListAPIProvider>().fetchData().whenComplete(() {
        productList = context
            .read<MenuListAPIProvider>()
            .menuListResponseModel!
            .productList;
      });
    } else {
      productList = context
              .read<MenuListAPIProvider>()
              .menuListResponseModel!
              .productList ??
          [];
    }
  }

  @override
  Widget build(BuildContext context) {
    final menuListApiProvider = Provider.of<MenuListAPIProvider>(context);
    if (menuListApiProvider.ifLoading) {
      return Center(
        child: SizedBox(
          height: 25,
          width: 25,
          child: CircularProgressIndicator(
            strokeWidth: 1,
          ),
        ),
      );
    } else if (menuListApiProvider.menuListResponseModel!.productList == null &&
        menuListApiProvider.menuListResponseModel!.status == "0") {
      return Center(
        child: Text(menuListApiProvider.menuListResponseModel!.message!),
      );
    }
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Form(
            key: searchKey,
            child: TextFormField(
              controller: searchController,
              onChanged: (value) {
                productList = menuListApiProvider
                    .menuListResponseModel!.productList!
                    .where((element) {
                  return element.menuName!
                      .trim()
                      .toUpperCase()
                      .contains(searchController.text.trim().toUpperCase());
                  // return searchController.text
                  //     .trim()
                  //     .toUpperCase()
                  //     .contains();
                }).toList();
                print(" The value is empty  " + value.isEmpty.toString());

                if (value.isEmpty) {
                  productList = context
                      .read<MenuListAPIProvider>()
                      .menuListResponseModel!
                      .productList;
                  searchController.clear();
                  print(" The value is empty  " + value.isEmpty.toString());
                  setState(() {
                    searchEmpty = true;
                  });
                } else {
                  print(productList!.length);
                  setState(() {
                    searchEmpty = false;
                  });
                }
              },
              decoration: InputDecoration(
                hintText: "Search",
                suffixIcon: searchEmpty
                    ? Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: Icon(Icons.search, color: Colors.black87),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: InkWell(
                            onTap: () {
                              productList = context
                                  .read<MenuListAPIProvider>()
                                  .menuListResponseModel!
                                  .productList;
                              setState(() {
                                searchEmpty = true;
                              });
                              searchController.clear();
                            },
                            child: Icon(Icons.clear, color: Colors.black87)),
                      ),
                hintStyle: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'OpenSans'),
                filled: false,
                // fillColor: Colors.white,
                contentPadding:
                    const EdgeInsets.only(left: 14.0, bottom: 6.0, top: 6.0),
                border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    borderSide: BorderSide(
                      width: 3,
                    )),
              ),
            )),
        backgroundColor: Colors.white,
        actions: [],
      ),
      body: buildBody(),
    );
  }

  buildBody() {
    // return FutureBuilder<ForgotModel?>(
    //     future: getapi.getMenuList(context),
    //     builder: (context, snapshot) {
    //       print(snapshot);
    //       if (snapshot.hasData) {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      itemCount: productList!.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Row(
            children: [
              Text(productList![index].menuName!.toUpperCase(),
                  style: CommonStyles.textDataBlack12()),
              Spacer(),
              Switch.adaptive(
                activeColor: Colors.deepPurple,
                value: productList![index].status != "1" ? false : true,
                onChanged: (val) async {
                  print(productList![index].id);
                  setState(() {
                    status = val;
                    print("status + $status");
                  });
                  Map param = {
                    "outlet_id": API.userData,
                    "menu_id": productList![index].id,
                    "status": status != true ? "0" : "1",
                  };
                  showLoading(context);
                  await getapi.menuOnOff(context, param);
                  await context.read<MenuListAPIProvider>().fetchData();
                  productList = context
                      .read<MenuListAPIProvider>()
                      .menuListResponseModel!
                      .productList;
                  setState(() {
                    searchEmpty = true;
                  });
                  searchController.clear();
                  Navigator.of(context).pop();

                  setState(() {});
                },
              ),
            ],
          ),
          subtitle: Text(
            '₹ ' + productList![index].mrp!,
            style: CommonStyles.textDataBlack12(),
          ),
        );
      },
    );
    //   }
    //   return Container();
    // });
  }
}
