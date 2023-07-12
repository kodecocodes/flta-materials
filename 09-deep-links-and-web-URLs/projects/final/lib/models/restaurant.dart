class Restaurant {
  String name;
  String attributes;
  String imageUrl;
  String imageCredits;
  double distance;
  double rating;

  Restaurant(
      this.name, this.attributes, this.imageUrl, this.imageCredits, this.distance, this.rating);
}

List<Restaurant> restaurants = [
  Restaurant(
    'The Blue Prawn', 
    'Seafood, Healthy, Organic',
    'assets/restaurants/TheBluePrawn.webp',
    'https://images.unsplash.com/photo-1572015124294-488267231e35?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1548&q=80',
    2.1, 
    4.5
  ),
  Restaurant(
    "Mama Rosa's Pizza", 
    'Pizza, Italian, Comfort Food',
    'assets/restaurants/MamaRosasPizza.webp',
    'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=962&q=80',
    0.7, 
    4.7
  ),
  Restaurant(
    'Bistro De Paris', 
    'French, Fine Dining, Wine',
    'assets/restaurants/BistroDeParis.jpg',
    'https://images.unsplash.com/photo-1608855238293-a8853e7f7c98?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1470&q=80',
    3.3,
    4.8
  ),
  Restaurant(
    'Green Zenphony', 
    'Vegan, Vegetarian, Healthy',
    'assets/restaurants/GreenZenphony.jpg',
    'https://images.unsplash.com/photo-1540914124281-342587941389?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1548&q=80',
    1.5, 
    4.4
  ),
  Restaurant(
    'Tandoori Flame', 
    'Indian, Spicy, Vegan Options',
    'assets/restaurants/TandooriFlame.jpg',
    'https://images.unsplash.com/photo-1617692855027-33b14f061079?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1470&q=80',
    2.8, 
    4.2
  ),
  Restaurant(
    'El Toro Loco', 
    'Mexican, Tacos, Margaritas',
    'assets/restaurants/ElToroLoco.jpg',
    'https://images.unsplash.com/photo-1615870216519-2f9fa575fa5c?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1632&q=80',
    0.9, 
    4.3
  ),
  Restaurant(
    'Old Kyoto Sushi', 
    'Japanese, Sushi, Seafood',
    'assets/restaurants/OldKyotoSushi.jpg',
    'https://images.unsplash.com/photo-1564489563601-c53cfc451e93?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=774&q=80',
    4.2, 
    4.6
  ),
  Restaurant(
    "Ravi's Naan House",
    'Indian, Street Food, Vegetarian Options',
    'assets/restaurants/RavisNaanHouse.jpg',
    'https://images.unsplash.com/photo-1505253758473-96b7015fcd40?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=800&q=80',
    1.2,
    4.1
  ),
  Restaurant(
    'Tuscan Olive', 
    'Italian, Pasta, Wine',
    'assets/restaurants/TuscanOlive.jpg',
    'https://images.unsplash.com/photo-1616299915952-04c803388e5f?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1524&q=80',
    3.5,
    4.7
  ),
  Restaurant(
    'The Breakfast Club',
    'Breakfast, Brunch, Coffee',
    'assets/restaurants/TheBreakfastClub.jpg',
    'https://images.unsplash.com/photo-1611601184963-9d1de9b79ff3?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1470&q=80',
    0.5, 
    4.5
  ),
];
