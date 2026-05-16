import 'package:ez_life/data/response/status.dart';
import 'package:ez_life/data/response/status.dart';

class ApiResponse<T>{
  String?message;
  T? data;
  Status? status;

  ApiResponse(this.message,this.data,this.status);

// Here ApiResponse.Error/Completed/Loading are called as named constructor
  // Here : is called initializer list(initialize variables before constructor called) or shortcut way for constructor
  ApiResponse.Error(): status = Status.ERROR;
  ApiResponse.Completed(): status = Status.COMPLETED;
  ApiResponse.Loading(): status = Status.LOADING;
  @override
  String toString(){
    return 'Status: $status\n Data: $data\n Message: $message';
  }
}