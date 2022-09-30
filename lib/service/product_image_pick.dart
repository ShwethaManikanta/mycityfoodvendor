import 'dart:io';

import 'package:flutter/cupertino.dart';

class ProductImagePickProvider with ChangeNotifier {
  late File _customerPCIDimage = File('');

  File get customerPCIDimage => _customerPCIDimage;

  set customerPCIDimage(File imageFile) {
    _customerPCIDimage = imageFile;
    notifyListeners();
  }

  void deleteCustomerPCIDImageFile() {
    _customerPCIDimage = File('');
    notifyListeners();
  }
}
