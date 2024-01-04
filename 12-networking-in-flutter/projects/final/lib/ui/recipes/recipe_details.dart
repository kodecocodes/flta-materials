import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lumberdash/lumberdash.dart';
import '../../network/service_interface.dart';
import '../../providers.dart';

import '../../data/models/recipe.dart';
import '../../network/model_response.dart';
import '../theme/colors.dart';
import '../widgets/common.dart';

class RecipeDetails extends ConsumerStatefulWidget {
  final Recipe recipe;

  const RecipeDetails({
    Key? key,
    required this.recipe,
  }) : super(key: key);

  @override
  ConsumerState<RecipeDetails> createState() => _RecipeDetailsState();
}

class _RecipeDetailsState extends ConsumerState<RecipeDetails> {
  Recipe? recipeDetail;

  @override
  void initState() {
    super.initState();
    loadRecipe();
  }

  void loadRecipe() async {
    final response = await ref
        .read(serviceProvider)
        .queryRecipe(widget.recipe.id.toString());
    final result = response.body;
    if (result is Success<Recipe>) {
      final body = result.value;
      recipeDetail = body;
      if (mounted) {
        setState(() {});
      }
    } else  {
      logMessage('Problems getting Recipe $result');
    }
  }

  @override
  Widget build(BuildContext context) {
    final maxHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.white,
          height: maxHeight,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                topImage(context),
                sizedW16,
                Container(
                    constraints: const BoxConstraints(maxWidth: 500),
                    child: Column(
                      children: [
                        titleRow(),
                        description(),
                        sizedW16,
                      ],
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void readRecipe(AsyncSnapshot<RecipeDetailsResponse> snapshot) {
    final result = snapshot.data?.body;
    if (result is Success<Recipe>) {
      final body = result.value;
      recipeDetail = body;
    }
  }

  Widget topImage(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        SizedBox(
          width: size.width,
          height: 150,
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  stops: [0.0, 0.5, 1.0],
                  colors: [lightGreen, Colors.white, lightGreen]),
            ),
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Hero(
            tag: 'recipe-${widget.recipe.id}',
            child: CachedNetworkImage(
              imageUrl: widget.recipe.image ?? '',
              alignment: Alignment.topCenter,
              fit: BoxFit.contain,
              placeholder: (context, url) => const CircularProgressIndicator(),
              height: 150,
              width: 200,
            ),
          ),
        ),
      ],
    );
  }

  Widget titleRow() {
    // TODO: Add Repository
    final titleRowColor = widget.recipe.bookmarked
        ? Colors.black
        : Colors.white;
    return Container(
      decoration: const BoxDecoration(color: lightGreen),
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: Row(
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back, color: titleRowColor),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            Expanded(
              child: AutoSizeText(
                widget.recipe.label ?? '',
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(
                    fontSize: 24,
                    fontFamily: 'Roboto',
                    color: titleRowColor),
              ),
            ),
            IconButton(
              icon: SvgPicture.asset(
                widget.recipe.bookmarked
                    ? 'assets/images/icon_bookmarks.svg'
                    : 'assets/images/icon_bookmark.svg',
                colorFilter: ColorFilter.mode(
                    titleRowColor,
                    BlendMode.srcIn),
              ),
              onPressed: () {
                if (!widget.recipe.bookmarked) {
                  if (recipeDetail != null) {
                    // TODO: Insert Recipe
                  }
                // ignore: dead_code
                } else {
                  // TODO: Delete Recipe
                }
                Navigator.pop(context);
              },
            ),
            sizedW8,
          ],
        ),
      ),
    );
  }

  Widget description() {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, top: 24.0),
      child: Html(data: recipeDetail?.description ?? ''),
    );
  }
}
