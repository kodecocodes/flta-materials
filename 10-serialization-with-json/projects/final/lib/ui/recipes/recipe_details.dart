import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../colors.dart';

class RecipeDetails extends StatelessWidget {
  const RecipeDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Stack(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: CachedNetworkImage(
                        // TODO 1
                        imageUrl:
                            'https://edamam-product-images.s3.amazonaws.com/web-img/e42/e42f9119813e890af34c259785ae1cfb.jpg?X-Amz-Security-Token=IQoJb3JpZ2luX2VjENL%2F%2F%2F%2F%2F%2F%2F%2F%2F%2FwEaCXVzLWVhc3QtMSJHMEUCIQDKe2vNkNGigosOjxxO9nTYmupq8Ic5YkJ2r9%2FE%2BcPaFgIgVlSgkinqWyfyPsVxPt4u6VJVWik00Qqnd2zAfnCQ3eIq2wQIy%2F%2F%2F%2F%2F%2F%2F%2F%2F%2F%2FARAAGgwxODcwMTcxNTA5ODYiDN2vjV%2FN7u%2BvyIdpsSqvBM8DWUrJVPkRjMcUpHuB060PPO0QDum3Cgbw7SPjU9ZMuu6htoBYsHe64GbZb5KtdSFdG4LCkdEnpIjkt4mB%2Bse0YnKvC9JDTOa682Il0zNGRTJDR1h87sxzUevj6jOqOo6wIp3%2Bq1XoMMQjTCt0G6q63IEiWctcJc0WbxoWfB%2FJpzdQp0Qq8gbkYlZARWnr7e4Qcxhgn6ZJ%2F4UFHqgIGZXGSXq1qa4ArYmBWKT1PxcBif19yr%2Bmku41Y2HPFPdhPA1mt04m3TD1sWaAOwciv4TCAWMRp%2BA3f21eoD1LKpoORMNmsJ8u%2BnZ8iUZ3LMo%2FMtwu11LqnMt5IJOqLDw%2FLn3NBVFdrDhwZI5Y37wDdy9Iz7etd5Ns20G4Sx8OZxqp3dWqEHjLfpm2XJWfxOW624A2F1PeFyYD3yyPw%2FnD%2Bcf6MtAhIeBnpihXhgmKQYNtyr%2F9aeJ6Q%2FpcshazmECRg44LfC5Ieveb9WTRmegNnDFYkCxO0BEdGeE0%2B%2B5yOzqcuoRab7TEscXP3VZFgUwFw6Yjw9nTg7sF0zn49%2FjXrTNvAkzEGiK3Nepp8OtLS%2Fqvw0Fb9HApefV3IHb27sR034pLCrTkbPW%2FKqK1xPQNAWlqjyfQmn9AALH538VEySa5kS%2B7eSKPDYphNWKr6G3piA1li%2FhG%2FFg9AXQqMyxAHcMyqdN69oA0r%2Fs1MTnQlFKmubmQxRAAXWkFf0OQaHSZ1V3FNhnDCROuWCcrqGWT%2B40woNn6lAY6qQHteUPl6%2B7ESjj3tzfoiwU4rV7Rvs23jy6E9wMb6rBA9kLaTE6vhWxDV9bfjLaN6fXC24xOm9MSA1F766J0oIuOg71T9cBZX4vRvqm1s3IDVKVi3mtF33rgy5hDoTt1wSp6z45CySX8%2FY1fQy3AAjzqODjfPcGL4BTZo4aj2AJEKW4xeHdunlM9XBQGkuchGxY1TfGqfrFo4glpt%2BCCJYIWtIjZAcKh%2BaF8&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Date=20220607T023538Z&X-Amz-SignedHeaders=host&X-Amz-Expires=3600&X-Amz-Credential=ASIASXCYXIIFBWOB2CP4%2F20220607%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Signature=27c082ba2e088dae316ed8fb72bf5acef28a61f719f7c8b36b5e0fefaaf29b36',
                        alignment: Alignment.topLeft,
                        fit: BoxFit.fill,
                        width: size.width,
                      ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: shim),
                        child: const BackButton(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 16.0),
                  child: Text(
                    // TODO 2
                    'Chicken Vesuvio',
                    style: TextStyle(
                        fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                const Padding(
                    padding: EdgeInsets.only(left: 16.0),
                    child: Chip(
                      // TODO 3
                      label: Text('16CAL'),
                    )),
                const SizedBox(
                  height: 16,
                ),
                Center(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      primary: green,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0)),
                    ),
                    onPressed: () {
                      // TODO 4
                      Navigator.pop(context);
                    },
                    icon: SvgPicture.asset(
                      'assets/images/icon_bookmark.svg',
                      color: Colors.white,
                    ),
                    label: const Text(
                      'Bookmark',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
