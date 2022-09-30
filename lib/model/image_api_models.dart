class ImageUploadResponse {
  String? fileUrl;
  String? fileName;
  String? status;
  String? message;

  ImageUploadResponse({this.fileUrl, this.fileName, this.status, this.message});

  ImageUploadResponse.fromJson(Map<String, dynamic> json) {
    fileUrl = json['file_url'];
    fileName = json['file_name'];
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['file_url'] = this.fileUrl;
    data['file_name'] = this.fileName;
    data['status'] = this.status;
    data['message'] = this.message;
    return data;
  }
}
