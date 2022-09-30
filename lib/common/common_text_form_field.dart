//Dob Auto Fill
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_picker/Picker.dart';

import 'common_styles.dart';

Widget textEditDate(
  TextEditingController textEditingController,
  String hintText,
  String labelText,
  String confirmText,
  BuildContext context,
) {
  return TextFormField(
      controller: textEditingController,
      decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText,
        hintStyle: const TextStyle(
            fontSize: 10, fontWeight: FontWeight.bold, fontFamily: 'OpenSans'),
        filled: false,
        fillColor: Colors.white,
        contentPadding:
            const EdgeInsets.only(left: 14.0, bottom: 6.0, top: 8.0),
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            borderSide: BorderSide(
              width: 2,
            )),
      ),
      validator: (value) {
        String text = value.toString();
        if (text.isEmpty) {
          return "$labelText Date";
        }
        return null;
      },
      onTap: () async {
        DateTime dateTime = DateTime(DateTime.now().year);
        Picker(
            // hideHeader: true,
            builderHeader: (BuildContext context) {
              return Column(
                children: [
                  Text(
                    "Select $labelText",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  )
                ],
              );
            },
            adapter: DateTimePickerAdapter(
                yearBegin: 1900,
                yearEnd: labelText == "Mfg Date"
                    ? (dateTime.year)
                    : (dateTime.year + 5)),
            magnification: 1.05,
            // title: Text("Select Date"),
            selectedTextStyle: TextStyle(color: Colors.blue),
            onConfirm: (Picker picker, List value) {
              var val = (picker.adapter as DateTimePickerAdapter).value;
              String date = "${val!.day}-" + "${val.month}-" + "${val.year}";
              textEditingController.text = date;
            }).showDialog(context);
      });
}

//Widget to make text input flield and it displays the string in the form filed only.
Widget textEditAutoUnit(
  TextEditingController textEditingController,
  String hintText,
  String labelText,
  String pickerData,
  String confirmText,
  String title,
  BuildContext context,
) {
  // textEditingController.text = pickerData.substring(21, 23);
  return TextFormField(
      controller: textEditingController,
      decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText,
        hintStyle: const TextStyle(
            fontSize: 10, fontWeight: FontWeight.bold, fontFamily: 'OpenSans'),
        filled: false,
        fillColor: Colors.white,
        contentPadding:
            const EdgeInsets.only(left: 14.0, bottom: 6.0, top: 8.0),
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            borderSide: BorderSide(
              width: 2,
            )),
      ),
      validator: (value) {
        var name = value.toString();
        if (name.isEmpty) {
          return "Unit";
        }
        return null;
      },
      onTap: () async {
        Picker(
            adapter: PickerDataAdapter<String>(
                pickerdata: const JsonDecoder().convert(pickerData),
                isArray: true),
            hideHeader: true,
            columnPadding: const EdgeInsets.all(2),
            confirmText: confirmText,
            confirmTextStyle: const TextStyle(
                fontSize: 20, fontWeight: FontWeight.w800, color: Colors.green),
            selectedTextStyle: const TextStyle(
                color: Colors.green, fontWeight: FontWeight.bold),

            // squeeze: 2,
            delimiter: [
              PickerDelimiter(
                  column: 5,
                  child: Container(
                    width: 16.0,
                    height: 10,
                    alignment: Alignment.center,
                    child: const Text('',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    color: Colors.white,
                  ))
            ],
            magnification: 1.05,
            textAlign: TextAlign.left,
            cancelTextStyle: const TextStyle(fontSize: 20),
            title: Text(title,
                style: const TextStyle(
                    fontWeight: FontWeight.w900, color: Colors.blue)),
            onConfirm: (Picker picker, List value) {
              String str = picker.getSelectedValues().toString();
              str = str.substring(1, (str.length) - 1);
              textEditingController.text = str;
            }).showDialog(context);
      });
}

