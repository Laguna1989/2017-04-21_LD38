package;

import FileList;
import haxe.Json;
import openfl.Assets;
import Tool;

class ItemManager
{
    private static var _resources : Array<Resource>;
    private static var _tools     : Array<Tool>;

    public static function init()
    {
        _resources = new Array<Resource>();

        _tools = new Array<Tool>();
        _tools.push(new StonePickaxe());
		_tools.push(new Tent());

        // Read resources from JSON files
        var list : Array<String> = FileList.getFileList("assets/data/", "resource.json");
        for(r in list)
        {
            var data:ParseResouce = Json.parse(Assets.getText(r));

            _resources.push(new Resource(data.name, data.displayName, data.stackSize, data.imageName));
        }
    }

    public static function getItem(itemName : String) : Item
    {
        if(itemName == null) return null;

        var item : Item;
        item = getResource(itemName);
        if(item != null) return item;

        item = getTool(itemName);
        return item;
    }

    private static function getResource(resourceName : String) : Resource
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