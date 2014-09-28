import com.GameInterface.Browser.Browser;
import com.GameInterface.UtilsBase;
import com.Utils.Signal;
import com.GameInterface.Game.Character;
import JSON;

class wojak.IO
{
    public  var config:Object = {};
    private var browser:Browser;
    private var room:String;
    private var connected:Boolean = false;
    public  var onReceive:Signal = new Signal();

    public function IO(_config) {
          for (var prop in _config) this.config[prop] = _config[prop]
          this.config.sender = Character.GetClientCharID().toString();
          connect()
    }

    public function connect() {
          if (!this.config.host) return;
          var mode = _global.Enums.WebBrowserStates.e_BrowserMode_Facebook
          browser = new Browser(mode, 100, 100);
          browser.SignalStartLoadingURL.Connect(this.onData, this);
          browser.OpenURL(config.host + "/");
    }


    public function join(room) {
          this.config.room = room;
          open("join", {room: this.config.room});
    }

    public function leave() {
          open("leave", {room: this.config.room });
    }

    public function emit(obj) {
          open("send", {room: this.config.room, value: obj});
    }

    private function open(cmd, obj) {
          obj.sender = this.config.sender;
          var __ts = UtilsBase.GetGameTime();
          var url = config.host + "#"+cmd+"/"+__ts+"?" + JSON.stringify(Object(obj));
          browser.OpenURL(url);
    }

    private function onData(data) {
          if (data.indexOf("rcv?") == -1) return;
          this.connected = true;
          data = data.split("rcv?").pop()
          this.onReceive.Emit(JSON.parse(data))
    }


}