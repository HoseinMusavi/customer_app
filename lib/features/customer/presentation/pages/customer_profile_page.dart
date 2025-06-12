// lib/features/customer/presentation/pages/customer_profile_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/service_locator.dart';
import '../../domain/entities/customer_entity.dart';
import '../cubit/customer_cubit.dart';

class CustomerProfilePage extends StatelessWidget {
  const CustomerProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('پروفایل مشتری'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      // BlocProvider وظیفه ساخت و ارائه Cubit به فرزندانش را دارد.
      body: BlocProvider(
        // ما از سرویس لوکیتور (sl) برای گرفتن نمونه CustomerCubit استفاده می‌کنیم
        // و بلافاصله تابع دریافت اطلاعات را با آیدی 1 (برای تست) فراخوانی می‌کنیم.
        create: (_) => sl<CustomerCubit>()..fetchCustomerDetails(1),

        // BlocBuilder به تغییرات Cubit گوش می‌دهد و UI را بازسازی می‌کند.
        child: BlocBuilder<CustomerCubit, CustomerState>(
          builder: (context, state) {
            // بر اساس هر وضعیت، یک ویجت متفاوت نمایش می‌دهیم.
            if (state is CustomerLoading || state is CustomerInitial) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is CustomerLoaded) {
              // اگر داده با موفقیت لود شد، ویجت نمایش پروفایل را برمی‌گردانیم.
              return _buildProfileView(context, state.customer);
            } else if (state is CustomerError) {
              // اگر خطا رخ داد، پیام خطا را نمایش می‌دهیم.
              return Center(child: Text(state.message));
            }
            // حالت پیش‌فرض
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  // یک ویجت کمکی برای نمایش زیبای اطلاعات پروفایل
  Widget _buildProfileView(BuildContext context, CustomerEntity customer) {
    return Center(
      child: Card(
        elevation: 4.0,
        margin: const EdgeInsets.all(16.0),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: customer.avatarUrl != null
                    ? NetworkImage(customer.avatarUrl!)
                    : null,
                child: customer.avatarUrl == null
                    ? const Icon(Icons.person, size: 50)
                    : null,
              ),
              const SizedBox(height: 24),
              Text(
                customer.fullName,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 12),
              Text(
                customer.email,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 8),
              Text(
                customer.phone,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
