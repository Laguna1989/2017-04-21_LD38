package;

import FileList;
import haxe.Json;
import openfl.Assets;

class CraftManager
{
    private static var _recipes : Array<CraftRecipe>;

    public static function init() : Void
    {
        _recipes = new Array<CraftRecipe>();

        // Read recipes from JSON files
        var list : Array<String> = FileList.getFileList("assets/data/", "recipe.json");
        for(s in list)
        {
            var data:ParseRecipe = Json.parse(Assets.getText(s));

            var r = new CraftRecipe(data.recipe, data.result);
            _recipes.push(r);
        }
    }

    public static function craft(items : Array<Item>) : Item
    {
        // Check item array against all recipes
        if(items.length == 9)
        {
            for(r in _recipes)
            {
                var valid = true;
                for(i in 0...9)
                {
                    if(r.Ingredients[i] != items[i])
                    {
                        valid = false;
                        break;
                    }
                }

                if(valid)
                {
                    return r.Result;
                }
            }
        }

        return null;
    }
}

typedef ParseRecipe =
{
    var recipe : Array<String>;
    var result : String;
}