// lib/features/product/data/repositories/fake_product_repository_impl.dart

import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/repositories/product_repository.dart';

class FakeProductRepositoryImpl implements ProductRepository {
  static const String burgerImageUrl =
      'https://cdn.donya-e-eqtesad.com/thumbnail/fpnXqzzKu9lr/QHn8O9nsSzT8qCU7RegsN6Pbb5v74eEtbKeSOh05Rabn0V-kPSDeBEt7TZyzEhnm/tYuNp3dZqsxU.jpg';
  static const String pizzaImageUrl =
      'https://cdn.donya-e-eqtesad.com/thumbnail/fpnXqzzKu9lr/QHn8O9nsSzT8qCU7RegsN6Pbb5v74eEtbKeSOh05Rabn0V-kPSDeBEt7TZyzEhnm/tYuNp3dZqsxU.jpg';
  static const String saladImageUrl =
      'https://cdn.donya-e-eqtesad.com/thumbnail/fpnXqzzKu9lr/QHn8O9nsSzT8qCU7RegsN6Pbb5v74eEtbKeSOh05Rabn0V-kPSDeBEt7TZyzEhnm/tYuNp3dZqsxU.jpg';
  static const String drinkImageUrl =
      'https://cdn.donya-e-eqtesad.com/thumbnail/fpnXqzzKu9lr/QHn8O9nsSzT8qCU7RegsN6Pbb5v74eEtbKeSOh05Rabn0V-kPSDeBEt7TZyzEhnm/tYuNp3dZqsxU.jpg';
  static const String coffeeImageUrl =
      'https://cdn.donya-e-eqtesad.com/thumbnail/fpnXqzzKu9lr/QHn8O9nsSzT8qCU7RegsN6Pbb5v74eEtbKeSOh05Rabn0V-kPSDeBEt7TZyzEhnm/tYuNp3dZqsxU.jpg';
  static const String cakeImageUrl =
      'https://cdn.donya-e-eqtesad.com/thumbnail/fpnXqzzKu9lr/QHn8O9nsSzT8qCU7RegsN6Pbb5v74eEtbKeSOh05Rabn0V-kPSDeBEt7TZyzEhnm/tYuNp3dZqsxU.jpg';

