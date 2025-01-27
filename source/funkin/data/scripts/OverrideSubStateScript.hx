package funkin.data.scripts;

class OverrideSubStateScript extends FunkinIris
{
	public var customMenu:Bool = false;

	public static function fromFile(file:String, ?name:String, ?additionalVars:Map<String, Any>)
	{
		if (name == null) name = file;

		return new OverrideSubStateScript(File.getContent(file), name, additionalVars);
	}

	public function new(script:String, ?name:String = "Script", ?custom:Bool = true, ?additionalVars:Map<String, Any>)
	{
		super(script, name, additionalVars);

		customMenu = call('customMenu', []);

		trace('is [$name] custom? [$customMenu]');

		set("state", flixel.FlxG.state);
		set("close", FlxG.state.closeSubState);
		set("add", FlxG.state.add);
		set("remove", FlxG.state.remove);
		set("insert", FlxG.state.insert);
		set("members", FlxG.state.members);
	}
}
