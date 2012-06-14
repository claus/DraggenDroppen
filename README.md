# DraggenDroppen

Drag and drop files from the local file system to Flash

## Usage

Flash:

	public function DraggenDroppenDemo()
	{
		dd = new DraggenDroppen();
		dd.addEventListener(DraggenDroppenEvent.DRAG_OVER, dragOverHandler);
		dd.addEventListener(DraggenDroppenEvent.DRAG_LEAVE, dragLeaveHandler);
		dd.addEventListener(DraggenDroppenEvent.FILE_START, fileStartHandler);
		dd.addEventListener(DraggenDroppenEvent.FILE_PROGRESS, fileProgressHandler);
		dd.addEventListener(DraggenDroppenEvent.FILE_COMPLETE, fileCompleteHandler);

		// dd.isSupported (Boolean)
		// Whether or not DraggenDroppen is supported by the browser
	}

	private function dragOverHandler(event:DraggenDroppenEvent):void {
		// User is dragging files:
		// Mouse pointer is over the SWF
	}

	private function dragLeaveHandler(event:DraggenDroppenEvent):void {
		// User is dragging files:
		// Mouse pointer left the SWF
	}

	private function fileStartHandler(event:DraggenDroppenEvent):void {
		// One of the dropped files starts transferring
	}

	private function fileProgressHandler(event:DraggenDroppenEvent):void {
		// One of the dropped files is transferring
	}

	private function fileCompleteHandler(event:DraggenDroppenEvent):void {
		// One of the dropped files completed transferring
	}

HTML:

	<script src="//ajax.googleapis.com/ajax/libs/swfobject/2.2/swfobject.js"></script>	
	<script src="js/DraggenDroppen.js"></script>	
	<script>

		(function() {

			var flashVars = {};
			var flashParams = {
				allowscriptaccess: "always",
				bgcolor: "#FFFFFF",
			};
			var flashAttribs = {
				id: "flashContent",
				name: "flashContent"
			};
			swfobject.embedSWF(
				"flash.swf",
				"flashDiv",
				"500",
				"400",
				"9.0",
				"expressInstall.swf",
				flashVars,
				flashParams,
				flashAttribs,
				function(e) {
					// Initialize DraggenDroppen
					DraggenDroppen.init(e.ref);
				}
			);

		})();

	</script>
	<div id="flashDiv"></div>

## Browser Support

- Chrome 6
- Firefox 3.6
- Opera 11.1
- IE 10

Safari and IE <= 9 are currently not supported due to lack of `FileReader` support.

