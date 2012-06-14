package com.madeinhaus.utils.dnd
{
	import flash.utils.ByteArray;

	public class DraggenDroppenFile
	{
		protected var _name:String;
		protected var _type:String;
		protected var _size:uint;

		protected var _content:ByteArray;
		
		public function DraggenDroppenFile(name:String, type:String, size:uint)
		{
			_name = name;
			_type = type;
			_size = size;
			
			_content = new ByteArray();
		}

		public function get name():String { return _name; }
		public function get type():String { return _type; }
		public function get size():uint { return _size; }
		public function get content():ByteArray { return _content; }

		public function get progress():Number
		{
			return _content.length / size;
		}
		
		internal function writeByte(value:uint):void
		{
			_content.writeByte(value);
		}
	}
}