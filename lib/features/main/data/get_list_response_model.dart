// Define the model class for the JSON response
class GetListResponseModel {
  bool? status;
  List<DataModel>? data;

  GetListResponseModel({this.status, this.data});

  factory GetListResponseModel.fromJson(Map<String, dynamic> json) {
    return GetListResponseModel(
      status: json['status'] as bool?,
      data: (json['data'] as List<dynamic>?)
          ?.map((item) => DataModel.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }
}

class DataModel {
  String? text;

  DataModel({this.text});

  factory DataModel.fromJson(Map<String, dynamic> json) {
    return DataModel(
      text: json['text'] as String?,
    );
  }
}
