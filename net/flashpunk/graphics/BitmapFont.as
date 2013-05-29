package net.flashpunk.graphics {
	
	import net.flashpunk.FP;
	
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	public class BitmapFont {
		
		/** @private */ private var _bitmap:BitmapData;
		/** @private */ private var _letters:Vector.<Rectangle> = new Vector.<Rectangle>(256, true);
		
		/** @private */ private var _letterWidth:uint;
		/** @private */ private var _letterHeight:uint;
		
		/** @private */ private var _charCode:uint;
		
		/**
		 * Instantiates the font from the source.
		 * 
		 * @param	source			source bitmap or image
		 * @param	letterWidth		the width of the letters
		 * @param	letterHeight	the height of the letters
		 */
		public function BitmapFont (source:*, letterWidth:uint, letterHeight:uint, charCode:uint = 31) {
			if (source is Class) _bitmap = FP.getBitmap(source);
			else if (source is BitmapData) _bitmap = source;
			
			if (!_bitmap) throw new Error("Invalid font source image.");

			_letterWidth = letterWidth;
			_letterHeight = letterHeight;
			_charCode = charCode;
			
			createFont();
		}
		
		/**
		 * Creates the font by getting all the letters into a list.
		 */
		private function createFont ():void {
			var position:Point = new Point(0, 0);
			var charCode:uint = _charCode;

			for (var y:uint = 0; y < _bitmap.height; y += _letterHeight) {
				for (var x:uint = 0; x < _bitmap.width; x += _letterWidth) {
					_letters[charCode] = new Rectangle(position.x, position.y, _letterWidth, _letterHeight);
					charCode++;
					position.x = x;
				}
				position.y += _letterHeight;
				position.x = 0;
			}
		}
		
		/** @private Returns the font BitmapData. */
		public function get bitmap ():BitmapData { return _bitmap; }
		
		/** @private Returns the letter Rectangle. */
		public function letter (code:uint):Rectangle { return _letters[code]; }
		
		/** @private Returns the width/height of the letters. */
		public function get width ():uint { return _letterWidth; }
		public function get height ():uint { return _letterHeight; }
		
	}

}
