import 'package:flutter/foundation.dart';

class OrbitData {
  static final List<Map<String, dynamic>> products = [
    {'name':'Luna','price':85,'collection':'LUNAR COLLECTION','description':'A delicate celestial fragrance inspired by moonlight, fresh air, and quiet nights.','image':'assets/images/Luna.jpg','notes':'Bergamot, Jasmine, Musk'},
    {'name':'Solar Flare','price':110,'collection':'SOLAR COLLECTION','description':'A radiant fragrance with warm amber tones and the intensity of a distant sun.','image':'assets/images/Solar Flare.jpg','notes':'Amber, Saffron, Vanilla'},
    {'name':'Nebula','price':95,'collection':'GALAXY COLLECTION','description':'A mysterious blend of floral and woody accords wrapped in a violet cosmic aura.','image':'assets/images/Nebula.jpg','notes':'Iris, Violet, Sandalwood'},
    {'name':'Eclipse','price':120,'collection':'DARK COLLECTION','description':'A deep, confident scent inspired by the stillness of a total eclipse.','image':'assets/images/Eclipse.jpg','notes':'Black Pepper, Cedar, Amber'},
    {'name':'Red Planet','price':90,'collection':'SOLAR COLLECTION','description':'A bold, warm fragrance with a trail as striking as a red horizon.','image':'assets/images/Red Planet.jpg','notes':'Pink Pepper, Cinnamon, Leather'},
    {'name':'Starlight','price':75,'collection':'LUNAR COLLECTION','description':'A luminous, clean scent with a soft and airy finish.','image':'assets/images/Starlight.jpg','notes':'Pear, White Musk, Neroli'},
    {'name':'Cosmic Oud','price':130,'collection':'GALAXY COLLECTION','description':'A rich oud fragrance with a smoky, elegant, long-lasting character.','image':'assets/images/Cosmic Oud.jpg','notes':'Oud, Incense, Patchouli'},
    {'name':'Midnight Orbit','price':105,'collection':'DARK COLLECTION','description':'A magnetic night fragrance with a smooth, warm and mysterious signature.','image':'assets/images/Midnight Orbit.jpg','notes':'Amber, Tonka, Vetiver'},
    {'name':'Violet Comet','price':88,'collection':'GALAXY COLLECTION','description':'A vivid purple-toned fragrance inspired by a comet crossing a distant nebula.','image':'assets/images/1.jpg','notes':'Violet, Musk, Cedar'},
    {'name':'Golden Horizon','price':115,'collection':'SOLAR COLLECTION','description':'A golden, warm scent with a polished and luminous character.','image':'assets/images/2.jpg','notes':'Amber, Spice, Woods'},
    {'name':'Dark Matter','price':125,'collection':'DARK COLLECTION','description':'A dark, modern scent with a bold and smoky impression.','image':'assets/images/3.jpg','notes':'Smoke, Woods, Musk'},
    {'name':'Purple Nebula','price':99,'collection':'GALAXY COLLECTION','description':'A dreamy fragrance with a soft floral heart and a deep woody base.','image':'assets/images/4.jpg','notes':'Iris, Florals, Sandalwood'},
    {'name':'Moon Shadow','price':92,'collection':'LUNAR COLLECTION','description':'A quiet night-time fragrance with a cool and elegant finish.','image':'assets/images/5.jpg','notes':'Musk, Cedar, Amber'},
    {'name':'Solar Crown','price':118,'collection':'SOLAR COLLECTION','description':'A radiant and refined fragrance with warm golden facets.','image':'assets/images/6.jpg','notes':'Saffron, Amber, Vanilla'},
    {'name':'Obsidian Star','price':128,'collection':'DARK COLLECTION','description':'A confident dark scent with a rich, sophisticated trail.','image':'assets/images/7.jpg','notes':'Leather, Pepper, Woods'},
    {'name':'Lunar Bloom','price':89,'collection':'LUNAR COLLECTION','description':'A gentle floral fragrance inspired by a moonlit garden.','image':'assets/images/8.jpg','notes':'Floral Notes, Musk, Pear'},
    {'name':'Golden Eclipse','price':122,'collection':'DARK COLLECTION','description':'A luxurious contrast of warm spice and deep woods.','image':'assets/images/9.jpg','notes':'Spice, Amber, Cedar'},
    {'name':'Blue Orbit','price':96,'collection':'GALAXY COLLECTION','description':'A cool, fresh fragrance inspired by distant blue planets.','image':'assets/images/10.jpg','notes':'Fresh Notes, Musk, Woods'},
    {'name':'Cosmic Veil','price':102,'collection':'GALAXY COLLECTION','description':'A mysterious fragrance with a violet, atmospheric character.','image':'assets/images/11.jpg','notes':'Violet, Amber, Musk'},
  ];

  static final Set<String> favorites = {};
  static final Map<String, int> cart = {};

  static final ValueNotifier<int> revision = ValueNotifier<int>(0);

  static void toggleFavorite(String name) {
    if (favorites.contains(name)) {
      favorites.remove(name);
    } else {
      favorites.add(name);
    }
    revision.value++;
  }

  static bool isFavorite(String name) => favorites.contains(name);

  static void addToCart(String name) {
    cart[name] = (cart[name] ?? 0) + 1;
    revision.value++;
  }

  static void changeQuantity(String name, int delta) {
    final next = (cart[name] ?? 0) + delta;
    if (next <= 0) {
      cart.remove(name);
    } else {
      cart[name] = next;
    }
    revision.value++;
  }

  static void removeFromCart(String name) {
    cart.remove(name);
    revision.value++;
  }

  static Map<String, dynamic> productByName(String name) =>
      products.firstWhere((p) => p['name'] == name, orElse: () => products.first);
}
