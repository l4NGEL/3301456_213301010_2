
class Product {
  final String id;
  final String name;
  final String description;
  final String category;
  final double price;
  final String imageUrl;

  // Add a quantity field to keep track of how many of the product are in the cart
  int quantity;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.price,
    required this.imageUrl,
    this.quantity = 0, // Initialize the quantity to 0 by default
  });
  // Sepete eklenen ürünler
  static List<Product> _sepetUrunler = [];

  static List<Product> get sepetUrunler => _sepetUrunler;

  void addToCart() {
    _sepetUrunler.add(this);
  }
  void removeFromCart() {
    if (quantity > 0) {
      quantity--;
    }
  }
}
List<Product> products = [
  Product(
    id: 'p1',
    name: 'Parol',
    description: 'Ağrı kesici',
    price: 10.99,
    imageUrl: 'assets/images/parol.jpg',
    category: 'sağlık ürünleri',
  ),
  Product(
    id: 'p2',
    name: 'Bepanthol',
    description: 'Cilt bakım kremi',
    price: 14.99,
    imageUrl: 'assets/images/bepanthol.jpg',
    category: 'kozmetik ürünleri',
  ),
  Product(
    id: 'p3',
    name: 'Omega-3',
    description: 'Balık yağı kapsülü',
    price: 19.99,
    imageUrl: 'assets/images/omega_3.jpg',
    category: 'vitaminler',
  ),
  Product(
    id: 'p4',
    name: 'Bebe Yağı',
    description: 'Cilt bakım yağı',
    price: 25.99,
    imageUrl: 'assets/images/bebe_yagi.jpg',
    category: 'bebek bakım ürünleri',
  ),
  Product(
    id: 'p5',
    name: 'Bebe Şampuanı',
    description: 'Saç ve vücut temizliği için',
    price: 12.99,
    imageUrl: 'assets/images/bebe_sampuan.jpg',
    category: 'bebek bakım ürünleri',
  ),
  Product(
    id: 'p6',
    name: 'Islak Mendil',
    description: 'Bebeğin cilt bakımı için ıslak mendil',
    price: 8.99,
    imageUrl: 'assets/images/islak_mendil.jpg',
    category: 'bebek bakım ürünleri',
  ),

  Product(
    id: 'p7',
    name: 'Nivea Yüz Temizleme Jeli',
    description: 'Cildi derinlemesine temizler',
    price: 25.99,
    imageUrl: 'assets/images/p7.png',
    category: 'kozmetik ürünleri',
  ),
  Product(
    id: 'p8',
    name: 'Cerave nemlendirici krem ',
    description: 'Uzun süre kalıcı, suya dayanıklı',
    price: 12.99,
    imageUrl: 'assets/images/p8.jpg',
    category: 'kozmetik ürünleri',
  ),
  Product(
    id: 'p9',
    name: 'Maybelline Fondöten',
    description: 'Cilde doğal bir görünüm sağlar',
    price: 19.99,
    imageUrl: 'assets/images/p9.png',
    category: 'kozmetik ürünleri',
  ),
  Product(
    id: 'p10',
    name: 'NIVEA Böğürtlen Dudak Bakım Kremi',
    description: '24 Saat Nem, Hafif Bordo Işıltı, Doğal Yağlar ile Gün Boyu Dudak Bakımı',
    price: 14.99,
    imageUrl: 'assets/images/p10.jpg',
    category: 'kozmetik ürünleri',
  ),
  Product(
    id: 'p11',
    name: 'Garnier Garnier Nem Bombası Canlandırıcı Kağıt Maske',
    description: 'Cildinize bakım yapar ',
    price: 21.99,
    imageUrl: 'assets/images/p11.jpg',
    category: 'kozmetik ürünleri',
  ),
  Product(
    id: 'p12',
    name: 'Tek kullanımlık maske',
    description: '3 katlı koruyucu maske',
    price: 0.99,
    imageUrl: 'assets/images/p12.jpg',
    category: 'tıbbi malzemeler',
  ),
  Product(
    id: 'p13',
    name: 'Antiseptik solüsyon',
    description: 'Dezenfektan solüsyonu',
    price: 7.99,
    imageUrl: 'assets/images/p13.jpg',
    category: 'tıbbi malzemeler',
  ),
  Product(
    id: 'p14',
    name: 'Lateks eldiven',
    description: 'Çok amaçlı kullanım için eldiven',
    price: 9.99,
    imageUrl: 'assets/images/p14.jpg',
    category: 'tıbbi malzemeler',
  ),
  Product(
    id: 'p15',
    name: 'Yüz koruyucu siperlik',
    description: 'Yüzü tamamen kaplayan siperlik',
    price: 14.99,
    imageUrl: 'assets/images/p15.jpg',
    category: 'tıbbi malzemeler',
  ),
  Product(
    id: 'p16',
    name: 'Tansiyon aleti',
    description: 'Elektronik tansiyon ölçer',
    price: 49.99,
    imageUrl: 'assets/images/p16.jpg',
    category: 'tıbbi malzemeler',
  ),
  Product(
    id: 'p17',
    name: 'Dijital ateş ölçer',
    description: 'Elektronik ateş ölçer',
    price: 19.99,
    imageUrl: 'assets/images/p17.jpg',
    category: 'tıbbi malzemeler',
  ),
  Product(
    id: 'p18',
    name: 'Deodorant',
    description: 'Antiperspirant deodorant stick',
    price: 5.99,
    imageUrl: 'assets/images/p18.jpg',
    category: 'personal care',
  ),
  Product(
    id: 'p19',
    name: 'Diş Macunu',
    description: 'Mint-flavored toothpaste with fluoride',
    price: 3.49,
    imageUrl: 'assets/images/p19.jpg',
    category: 'personal care',
  ),
  Product(
    id: 'p20',
    name: 'Shampoo',
    description: 'Gentle shampoo for all hair types',
    price: 8.99,
    imageUrl: 'assets/images/p20.jpg',
    category: 'personal care',
  ),
  Product(
    id: 'p21',
    name: ' Saç Kremi',
    description: 'Moisturizing conditioner for dry hair',
    price: 9.99,
    imageUrl: 'assets/images/p21.jpg',
    category: 'personal care',
  ),
  Product(
    id: 'p22',
    name: 'Duş Jeli',
    description: '',
    price: 12.99,
    imageUrl: 'assets/images/p22.jpg',
    category: 'personal care',
  ),
  Product(
    id: 'p23',
    name: 'FLa Roche Posay Saf C Vitamini Işıltı Veren Antioksidan Serum ',
    description: 'C Vitamini ile leke oluşumunu engellemeye yardımcıdır',
    price: 759.92,
    imageUrl: 'assets/images/p23.jpg',
    category: 'personal care',
  ),
  Product(
    id: 'p24',
    name: 'Protein Tozu',
    description: 'Hızlı kas gelişimi için protein desteği',
    price: 34.99,
    imageUrl: 'assets/images/p24.jpg',
    category: 'takviye gıdalar',
  ),
  Product(
    id: 'p25',
    name: 'Kreatin',
    description: 'Süratli güç ve dayanıklılık artışı sağlayan bir takviye',
    price: 24.99,
    imageUrl: 'assets/images/p25.jpg',
    category: 'takviye gıdalar',
  ),
  Product(
    id: 'p26',
    name: 'Pharmaton Essential Daily ',
    description: 'Bağışıklık Sisteminin Normal Fonksiyonuna Katkıda Bulunur',
    price: 153.30,
    imageUrl: 'assets/images/p26.jpg',
    category: 'takviye gıdalar',
  ),
  Product(
    id: 'p27',
    name: 'Kolejen',
    description: 'Günlük vitamin ihtiyacını karşılayan bir takviye',
    price: 263,
    imageUrl: 'assets/images/p27.jpg',
    category: 'takviye gıdalar',
  ),
  Product(
    id: 'p28',
    name: 'Balık Yağı',
    description: 'DHA ve EPA gibi yağ asitleri içeren bir takviye',
    price: 22.99,
    imageUrl: 'assets/images/p28.jpg',
    category: 'takviye gıdalar',
  ),
  Product(
    id: 'p29',
    name: 'Probiyotik',
    description: 'Bağırsak sağlığını koruyan ve sindirim sistemini düzenleyen bir takviye',
    price: 18.99,
    imageUrl: 'assets/images/p29.jpg',
    category: 'takviye gıdalar',
  ),
  Product(
    id: 'p30',
    name: 'Advil',
    description: 'Ağrı kesici ve ateş düşürücüdür.',
    category: 'Ağrı Kesiciler',
    price: 7.99,
    imageUrl: 'assets/images/p30.jpg',
  ),
  Product(
    id: 'p31',
    name: 'Amoklavin',
    description: 'Antibiyotiktir.',
    category: 'Antibiyotikler',
    price: 15.99,
    imageUrl: 'assets/images/p31.jpg',
  ),
  Product(
    id: 'p32',
    name: 'Klavunat',
    description: 'Antibiyotiktir.',
    category: 'Antibiyotikler',
    price: 12.99,
    imageUrl: 'assets/images/p32.jpg',
  ),
  Product(
    id: 'p33',
    name: 'İbucold C',
    description: 'Ağrı kesici ve ateş düşürücüdür.',
    category: 'Ağrı Kesiciler',
    price: 9.99,
    imageUrl: 'assets/images/P33.jpg',
  ),
  Product(
    id: 'p34',
    name: 'Panadol',
    description: 'Ağrı kesici ve ateş düşürücüdür.',
    category: 'Ağrı Kesiciler',
    price: 6.99,
    imageUrl: 'assets/images/p34.jpg',
  ),
  Product(
    id: 'p35',
    name: 'Calpol',
    description: 'Ateş düşürücü ve ağrı kesici',
    price: 12.99,
    imageUrl: 'assets/images/p35.jpg',
    category: 'çocuk ilacı',
  ),
  Product(
    id: 'p36',
    name: 'Coldaway plus',
    description: 'soğuk algınlığı',
    price: 9.99,
    imageUrl: 'assets/images/p36.jpg',
    category: 'çocuk ilacı',
  ),
  Product(
    id: 'p37',
    name: 'Dolven',
    description: 'Çocuklar için ağrı kesici',
    price: 15.99,
    imageUrl: 'assets/images/p37.jpg',
    category: 'çocuk ilacı'),
  Product(
    id: 'P38',
    name: 'Pudra',
    description: 'Bebe pudrası',
    price: 7.99,
    imageUrl: 'assets/images/p38.jpg',
    category: 'bebek bakım ürünleri',
  ),
  Product(
    id: 'p39',
    name: 'Bebek Bezi ',
    description: 'Yenidoğan',
    price: 3.99,
    imageUrl: 'assets/images/p39.jpg',
    category: 'bebek bakım ürünleri',
  ),
  Product(
    id: 'p40',
    name: 'Pişik Kremi',
    description: 'Bebe pişik kremi',
    price: 9.99,
    imageUrl: 'assets/images/p40.jpg',
    category: 'bebek bakım ürünleri',
  ),
  Product(
    id: 'p41',
    name: 'Bebek Biberon',
    description: 'Bebek şampuanı',
    price: 99.95,
    imageUrl: 'assets/images/p41.jpg',
    category: 'bebek bakım ürünleri',
  ),
  Product(
    id: 'p42',
    name: 'Fitalive Gasicon Bitkisel Gaz Giderici',
    description: 'Bebek yağı',
    price: 105.99,
    imageUrl: 'assets/images/p42.jpg',
    category: 'bebek bakım ürünleri',
  ),
  Product(
    id: 'p43',
    name: 'Tylolhot',
    description: 'Ağrı ve ateş düşürücü',
    price: 15.99,
    imageUrl: 'assets/images/p43.jpg',
    category: 'sağlık ürünleri',
  ),
  Product(
    id: 'p44',
    name: 'Vicks Krem',
    description: 'Nezle, grip ve öksürük için kullanılır',
    price: 12.99,
    imageUrl: 'assets/images/p44.jpg',
    category: 'sağlık ürünleri',
  )
];
