package states;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxBackdrop;

class GalleryShitState extends MusicBeatState
{
  var bg:FlxSprite;
  var coolbackdrop:FlxBackdrop;

  var curSelected:Int = 0;

  var shit:Array<String> = ['Week', 'Cum'];
  var diffNames:Array<String> = ['easy','normal','hard'];
  var songs Array<String> = [
	  ['pico', 'philly-nice', 'blammed']
  ];

  var menuItems:FlxTypedGroup<FlxSprite>;

  override function create()
  {
	Paths.clearStoredMemory();
	Paths.clearUnusedMemory();
    bg = new FlxSprite(0.0).loadGraphic(Paths.image("Some/StoryStuff/Bg"));
    bg.antialiasing = FlxG.save.data.antialiasing;
    add(bg);

    coolbackdrop = new FlxBackdrop(0.0).loadGraphic(Paths.image("Some/StoryStuff/FlxBackdroplol"));
    coolbackdrop.velocity.set(50.50);
    coolbackdrop.screenCenter(Y);
	coolbackdrop.alpha = 0.25;
	coolbackdrop.blend = BlendMode.MULTIPLY;
    add(coolbackdrop);

    menuItems = new FlxTypedGroup<FlxSprite>();
    add(menuItems);

	diffName = new FlxText(0, 400, 0, diffNames[0], 32);
	diffName.antialiasing = FlxG.save.data.antialiasing;
	diffName.font = Paths.font("vcr.ttf");
	add(diffName);

    var tex = Paths.getSparrowAtlas('Some/StoryStuff/items');

    for (i in 0...shit.length)
    {
        var menuItem FlxSprite = new FlxSprite(0, 0);
        menuItem.frames = tex;
        menuItem.animation.addByPrefix('idle', shit[i] + " idle", 24);
        menuItem.animation.addByPrefix('selected', shit[i] + " sel", 24);
        menuItem.animation.play('idle');
        menuItem.ID = i;
        menuItem.updateHitbox();

        switch (i)
        {
            case 0:
                menuItem.setPosition(130, 96);
            case 1:
                menuItem.setPosition(130, 174);
        }

        menuItem.scrollFactor.set(0, 0.25);
        menuItem.antialiasing = FlxG.save.data.antialiasing;
        bg.updateHitbox();
        menuItems.add(menuItem);
		changeItem();
		changeDiff();
    }

    super.create();
	Paths.clearUnusedMemory();
  }

  override function update(elapsed:Float)
  {
    if (controls.BACK)
        MusicBeatState.switchState(new MainMenuState());

	if (controls.UP_P)
		changeItem(-1);
	if (controls.DOWN_P)
		changeItem(1);
	if (controls.LEFT_P)
		changeDiff(-1);
	if (controls.RIGHT_P)
		changeDiff(1);
	if (controls.ACCEPT && shit[curSelected] = 'Cum')
	    doShit();

    super.update(elapsed);
  }

	function changeDiff(huh:Int = 0)
	{
		diffi += huh;

		if (diffi < 0)
			diffi = diffNames.length - 1;
		if (diffi > diffNames.length - 1)
			diffi = 0;
		diffName.text = diffNames[diffi];
		//Debug.logTrace(diffi);
	}

	function doShit()
{
	PlayState.storyPlaylist = songs[curSelected];
	PlayState.isStoryMode = true;
	PlayState.songMultiplier = 1;

	PlayState.isSM = false;
	var diffic = "";

	switch (diffi)
	{
    	case 1:
        	diffic = "-hard";
	}

	Debug.logTrace("loadIn" + diffic);

	PlayState.storyDifficulty = diffi;
	PlayState.SONG = Song.conversionChecks(Song.loadFromJson(PlayState.storyPlaylist[0], diffic));
	PlayState.storyWeek = curSelected;
	new FlxTimer().start(1, function(tmr:FlxTimer)
	{
    	LoadingState.loadAndSwitchState(new PlayState(), true);
	});
}

  function changeItem(huh:Int = 0)
{
    curSelected += huh;

    if (curSelected >= menuItems.length)
        curSelected = 0;
    if (curSelected < 0)
        curSelected = menuItems.length - 1;

    menuItems.forEach(function(spr:FlxSprite)
    {
        spr.animation.play('idle');
        spr.updateHitbox();

        if (spr.ID == curSelected)
        {
            spr.animation.play('selected');
            var add:Float = 0;
            if (menuItems.length > 4)
            {
                add = menuItems.length * 8;
            }
            spr.centerOffsets();
        }
    });
}
