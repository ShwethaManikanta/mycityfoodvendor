import 'dart:io';
import 'package:mycityfoodvendor/model/limit_model.dart';
import 'package:mycityfoodvendor/service/limit_list_api_provider.dart';
import 'package:mycityfoodvendor/service/profile_details_api_provider.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:mycityfoodvendor/API/api.dart';
import 'package:mycityfoodvendor/API/update_product_api.dart';
import 'package:mycityfoodvendor/common/cached_network_image.dart';
import 'package:mycityfoodvendor/common/common_styles.dart';
import 'package:mycityfoodvendor/common/common_text_form_field.dart';
import 'package:mycityfoodvendor/common/screen_size.dart';
import 'package:mycityfoodvendor/common/utils.dart';
import 'package:mycityfoodvendor/model/image_api_models.dart';
import 'package:mycityfoodvendor/model/product_model.dart';
import 'package:mycityfoodvendor/model/product_update_model.dart';
import 'package:mycityfoodvendor/model/recently_added_products_model.dart';
import 'package:mycityfoodvendor/service/add_product_api_provider.dart';
import 'package:mycityfoodvendor/service/image_picker_service.dart';
import 'package:mycityfoodvendor/service/recent_product_api_provider.dart';
import 'package:provider/provider.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  void initState() {
    super.initState();
    initializeRecentAddedProducts();
  }

  void initializeRecentAddedProducts() {
    if (context.read<RecentAddedProductsAPIProvider>().productDetails == null) {
      context
          .read<RecentAddedProductsAPIProvider>()
          .fetchProduct()
          .then((value) {
        searchList = context
            .read<RecentAddedProductsAPIProvider>()
            .productDetails!
            .productDetails;
      });
    } else {
      searchList = context
          .read<RecentAddedProductsAPIProvider>()
          .productDetails!
          .productDetails;
    }
    setState(() {});
  }

  final searchController = TextEditingController();
  final searchKey = GlobalKey<FormState>();
  List<RProductDetails>? searchList = [];

  bool searchEmpty = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          flexibleSpace: appBar(),
        ),
        floatingActionButton: floatingActionbutton(context),
        body: body(context));
  }

  appBar() {
    final recentlyAddedAPIProvider =
        Provider.of<RecentAddedProductsAPIProvider>(context);
    if (recentlyAddedAPIProvider.productDetails == null) {
      return Center(
        child: SizedBox(
          height: 25,
          width: 25,
          child: CircularProgressIndicator(
            strokeWidth: 1,
          ),
        ),
      );
    } else if (recentlyAddedAPIProvider.productDetails!.productDetails ==
        null) {
      return Center(
        child: Text(recentlyAddedAPIProvider.productDetails!.message!),
      );
    }
    return ListTile(
      title: Form(
          key: searchKey,
          child: TextFormField(
            controller: searchController,
            onChanged: (value) {
              searchList = recentlyAddedAPIProvider
                  .productDetails!.productDetails!
                  .where((element) {
                return element.productName!
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
                searchList = context
                    .read<RecentAddedProductsAPIProvider>()
                    .productDetails!
                    .productDetails;
                searchController.clear();
                print(" The value is empty  " + value.isEmpty.toString());
                setState(() {
                  searchEmpty = true;
                });
              } else {
                print(searchList!.length);
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
                            searchList = context
                                .read<RecentAddedProductsAPIProvider>()
                                .productDetails!
                                .productDetails;
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
      // backgroundColor: Colors.white,
    );
  }

  Widget body(BuildContext context) {
    final recentlyAddedAPIProvider =
        Provider.of<RecentAddedProductsAPIProvider>(context);
    if (recentlyAddedAPIProvider.productDetails == null) {
      return Center(
        child: SizedBox(
          height: 25,
          width: 25,
          child: CircularProgressIndicator(
            strokeWidth: 1,
          ),
        ),
      );
    } else if (recentlyAddedAPIProvider.productDetails!.productDetails ==
        null) {
      return Center(
        child: Text(recentlyAddedAPIProvider.productDetails!.message!),
      );
    }
    return RefreshIndicator(
      onRefresh: () async {
        await context.read<RecentAddedProductsAPIProvider>().fetchProduct();
        searchList = context
            .read<RecentAddedProductsAPIProvider>()
            .productDetails!
            .productDetails;
        setState(() {});
      },
      child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisExtent: 420,
              crossAxisCount: 2,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5),
          itemCount: searchList!.length,
          itemBuilder: (context, index) {
            return GridViewBox(
              productModel: searchList![index],
              imageUrl:
                  recentlyAddedAPIProvider.productDetails!.productImageUrl!,
            );
          }),
    );
  }

  Widget? floatingActionbutton(BuildContext context) {
    final profileModelAPIProvider =
        Provider.of<ProfileModelAPIProvider>(context);
    print(" profileModelAPIProvider.profileModel!.userDetails!.outletMainId " +
        profileModelAPIProvider.profileModel!.userDetails!.outletMainId
            .toString());
    print(" profileModelAPIProvider.profileModel!.userDetails!.outletMainId " +
        profileModelAPIProvider.profileModel!.userDetails!.outletMainId
            .toString());
    if (profileModelAPIProvider.ifLoading) {
      return Utils.getLoadingCenter25();
    } else if (profileModelAPIProvider.error) {
      return Utils.showErrorMessage(profileModelAPIProvider.errorMessage);
    } else if (profileModelAPIProvider.profileModel != null &&
        profileModelAPIProvider.profileModel!.status == "0") {
      return Utils.showErrorMessage(
          profileModelAPIProvider.profileModel!.message!);
    } else if (profileModelAPIProvider
            .profileModel!.userDetails!.outletMainId ==
        "") {
      return FloatingActionButton.extended(
        backgroundColor: Colors.lightGreen,
        onPressed: () async {
          await Navigator.of(context)
              .push(MaterialPageRoute(
                  builder: (context) => AddProductForGroceries()))
              .whenComplete(() {
            searchList = context
                .read<RecentAddedProductsAPIProvider>()
                .productDetails!
                .productDetails;
            setState(() {});
          });
        },
        label: Text(
          "Add Product",
          style: CommonStyles.textDataWhite15(),
        ),
        icon: const Icon(
          Icons.add,
          color: Colors.white,
          size: 20,
        ),
      );
    }
    return null;
  }
}

class AddProductForGroceries extends StatefulWidget {
  const AddProductForGroceries({Key? key, this.productModel, this.baseUrl})
      : super(key: key);

  final RProductDetails? productModel;
  final String? baseUrl;
  @override
  _AddGrocery createState() => _AddGrocery();
}

class _AddGrocery extends State<AddProductForGroceries> {
  final productNameKey = GlobalKey<FormState>();
  final salePriceKey = GlobalKey<FormState>();
  final mrpKey = GlobalKey<FormState>();
  final qtyKey = GlobalKey<FormState>();
  final discountKey = GlobalKey<FormState>();
  final gstKey = GlobalKey<FormState>();
  final stockKey = GlobalKey<FormState>();
  final containerCharge = GlobalKey<FormState>();
  final typeKey = GlobalKey<FormState>();
  final qtyTypeKey = GlobalKey<FormState>();
  final taxKey = GlobalKey<FormState>();
  final restaruantKey = GlobalKey<FormState>();
  final descriptionKey = GlobalKey<FormState>();

  final categoryController = TextEditingController();
  final productNameController = TextEditingController();
  final salePriceController = TextEditingController();
  final mrpController = TextEditingController();
  final restaruantController = TextEditingController();
  final discountController = TextEditingController();
  final gstController = TextEditingController();
  final qtyController = TextEditingController();
  final stockController = TextEditingController();
  final descriptionController = TextEditingController();
  final containerChargeController = TextEditingController();
  final typeController = TextEditingController();
  final selectedCategoryID = TextEditingController();

  String? _productImage;

  //Date Time Picker
  DateTime selectedDate = DateTime.now();
  bool isLoading = true;

  // Future<void> getProfileData() async {
  //   await apiService.fetchAlbum({"user_id": API.userData}).then((value) {
  //     print("USER ID  --------------------    ----->>>>${API.userData}");
  //     setState(() {
  //       _profileModel = value;
  //       print("-----------------  GET PROFILE DATA");
  //       isLoading = false;
  //     });
  //   });
  // }

  LimitsList? choiceOfUnit;

  @override
  void initState() {
    getSearchFood();
    context.read<LimitListAPIProvider>().getList();

    if (widget.productModel != null) {
      print('--------------- qty' + widget.productModel!.qty!);

      _productImage = widget.productModel!.productImage!;
      productNameController.text = widget.productModel!.productName!;
      salePriceController.text = widget.productModel!.salePrice!;
      mrpController.text = widget.productModel!.mrp!;
      discountController.text = widget.productModel!.discount!;
      stockController.text = widget.productModel!.productStock!;
      descriptionController.text = widget.productModel!.description!;
      containerChargeController.text = widget.productModel!.packingTax!;
      gstController.text = widget.productModel!.serviceTax!;
      taxTypeInitialized = widget.productModel!.taxType;
      categoryTypeValue = widget.productModel!.resType == ""
          ? "Select Food Type"
          : widget.productModel!.resType == "1"
              ? "Veg"
              : "Non-Veg";
      // containerChargeController.text = widget.productModel.
      // resTypeValue = widget.productModel!.resType == null
      //     ? "Restaruant"
      //     : widget.productModel!.resType == "1"
      //         ? "Restaruant"
      //         : widget.productModel!.resType == "2"
      //             ? "Meat"
      //             : "Bakery";

      qtyController.text =
          widget.productModel!.qty != null ? widget.productModel!.qty! : "";

      print("category type value ----- - - - - - - -" +
          categoryTypeValue.toString());
      if (context
              .read<ProfileModelAPIProvider>()
              .profileModel!
              .userDetails!
              .foodTypeId !=
          "1") {
        if (widget.productModel!.qty_type != "") {
          if (context.read<LimitListAPIProvider>().limitListResponseModel ==
              null) {
            context.read<LimitListAPIProvider>().getList().whenComplete(() {
              choiceOfUnit = context
                  .read<LimitListAPIProvider>()
                  .limitListResponseModel!
                  .limitsList!
                  .firstWhere((element) =>
                      element.id == widget.productModel!.qty_type!);
            });
          } else {
            choiceOfUnit = context
                .read<LimitListAPIProvider>()
                .limitListResponseModel!
                .limitsList!
                .firstWhere(
                    (element) => element.id == widget.productModel!.qty_type!);
          }
        }

        // print(widget.productModel!.resType);
        // print("-----------res type --------" + resTypeValue.toString());
      }
      print("category type value" + categoryTypeValue.toString());
      // choiceOfUnit =     widget.productModel!.qty_type!;
    }

    super.initState();
  }

  getTaxString(String id) {
    if (id == "1") {
      return "Including Tax";
    } else {
      return "Excluding Tax";
    }
  }

  @override
  void dispose() {
    super.dispose();
    productNameController.clear();
    salePriceController.clear();
    mrpController.clear();
    discountController.clear();
    gstController.clear();
    stockController.clear();
    descriptionController.clear();
    containerChargeController.clear();
    productNameController.dispose();
    salePriceController.dispose();
    mrpController.dispose();
    discountController.dispose();
    gstController.dispose();
    stockController.dispose();
    descriptionController.dispose();
    containerChargeController.dispose();
    qtyController.dispose();
  }

  appBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back,
          size: 25,
          color: Colors.black,
        ),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      flexibleSpace: Container(
        decoration: const BoxDecoration(color: Colors.white),
      ),
      elevation: 0,
      centerTitle: true,
      backgroundColor: Color.fromARGB(255, 245, 81, 6),
      title: widget.productModel == null
          ? Text(
              "Add Product",
              style: CommonStyles.textHeaderBlack16(),
            )
          : Text(
              "Edit Product",
              style: CommonStyles.textHeaderBlack16(),
            ),
    );
  }

  File selectedProductImageFile = File('');
  var taxTypeInitialized;
  var taxTypeValue;
  List<String> taxType = ["Including Tax", "Excluding Tax"];

  String? categoryTypeValue;
  List<String> categoryType = ["Veg", "Non-Veg"];

  dropDownButton() {
    final limitListAPIProvider = Provider.of<LimitListAPIProvider>(context);
    if (limitListAPIProvider.ifLoading) {
      return Utils.getLoadingCenter25();
    } else if (limitListAPIProvider.error) {
      return Utils.showErrorMessage(limitListAPIProvider.errorMessage);
    } else if (limitListAPIProvider.limitListResponseModel != null &&
        limitListAPIProvider.limitListResponseModel!.status == "0") {
      return Utils.showErrorMessage(
          limitListAPIProvider.limitListResponseModel!.message!);
    }
    final limitList = limitListAPIProvider.limitListResponseModel!.limitsList;

    //       child: Container(
//           height: 50,
//           decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(5),
//               border: Border.all(color: Colors.black, width: 0.7)),
//           child: dropDownButton()),
//     );
    return Padding(
      padding: EdgeInsets.only(left: 8),
      child: Container(
        height: 47,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: Colors.black, width: 0.7)),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<LimitsList>(
            isDense: true,
            hint: Container(
              margin: EdgeInsets.all(8),
              padding: const EdgeInsets.only(left: 6.0, top: 3),
              child: FittedBox(
                child: Text(
                  "Quantity Type",
                  overflow: TextOverflow.fade,
                  style: TextStyle(fontSize: 14),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            alignment: Alignment.center,
            // value: limitList![int.parse(choiceOfUnit.toString())],
            value: choiceOfUnit == null
                ? null
                : limitList!
                    .firstWhere((element) => element.id == choiceOfUnit!.id!),

            onChanged: (newValue) async {
              setState(() {
                choiceOfUnit = newValue!;
              });
              print(choiceOfUnit);
            },
            items: limitList!.map((LimitsList value) {
              return DropdownMenuItem<LimitsList>(
                value: value,
                child: FittedBox(
                  child: Text(
                    value.limits!,
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final imagePickerService = Provider.of<ImagePickerService>(context);
    final profileModelAPIProvider =
        Provider.of<ProfileModelAPIProvider>(context);

    return Scaffold(
        appBar: appBar(context),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: SizedBox(
                      height: 100,
                      width: 100,
                      child: selectedProductImageFile.path == File('').path &&
                              widget.productModel != null
                          ? InkWell(
                              onTap: () async {
                                final result = await imagePickerService
                                    .chooseImageFile(context);
                                if (result != null) {
                                  setState(() {
                                    selectedProductImageFile = result;
                                  });
                                }
                              },
                              child: _productImage == "" ||
                                      _productImage == null
                                  ? Container(
                                      height: 100,
                                      width: 100,
                                      decoration: BoxDecoration(
                                        // borderRadius: const BorderRadius.all(Radius.circular(50)),
                                        border: Border.all(
                                            color: Colors.black, width: 0.1),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Add Image",
                                            style:
                                                CommonStyles.textDataBlack13(),
                                          ),
                                          // if (imageFile.path == null) Text("Image Not Available")
                                        ],
                                      ),
                                    )
                                  : cachedNetworkImage(100, 100,
                                      widget.baseUrl! + _productImage!),
                            )
                          : ProductImageBox(
                              imageFile: selectedProductImageFile,
                              radius: 0,
                              onPressed: () async {
                                final result = await imagePickerService
                                    .chooseImageFile(context);
                                if (result != null) {
                                  setState(() {
                                    selectedProductImageFile = result;
                                  });
                                }
                              })
                      // :
                      // selectedProductImageFile.path != File('').path
                      //     ? ProductImageBox(
                      //         imageFile: selectedProductImageFile,
                      //         radius: 0,
                      //         onPressed: () async {
                      //           final result = await imagePickerService
                      //               .chooseImageFile(context);
                      //           setState(() {
                      //             selectedProductImageFile = result;
                      //           });
                      //         })
                      // :

                      // selectedProductImageFile.path == File('').path
                      // ?
                      // Center(
                      //     child: Text(
                      //       "Image Not Available !! \n Choose Image",
                      //       textAlign: TextAlign.center,
                      //     ),
                      //   )
                      ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: width(context) * 0.93,
                            child: Form(
                              key: productNameKey,
                              child: itemNameTextField(
                                productNameController,
                                "Product Name",
                                "Item Name",
                                this.context,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Visibility(
                            visible: profileModelAPIProvider
                                    .profileModel!.userDetails!.foodTypeId !=
                                "2",
                            child: Expanded(
                              flex: 2,
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 5),
                                height: 47,
                                padding: EdgeInsets.only(left: 5),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                        color: Colors.black, width: 0.7)),
                                child: SizedBox(
                                  child: Form(
                                    key: taxKey,
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton<String>(
                                        hint: Padding(
                                          padding: EdgeInsets.only(left: 6.0),
                                          child: Text(
                                            widget.productModel != null &&
                                                    widget.productModel!
                                                            .taxType !=
                                                        null &&
                                                    widget.productModel!
                                                            .taxType !=
                                                        ""
                                                ? getTaxString(widget
                                                    .productModel!.taxType!)
                                                : "Tax Type *",
                                            style: TextStyle(fontSize: 14),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),

                                        alignment: Alignment.center,
                                        value: taxTypeValue,

                                        //isDense: true,
                                        onChanged: (newValue) async {
                                          setState(() {
                                            taxTypeValue = newValue;
                                          });
                                          print(taxTypeValue);
                                        },
                                        items: profileModelAPIProvider
                                                    .profileModel!
                                                    .userDetails!
                                                    .restaurantType ==
                                                "1"
                                            ? taxType.map((String value) {
                                                return DropdownMenuItem<String>(
                                                  value: value,
                                                  child: Text(
                                                    value,
                                                    style:
                                                        TextStyle(fontSize: 14),
                                                  ),
                                                );
                                              }).toList()
                                            : taxType.map((String value) {
                                                return DropdownMenuItem<String>(
                                                  value: value,
                                                  child: Text(
                                                    value,
                                                    style:
                                                        TextStyle(fontSize: 14),
                                                  ),
                                                );
                                              }).toList(),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5),
                              child: SizedBox(
                                // width: MediaQuery.of(context).size.width * 0.3,
                                child: Form(
                                  key: salePriceKey,
                                  child: textEditNumericData(
                                      salePriceController,
                                      "Sale Price",
                                      TextInputType.number,
                                      "Sale Price"),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5),
                              child: SizedBox(
                                // width: MediaQuery.of(context).size.width * 0.2,
                                child: Form(
                                  key: mrpKey,
                                  child: textEditNumericData(mrpController,
                                      "MRP", TextInputType.number, "MRP"),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.6,
                            child: Form(
                              key: containerCharge,
                              child: textEditNumericData(
                                  containerChargeController,
                                  "Container Charge",
                                  TextInputType.number,
                                  "Container Charge"),
                            ),
                          ),
                          SizedBox(height: 20),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.3,
                            child: Form(
                              key: discountKey,
                              child: textEditNumericData(
                                discountController,
                                "Discount Precentage",
                                TextInputType.number,
                                "Discount %",
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.6,
                            child: Form(
                              key: gstKey,
                              child: textEditNumericData(
                                  gstController,
                                  "GST Percentage",
                                  TextInputType.number,
                                  "GST %"),
                            ),
                          ),
                          SizedBox(
                            // margin: EdgeInsets.fromLTRB(8, 8, 8, 15),
                            width: MediaQuery.of(context).size.width * 0.3,
                            child: Form(
                              key: stockKey,
                              // onChanged: () => setState(
                              //     () => _submit = dob_key.currentState.validate()),
                              child: textEditNumericData(
                                stockController,
                                "Stock ",
                                TextInputType.number,
                                "Stock ",
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          // Container(
                          //   padding: EdgeInsets.only(left: 15),
                          //   width:
                          //       MediaQuery.of(context).size.width * 0.6,
                          //   height: 42,
                          //   decoration: BoxDecoration(
                          //       borderRadius: BorderRadius.circular(5),
                          //       border: Border.all(
                          //           color: Colors.black, width: 0.7)),
                          //   child: SizedBox(
                          //     child: Form(
                          //       key: restaruantKey,
                          //       child: DropdownButtonHideUnderline(
                          //         child: DropdownButton<String>(
                          //           hint: Padding(
                          //             padding: EdgeInsets.only(left: 6.0),
                          //             child: Text(
                          //               "Restaruant Type *",
                          //               textAlign: TextAlign.center,
                          //               style: TextStyle(fontSize: 14),
                          //             ),
                          //           ),
                          //           // alignment: Alignment.center,
                          //           value: resTypeValue,
                          //           //isDense: true,
                          //           onChanged: (newValue) {
                          //             setState(() {
                          //               resTypeValue = newValue;
                          //             });
                          //             print(resTypeValue);
                          //           },
                          //           items: restaruantType
                          //               .map((String value) {
                          //             return DropdownMenuItem<String>(
                          //               value: value,
                          //               child: Text(
                          //                 value,
                          //                 style: TextStyle(fontSize: 14),
                          //               ),
                          //             );
                          //           }).toList(),
                          //         ),
                          //       ),
                          //     ),
                          //   ),
                          // ),
                          Container(
                            height: 45,
                            width: deviceWidth(context) * 0.92,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                    color: Colors.black, width: 0.7)),
                            child: Form(
                              key: typeKey,
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  hint: Padding(
                                    padding: EdgeInsets.only(left: 3.0),
                                    child: Text(
                                      "Food Type *",
                                      style: TextStyle(fontSize: 14),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  alignment: Alignment.center,
                                  value: categoryTypeValue,
                                  //isDense: true,
                                  onChanged: (newValue) async {
                                    setState(() {
                                      categoryTypeValue = newValue;
                                    });

                                    print(categoryTypeValue);
                                  },
                                  items: categoryType.map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: FittedBox(
                                        child: Text(
                                          value,
                                          style: TextStyle(fontSize: 14),
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                              // width:
                              //     MediaQuery.of(context).size.width * 0.5,
                              flex: 1,
                              // : MediaQuery.of(context).size.width *
                              //     0.93,
                              child: Form(
                                key: qtyKey,
                                child: textEditNumericData(
                                    qtyController,
                                    "Quantity",
                                    TextInputType.number,
                                    "Quantity"),
                              ),
                            ),
                            Visibility(
                                visible: profileModelAPIProvider.profileModel!
                                        .userDetails!.foodTypeId !=
                                    "1",
                                child:
                                    Expanded(flex: 1, child: dropDownButton()))
                            // Container(
                            //   width:
                            //       MediaQuery.of(context).size.width * 0.4,
                            //   height: 50,
                            //   decoration: BoxDecoration(
                            //       borderRadius: BorderRadius.circular(5),
                            //       border: Border.all(
                            //           color: Colors.black, width: 0.7)),
                            //   child: Form(
                            //     key: qtyTypeKey,
                            //     child: DropdownButtonHideUnderline(
                            //       child: DropdownButton<String>(
                            //         isDense: true,
                            //         hint: Container(
                            //           margin: EdgeInsets.all(8),
                            //           padding: const EdgeInsets.only(
                            //               left: 6.0, top: 3),
                            //           child: FittedBox(
                            //             child: Text(
                            //               "Quantity Type",
                            //               overflow: TextOverflow.fade,
                            //               style: TextStyle(fontSize: 14),
                            //               textAlign: TextAlign.center,
                            //             ),
                            //           ),
                            //         ),
                            //         alignment: Alignment.center,
                            //         value: quantityTypeValue,
                            //         //isDense: true,
                            //         onChanged: (newValue) async {
                            //           setState(() {
                            //             quantityTypeValue = newValue;
                            //           });
                            //           print(quantityTypeValue);
                            //         },
                            //         items: quantityType.map((String value) {
                            //           return DropdownMenuItem<String>(
                            //             value: value,
                            //             child: FittedBox(
                            //               child: Text(
                            //                 value,
                            //                 style: TextStyle(fontSize: 14),
                            //               ),
                            //             ),
                            //           );
                            //         }).toList(),
                            //       ),
                            //     ),
                            //   ),
                            // )
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      SizedBox(
                        height: 45,
                        child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: food != null
                                ? DropdownSearch(
                                    mode: Mode.DIALOG,
                                    items: food,
                                    //  selectedItem: widget.productModel !=null? widget.productModel.,
                                    onChanged: (value) {
                                      print(value.toString());
                                      int index =
                                          food!.indexOf(value!.toString());
                                      print("Selected Index ID" + food![index]);
                                      selectedId = id![index];
                                      print("----" + selectedId);
                                    },
                                    showSearchBox: true,
                                    enabled: true,
                                    label: widget.productModel == null ||
                                            widget.productModel!.categoryId ==
                                                null ||
                                            widget.productModel!.categoryId ==
                                                "" ||
                                            widget.productModel!.categoryName ==
                                                "" ||
                                            widget.productModel!.categoryId ==
                                                null
                                        ? "Category Based"
                                        : widget.productModel!.categoryName!,
                                  )
                                : SizedBox(
                                    width: 25,
                                    height: 15,
                                    child: Center(
                                      child: CircularProgressIndicator(
                                        strokeWidth: 1,
                                      ),
                                    ),
                                  )),
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.92,
                            child: Form(
                              key: descriptionKey,
                              child: textEditMultiLine(
                                  descriptionController,
                                  "Description",
                                  TextInputType.text,
                                  "Description"),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      SizedBox(
                        width: width(context) * 0.7,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (widget.productModel == null) {
                              addProduct();
                            } else {
                              updateProduct();
                            }
                          },
                          style: ButtonStyle(
                              overlayColor: MaterialStateProperty.all<Color>(
                                  Colors.transparent),
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  Colors.yellow[900]!),
                              padding:
                                  MaterialStateProperty.all<EdgeInsetsGeometry>(
                                      const EdgeInsets.only(
                                          top: 12,
                                          bottom: 12,
                                          left: 6,
                                          right: 6)),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.yellow[900]!),
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      side: BorderSide(color: Colors.blue[900]!)))),
                          child: Center(
                              child: widget.productModel == null
                                  ? Text('ADD PRODUCT',
                                      style: CommonStyles.textDataWhite15())
                                  : Text('UPDATE PRODUCT',
                                      style: CommonStyles.textDataWhite15())),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  String selectedId = "";
  List<String>? food = [];
  List<String>? id = [];

  Future getSearchFood() async {
    final profileModelAPIProvider =
        Provider.of<ProfileModelAPIProvider>(context, listen: false);
    final result = await getapi.searchFood(
        profileModelAPIProvider.profileModel!.userDetails!.restaurantType!, "");
    print("category length :" + result!.categoryList!.length.toString());
    setState(() {
      result.categoryList!.forEach((element) {
        food!.add(element.category!);
        id!.add(element.id!);
      });
    });

    print("food Length${food!.length}");
    return food;
  }

  addProduct() async {
    final addProductAPIProvider =
        Provider.of<AddProductAPiProvider>(context, listen: false);
    final profileModelAPIProvider =
        Provider.of<ProfileModelAPIProvider>(context, listen: false);
    ImageUploadResponse? imageUploadResponse;
    if (profileModelAPIProvider.profileModel!.userDetails!.foodTypeId! != "2" &&
        taxTypeValue == null) {
      Utils.getSnackBar(context, "Tax Type is Mandatory");
    } else {
      if (productNameKey.currentState!.validate() &&
          salePriceKey.currentState!.validate() &&
          descriptionKey.currentState!.validate() &&
          typeKey.currentState!.validate() &&
          selectedId != "") {
        if (selectedProductImageFile.path != File("").path) {
          print(
              "selectedProductImageFile ---------------- ${selectedProductImageFile.path}");
          imageUploadResponse =
              await getapi.uploadImage(selectedProductImageFile);
        }
        final addProductModel = AddProductRequestModel(
            productImage: imageUploadResponse == null
                ? ""
                : imageUploadResponse.fileName!,
            restaruantType: "",
            description: descriptionController.text,
            taxType: returnTaxTypeValue(taxTypeValue ?? "2"),
            discount: discountController.text,
            productName: productNameController.text,
            mrp: mrpController.text,
            packingTax: containerChargeController.text,
            salePrice: salePriceController.text,
            serviceTax: gstController.text,
            stock: stockController.text,
            containerCharges: containerChargeController.text,
            categoryId: selectedId.toString(),
            foodType: categoryTypeValue == "Veg" ? "1" : "2",
            quantity: qtyController.text,
            quantityType: choiceOfUnit == null ? "" : choiceOfUnit!.id!,
            vendorId: API.userData);

        showLoading(context);
        await addProductAPIProvider.addProduct(
            addProductRequestModel: addProductModel);

        if (addProductAPIProvider.profileDetails != null) {
          Utils.getSnackBar(context, "Succefully Added Product");
          productNameController.clear();
          salePriceController.clear();
          mrpController.clear();
          discountController.clear();
          gstController.clear();
          stockController.clear();
          categoryController.clear();
          containerChargeController.clear();
          descriptionController.clear();
          selectedProductImageFile = File('');
          await context.read<RecentAddedProductsAPIProvider>().fetchProduct();
          Navigator.of(context).pop();

          Navigator.of(context).pop();
        } else if (imageUploadResponse == null) {
          Utils.getSnackBar(
            context,
            "Oops Something went wrong",
          );
          Navigator.of(context).pop();
        }

        //   else {
        //   Utils.getSnackBar(context, imageUploadResponse.message!);
        //   Navigator.of(context).pop();
        // }
      } else if (selectedId == "") {
        print("Selected Id" + selectedId.toString());
        Utils.getSnackBar(context, "Please Select Category Based");
      } else {
        print("Selected Id" + selectedId.toString());

        Utils.getSnackBar(context, "Please Fill All Required Details");
      }
    }
  }

  String returnTaxTypeValue(String taxType) {
    if (taxType == "Including Tax") {
      return "1";
    } else {
      return "2";
    }
  }
  /*else {
      Utils.getSnackBar(context, "Image is required");
    }*/
  // }

  updateProduct() async {
    final updateProviderAPIProvider =
        Provider.of<UpdateProductAPIProvider>(context, listen: false);
    if (productNameKey.currentState!.validate() &&
        salePriceKey.currentState!.validate() &&
        descriptionKey.currentState!.validate() &&
        typeKey.currentState!.validate()) {
      print(" the category type ------------ ------- - - - - - - - - " +
          categoryTypeValue.toString());
      showLoading(context);
      ImageUploadResponse? imageUploadResponse;
      if (selectedProductImageFile.path != File("").path) {
        imageUploadResponse =
            await getapi.uploadImage(selectedProductImageFile);
        print("inside image response");
      }
      final updateResponeModel = UpdateProductRequestModel(
          restaruantType: "",
          taxType: taxTypeValue == null && taxTypeInitialized != ""
              ? taxTypeInitialized
              : taxTypeValue,
          productId: widget.productModel!.id!,
          categoryId: widget.productModel!.categoryId == null
              ? selectedId.toString()
              : widget.productModel!.categoryId!,
          vendorId: API.userData,
          stock: stockController.text,
          foodType: categoryTypeValue != null
              ? categoryTypeValue == "Veg"
                  ? "1"
                  : "2"
              : widget.productModel!.resType!,
          quantity: qtyController.text,
          quantityType: choiceOfUnit == null
              ? widget.productModel!.qty_type!
              : choiceOfUnit!.id!,
          serviceTax: gstController.text,
          salePrice: salePriceController.text,
          packingTax: containerChargeController.text,
          mrp: mrpController.text,
          productName: productNameController.text,
          discount: discountController.text,
          description: descriptionController.text,
          productImage: selectedProductImageFile.path != File("").path
              ? imageUploadResponse!.fileUrl!
              : widget.productModel!.productImage!);

      await updateProviderAPIProvider.updateProductInfo(
          updateProductRequestModel: updateResponeModel);

      Utils.getSnackBar(context, "Succefully Updated Product");

      productNameController.clear();
      salePriceController.clear();
      mrpController.clear();

      discountController.clear();
      gstController.clear();
      stockController.clear();
      categoryController.clear();
      containerChargeController.clear();
      descriptionController.clear();
      selectedProductImageFile = File('');
      await context.read<RecentAddedProductsAPIProvider>().fetchProduct();

      Navigator.of(context).pop();
      Navigator.of(context).pop();

      /* else if (result == null) {
        Utils.getSnackBar(
          context,
          "Oops Something went wrong",
        );
        Navigator.of(context).pop();
      } else {
        Utils.getSnackBar(context, result.message!);
        Navigator.of(context).pop();
      }*/
    } else {
      Utils.getSnackBar(context, "* Mandatory fields required");
    }
  }
}

class GridViewBox extends StatefulWidget {
  const GridViewBox(
      {Key? key, required this.imageUrl, required this.productModel})
      : super(key: key);

  final RProductDetails productModel;
  final String imageUrl;

  @override
  State<GridViewBox> createState() => _GridViewBoxState();
}

class _GridViewBoxState extends State<GridViewBox> {
  @override
  Widget build(BuildContext context) {
    return recentlyAddedProduct(context);
  }

  Widget recentlyAddedProduct(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.yellow),
          borderRadius: BorderRadius.circular(10)),
      //  height: 450,
      child: Column(
        children: [
          SizedBox(
            height: 200,
            width: double.infinity,
            child: widget.productModel.productImage == null ||
                    widget.imageUrl + widget.productModel.productImage! ==
                        "http://closetobuy.com/closetobuy/uploads/menu/"
                ? Center(
                    child: Text("Image Not Uploaded"),
                  )
                : NetworkImageViewWithHeightWidth(
                    photoUrl:
                        widget.imageUrl + widget.productModel.productImage!,
                    radius: 10,
                    borderColor: Colors.white,
                    borderWidth: 0.3,
                    width: 200,
                    height: 200),
          ),
          SizedBox(
            width: 190,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: RichText(
                    overflow: TextOverflow.ellipsis,
                    text: TextSpan(
                      text: 'Name : ',
                      style: CommonStyles.textDataBlack13(),
                      children: <TextSpan>[
                        TextSpan(
                          text: widget.productModel.productName,
                          style: CommonStyles.textDataBlack15(),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 7),
                RichText(
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(
                    text: 'Sale Price : ',
                    style: CommonStyles.textDataBlack13(),
                    children: <TextSpan>[
                      TextSpan(
                        text: widget.productModel.salePrice,
                        style: CommonStyles.textDataBlack15(),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 7),
                RichText(
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(
                    text: 'MRP : ',
                    style: CommonStyles.textDataBlack13(),
                    children: <TextSpan>[
                      TextSpan(
                        text: widget.productModel.mrp,
                        style: CommonStyles.textDataBlack15(),
                      )
                    ],
                  ),
                ),
                /* Row(
                  children: [
                    SizedBox(height: 7),
                    RichText(
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(
                        text: 'Quantity : ',
                        style: CommonStyles.textDataBlack13(),
                        children: <TextSpan>[
                          TextSpan(
                            text: widget.productModel.qty,
                            style: CommonStyles.textDataBlack15(),
                          )
                        ],
                      ),
                    ),
                  ],
                ),*/
                SizedBox(height: 7),
                RichText(
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(
                    text: 'Discount : ',
                    style: CommonStyles.textDataBlack13(),
                    children: <TextSpan>[
                      TextSpan(
                        text: widget.productModel.discount,
                        style: CommonStyles.textDataBlack15(),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 7),
                RichText(
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(
                    text: 'Service Tax : ',
                    style: CommonStyles.textDataBlack13(),
                    children: <TextSpan>[
                      TextSpan(
                        text: widget.productModel.serviceTax,
                        style: CommonStyles.textDataBlack15(),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 7),
                RichText(
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(
                    text: 'Stock : ',
                    style: CommonStyles.textDataBlack13(),
                    children: <TextSpan>[
                      TextSpan(
                        text: widget.productModel.productStock,
                        style: CommonStyles.textDataBlack15(),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 7),
                RichText(
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(
                    text: 'Packing Tax : ',
                    style: CommonStyles.textDataBlack13(),
                    children: <TextSpan>[
                      TextSpan(
                        text: widget.productModel.packingTax,
                        style: CommonStyles.textDataBlack15(),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 7),
                /*RichText(
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(
                    text: 'Category : ',
                    style: CommonStyles.textDataBlack13(),
                    children: <TextSpan>[
                      TextSpan(
                        text: productModel.,
                        style: CommonStyles.textDataBlack15(),
                      )
                    ],
                  ),
                ),*/

                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Row(
                        children: [
                          Text(
                            widget.productModel.approvelStatus == "1"
                                ? "Verified"
                                : "Not Verify",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: widget.productModel.approvelStatus == "1"
                                    ? Colors.green
                                    : Colors.red),
                          ),
                          Icon(
                            widget.productModel.approvelStatus == "1"
                                ? Icons.check_circle
                                : Icons.cancel,
                            color: widget.productModel.approvelStatus == "1"
                                ? Colors.green
                                : Colors.red,
                            size: 16,
                          )
                        ],
                      ),
                    ),
                    // InkWell(
                    //   onTap: () {
                    //     Navigator.of(context).push(MaterialPageRoute(
                    //         builder: (context) => AddProductForGroceries(
                    //             productModel: widget.productModel,
                    //             baseUrl: widget.imageUrl)));
                    //   },
                    //   child: Container(
                    //     padding: EdgeInsets.all(4),
                    //     decoration: BoxDecoration(
                    //         color: Colors.lightGreen,
                    //         borderRadius: BorderRadius.circular(6)),
                    //     width: 80,
                    //     child: Row(
                    //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //       children: [
                    //         Text(
                    //           "Edit",
                    //           style: TextStyle(
                    //               fontSize: 14, fontWeight: FontWeight.bold),
                    //         ),
                    //         Icon(
                    //           Icons.edit_outlined,
                    //           size: 14,
                    //         )
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    toShowEditOption()
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  toShowEditOption() {
    final profileModelAPIProvider =
        Provider.of<ProfileModelAPIProvider>(context);

    if (profileModelAPIProvider.ifLoading) {
      return Utils.getLoadingCenter25();
    } else if (profileModelAPIProvider.error) {
      return Utils.showErrorMessage(profileModelAPIProvider.errorMessage);
    } else if (profileModelAPIProvider.profileModel != null &&
        profileModelAPIProvider.profileModel!.status == "0") {
      return Utils.showErrorMessage(
          profileModelAPIProvider.profileModel!.message!);
    }
    if (profileModelAPIProvider.profileModel!.userDetails!.outletMainId !=
            null &&
        profileModelAPIProvider.profileModel!.userDetails!.outletMainId == "") {
      return InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => AddProductForGroceries(
                  productModel: widget.productModel,
                  baseUrl: widget.imageUrl)));
        },
        child: Container(
          padding: EdgeInsets.all(4),
          decoration: BoxDecoration(
              color: Colors.lightGreen, borderRadius: BorderRadius.circular(6)),
          width: 80,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "Edit",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              Icon(
                Icons.edit_outlined,
                size: 14,
              )
            ],
          ),
        ),
      );
    }
    return SizedBox();
  }
}

class ProductImageBox extends StatelessWidget {
  const ProductImageBox({
    Key? key,
    required this.imageFile,
    required this.radius,
    this.borderColor = Colors.black,
    this.borderWidth = 0.5,
    required this.onPressed,
  }) : super(key: key);
  final File imageFile;
  final double radius;
  final Color borderColor;
  final double borderWidth;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onPressed,
        child: imageFile.path == File('').path || imageFile.path.isEmpty
            ? Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  // borderRadius: const BorderRadius.all(Radius.circular(50)),
                  border: Border.all(color: borderColor, width: borderWidth),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Add Image",
                      style: CommonStyles.textDataBlack13(),
                    ),
                    // if (imageFile.path == null) Text("Image Not Available")
                  ],
                ),
              )
            : Image.file(
                imageFile,
                cacheHeight: 100,
                cacheWidth: 100,
              ));
  }
}

// class LimitDropDownFragment extends StatefulWidget {
//   const LimitDropDownFragment({Key? key}) : super(key: key);

//   @override
//   _LimitDropDownFragmentState createState() => _LimitDropDownFragmentState();
// }

// class _LimitDropDownFragmentState extends State<LimitDropDownFragment> {
//   @override
//   void initState() {
//     if (context.read<LimitListAPIProvider>().limitListResponseModel == null) {
//       context.read<LimitListAPIProvider>().getList();
//     }
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Container(
//           height: 50,
//           decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(5),
//               border: Border.all(color: Colors.black, width: 0.7)),
//           child: dropDownButton()),
//     );
//   }

//   dropDownButton() {
//     final limitListAPIProvider = Provider.of<LimitListAPIProvider>(context);
//     if (limitListAPIProvider.ifLoading) {
//       return Utils.getLoadingCenter25();
//     } else if (limitListAPIProvider.error) {
//       return Utils.showErrorMessage(limitListAPIProvider.errorMessage);
//     } else if (limitListAPIProvider.limitListResponseModel != null &&
//         limitListAPIProvider.limitListResponseModel!.status == "0") {
//       return Utils.showErrorMessage(
//           limitListAPIProvider.limitListResponseModel!.message!);
//     }
//     final limitList = limitListAPIProvider.limitListResponseModel!.limitsList;
//     return DropdownButtonHideUnderline(
//       child: DropdownButton<LimitsList>(
//         isDense: true,
//         hint: Container(
//           margin: EdgeInsets.all(8),
//           padding: const EdgeInsets.only(left: 6.0, top: 3),
//           child: FittedBox(
//             child: Text(
//               "Quantity Type",
//               overflow: TextOverflow.fade,
//               style: TextStyle(fontSize: 14),
//               textAlign: TextAlign.center,
//             ),
//           ),
//         ),
//         alignment: Alignment.center,
//         value: limitList![int.parse(choiceOfUnit.toString())],
//         onChanged: (newValue) async {
//           setState(() {
//             choiceOfUnit = newValue!;
//           });
//           print(choiceOfUnit);
//         },
//         items: limitList.map((LimitsList value) {
//           return DropdownMenuItem<LimitsList>(
//             value: value,
//             child: FittedBox(
//               child: Text(
//                 value.limits!,
//                 style: TextStyle(fontSize: 14),
//               ),
//             ),
//           );
//         }).toList(),
//       ),
//     );
//   }
// }
