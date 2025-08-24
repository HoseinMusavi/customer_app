import 'dart:io';

import 'package:flutter/material.dart';
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
    if (user == null) {
      throw const ServerException(message: 'User not authenticated');
    }

    try {
      debugPrint(
        "✅ [DataSource] -> getCustomerDetails: در حال ارسال درخواست به Supabase...",
      );
      final response = await supabaseClient
          .from('customers')
          .select()
          .eq('id', user.id)
          .single()
          .timeout(const Duration(seconds: 15)); // ‼️ اضافه شدن تایم‌اوت

      debugPrint(
        "✅ [DataSource] -> getCustomerDetails: پاسخ با موفقیت دریافت شد.",
      );
      return CustomerModel.fromJson(response);
    } on PostgrestException catch (e) {
      if (e.code == 'PGRST116') {
        debugPrint(
          " passo [DataSource] -> getCustomerDetails: پروفایل برای کاربر جدید یافت نشد.",
        );
        throw const ServerException(message: 'Profile not found');
      }
      debugPrint(
        "❌ [DataSource] -> getCustomerDetails: خطای Postgrest: ${e.message}",
      );
      throw ServerException(message: e.message);
    } catch (e) {
      debugPrint(
        "❌ [DataSource] -> getCustomerDetails: خطای پیش‌بینی نشده یا تایم‌اوت: ${e.toString()}",
      );
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<List<AddressModel>> getAddresses() async {
    // این بخش در آینده پیاده‌سازی خواهد شد
    debugPrint(
      " passo [DataSource] -> getAddresses: فراخوانی شد اما هنوز پیاده‌سازی نشده.",
    );
    return [];
  }

  @override
  Future<CustomerModel> updateCustomerProfile(CustomerModel customer) async {
    try {
      debugPrint(
        "✅ [DataSource] -> updateCustomerProfile: در حال ارسال دستور upsert به جدول customers...",
      );
      final response = await supabaseClient
          .from('customers')
          .upsert(customer.toJson())
          .select()
          .single()
          .timeout(const Duration(seconds: 15));
      debugPrint(
        "✅ [DataSource] -> updateCustomerProfile: پاسخ موفق از Supabase دریافت شد.",
      );
      return CustomerModel.fromJson(response);
    } catch (e) {
      debugPrint(
        "❌ [DataSource] -> updateCustomerProfile: خطا در زمان upsert کردن داده: ${e.toString()}",
      );
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

      debugPrint(
        "✅ [DataSource] -> uploadAvatar: در حال آپلود فایل به مسیر: $filePath",
      );
      await supabaseClient.storage.from('avatars').upload(filePath, imageFile);

      final imageUrl = supabaseClient.storage
          .from('avatars')
          .getPublicUrl(filePath);
      debugPrint("✅ [DataSource] -> uploadAvatar: URL عمومی عکس دریافت شد.");
      return imageUrl;
    } catch (e) {
      debugPrint(
        "❌ [DataSource] -> uploadAvatar: خطا در حین آپلود: ${e.toString()}",
      );
      throw ServerException(
        message: 'Failed to upload avatar: ${e.toString()}',
      );
    }
  }
}
