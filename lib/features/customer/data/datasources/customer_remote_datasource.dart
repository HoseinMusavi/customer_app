import 'package:dio/dio.dart';
import '../../../../core/error/exceptions.dart';
import '../models/customer_model.dart';

abstract class CustomerRemoteDataSource {
  Future<CustomerModel> getCustomerDetails(int id);
}

class CustomerRemoteDataSourceImpl implements CustomerRemoteDataSource {
  final Dio dio;

  CustomerRemoteDataSourceImpl({required this.dio});

  @override
  Future<CustomerModel> getCustomerDetails(int id) async {
    final response = await dio.get('/api/users/$id/profile/');

    if (response.statusCode == 200) {
      return CustomerModel.fromJson(response.data);
    } else {
      throw ServerException();
    }
  }
}
