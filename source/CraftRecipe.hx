package;

class CraftRecipe
{
    public var Ingredients : Array<Item>;
    public var Result : Item;
    public var Quantity : Int;

    public function new(ingredients : Array<String>, result : String, quantity : Int)
    {
        Ingredients = new Array<Item>();

        for(ingredient in ingredients)
        {
            var item = ItemManager.getItem(ingredient);
            Ingredients.push(item);
        }

        Result = ItemManager.getItem(result);
        Quantity = quantity;
    }
}