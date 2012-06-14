package
{
	import com.madeinhaus.utils.dnd.DraggenDroppen;
	import com.madeinhaus.utils.dnd.DraggenDroppenEvent;

	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFormat;

	public class DraggenDroppenDemo extends Sprite
	{
		private var tf:TextField;
		private var state:String = "idle";
		private var filesLog:String = "";

		private var dd:DraggenDroppen;

		public function DraggenDroppenDemo()
		{
			createUI();

			dd = new DraggenDroppen();
			dd.addEventListener(DraggenDroppenEvent.DRAG_OVER, dragOverHandler);
			dd.addEventListener(DraggenDroppenEvent.DRAG_LEAVE, dragLeaveHandler);
			dd.addEventListener(DraggenDroppenEvent.FILE_START, fileStartHandler);
			dd.addEventListener(DraggenDroppenEvent.FILE_PROGRESS, fileProgressHandler);
			dd.addEventListener(DraggenDroppenEvent.FILE_COMPLETE, fileCompleteHandler);

			updateText();
		}

		private function dragOverHandler(event:DraggenDroppenEvent):void {
			state = "over";
			updateText();
		}

		private function dragLeaveHandler(event:DraggenDroppenEvent):void {
			state = "leave";
			updateText();
		}

		private function fileStartHandler(event:DraggenDroppenEvent):void {
			state = "receiving";
			updateText();
		}

		private function fileProgressHandler(event:DraggenDroppenEvent):void {
			updateText();
		}

		private function fileCompleteHandler(event:DraggenDroppenEvent):void {
			state = "idle";
			filesLog += "\n" + event.file.name + ", " + f(event.file.size + " bytes", "888888") + ": " + f("ok", "00aa00", true);
			updateText();
		}

		private function createUI():void {
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.addEventListener(Event.RESIZE, function(event) { resize(); });

			tf = new TextField();
			tf.defaultTextFormat = new TextFormat("_sans", 13, 0x000000);
			tf.multiline = true;
			tf.wordWrap = false;
			tf.selectable = true;
			addChild(tf);

			resize();
		}

		private function updateText():void {
			var text:String = f("DraggenDroppen", "0000ff", true);
			text += "\n\n" + f("Supported:", "000000", true) + " "
			if(dd.isSupported) {
				text += f("yes", "00aa00", true);
				text += "\n" + f("State:", "000000", true) + " " + state;
				text += "\n\nDrop some files here..\n";
				if(filesLog != "") {
					text += filesLog;
				}
				if(state == "receiving") {
					var progress:String = Math.round(dd.currentFile.progress * 100) + "%";
					text += "\n" + dd.currentFile.name + ": " + f(progress, "000000", true);
				}
			} else {
				text += f("no", "cc0000", true) + "\nSorry. Try Chrome, Firefox or Opera.";
			}
			tf.htmlText = text;
		}

		private function f(text:String, color:String, bold:Boolean = false):String {
			if(bold) { text = "<b>" + text + "</b>"; }
			return "<font color='#" + color + "'>" + text + "</font>"; 
		}

		private function resize():void {
			tf.x = 10;
			tf.y = 10;
			tf.width = stage.stageWidth - 20;
			tf.height = stage.stageHeight - 20;
		}
	}
}