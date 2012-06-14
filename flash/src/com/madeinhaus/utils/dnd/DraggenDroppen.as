package com.madeinhaus.utils.dnd
{
	import flash.events.EventDispatcher;
	import flash.external.ExternalInterface;

	public class DraggenDroppen extends EventDispatcher
	{
		protected var _currentFile:DraggenDroppenFile;
		protected var _isSupported:Boolean;
		
		public function DraggenDroppen()
		{
			super();
			init();
		}

		public function get currentFile():DraggenDroppenFile { return _currentFile; }
		public function get isSupported():Boolean { return _isSupported; }
		
		protected function init():void
		{
			_isSupported = false;
			if(ExternalInterface.available) {
				ExternalInterface.addCallback("DraggenDroppen_capability", capabilityHandler);
				ExternalInterface.addCallback("DraggenDroppen_dragOver", dragOverHandler);
				ExternalInterface.addCallback("DraggenDroppen_dragLeave", dragLeaveHandler);
				ExternalInterface.addCallback("DraggenDroppen_begin", beginHandler);
				ExternalInterface.addCallback("DraggenDroppen_chunk", chunkHandler);
				ExternalInterface.addCallback("DraggenDroppen_end", endHandler);
				ExternalInterface.call("DraggenDroppen.enable");
			}
		}
		
		protected function capabilityHandler(isSupported:Boolean):void
		{
			_isSupported = isSupported;
		}
		
		protected function dragOverHandler():void
		{
			dispatchEvent(new DraggenDroppenEvent(DraggenDroppenEvent.DRAG_OVER));
		}
		
		protected function dragLeaveHandler():void
		{
			dispatchEvent(new DraggenDroppenEvent(DraggenDroppenEvent.DRAG_LEAVE));
		}
		
		private function beginHandler(name:String, type:String, size:uint):void
		{
			_currentFile = new DraggenDroppenFile(name, type, size);
			dispatchEvent(new DraggenDroppenEvent(DraggenDroppenEvent.FILE_START, currentFile));
		}
		
		private function chunkHandler(chunk:String):void
		{
			if(currentFile != null) {
				var chunkArr:Array = chunk.split(",");
				var chunkArrLen:uint = chunkArr.length;
				for(var i:uint = 0; i < chunkArrLen; i++) {
					currentFile.writeByte(parseInt(String(chunkArr[i]), 16));
				}
				dispatchEvent(new DraggenDroppenEvent(DraggenDroppenEvent.FILE_PROGRESS, currentFile));
			}
		}
		
		private function endHandler():void
		{
			if(currentFile != null) {
				if(currentFile.size == currentFile.content.length) {
					dispatchEvent(new DraggenDroppenEvent(DraggenDroppenEvent.FILE_COMPLETE, currentFile));
				} else {
					dispatchEvent(new DraggenDroppenErrorEvent(DraggenDroppenErrorEvent.FILE_SIZE_MISMATCH));
				}
				_currentFile = null;
			}
		}
	}
}
