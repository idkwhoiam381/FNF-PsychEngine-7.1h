package states;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxBackdrop;

class GalleryShitState extends MusicBeatState
{
  var bg:FlxSprite;
  var coolbackdrop:FlxBackdrop;

  var shit:Array<String> = ['Week', 'Cum'];

  var menuItems:FlxTypedGroup<FlxSprite>;

  override function create()
  {
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

    var tex = Paths.getSparrowAtlas('Some/StoryStuff/items');

    for (i in 0...optionShit.length)
    {
        var menuItem FlxSprite = new FlxSprite(0, 0);
        menuItem.frames = tex;
        menuItem.scale.set(0.5, 0.5);
        menuItem.animation.addByPrefix('idle', optionShit[i] + " idle", 24);
        menuItem.animation.addByPrefix('selected', optionShit[i] + " sel", 24);
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
    }

    super.create();
  }

  override function update(elapsed:Float)
  {
    if (controls.BACK)
        MusicBeatState.switchState(new MainMenuState());
    super.update(elapsed);
  }

  function changeItem(huh:Int = 0, ?sound:Bool = false)
}