//Category textField
Widget searchTextField(
  TextEditingController textEditingController,
  TextEditingController productIdController,
  String hintText,
  String labelText,
  BuildContext context,
) {
  // final subCategoryApiCall =
  //     Provider.of<SubCategoryApiCall>(context, listen: false);

  return TextFormField(
      controller: textEditingController,
      readOnly: true,
      decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText,
        
        hintStyle: const TextStyle(
            fontSize: 10, fontWeight: FontWeight.bold, fontFamily: 'OpenSans'),
        filled: false,
        // fillColor: Colors.white,
        contentPadding:
            const EdgeInsets.only(left: 14.0, bottom: 6.0, top: 8.0),
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            borderSide: BorderSide(
              width: 4,
            )),
      ),
      validator: (value) {
        var name = value.toString();
        if (name.isEmpty) {
          return "Item Name";
        }
        return null;
      },
      onTap: () async {
        // var value = await showSearch(
        //     context: context,
        //     delegate: SearchFromCategory(
        //         buildContext: context,
        //         controller: textEditingController,
        //         categoryModel: categoryModel));

        // print("Value sent");
        // productModelProvider.selectedSubcategory = "Select SubCategory";
        // productIdController.text = value!;
      });
}

//Widget to make text input flield and it displays the string in the form filed only.
Widget textEditTypePicker(
  TextEditingController textEditingController,
  String hintText,
  String labelText,
  String pickerData,
  String confirmText,
  String title,
  BuildContext context,
) {
  // textEditingController = new TextEditingController(
  //     text: labelText == 'Type'
  //         ? pickerData.substring(11, 18)
  //         : pickerData.substring(21, 23));
  // textEditingController.text = pickerData.substring(11, 18);
  return TextFormField(
      controller: textEditingController,
      decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText,
        hintStyle: const TextStyle(
            fontSize: 10, fontWeight: FontWeight.bold, fontFamily: 'OpenSans'),
        filled: false,
        fillColor: Colors.white,
        contentPadding:
            const EdgeInsets.only(left: 14.0, bottom: 6.0, top: 8.0),
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            borderSide: BorderSide(
              width: 2,
            )),
      ),
      validator: (value) {
        var name = value.toString();
        if (name.isEmpty) {
          return "Unit";
        }
        return null;
      },
      onTap: () async {
        Picker(
            adapter: PickerDataAdapter<String>(
                pickerdata: const JsonDecoder().convert(pickerData),
                isArray: true),
            hideHeader: true,
            columnPadding: const EdgeInsets.all(2),
            confirmText: confirmText,
            confirmTextStyle: const TextStyle(
                fontSize: 20, fontWeight: FontWeight.w800, color: Colors.green),
            selectedTextStyle: const TextStyle(
                color: Colors.green, fontWeight: FontWeight.bold),

            // squeeze: 2,
            delimiter: [
              PickerDelimiter(
                  column: 5,
                  child: Container(
                    width: 16.0,
                    height: 10,
                    alignment: Alignment.center,
                    child: const Text('',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    color: Colors.white,
                  ))
            ],
            magnification: 1.05,
            textAlign: TextAlign.left,
            cancelTextStyle: TextStyle(fontSize: 20),
            title: Text(title,
                style: const TextStyle(
                    fontWeight: FontWeight.w900, color: Colors.blue)),
            onConfirm: (Picker picker, List value) {
              String str = picker.getSelectedValues().toString();
              str = str.substring(1, (str.length) - 1);
              textEditingController.text = str;
            }).showDialog(context);
      });
}

//Widget to take text input while adding item (BrandName, Category, Expiry date)
Widget textEditMultiLine(
  TextEditingController textEditingController,
  String hintText,
  TextInputType textInputType,
  String labelText,
) {
  return TextFormField(
    controller: textEditingController,
    maxLines: 5,
    minLines: 2,
    autofocus: false,
    style: CommonStyles.textDataBlack13(),
    decoration: InputDecoration(
      isDense: true,
      hintText: hintText,
      labelText: labelText,
      labelStyle: CommonStyles.textDataBlack13(),
      hintStyle: CommonStyles.textDataBlack13(),
      filled: false,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 20.0),
      border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          borderSide: BorderSide(
            width: 2,
          )),
    ),
    keyboardType: textInputType,
    cursorColor: Colors.green.shade600,
    cursorWidth: 3.0,
    validator: (value) {
      var editText = value.toString();
      return null;
    },
  );
}

