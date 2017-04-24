package;

class CraftRecipe
{
    public var Ingredients : Array<Item>;
    public var Result : Item;
    public var Quantity : Int;
	public var level : Int;

    public function new(ingredients : Array<String>, result : String, quantity : Int, l: Null<Int>)
    {
		level = (l == null) ? 0 : l;
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