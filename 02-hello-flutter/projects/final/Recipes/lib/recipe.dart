/*
 * Copyright (c) 2020 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
 * distribute, sublicense, create a derivative work, and/or sell copies of the
 * Software in any work that is designed, intended, or marketed for pedagogical or
 * instructional purposes related to programming, coding, application development,
 * or information technology.  Permission for such use, copying, modification,
 * merger, publication, distribution, sublicensing, creation of derivative works,
 * or sale is expressly withheld.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

class Recipe {
  String label;
  String imageUrl;
  int servings;
  List<Ingredient> ingredients;

  Recipe(this.label, this.imageUrl, this.servings, this.ingredients);

  static List<Recipe> samples = [
    Recipe(
      "Spaghetti and Meatballs",
      "assets/2126711929_ef763de2b3_w.jpg",
      4,
      [
        Ingredient(1, "box", "Spaghetti"),
        Ingredient(4, "", "Frozen Meatballs"),
        Ingredient(0.5, "jar", "sauce"),
      ],
    ),
    Recipe(
      "Tomato Soup",
      "assets/27729023535_a57606c1be.jpg",
      2,
      [
        Ingredient(1, "can", "Tomato Soup"),
      ],
    ),
    Recipe(
      "Grilled Cheese",
      "assets/3187380632_5056654a19_b.jpg",
      1,
      [
        Ingredient(2, "slices", "Cheese"),
        Ingredient(2, "slices", "Bread"),
      ],
    ),
    Recipe(
      "Chocolate Chip Cookies",
      "assets/15992102771_b92f4cc00a_b.jpg",
      24,
      [
        Ingredient(4, "cups", "flour"),
        Ingredient(2, "cups", "sugar"),
        Ingredient(0.5, "cups", "chocolate chips"),
      ],
    ),
    Recipe(
      "Taco Salad",
      "assets/8533381643_a31a99e8a6_c.jpg",
      1,
      [
        Ingredient(4, "oz", "nachos"),
        Ingredient(3, "oz", "taco meat"),
        Ingredient(0.5, "cup", "cheese"),
        Ingredient(0.25, "cup", "chopped tomatoes"),
      ],
    ),
    Recipe(
      "Hawaiian Pizza",
      "assets/15452035777_294cefced5_c.jpg",
      4,
      [
        Ingredient(1, "item", "pizza"),
        Ingredient(1, "cup", "pineapple"),
        Ingredient(8, "oz", "ham"),
      ],
    ),
  ];
}

class Ingredient {
  double quantity;
  String measure;
  String name;

  Ingredient(this.quantity, this.measure, this.name);
}
