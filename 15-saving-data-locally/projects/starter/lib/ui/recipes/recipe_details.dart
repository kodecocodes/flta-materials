import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:recipes/providers.dart';

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
  Widget build(BuildContext context) {
    final maxHeight = MediaQuery.of(context).size.height;
    return FutureBuilder<Response<Result<Recipe>>>(
      future:
          ref.read(serviceProvider).queryRecipe(widget.recipe.id.toString()),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          readRecipe(snapshot);
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
                              sizedW16,
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
        } else {
          return Container();
        }
      },
    );
  }

  void readRecipe(AsyncSnapshot<Response<Result<Recipe>>> snapshot) {
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
          height: 200,
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
              placeholder: (context, url) =>
                  const CircularProgressIndicator(),
              height: 200,
              // width: size.width,
            ),
          ),
        ),
      ],
    );
  }

  Widget titleRow() {
    final repository = ref.read(repositoryProvider);
    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          Expanded(
            child: AutoSizeText(
              widget.recipe.label ?? '',
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: const TextStyle(
                fontSize: 24,
                fontFamily: 'Roboto',
              ),
            ),
          ),
          IconButton(
            icon: SvgPicture.asset(
              'assets/images/icon_bookmark.svg',
            ),
            onPressed: () {
              if (recipeDetail != null) {
                repository.insertRecipe(recipeDetail!);
              }
              Navigator.pop(context);
            },
          ),
          sizedW8,
        ],
      ),
    );
  }

  Widget description() {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: Html(data: recipeDetail?.description ?? ''),
    );
  }
}
