package;

import flixel.FlxState;
import flixel.FlxG;
import flixel.input.keyboard.FlxKey;
import lime.app.Application;
import funkin.data.*;

class Init extends FlxState
{
	public static var muteKeys:Array<FlxKey> = [FlxKey.ZERO];
	public static var volumeDownKeys:Array<FlxKey> = [FlxKey.NUMPADMINUS, FlxKey.MINUS];
	public static var volumeUpKeys:Array<FlxKey> = [FlxKey.NUMPADPLUS, FlxKey.PLUS];

	typedef SongData =
{
    finished:Bool,
    fc:Bool
}

var songMap:StringMap = new StringMap();
var songs = ['crunch', 'milkyway', 'choke-a-lot', 'doubt', 'hope', 'reunion', 'smile', 'order-up', 'last-course', 'soundtest', 'alert', 'legacy', 'rumor', 'threat', 'rattled', 'crunchmix', 'yolo', 'harness', 'ravegirl'];

// porting old save stuff over to modern save format
var songsFC:StringMap;
var songsComplete:StringMap;
	
	override public function create():Void
	{
		if(FlxG.save.data.songsCompleteFNC != null)
        songsComplete = FlxG.save.data.songsCompleteFNC;
    else
        songsComplete = new StringMap();

    if(FlxG.save.data.songsFCFNC != null)
        songsFC = FlxG.save.data.songsFCFNC;
    else
        songsFC = new StringMap();

    for(song in songs){ 
        var FC = songsFC.get(song) == null ? false : songsFC.get(song);
        var FINISHED = songsComplete.get(song) == null ? false : songsComplete.get(song);

        songMap.set(song, {finished: FINISHED, fc: FC});
    }    
    
    if(FlxG.save.data.CrunchinSongData == null)
        FlxG.save.data.CrunchinSongData = songMap;

    trace(FlxG.save.data.CrunchinSongData);
    FlxG.save.flush();
		
		funkin.data.scripts.FunkinIris.InitLogger();

		Paths.clearStoredMemory();
		Paths.clearUnusedMemory();

		Paths.pushGlobalMods();

		funkin.data.WeekData.loadTheFirstEnabledMod();

		FlxG.game.focusLostFramerate = 60;
		FlxG.sound.muteKeys = muteKeys;
		FlxG.sound.volumeDownKeys = volumeDownKeys;
		FlxG.sound.volumeUpKeys = volumeUpKeys;
		FlxG.keys.preventDefaultKeys = [TAB];

		FlxG.mouse.visible = false;

		funkin.backend.PlayerSettings.init();

		FlxG.save.bind('funkin', CoolUtil.getSavePath());

		ClientPrefs.loadPrefs();

		funkin.data.Highscore.load();

		funkin.objects.video.FunkinVideoSprite.init();

		if (FlxG.save.data != null && FlxG.save.data.fullscreen) FlxG.fullscreen = FlxG.save.data.fullscreen;
		if (FlxG.save.data.weekCompleted != null) funkin.states.StoryMenuState.weekCompleted = FlxG.save.data.weekCompleted;

		FlxG.mouse.visible = false;

		// MusicBeatState.transitionInState = funkin.states.transitions.FadeTransition;
		// MusicBeatState.transitionOutState = funkin.states.transitions.FadeTransition;

		#if desktop
		if (!DiscordClient.isInitialized)
		{
			DiscordClient.initialize();
			Application.current.onExit.add((ec) -> DiscordClient.shutdown());
		}
		#end

		super.create();

		FlxG.switchState(new funkin.states.TitleState());
	}
}
