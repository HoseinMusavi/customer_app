import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/repositories/product_repository.dart';

class FakeProductRepositoryImpl implements ProductRepository {
  static const String burgerImageUrl =
      'https://calindairy.com/wp-content/uploads/2023/08/double-burger.webp'; // چیزبرگر مخصوص
  static const String friesImageUrl =
      'https://media.aamaaj.ir/2023/01/248419504_1280654395782243_8218209085093290956_n-1024x1024-1.jpg'; // سیب زمینی با پنیر
  static const String dooghImageUrl =
      'https://sonnatkala.ir/mag/wp-content/uploads/2021/08/%D8%A2%D9%86%DA%86%DB%8C%D9%84%D8%A7%D8%AF%D8%A7-%D9%85%DA%A9%D8%B2%DB%8C%DA%A9%DB%8C.jpg'; // دوغ سنتی
  static const String pizzaImageUrl =
      'https://shirazgolpar.com/wp-content/uploads/2024/08/%D8%A7%D8%AF%D9%88%DB%8C%D9%87-%D9%81%D8%B3%D8%AA-%D9%81%D9%88%D8%AF-.jpg'; // پیتزا مارگاریتا
  static const String pepperoniPizzaImageUrl =
      'https://bestfarsi.ir/wp-content/uploads/Fried-chicken.jpg'; // پیتزا پپرونی
  static const String saladImageUrl =
      'https://www.chetor.com/wp-content/uploads/2018/12/healthlyfastfood.jpg'; // سالاد شیرازی
  static const String teaImageUrl =
      'https://cdn.yjc.ir/files/fa/news/1400/12/28/15809832_568.jpg'; // چای زعفرانی
  static const String saffronCakeImageUrl =
      'https://shirazgolpar.com/wp-content/uploads/2024/08/%D8%A7%D8%AF%D9%88%DB%8C%D9%87-%D9%81%D8%B3%D8%AA-%D9%81%D9%88%D8%AF-.jpg'; // کیک زعفرانی
  static const String sekkenjabinImageUrl =
      'https://sonnatkala.ir/mag/wp-content/uploads/2021/08/%D8%A2%D9%86%DA%86%DB%8C%D9%84%D8%A7%D8%AF%D8%A7-%D9%85%DA%A9%D8%B2%DB%8C%DA%A9%DB%8C.jpg'; // شربت سکنجبین
  static const String kebabImageUrl =
      'https://bestfarsi.ir/wp-content/uploads/Fried-chicken.jpg'; // چلوکباب سلطانی
  static const String zereshkPoloImageUrl =
      'https://www.chetor.com/wp-content/uploads/2018/12/healthlyfastfood.jpg'; // زرشک پلو

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
