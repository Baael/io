
JSON:
*  https://github.com/CaravaggioSoftwareDev/json-as2


## EXAMPLE

```

import com.GameInterface.DistributedValue;
import com.GameInterface.Game.Character;
import com.GameInterface.UtilsBase;
import wojak.IO;

class Main
{

  public static var io;

  public static function main(_swfRoot:MovieClip):Void
  {
    swfRoot.onLoad = onLoad;
  }

  public static function onLoad():Void
  {
    io = new wojak.IO({ host: 'http://test.tsw:5555' })

    io.join("test_room")
    io.onReceive.Connect(whenDataCame)

    var command = DistributedValue.Create("testing_io");
    command.SetValue(null)
    command.SignalChanged.Connect(onTestCmd)

  }

  public static function onTestCmd(data):Void {
    io.emit({current_game_time: UtilsBase.GetGameTime()})
  }

  public static function whenDataCame(data):Void {
    for(var prop in data){
      UtilsBase.PrintChatText(prop.toString() +": "+data[prop].toString())
    }
  }

}


```