  final Map<int, List<ProductEntity>> _productsByStore = {
    1: [
      // فست فود آلفا
      const ProductEntity(
        id: 101,
        storeId: 1,
        storeName: 'فست فود آلفا',
        name: 'دبل چیزبرگر',
        description: '۲۰۰ گرم گوشت، دو لایه پنیر گودا، نان مخصوص',
        price: 350000,
        discountPrice: 320000,
        imageUrl: burgerImageUrl,
        category: 'برگر',
        isAvailable: true,
      ),
      const ProductEntity(
        id: 102,
        storeId: 1,
        storeName: 'فست فود آلفا',
        name: 'سیب زمینی ویژه',
        description: 'سیب زمینی سرخ شده با قارچ و پنیر',
        price: 120000,
        discountPrice: null,
        imageUrl:
            'https://cdn.donya-e-eqtesad.com/thumbnail/fpnXqzzKu9lr/QHn8O9nsSzT8qCU7RegsN6Pbb5v74eEtbKeSOh05Rabn0V-kPSDeBEt7TZyzEhnm/tYuNp3dZqsxU.jpg',
        category: 'پیش غذا',
        isAvailable: true,
      ),
      const ProductEntity(
        id: 103,
        storeId: 1,
        storeName: 'فست فود آلفا',
        name: 'نوشابه کوکا کولا',
        description: 'قوطی ۳۳۰ میلی‌لیتر',
        price: 20000,
        discountPrice: null,
        imageUrl: drinkImageUrl,
        category: 'نوشیدنی',
        isAvailable: false,
      ),
    ],
    2: [
      // پیتزا بتا
      const ProductEntity(
        id: 201,
        storeId: 2,
        storeName: 'پیتزا بتا',
        name: 'پیتزا رست بیف',
        description: 'خمیر ایتالیایی، گوشت رست بیف، قارچ، فلفل دلمه‌ای',
        price: 450000,
        discountPrice: null,
        imageUrl: pizzaImageUrl,
        category: 'پیتزا',
        isAvailable: true,
      ),
      const ProductEntity(
        id: 202,
        storeId: 2,
        storeName: 'پیتزا بتا',
        name: 'پیتزا پپرونی',
        description: 'خمیر ایتالیایی، پپرونی، پنیر فراوان',
        price: 410000,
        discountPrice: 390000,
        imageUrl: pizzaImageUrl,
        category: 'پیتزا',
        isAvailable: true,
      ),
      const ProductEntity(
        id: 203,
        storeId: 2,
        storeName: 'پیتزا بتا',
        name: 'سالاد سزار',
        description: 'کاهو رسمی، فیله سوخاری، نان تست، سس مخصوص',
        price: 180000,
        discountPrice: null,
        imageUrl: saladImageUrl,
        category: 'سالاد',
        isAvailable: true,
      ),
    ],
    3: [
      // کافه گاما
      const ProductEntity(
        id: 301,
        storeId: 3,
        storeName: 'کافه گاما',
        name: 'قهوه لاته',
        description: 'یک شات اسپرسو با شیر بخار داده شده',
        price: 95000,
        discountPrice: null,
        imageUrl: coffeeImageUrl,
        category: 'نوشیدنی گرم',
        isAvailable: true,
      ),
      const ProductEntity(
        id: 302,
        storeId: 3,
        storeName: 'کافه گاما',
        name: 'کیک شکلاتی',
        description: 'کیک روز با طعم شکلات تلخ',
        price: 130000,
        discountPrice: null,
        imageUrl: cakeImageUrl,
        category: 'کیک و دسر',
        isAvailable: true,
      ),
      const ProductEntity(
        id: 303,
        storeId: 3,
        storeName: 'کافه گاما',
        name: 'چای ماسالا',
        description: 'ترکیب شیر، چای و ادویه‌های معطر',
        price: 85000,
        discountPrice: 80000,
        imageUrl:
            'https://cdn.donya-e-eqtesad.com/thumbnail/fpnXqzzKu9lr/QHn8O9nsSzT8qCU7RegsN6Pbb5v74eEtbKeSOh05Rabn0V-kPSDeBEt7TZyzEhnm/tYuNp3dZqsxU.jpg',
        category: 'نوشیدنی گرم',
        isAvailable: false,
      ),
    ],
    4: [
      // رستوران دلتا
      const ProductEntity(
        id: 401,
        storeId: 4,
        storeName: 'رستوران دلتا',
        name: 'چلوکباب کوبیده',
        description: 'دو سیخ کباب کوبیده ۱۲۰ گرمی با برنج ایرانی',
        price: 280000,
        discountPrice: null,
        imageUrl:
            'https://cdn.donya-e-eqtesad.com/thumbnail/fpnXqzzKu9lr/QHn8O9nsSzT8qCU7RegsN6Pbb5v74eEtbKeSOh05Rabn0V-kPSDeBEt7TZyzEhnm/tYuNp3dZqsxU.jpg',
        category: 'کباب',
        isAvailable: true,
      ),
      const ProductEntity(
        id: 402,
        storeId: 4,
        storeName: 'رستوران دلتا',
        name: 'جوجه کباب',
        description: 'یک سیخ جوجه کباب ۲۵۰ گرمی با برنج ایرانی',
        price: 260000,
        discountPrice: null,
        imageUrl:
            'https://cdn.donya-e-eqtesad.com/thumbnail/fpnXqzzKu9lr/QHn8O9nsSzT8qCU7RegsN6Pbb5v74eEtbKeSOh05Rabn0V-kPSDeBEt7TZyzEhnm/tYuNp3dZqsxU.jpg',
        category: 'کباب',
        isAvailable: true,
      ),
    ],
  };

  @override
  Future<Either<Failure, List<ProductEntity>>> getProductsByStore(
    int storeId,
  ) async {
    await Future.delayed(const Duration(milliseconds: 800));
    // اگر برای فروشگاه محصولی تعریف نشده بود، لیست خالی برگردان
    final products = _productsByStore[storeId] ?? [];
    return Right(products);
  }
}
