package funkin.states.substates;

import funkin.utils.DifficultyUtil;
import funkin.utils.CameraUtil;
import funkin.data.options.OptionsState;
import flixel.FlxG;
import flixel.addons.display.FlxBackdrop;
import funkin.utils.WindowUtil;
import lime.app.Application;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.addons.transition.FlxTransitionableState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.input.keyboard.FlxKey;
import flixel.system.FlxSound;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.FlxCamera;
import flixel.util.FlxStringUtil;
import funkin.backend.MusicBeatSubstate;
import funkin.data.*;
import funkin.states.*;
import funkin.objects.*;

class AreYouSure extends MusicBeatSubstate
{
    var image1:FlxSprite;
var image2:FlxSprite;
var ohyeah:FunkinVideoSprite;
var state:Int = 0;
var ready = true;
var cantDoNothing = false;

	override function create()
	{
	    image1 = new FlxSprite().loadGraphic(Paths.image('awards/areyousure/areyousure'));
    image1.scrollFactor.set();
    image1.screenCenter();
    image1.antialiasing = ClientPrefs.globalAntialiasing;
    image1.alpha = 0;
    add(image1);

    image2 = new FlxSprite().loadGraphic(Paths.image('awards/areyousure/areyousuresure'));
    image2.scrollFactor.set();
    image2.screenCenter();
    image2.antialiasing = ClientPrefs.globalAntialiasing;
    image2.alpha = 0;
    add(image2);

    ohyeah = new FunkinVideoSprite();
    ohyeah.addCallback('onFormat', ()->{
        ohyeah.setGraphicSize(0, FlxG.height * 1.5);
        ohyeah.updateHitbox();
        ohyeah.screenCenter();
    });
    ohyeah.addCallback('onEnd', die);
    ohyeah.load(Paths.video('bozo'));
    add(ohyeah);

    nextState(state);
	   
		super.create();
	}
	
	function die(){

    if(FlxG.save.data.CrunchinSongData != null){
        FlxG.save.data.CrunchinSongData = null;
        Application.current.window.alert('Dumb stupid bitch', 'oopsies!');
    }else
        Application.current.window.alert('dude what are you doing. you dont even have save data. how did you manage to get here if you dont even have save data ??????? ITS CREATED ON THE TITLE SCREEN.', 'oopsies!');
    
    FlxG.save.flush();
    WindowUtil.crashTheFuckingGame();
}

function nextState(stateNumber:Int)
{
    if(ready)
    {
        ready = false;

        switch(stateNumber)
        {
            case 0:
                FlxTween.tween(image1, {alpha: 1}, 0.5, {ease: FlxEase.quadOut, onComplete: function(twn:FlxTween){
                    state = 1;
                    ready = true;
                }});
            case 1:
                FlxG.sound.music.volume = 0.5;
                FlxTween.tween(image2, {alpha: 1}, 0.5, {ease: FlxEase.quadOut, onComplete: function(twn:FlxTween){
                    FlxG.sound.music.volume = 0;
                    state = 2;
                    ready = true;
                }});
            case 2:
                FlxG.sound.music.stop();
                cantDoNothing = true;
                ohyeah.play();
        }
    }
}

function backState(stateNumber:Int)
{
    switch(stateNumber)
    {
        case 1:
            FlxG.sound.music.volume = 1;
            FlxTween.tween(image1, {alpha: 0}, 0.5, {ease: FlxEase.quadOut, onComplete: function(twn:FlxTween){
                close();
            }});
        case 2:
            image1.alpha = 0;
            FlxG.sound.music.volume = 1;
            FlxTween.tween(image2, {alpha: 0}, 0.5, {ease: FlxEase.quadOut, onComplete: function(twn:FlxTween){
                close();
            }});
    }
}

	override function update(elapsed:Float)
	{

		super.update(elapsed);
	 
	    if(!cantDoNothing)
    {
        var spacebar = FlxG.keys.justPressed.SPACE;
        var escape = FlxG.keys.justPressed.ESCAPE;
        if(spacebar)
        {
            nextState(state);
        }

        if(escape)
        {
            backState(state);
        }
    }
    }