//Widget to take text input while adding item (BrandName, Category, Expiry date)
Widget textEditNumericData(
  TextEditingController textEditingController,
  String hintText,
  TextInputType textInputType,
  String labelText,
) {
  return TextFormField(
    controller: textEditingController,
    autofocus: false,
    keyboardType: const TextInputType.numberWithOptions(decimal: true),
    style: CommonStyles.textDataBlack13(),
    decoration: InputDecoration(
      hintText: hintText,
      labelText: labelText,
      labelStyle: CommonStyles.textDataBlack13(),
      filled: false,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.only(left: 14.0, bottom: 6.0, top: 8.0),
      border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          borderSide: BorderSide(
            width: 2,
          )),
    ),
    cursorColor: Colors.green.shade600,
    cursorWidth: 3.0,
    // controller: _phoneController,
    validator: (value) {
      var editText = value.toString();
      if (value!.isEmpty) {
        return "Enter Valid Details";
      }
    },
  );
}

//Widget to take text input while adding item (BrandName, Category, Expiry date)
Widget textEditLocation(
    TextEditingController textEditingController,
    String hintText,
    TextInputType textInputType,
    String labelText,
    BuildContext context) {
  // FocusScope.of(context).requestFocus(new FocusNode());
  return TextFormField(
    controller: textEditingController,
    autofocus: false,
    style: const TextStyle(
      shadows: [
        Shadow(
          offset: Offset(0.2, 0.2),
          blurRadius: 0.5,
          color: Colors.black,
        )
      ],
      color: Colors.black,
      fontSize: 18,
      fontWeight: FontWeight.bold,
    ),
    decoration: InputDecoration(
      hintText: hintText,
      labelText: labelText,
      labelStyle: const TextStyle(color: Colors.black),
      hintStyle:
          const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
      filled: false,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.only(left: 14.0, bottom: 6.0, top: 8.0),
      border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          borderSide: BorderSide(
            width: 2,
          )),
    ),
    keyboardType: textInputType,
    cursorColor: Colors.green.shade600,
    cursorWidth: 3.0,
    // controller: _phoneController,
    validator: (value) {
      var editText = value.toString();

      return null;
    },
  );
}

Widget itemNameTextField(
  TextEditingController textEditingController,
  String hintText,
  String labelText,
  BuildContext context,
) {
  return TextFormField(
    controller: textEditingController,
    decoration: InputDecoration(
      hintText: hintText,
      labelText: labelText,
      hintStyle: const TextStyle(
          fontSize: 10, fontWeight: FontWeight.w500, fontFamily: 'OpenSans'),
      filled: false,
      // fillColor: Colors.white,
      contentPadding: const EdgeInsets.only(left: 14.0, bottom: 6.0, top: 8.0),
      border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          borderSide: BorderSide(
            width: 4,
          )),
    ),
    validator: (value) {
      var name = value.toString();
      if (name.isEmpty) {
        return "Item Name";
      }
      return null;
    },
    // onTap: () async {}
  );
}

//Widget to make text input flield and it displays the string in the form filed only.
Widget textEditAutoBestBefore(
  TextEditingController textEditingController,
  String hintText,
  String labelText,
  String confirmText,
  BuildContext context,
) {
  return TextFormField(
      controller: textEditingController,
      decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText,
        hintStyle: const TextStyle(
            fontSize: 10, fontWeight: FontWeight.bold, fontFamily: 'OpenSans'),
        filled: false,
        fillColor: Colors.white,
        contentPadding:
            const EdgeInsets.only(left: 14.0, bottom: 6.0, top: 8.0),
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            borderSide: BorderSide(
              width: 2,
            )),
      ),
      validator: (value) {
        var name = value.toString();
        if (name.isEmpty) {
          return "Best Before";
        }
        return null;
      },
      onTap: () async {
        Picker(
            adapter: NumberPickerAdapter(data: [
              const NumberPickerColumn(begin: 1, end: 24),
            ]),
            diameterRatio: 1,
            magnification: 1.05,
            builderHeader: (context) {
              return Column(
                children: [
                  Text(
                    labelText,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              );
            },
            footer: footer(),
            selectedTextStyle: const TextStyle(color: Colors.blue),
            onConfirm: (Picker picker, List value) {
              String str = picker.getSelectedValues().toString();
              str = str.substring(1, (str.length) - 1);
              textEditingController.text = str;
            }).showDialog(context);
      });
}

Widget footer() {
  return Column(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.center,
    children: const [
      Text(
        "In Months",
        style: TextStyle(fontWeight: FontWeight.bold),
      )
    ],
  );
}
