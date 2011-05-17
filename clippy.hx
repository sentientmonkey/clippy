import flash.display.MovieClip;
import flash.events.MouseEvent;
import flash.display.SimpleButton;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormat;
import flash.external.ExternalInterface;

class Clippy {
  static var text:String;
  static var func:String;
  static var label:TextField;
  static var button:SimpleButton;
  static var format:TextFormat;

  static function upFunction (e:MouseEvent) {
    if(ExternalInterface.available) {
      ExternalInterface.marshallExceptions = true;
      if(func != '') {
        text = ExternalInterface.call(func);
      }
    }
    flash.system.System.setClipboard(text);
    label.text = "copied!";
    label.setTextFormat(format);
  }

  static function overFunction (e:MouseEvent) {
    label.textColor = 0x666666;
  }
  
  static function outFunction(e:MouseEvent) {
    label.textColor = 0x888888;
    label.text = "copy to clipboard";
    label.setTextFormat(format);
  }

  // Main
  static function main() {
    text = flash.Lib.current.loaderInfo.parameters.text;
    func = flash.Lib.current.loaderInfo.parameters.func;
    
    // label
    
    label = new TextField();
    format = new TextFormat("Arial", 11);
    
    label.text = "copy to clipboard";
    label.setTextFormat(format);
    label.textColor = 0x888888;
    label.selectable = false;
    label.x = 15;
    
    flash.Lib.current.addChild(label);
    
    // button
    button = new SimpleButton();
    button.useHandCursor = true;
    button.upState = flash.Lib.attach("button_up");
    button.overState = flash.Lib.attach("button_over");
    button.downState = flash.Lib.attach("button_down");
    button.hitTestState = flash.Lib.attach("button_down");
    
    label.addEventListener(MouseEvent.MOUSE_UP, upFunction );
    button.addEventListener(MouseEvent.MOUSE_UP, upFunction );
    
    label.addEventListener(MouseEvent.MOUSE_OVER, overFunction);
    button.addEventListener(MouseEvent.MOUSE_OVER, overFunction);

    label.addEventListener(MouseEvent.MOUSE_OUT, outFunction);
    button.addEventListener(MouseEvent.MOUSE_OUT, outFunction);
    
    flash.Lib.current.addChild(button);
  }
}
