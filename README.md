
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
    io.onReceive.Connect(ioDataReceived)

    var command = DistributedValue.Create("testing_io");
    command.SetValue(1)
    command.SignalChanged.Connect(testCommandCallback)

  }

  public static function testCommandCallback(data):Void {
    io.emit({current_game_time: UtilsBase.GetGameTime()})
  }

  public static function ioDataReceived(data):Void {
    for(var prop in data){
      UtilsBase.PrintChatText(prop.toString() +": "+data[prop].toString())
    }
  }

}


```


```

/setoption testing_io !testing_io

```