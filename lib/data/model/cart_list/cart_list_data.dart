import 'calculations.dart';
import 'cart.dart';

class CartListData {
  List<Cart>? carts;
  Calculations? calculations;

  CartListData({this.carts, this.calculations});

  factory CartListData.fromJson(Map<String, Object?> json) => CartListData(
        carts: (json['carts'] as List<dynamic>?)
            ?.map((e) => Cart.fromJson(e as Map<String, Object?>))
            .toList(),
        calculations: json['calculations'] == null
            ? null
            : Calculations.fromJson(
                json['calculations']! as Map<String, Object?>),
      );

  Map<String, Object?> toJson() => {
        'carts': carts?.map((e) => e.toJson()).toList(),
        'calculations': calculations?.toJson(),
      };
}
