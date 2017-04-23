package;

import haxe.Json;
import openfl.Assets;
import Tool;

class ItemManager
{
    private static var _resources : Array<Item>;
    private static var _tools     : Array<Tool>;

    public static function init()
    {
        _resources = new Array<Item>();

        _tools = new Array<Tool>();
		
		_tools.push(new Fire());
		_tools.push(new Food());
		_tools.push(new Pie());
        _tools.push(new StonePickaxe());
		_tools.push(new Tent());
		_tools.push(new Berry());

        // Read resources from JSON files
        var list : Array<String> = FileList.getFileList("assets/data/", "resource.json");
        for(r in list)
        {
            var data:ParseResouce = Json.parse(Assets.getText(r));

			trace(r);
            _resources.push(new Item(data.name, data.displayName, data.stackSize, data.imageName));
        }
    }

    public static function getItem(itemName : String) : Item
    {
        if(itemName == null) return null;

        var item : Item;
        item = getResource(itemName);
        if(item != null) return item;

        item = cast getTool(itemName);
		//trace("item " + itemName + " found: " + item);
        return  item;
    }

    private static function getResource(resourceName : String) : Item
    {
        if(resourceName == null) return null;
        
        for(r in _resources)
        {
            if(r.Name == resourceName)
            {
                return r;
            }
        }

        return null;
    }

    private static function getTool(toolName : String) : Tool
    {
        for(t in _tools)
        {
            if(t.Name == toolName)
            {
				//trace("tool " + toolName + " found");
                return t;
            }
        }

        return null;
    }
}

typedef ParseResouce =
{
    var name : String;
    var displayName : String;
    var stackSize : Int;
    var imageName : String;
}