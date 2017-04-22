package;

import Resource;
import Item;
import ItemManager;

class CraftRecipe
{
    public var Ingredients : Array<Resource>;
    public var Result : Item;

    public function new(ingredients : Array<String>, result : String)
    {
        Ingredients = new Array<Resource>();

        for(ingredient in ingredients)
        {
            Ingredients.push(cast ItemManager.getItem(ingredient));
        }

        Result = ItemManager.getItem(result);
    }
}