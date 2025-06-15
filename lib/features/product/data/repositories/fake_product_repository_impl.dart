// lib/features/product/data/repositories/fake_product_repository_impl.dart

import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/repositories/product_repository.dart';

class FakeProductRepositoryImpl implements ProductRepository {
  static const String imageUrl =
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTLGt8eRwwryxAdOr9gM72TNjomZeGmXfKTR6pIOPqMnkJQ7QmTTyK6Mu4pY2SgekJUe0c&usqp=CAU';

  @override
  Future<Either<Failure, List<ProductEntity>>> getProductsByStore(
    int storeId,
  ) async {
    // شبیه‌سازی یک تاخیر کوتاه شبکه
    await Future.delayed(const Duration(milliseconds: 800));

    // بر اساس storeId، لیست محصولات متفاوتی را برمی‌گردانیم
    switch (storeId) {
      case 1: // منوی فست فود آلفا
        return Right([
          const ProductEntity(
            id: 101,
            storeId: 1,
            storeName: 'فست فود آلفا',
            name: 'چیزبرگر کلاسیک',
            description: '۱۵۰ گرم گوشت گوساله، پنیر گودا، کاهو، گوجه، خیارشور',
            price: 185000,
            imageUrl: imageUrl,
          ),
          const ProductEntity(
            id: 102,
            storeId: 1,
            storeName: 'فست فود آلفا',
            name: 'سیب زمینی سرخ کرده',
            description: 'سیب زمینی خلالی سرخ شده همراه با ادویه مخصوص',
            price: 75000,
            imageUrl: imageUrl,
          ),
          const ProductEntity(
            id: 103,
            storeId: 1,
            storeName: 'فست فود آلفا',
            name: 'سالاد سزار',
            description: 'کاهو، نان تست، سس سزار، فیله مرغ گریل شده',
            price: 120000,
            imageUrl: imageUrl,
          ),
        ]);
      case 2: // منوی پیتزا بتا
        return Right([
          const ProductEntity(
            id: 201,
            storeId: 2,
            storeName: 'پیتزا بتا',
            name: 'پیتزا پپرونی',
            description: 'خمیر ایتالیایی، سس مخصوص، پنیر موزارلا، پپرونی تند',
            price: 220000,
            imageUrl: imageUrl,
          ),
          const ProductEntity(
            id: 202,
            storeId: 2,
            storeName: 'پیتزا بتا',
            name: 'پاستا آلفردو',
            description: 'پنه، سس آلفردو، فیله مرغ، قارچ، جعفری',
            price: 195000,
            imageUrl: imageUrl,
          ),
        ]);
      default: // منوی کافه گاما (برای بقیه فروشگاه‌ها)
        return Right([
          const ProductEntity(
            id: 301,
            storeId: 3,
            storeName: 'کافه گاما',
            name: 'قهوه لاته',
            description: 'یک شات اسپرسو به همراه شیر بخار داده شده',
            price: 90000,
            imageUrl: imageUrl,
          ),
          const ProductEntity(
            id: 302,
            storeId: 3,
            storeName: 'کافه گاما',
            name: 'چیزکیک نیویورکی',
            description: 'کیک پنیر پخته شده با سس توت فرنگی',
            price: 110000,
            imageUrl: imageUrl,
          ),
        ]);
    }
  }
}
