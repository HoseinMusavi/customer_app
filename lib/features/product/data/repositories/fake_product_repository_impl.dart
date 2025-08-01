import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/repositories/product_repository.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/repositories/product_repository.dart';

class FakeProductRepositoryImpl implements ProductRepository {
  // آدرس‌های معتبر جایگزین شده‌اند
  static const String burgerImageUrl =
      'https://calindairy.com/wp-content/uploads/2023/08/double-burger.webp';
  static const String friesImageUrl =
      'https://media.aamaaj.ir/2023/01/248419504_1280654395782243_8218209085093290956_n-1024x1024-1.jpg';
  // URL جایگزین برای دوغ
  static const String dooghImageUrl =
      'https://astepinto.com/wp-content/uploads/2022/07/Doogh-Abali-Glass-Bottle-1L-2.jpg';
  // URL جایگزین برای پیتزا
  static const String pizzaImageUrl =
      'https://images.unsplash.com/photo-1513104890138-7c749659a591';
  // URL جایگزین برای پیتزا پپرونی
  static const String pepperoniPizzaImageUrl =
      'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38';
  static const String saladImageUrl =
      'https://www.chetor.com/wp-content/uploads/2018/12/healthlyfastfood.jpg';
  static const String teaImageUrl =
      'https://cdn.yjc.ir/files/fa/news/1400/12/28/15809832_568.jpg';
  // URL جایگزین برای کیک زعفرانی
  static const String saffronCakeImageUrl =
      'https://images.unsplash.com/photo-1607478900766-efe13248b125';
  // URL جایگزین برای سکنجبین
  static const String sekkenjabinImageUrl =
      'https://static.farakav.com/files/pictures/01570177.jpg';
  // URL جایگزین برای کباب
  static const String kebabImageUrl =
      'https://images.unsplash.com/photo-1517244683847-7456b63c5969';
  static const String zereshkPoloImageUrl =
      'https://www.chetor.com/wp-content/uploads/2018/12/healthlyfastfood.jpg';

  // ... بقیه کد بدون تغییر باقی می‌ماند ...

  final Map<int, List<ProductEntity>> _productsByStore = {
    1: [
      // فست فود آلفا
      const ProductEntity(
        id: 101,
        storeId: 1,
        storeName: 'فست فود آلفا',
        name: 'چیزبرگر مخصوص',
        description: 'گوشت گوساله ۱۸۰ گرمی، پنیر چدار، کاهو، گوجه، سس مخصوص',
        price: 185000,
        discountPrice: 165000,
        imageUrl: burgerImageUrl,
        category: 'برگر',
        isAvailable: true,
      ),
      const ProductEntity(
        id: 102,
        storeId: 1,
        storeName: 'فست فود آلفا',
        name: 'سیب زمینی با پنیر',
        description: 'سیب زمینی سرخ شده با پنیر موزارلا و سس قارچ',
        price: 75000,
        discountPrice: null,
        imageUrl: friesImageUrl,
        category: 'پیش غذا',
        isAvailable: true,
      ),
      const ProductEntity(
        id: 103,
        storeId: 1,
        storeName: 'فست فود آلفا',
        name: 'دوغ سنتی',
        description: 'دوغ ایرانی ۳۳۰ میلی‌لیتر با طعم نعنا',
        price: 15000,
        discountPrice: null,
        imageUrl: dooghImageUrl,
        category: 'نوشیدنی',
        isAvailable: true,
      ),
    ],
    2: [
      // پیتزا بتا
      const ProductEntity(
        id: 201,
        storeId: 2,
        storeName: 'پیتزا بتا',
        name: 'پیتزا مارگاریتا',
        description: 'خمیر ایتالیایی، پنیر موزارلا، ریحان تازه، سس گوجه',
        price: 210000,
        discountPrice: 195000,
        imageUrl: pizzaImageUrl,
        category: 'پیتزا',
        isAvailable: true,
      ),
      const ProductEntity(
        id: 202,
        storeId: 2,
        storeName: 'پیتزا بتا',
        name: 'پیتزا پپرونی',
        description: 'پپرونی، پنیر موزارلا، سس گوجه فرنگی',
        price: 230000,
        discountPrice: 215000,
        imageUrl: pepperoniPizzaImageUrl,
        category: 'پیتزا',
        isAvailable: true,
      ),
      const ProductEntity(
        id: 203,
        storeId: 2,
        storeName: 'پیتزا بتا',
        name: 'سالاد شیرازی',
        description: 'خیار، گوجه، پیاز، جعفری، آبلیمو',
        price: 95000,
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
        name: 'چای زعفرانی',
        description: 'چای ایرانی با طعم زعفران و هل',
        price: 65000,
        discountPrice: null,
        imageUrl: teaImageUrl,
        category: 'نوشیدنی گرم',
        isAvailable: true,
      ),
      const ProductEntity(
        id: 302,
        storeId: 3,
        storeName: 'کافه گاما',
        name: 'کیک زعفرانی',
        description: 'کیک زعفرانی با پسته و خامه',
        price: 85000,
        discountPrice: null,
        imageUrl: saffronCakeImageUrl,
        category: 'کیک و دسر',
        isAvailable: true,
      ),
      const ProductEntity(
        id: 303,
        storeId: 3,
        storeName: 'کافه گاما',
        name: 'شربت سکنجبین',
        description: 'شربت سنتی ایرانی با خیار رنده‌شده',
        price: 60000,
        discountPrice: 55000,
        imageUrl: sekkenjabinImageUrl,
        category: 'نوشیدنی سرد',
        isAvailable: true,
      ),
    ],
    4: [
      // رستوران دلتا
      const ProductEntity(
        id: 401,
        storeId: 4,
        storeName: 'رستوران دلتا',
        name: 'چلوکباب سلطانی',
        description: 'یک سیخ برگ و یک سیخ کوبیده با برنج ایرانی و گوجه',
        price: 320000,
        discountPrice: 295000,
        imageUrl: kebabImageUrl,
        category: 'کباب',
        isAvailable: true,
      ),
      const ProductEntity(
        id: 402,
        storeId: 4,
        storeName: 'رستوران دلتا',
        name: 'زرشک پلو با مرغ',
        description: 'سینه مرغ زعفرانی با برنج ایرانی و زرشک',
        price: 180000,
        discountPrice: null,
        imageUrl: zereshkPoloImageUrl,
        category: 'غذای ایرانی',
        isAvailable: true,
      ),
    ],
  };

  @override
  Future<Either<Failure, List<ProductEntity>>> getProductsByStore(
    int storeId,
  ) async {
    await Future.delayed(const Duration(milliseconds: 800));
    final products = _productsByStore[storeId] ?? [];
    return Right(products);
  }
}
