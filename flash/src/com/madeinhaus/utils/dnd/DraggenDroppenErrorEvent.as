package com.madeinhaus.utils.dnd
{
	import flash.events.Event;
	
	public class DraggenDroppenErrorEvent extends Event
	{
		private static const NAME:String = "DraggenDroppenErrorEvent";
		
		public static const FILE_SIZE_MISMATCH:String = NAME + "FileSizeMismatch";
		
		public function DraggenDroppenErrorEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			super(type, bubbles, cancelable);
		}
		
		public override function clone():Event
		{
			return new DraggenDroppenErrorEvent(type, bubbles, cancelable);
		}
	}
}