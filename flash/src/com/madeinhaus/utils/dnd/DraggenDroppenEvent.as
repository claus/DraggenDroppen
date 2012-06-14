package com.madeinhaus.utils.dnd
{
	import flash.events.Event;
	
	public class DraggenDroppenEvent extends Event
	{
		private static const NAME:String = "DraggenDroppenEvent";
		
		public static const DRAG_OVER:String = NAME + "DragOver";
		public static const DRAG_LEAVE:String = NAME + "DragLeave";
		
		public static const FILE_START:String = NAME + "FileStart";
		public static const FILE_PROGRESS:String = NAME + "FileProgress";
		public static const FILE_COMPLETE:String = NAME + "FileComplete";
		
		public var file:DraggenDroppenFile;
		
		public function DraggenDroppenEvent(type:String, file:DraggenDroppenFile = null, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			super(type, bubbles, cancelable);
			this.file = file;
		}
		
		public override function clone():Event
		{
			return new DraggenDroppenEvent(type, file, bubbles, cancelable);
		}
	}
}