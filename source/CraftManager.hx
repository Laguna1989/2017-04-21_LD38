package;

import FileList;
import haxe.Json;
import openfl.Assets;

class CraftManager
{
    private static var _recipes : Array<CraftRecipe>;
	public static var extended : Bool = false;

    public static function init() : Void
    {
        _recipes = new Array<CraftRecipe>();

        // Read recipes from JSON files
        var list : Array<String> = FileList.getFileList("assets/data/", "recipe.json");
        for(s in list)
        {
            var data:ParseRecipe = Json.parse(Assets.getText(s));
	
			
            var r = new CraftRecipe(data.recipe, data.result, data.quantity, data.level);
            _recipes.push(r);
        }
		extended = false;
    }

    public static function craft(items : Array<Item>) : CraftRecipe
    {
        // Check item array against recipes
        for(r in _recipes)
        {
            var valid = true;
			if (r.level > 0 && !extended) continue;

            for(offset in 0...9)
            {
                valid = true;

                trace("offset " + offset + " too big? " + (9 - offset < r.Ingredients.length));
                if(9 - offset < r.Ingredients.length)
                {
                    valid = false;
                    break;
                }

                for(i in 0...r.Ingredients.length)
                {
                    if(r.Ingredients[i] == null && items[i + offset] == null) continue;

                    if((r.Ingredients[i] == null && items[i + offset] != null)
                    || (r.Ingredients[i] != null && items[i + offset] == null)
                    || r.Ingredients[i].Name != items[i + offset].Name)
                    {
                        valid = false;
                        break;
                    }
                }

                for(i in (r.Ingredients.length)...9)
                {
                    if(items[i + offset] != null)
                    {
                        valid = false;
                        break;
                    }
                }

                if(valid)
                {
                    return r;
                }
            }
        }

        return null;
    }
}

typedef ParseRecipe =
{
    var recipe   : Array<String>;
    var result   : String;
    var quantity : Int;
	var level : Int;
}