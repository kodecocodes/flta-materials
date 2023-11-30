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
    } else {
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
    final repository = ref.read(repositoryProvider.notifier);
    final deviceWidth = MediaQuery.of(context).size.shortestSide;
    final isHandset = 300 < deviceWidth && deviceWidth < 600;
    final horizontalPadding = isHandset ? 0.0 : deviceWidth / 2;

    return SizedBox(
      height: 150,
      child: Stack(
        children: [
          Positioned.fill(
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
          Positioned.fill(
            left: horizontalPadding,
            right: horizontalPadding,
            child: Hero(
              tag: 'recipe-${widget.recipe.id}',
              child: CachedNetworkImage(
                imageUrl: widget.recipe.image ?? '',
                fit: BoxFit.cover,
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
              ),
            ),
          ),
          Positioned(
            top: 8,
            left: 16,
            child: CircleAvatar(
              backgroundColor: Colors.black54,
              child: IconButton(
                splashColor: Colors.white,
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ),
          Positioned(
            top: 8,
            right: 16,
            child: CircleAvatar(
              backgroundColor: Colors.black54,
              child: IconButton(
                icon: SvgPicture.asset(
                  widget.recipe.bookmarked
                      ? 'assets/images/icon_bookmarks.svg'
                      : 'assets/images/icon_bookmark.svg',
                  colorFilter:
                      const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                ),
                onPressed: () {
                  if (!widget.recipe.bookmarked) {
                    if (recipeDetail != null) {
                      repository.insertRecipe(recipeDetail!).then((_) {
                        ScaffoldMessenger.of(context)
                          ..clearSnackBars()
                          ..showSnackBar(
                            SnackBar(
                              content: Text(
                                'You\'ve bookmarked the recipe: '
                                '${widget.recipe.label ?? ""}.',
                              ),
                            ),
                          );
                      });
                    }
                  } else {
                    repository.deleteRecipe(recipeDetail!).then((_) {
                      ScaffoldMessenger.of(context)
                        ..clearSnackBars()
                        ..showSnackBar(
                          SnackBar(
                            content: Text(
                              'You\'ve removed '
                              '${widget.recipe.label ?? ""}'
                              ' from your bookmarked recipes.',
                            ),
                          ),
                        );
                    });
                  }
                  Navigator.pop(context);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget titleRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
      child: Text(
        widget.recipe.label ?? '',
        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
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
