import 'product_model.dart';

class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, required this.quantity});
}

class Cart {

  List<CartItem> _items = [];

  List<CartItem> get items => _items;

  void addProduct(Product product) {
    for (var item in _items) {
      if (item.product.id == product.id) {
        item.quantity++;
        return;
      }
    }
    _items.add(CartItem(product: product, quantity: 1));
  }

  void removeProduct(Product product) {
    for (var item in _items) {
      if (item.product.id == product.id) {
        if (item.quantity > 1) {
          item.quantity--;
        } else {
          _items.remove(item);
        }
        return;
      }
    }
  }

  int get totalPrice {
    int total = 0;
    for (var item in _items) {
      total += (item.product.price * item.quantity).toInt();
    }
    return total;
  }
}