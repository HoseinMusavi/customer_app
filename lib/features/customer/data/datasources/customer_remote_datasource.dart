import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/error/exceptions.dart';
import '../models/address_model.dart';
import '../models/customer_model.dart';

abstract class CustomerRemoteDataSource {
  Future<CustomerModel> getCustomerDetails();
  Future<List<AddressModel>> getAddresses();
  Future<CustomerModel> updateCustomerProfile(CustomerModel customer);
  Future<String> uploadAvatar(File imageFile);
}

class CustomerRemoteDataSourceImpl implements CustomerRemoteDataSource {
  final SupabaseClient supabaseClient;
  CustomerRemoteDataSourceImpl({required this.supabaseClient});

  @override
  Future<CustomerModel> getCustomerDetails() async {
    final user = supabaseClient.auth.currentUser;
    if (user == null)
      throw const ServerException(message: 'User not authenticated');

    try {
      final response = await supabaseClient
          .from('customers')
          .select()
          .eq('id', user.id)
          .single();
      return CustomerModel.fromJson(response);
    } on PostgrestException catch (e) {
      if (e.code == 'PGRST116') {
        throw const ServerException(message: 'Profile not found');
      }
      throw ServerException(message: e.message);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<List<AddressModel>> getAddresses() async {
    // This part will be implemented in the future
    return [];
  }

  @override
  Future<CustomerModel> updateCustomerProfile(CustomerModel customer) async {
    try {
      final response = await supabaseClient
          .from('customers')
          .upsert(customer.toJson())
          .select()
          .single();
      return CustomerModel.fromJson(response);
    } catch (e) {
      throw ServerException(
        message: 'Failed to update profile: ${e.toString()}',
      );
    }
  }

  @override
  Future<String> uploadAvatar(File imageFile) async {
    try {
      final user = supabaseClient.auth.currentUser;
      if (user == null)
        throw const ServerException(message: 'User not authenticated');

      final fileExt = imageFile.path.split('.').last;
      final fileName = '${DateTime.now().millisecondsSinceEpoch}.$fileExt';
      final filePath = '${user.id}/$fileName';

      await supabaseClient.storage.from('avatars').upload(filePath, imageFile);

      final imageUrl = supabaseClient.storage
          .from('avatars')
          .getPublicUrl(filePath);
      return imageUrl;
    } catch (e) {
      throw ServerException(
        message: 'Failed to upload avatar: ${e.toString()}',
      );
    }
  }
}
