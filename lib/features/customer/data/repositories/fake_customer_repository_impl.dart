// lib/features/customer/data/repositories/fake_customer_repository_impl.dart

import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../../domain/entities/address_entity.dart';
import '../../domain/entities/customer_entity.dart';
import '../../domain/repositories/customer_repository.dart';

class FakeCustomerRepositoryImpl implements CustomerRepository {
  @override
  Future<Either<Failure, CustomerEntity>> getCustomerDetails(int id) async {
    await Future.delayed(const Duration(seconds: 1));

    const List<AddressEntity> fakeAddresses = [
      AddressEntity(
        id: 101,
        title: 'خانه',
        city: 'تهران',
        postalCode: '1234567890',
        fullAddress: 'میدان آزادی، خیابان آزادی، پلاک ۱، واحد ۱',
      ),
      AddressEntity(
        id: 102,
        title: 'محل کار',
        city: 'تهران',
        postalCode: '9876543210',
        fullAddress: 'میدان انقلاب، خیابان کارگر، پلاک ۲، واحد ۲',
      ),
      AddressEntity(
        id: 103,
        title: 'منزل دوست',
        city: 'کرج',
        postalCode: '1112223334',
        fullAddress: 'مهرشهر، بلوار ارم، خیابان صد و یکم',
      ),
    ];

    const fakeCustomer = CustomerEntity(
      id: 1,
      fullName: "حسین موسوی",
      email: "test@example.com",
      phone: "09123456789",
      avatarUrl: "https://i.pravatar.cc/150?u=a042581f4e29026704d",
      addresses: fakeAddresses,
      defaultAddressId: 101,
    );
    return const Right(fakeCustomer);
  }
}
