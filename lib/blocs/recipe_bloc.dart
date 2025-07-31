import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/recipe.dart';

abstract class RecipeState {}

class RecipesLoading extends RecipeState {}

class RecipesLoaded extends RecipeState {
  final List<Recipe> recipes;
  RecipesLoaded(this.recipes);
}

class RecipeAdded extends RecipeState {}

class RecipeUpdated extends RecipeState {}

class RecipeError extends RecipeState {
  final String message;
  RecipeError(this.message);
}

abstract class RecipeEvent {}

class LoadRecipes extends RecipeEvent {}

class AddRecipe extends RecipeEvent {
  final Recipe recipe;
  AddRecipe(this.recipe);
}

class UpdateRecipe extends RecipeEvent {
  final Recipe recipe;
  UpdateRecipe(this.recipe);
}

class DeleteRecipe extends RecipeEvent {
  final String id;
  DeleteRecipe(this.id);
}

class UpdateRecipes extends RecipeEvent {
  final List<Recipe> recipes;
  UpdateRecipes(this.recipes);
}

class RecipeBloc extends Bloc<RecipeEvent, RecipeState> {
  RecipeBloc() : super(RecipesLoading()) {
    on<LoadRecipes>((event, emit) async {
      await Future.delayed(const Duration(milliseconds: 500));
      emit(RecipesLoaded(_initialRecipes));
    });

    on<AddRecipe>((event, emit) {
      final currentState = state;
      if (currentState is RecipesLoaded) {
        final updatedRecipes = List<Recipe>.from(currentState.recipes)
          ..add(event.recipe);
        emit(RecipesLoaded(updatedRecipes));
      }
    });

    on<UpdateRecipe>((event, emit) {
      final currentState = state;
      if (currentState is RecipesLoaded) {
        final updatedRecipes = currentState.recipes.map((recipe) {
          return recipe.id == event.recipe.id ? event.recipe : recipe;
        }).toList();
        emit(RecipesLoaded(updatedRecipes));
      }
    });

    on<DeleteRecipe>((event, emit) {
      final currentState = state;
      if (currentState is RecipesLoaded) {
        final updatedRecipes = currentState.recipes
            .where((recipe) => recipe.id != event.id)
            .toList();
        emit(RecipesLoaded(updatedRecipes));
      }
    });

    on<UpdateRecipes>((event, emit) {
      emit(RecipesLoaded(event.recipes));
    });
  }

  final List<Recipe> _initialRecipes = [
    Recipe(
      id: '1',
      title: 'Паста Карбонара',
      description: 'Классическая итальянская паста с яйцом, беконом и сыром',
      imagePath: null,
    ),
    Recipe(
      id: '2',
      title: 'Оливье',
      description: 'Традиционный русский салат с колбасой и овощами',
      imagePath: null,
    ),
    Recipe(
      id: '3',
      title: 'Тирамису',
      description: 'Итальянский десерт с кофе и сыром маскарпоне',
      imagePath: null,
    ),
    Recipe(
      id: '4',
      title: 'Борщ',
      description: 'Украинский суп со свеклой и мясом',
      imagePath: null,
    ),
    Recipe(
      id: '5',
      title: 'Панкейки',
      description: 'Американские толстые блинчики с кленовым сиропом',
      imagePath: null,
    ),
  ];
}