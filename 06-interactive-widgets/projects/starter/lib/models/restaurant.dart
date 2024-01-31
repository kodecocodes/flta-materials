class Item {
  final String name;
  final String description;
  final double price;
  final String imageUrl;

  Item({
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
  });
}

class Restaurant {
  String id;
  String name;
  String address;
  String attributes;
  String imageUrl;
  String imageCredits;
  double distance;
  double rating;
  List<Item> items;

  Restaurant(
    this.id,
    this.name,
    this.address,
    this.attributes,
    this.imageUrl,
    this.imageCredits,
    this.distance,
    this.rating,
    this.items,
  );

  String getRatingAndDistance() {
    return '''Rating: ${rating.toStringAsFixed(1)} ★ | Distance: ${distance.toStringAsFixed(1)} miles''';
  }
}

List<Restaurant> restaurants = [
  Restaurant(
    '0',
    'The Blue Prawn',
    '676 Cedar St, New York, PA 19113',
    'Seafood, Healthy, Organic',
    'assets/restaurants/TheBluePrawn.webp',
    'https://images.unsplash.com/photo-1572015124294-488267231e35?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1548&q=80',
    2.1,
    4.5,
    [
      Item(
        name: 'Ocean Bounty Salad',
        description:
            '''A fresh mix of organic greens, cherry tomatoes, avocados, topped with succulent prawns and a lemon vinaigrette.''',
        price: 14.99,
        imageUrl:
            'https://images.unsplash.com/photo-1572449043416-55f4685c9bb7?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1160&q=80',
      ),
      Item(
        name: 'Grilled Prawn Tacos',
        description:
            '''Soft organic tortillas filled with seasoned grilled prawns, fresh cabbage slaw, and a zesty avocado salsa.''',
        price: 16.99,
        imageUrl:
            'https://images.unsplash.com/photo-1624300629298-e9de39c13be5?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=774&q=80',
      ),
      Item(
        name: 'Blue Prawn Risotto',
        description:
            '''Creamy organic Arborio rice cooked with white wine and garlic, enriched with blue prawns and sprinkled with parmesan.''',
        price: 19.99,
        imageUrl:
            'https://images.unsplash.com/photo-1609770424775-39ec362f2d94?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=930&q=80',
      ),
      Item(
        name: 'Seaweed-Wrapped Salmon',
        description:
            '''Organic salmon fillet wrapped in seaweed, steamed to perfection, served with quinoa and a side of roasted veggies.''',
        price: 21.99,
        imageUrl:
            'https://images.unsplash.com/photo-1519708227418-c8fd9a32b7a2?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1470&q=80',
      ),
      Item(
        name: 'Lobster & Prawn Soup',
        description:
            '''A rich and hearty soup made from fresh organic lobster and prawns, complemented with seasonal herbs and a touch of coconut milk.''',
        price: 17.99,
        imageUrl:
            'https://images.unsplash.com/photo-1533745807-618e4bd071f2?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1374&q=80',
      ),
    ],
  ),
  Restaurant(
    '1',
    "Mama Rosa's Pizza",
    '603 Cedar St, Chicago, AZ 92294',
    'Pizza, Italian, Comfort Food',
    'assets/restaurants/MamaRosasPizza.webp',
    'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=962&q=80',
    0.7,
    4.7,
    [
      Item(
        name: 'Margherita Classic',
        description:
            '''Timeless blend of ripe tomatoes, fresh basil, mozzarella cheese, and a touch of olive oil on a thin crust.''',
        price: 12.99,
        imageUrl:
            'https://images.unsplash.com/photo-1598023696416-0193a0bcd302?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1536&q=80',
      ),
      Item(
        name: 'Pepperoni Passion',
        description:
            '''Generous layers of spicy pepperoni on a bed of mozzarella and marinara sauce.''',
        price: 14.99,
        imageUrl:
            'https://images.unsplash.com/photo-1534308983496-4fabb1a015ee?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1476&q=80',
      ),
      Item(
        name: 'Mamas Veggie Supreme',
        description:
            '''A delightful array of bell peppers, olives, red onions, mushrooms, and spinach with feta and mozzarella cheese.''',
        price: 13.99,
        imageUrl:
            'https://images.unsplash.com/photo-1648679708301-3e2865043526?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1374&q=80',
      ),
      Item(
        name: 'Spaghetti Carbonara',
        description:
            '''Creamy pasta cooked with crisp pancetta, eggs, and parmesan cheese, sprinkled with parsley.''',
        price: 15.99,
        imageUrl:
            'https://images.unsplash.com/photo-1588013273468-315fd88ea34c?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1469&q=80',
      ),
      Item(
        name: 'Chicken Parmesan',
        description:
            '''Tender breaded chicken breast topped with marinara sauce, mozzarella, and parmesan cheese, served with spaghetti.''',
        price: 17.99,
        imageUrl:
            'https://images.unsplash.com/photo-1632778149955-e80f8ceca2e8?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1470&q=80',
      ),
      Item(
          name: 'Tiramisu Delight',
          description:
              '''Classic Italian dessert made with layers of coffee-soaked ladyfingers and rich mascarpone cream, dusted with cocoa.''',
          price: 7.99,
          imageUrl:
              'https://images.unsplash.com/photo-1586040140378-b5634cb4c8fc?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=772&q=80'),
    ],
  ),
  Restaurant(
    '2',
    'Bistro De Paris',
    '810 Main St, San Jose, NY 19113',
    'French, Fine Dining, Wine',
    'assets/restaurants/BistroDeParis.jpg',
    'https://images.unsplash.com/photo-1608855238293-a8853e7f7c98?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1470&q=80',
    3.3,
    4.8,
    [
      Item(
          name: 'Coq au Vin',
          description:
              '''Tender chicken slow-cooked in a rich red wine sauce with mushrooms, pearl onions, and lardons.''',
          price: 26.99,
          imageUrl:
              'https://images.unsplash.com/photo-1475869430886-fb14585f7443?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1470&q=80'),
      Item(
          name: 'Bouillabaisse',
          description:
              '''Provencal fish stew made with a blend of fish, shellfish, leeks, onions, tomatoes, and served with a side of rouille sauce.''',
          price: 29.99,
          imageUrl:
              'https://images.unsplash.com/photo-1600265721436-734abbfe2137?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1374&q=80'),
      Item(
          name: 'Duck à lOrange',
          description:
              '''Roast duck served with a sweet and tangy orange sauce, complemented by seasonal vegetables.''',
          price: 28.99,
          imageUrl:
              'https://images.unsplash.com/photo-1580554530778-ca36943938b2?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=928&q=80'),
      Item(
          name: 'Ratatouille Niçoise',
          description:
              '''A flavorful stew of eggplant, bell peppers, zucchini, and tomatoes, seasoned with fresh herbs from Provence.''',
          price: 22.99,
          imageUrl:
              'https://images.unsplash.com/photo-1594576182733-ad4ec76e674f?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1470&q=80'),
      Item(
          name: 'Crème Brûlée',
          description:
              '''Creamy vanilla custard topped with a layer of hardened caramelized sugar.''',
          price: 9.99,
          imageUrl:
              'https://images.unsplash.com/photo-1615235739538-95040f341ba8?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=928&q=80'),
      Item(
          name: 'Chateau Bordeaux',
          description:
              '''Fine-aged red wine from the Bordeaux region, boasting deep flavors of plum, black currant, and hints of cedar.''',
          price: 49.99,
          imageUrl:
              'https://images.unsplash.com/photo-1474722883778-792e7990302f?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=782&q=80'),
    ],
  ),
  Restaurant(
    '3',
    'Green Zenphony',
    '810 Main St, San Jose, NY 19113',
    'Vegan, Vegetarian, Healthy',
    'assets/restaurants/GreenZenphony.jpg',
    'https://images.unsplash.com/photo-1540914124281-342587941389?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1548&q=80',
    1.5,
    4.4,
    [
      Item(
          name: 'Mystical Mushroom Ramen',
          description:
              '''Hearty broth infused with shiitake and maitake mushrooms, served with whole grain noodles, tofu, and seasonal greens.''',
          price: 14.99,
          imageUrl:
              'https://images.unsplash.com/photo-1511910849309-0dffb8785146?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=774&q=80'),
      Item(
          name: 'Golden Turmeric Bowl',
          description:
              '''A vibrant blend of quinoa, roasted vegetables, chickpeas, and drizzled with a turmeric-tahini dressing.''',
          price: 12.99,
          imageUrl:
              'https://images.unsplash.com/photo-1518710339019-eee82fe8d97f?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=774&q=80'),
      Item(
          name: 'Zen Buddha Wrap',
          description:
              '''A hearty wrap filled with hummus, avocado, shredded beets, carrots, and sprouts. Served with a side of kale chips.''',
          price: 10.99,
          imageUrl:
              'https://plus.unsplash.com/premium_photo-1664648119287-dd5bfde1cb0a?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=774&q=80'),
      Item(
          name: 'Green Harmony Smoothie',
          description:
              '''A refreshing blend of spinach, cucumber, green apple, chia seeds, and coconut water.''',
          price: 6.99,
          imageUrl:
              'https://images.unsplash.com/photo-1610970881699-44a5587cabec?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=774&q=80'),
      Item(
          name: 'Avocado Chocolate Mousse',
          description:
              '''A creamy and rich mousse made from ripe avocados, cacao, and sweetened with agave nectar.''',
          price: 7.99,
          imageUrl:
              'https://images.unsplash.com/photo-1621792907789-666f0e69ea03?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=774&q=80'),
      Item(
          name: 'Serenity Herbal Tea',
          description:
              '''A soothing blend of chamomile, lavender, and rose petals. Perfect for relaxation.''',
          price: 4.99,
          imageUrl:
              'https://images.unsplash.com/photo-1615205597144-5c7c885291d2?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=816&q=80'),
    ],
  ),
  Restaurant(
    '4',
    'Tandoori Flame',
    '810 Main St, San Jose, NY 19113',
    'Indian, Spicy, Vegan Options',
    'assets/restaurants/TandooriFlame.jpg',
    'https://images.unsplash.com/photo-1617692855027-33b14f061079?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1470&q=80',
    2.8,
    4.2,
    [
      Item(
          name: 'Butter Chicken',
          description:
              '''Tender chicken pieces marinated in yogurt and spices, cooked in a rich tomato-based gravy with a touch of cream.''',
          price: 15.99,
          imageUrl:
              'https://images.unsplash.com/photo-1588166524941-3bf61a9c41db?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=768&q=80'),
      Item(
          name: 'Paneer Tikka Masala',
          description:
              '''Soft paneer cubes cooked in a spicy and creamy tomato gravy, infused with aromatic herbs.''',
          price: 14.99,
          imageUrl:
              'https://images.unsplash.com/photo-1596797038530-2c107229654b?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=870&q=80'),
      Item(
          name: 'Chana Masala',
          description:
              '''Hearty chickpeas simmered in a tangy and spicy tomato gravy, garnished with fresh cilantro.''',
          price: 12.99,
          imageUrl:
              'https://images.unsplash.com/photo-1565557623262-b51c2513a641?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1371&q=80'),
      Item(
          name: 'Tandoori Broccoli',
          description:
              '''Broccoli florets marinated in a blend of yogurt and spices, then roasted in the tandoor to perfection.''',
          price: 11.99,
          imageUrl:
              'https://images.unsplash.com/photo-1617692855027-33b14f061079?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1470&q=80'),
      Item(
          name: 'Lamb Rogan Josh',
          description:
              '''Slow-cooked lamb chunks in a rich and aromatic gravy, made from onions, yogurt, and a blend of spices.''',
          price: 18.99,
          imageUrl:
              'https://images.unsplash.com/photo-1514516345957-556ca7d90a29?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1470&q=80'),
      Item(
          name: 'Vegan Biryani',
          description:
              '''Flavorful rice dish cooked with a medley of vegetables and aromatic spices, served with a side of vegan raita.''',
          price: 14.99,
          imageUrl:
              'https://images.unsplash.com/photo-1563379091339-03b21ab4a4f8?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1020&q=80'),
    ],
  ),
  Restaurant(
    '5',
    'El Toro Loco',
    '810 Main St, San Jose, NY 19113',
    'Mexican, Tacos, Margaritas',
    'assets/restaurants/ElToroLoco.jpg',
    'https://images.unsplash.com/photo-1615870216519-2f9fa575fa5c?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1632&q=80',
    0.9,
    4.3,
    [
      Item(
          name: 'Carne Asada Tacos',
          description:
              '''Grilled steak tacos served with fresh cilantro, diced onions, and a squeeze of lime.''',
          price: 13.99,
          imageUrl:
              'https://images.unsplash.com/photo-1514843319620-4f042827c481?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1470&q=80'),
      Item(
          name: 'Pescado Tacos',
          description:
              '''Lightly breaded fish tacos topped with cabbage slaw, pico de gallo, and tangy chipotle mayo.''',
          price: 14.99,
          imageUrl:
              'https://images.unsplash.com/photo-1604467715878-83e57e8bc129?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=776&q=80'),
      Item(
          name: 'Enchiladas',
          description:
              '''Soft tortillas filled with sautéed vegetables, smothered in red enchilada sauce and melted cheese.''',
          price: 12.99,
          imageUrl:
              'https://images.unsplash.com/photo-1534352956036-cd81e27dd615?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=802&q=80'),
      Item(
          name: 'Guacamole & Chips',
          description:
              'Freshly made guacamole served with crispy tortilla chips.',
          price: 6.99,
          imageUrl:
              'https://images.unsplash.com/photo-1585688964721-e30447e290d7?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1470&q=80'),
      Item(
          name: 'Classic Margarita',
          description:
              '''A refreshing blend of tequila, lime juice, triple sec, served on the rocks with a salted rim.''',
          price: 8.99,
          imageUrl:
              'https://images.unsplash.com/photo-1634003311194-152e30e732f7?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1471&q=80'),
      Item(
          name: 'Churros with Chocolate Sauce',
          description:
              '''Crispy golden churros dusted with cinnamon sugar, served with a side of rich chocolate dipping sauce.''',
          price: 7.99,
          imageUrl:
              'https://images.unsplash.com/photo-1624371414361-e670edf4898d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1470&q=80'),
    ],
  ),
  Restaurant(
    '6',
    'Sushi Delight',
    '810 Main St, San Jose, NY 19113',
    'Japanese, Sushi, Seafood',
    'assets/restaurants/OldKyotoSushi.jpg',
    'https://images.unsplash.com/photo-1564489563601-c53cfc451e93?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=774&q=80',
    4.2,
    4.6,
    [
      Item(
          name: 'Salmon Nigiri',
          description:
              '''Fresh, raw salmon slices served atop hand-pressed vinegar-seasoned rice.''',
          price: 13.99,
          imageUrl:
              'https://images.unsplash.com/photo-1648146298796-2d4ab2f380d2?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1470&q=80'),
      Item(
          name: 'Tuna Maki Roll',
          description:
              '''Sushi roll filled with fresh tuna, cucumber, and avocado, wrapped in seaweed and sushi rice.''',
          price: 14.99,
          imageUrl:
              'https://images.unsplash.com/photo-1587758822443-9d4088f8b838?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=774&q=80'),
      Item(
          name: 'Vegetable Tempura',
          description:
              '''Assorted vegetables lightly battered and deep-fried until crispy, served with tempura dipping sauce.''',
          price: 12.99,
          imageUrl:
              'https://images.unsplash.com/photo-1593357849627-cbbc9fda6b05?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1470&q=80'),
      Item(
          name: 'Miso Soup',
          description:
              '''Traditional Japanese soup made with soybean paste, tofu, and seaweed.''',
          price: 6.99,
          imageUrl:
              'https://images.unsplash.com/photo-1582271929389-5bbccafeb493?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=626&q=80'),
      Item(
          name: 'Green Tea Ice Cream',
          description: 'Refreshing and creamy green tea-flavored ice cream.',
          price: 8.99,
          imageUrl:
              'https://images.unsplash.com/photo-1603736029103-dafad0eb0906?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1471&q=80'),
      Item(
          name: 'Tempura Banana with Sesame Seeds',
          description:
              '''Ripe banana slices dipped in tempura batter, deep-fried until golden, and sprinkled with sesame seeds.''',
          price: 7.99,
          imageUrl:
              'https://images.unsplash.com/photo-1461648704997-bc28bf991386?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1470&q=80'),
    ],
  ),
  Restaurant(
    '7',
    'Tuscan Olive',
    '810 Main St, San Jose, NY 19113',
    'Italian, Pasta, Wine',
    'assets/restaurants/TuscanOlive.jpg',
    'https://images.unsplash.com/photo-1616299915952-04c803388e5f?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1524&q=80',
    3.5,
    4.7,
    [
      Item(
          name: 'Fettuccine Alfredo',
          description:
              '''Creamy pasta dish made with butter, heavy cream, and Parmesan cheese, topped with freshly chopped parsley.''',
          price: 14.99,
          imageUrl:
              'https://images.unsplash.com/photo-1645112411341-6c4fd023714a?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1470&q=80'),
      Item(
          name: 'Spaghetti Carbonara',
          description:
              '''Classic Roman dish with spaghetti, eggs, Pecorino Romano, guanciale, and pepper.''',
          price: 13.99,
          imageUrl:
              'https://images.unsplash.com/photo-1612874742237-6526221588e3?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1471&q=80'),
      Item(
          name: 'Eggplant Parmigiana',
          description:
              '''Layers of thinly sliced eggplant, marinara sauce, and mozzarella, baked to perfection.''',
          price: 15.99,
          imageUrl:
              'https://images.unsplash.com/photo-1594576182733-ad4ec76e674f?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1470&q=80'),
      Item(
          name: 'Osso Buco',
          description:
              '''Slow-cooked veal shanks in a white wine and tomato sauce, served with risotto alla Milanese.''',
          price: 24.99,
          imageUrl:
              'https://images.unsplash.com/photo-1620167789167-b18dea494214?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1470&q=80'),
      Item(
          name: 'Tiramisu',
          description:
              '''Delicate layers of coffee-soaked ladyfingers and mascarpone cheese, dusted with cocoa powder.''',
          price: 8.99,
          imageUrl:
              'https://images.unsplash.com/photo-1586040140378-b5634cb4c8fc?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=772&q=80'),
      Item(
          name: 'Chianti Classico',
          description:
              '''A robust red wine with flavors of dark cherry and spice, perfect for pairing with hearty Italian dishes.''',
          price: 12.99,
          imageUrl:
              'https://images.unsplash.com/photo-1553361371-9b22f78e8b1d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=774&q=80'),
    ],
  ),
  Restaurant(
    '8',
    'The Breakfast Club',
    '810 Main St, San Jose, NY 19113',
    'Breakfast, Brunch, Coffee',
    'assets/restaurants/TheBreakfastClub.jpg',
    'https://images.unsplash.com/photo-1611601184963-9d1de9b79ff3?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1470&q=80',
    0.5,
    4.5,
    [
      Item(
          name: 'Classic Pancake Stack',
          description:
              '''Fluffy buttermilk pancakes served with butter, maple syrup, and a side of fresh berries.''',
          price: 9.99,
          imageUrl:
              'https://images.unsplash.com/photo-1565299543923-37dd37887442?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=962&q=80'),
      Item(
        name: 'Eggs Benedict',
        description:
            '''Toasted English muffins topped with ham, poached eggs, and creamy hollandaise sauce.''',
        price: 12.99,
        imageUrl:
            'https://images.unsplash.com/photo-1608039829572-78524f79c4c7?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=774&q=80',
      ),
      Item(
          name: 'Avocado Toast',
          description:
              '''Whole grain toast spread with ripe avocado, cherry tomatoes, radish slices, and a sprinkle of feta.''',
          price: 8.99,
          imageUrl:
              'https://images.unsplash.com/photo-1603046891726-36bfd957e0bf?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=774&q=80'),
      Item(
          name: 'French Toast Casserole',
          description:
              '''Sweet and savory bread pudding style French toast served with a side of crispy bacon.''',
          price: 11.99,
          imageUrl:
              'https://images.unsplash.com/photo-1510693206972-df098062cb71?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1298&q=80'),
      Item(
          name: 'Cappuccino',
          description:
              '''A perfect blend of espresso, steamed milk, and a frothy top, dusted with cocoa or cinnamon.''',
          price: 3.99,
          imageUrl:
              'https://images.unsplash.com/photo-1572442388796-11668a67e53d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1270&q=80'),
      Item(
          name: 'Vegan Breakfast Burrito',
          description:
              '''A hearty wrap filled with scrambled tofu, sautéed vegetables, black beans, and avocado. Served with salsa on the side.''',
          price: 10.99,
          imageUrl:
              'https://images.unsplash.com/photo-1574365361850-8e8aec561723?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=870&q=80'),
    ],
  ),
];
