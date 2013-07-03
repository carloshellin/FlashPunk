package net.flashpunk.graphics {
	
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	/**
	 * Creates text from an image with letter sprites. Assumes that the source 
	 * image has all the letters side by side in tiles of the defined size and 
	 * in the order of the letters array.
	 */
	
	public class BitmapText extends Image {
		
		// Text bitmap
		/** @private */ private var _textBitmap:BitmapData;
		
		// the font
		/** @private */ private var _font:BitmapFont;
		
		// Properties
		/** @private */ private var _rect:Rectangle;
		
		// Text
		/** @private */ private var _string:String;
		/** @private */ private var _align:String;
		
		// Lines
		/** @private */ private var _lineString:Array;
		/** @private */ private var _lineCount:uint;
		/** @private */ private var _lineWidth:Array;
		/** @private */ private var _lineGap:uint;
		
		// Letters
		/** @private */ private var _letterCount:uint;
		/** @private */ private var _letterGap:int;
		
		/**
		 * Constructor.
		 * 
		 * @param	source			the source image
		 * @param	string			the text string to display
		 * @param	align			the text alignment 'left', 'center', 'right' (default is 'left')
		 * @param	letterGap		the gap between letters in pixels (default is 0)
		 * @param	lineGap			the gap between lines in pixels (default is 0)
		 */
		public function BitmapText (font:BitmapFont, string:String, align:String = 'left', letterGap:int = 0, lineGap:uint = 0) {
			_rect = new Rectangle();
			_font = font;
			_string = string;
			_align = align.toLowerCase();
			_lineGap = lineGap;
			_letterGap = letterGap;
			
			createText();
			
			_source = new BitmapData(_rect.width, _rect.height, true, 0);
			super(_source);
			
			updateBuffer();
		}
		
		/** @private Updates the drawing buffer. */
		override public function updateBuffer(clearBefore:Boolean = false):void {
			_source.fillRect(_sourceRect, 0);
			_source.draw(_textBitmap);
			
			super.updateBuffer();
		}
		
		/**
		 * Calculates the BitmapData size.
		 */
		private function calcRect ():void {
			_rect.width = 0;
			_rect.height = 0;
			
			_string = String(_string);
			_letterCount = _string.length;
			
			_lineString = _string.split("\n");
			_lineCount = _lineString.length;
			_lineWidth = new Array(_lineCount);
			
			// iterate lines
			for (var i:uint = 0; i < _lineCount; i++) {
				_lineWidth[i] = 0;
				// iterate line letters
				for (var j:uint = 0; j < _lineString[i].length; j++) {
					// check if letter exists
					if (_font.letter(_lineString[i].charCodeAt(j)) != null) {
						// add letter width to line width
						_lineWidth[i] += _font.width;
						// add letter gap
						if (j + 1 < _lineString[i].length) _lineWidth[i] += _letterGap;
					}
				}
				// set widest line
				if (_lineWidth[i] > _rect.width) _rect.width = _lineWidth[i];
				// add line height to total height
				_rect.height += _font.height;
				// add line gap
				if (i + 1 < _lineCount) _rect.height += _lineGap;
			}
			
			if (_rect.width == 0) _rect.width = 1;
			if (_rect.height == 0) _rect.height = 1;

			_textBitmap = new BitmapData(_rect.width, _rect.height, true, 0x00000000);

			_source = new BitmapData(_rect.width, _rect.height, true, 0);
			_sourceRect = _source.rect;
			
			_buffer = new BitmapData(_sourceRect.width, _sourceRect.height, true, 0);
			_bufferRect = _buffer.rect;
		}
		
		/**
		 * Creates the text BitmapData.
		 */
		private function createText ():void {
			calcRect();
			
			var offset:Point = new Point(0, 0);
			var char:Rectangle = new Rectangle();
			
			// iterate lines again
			for (var i:uint = 0; i < _lineCount; i++) {
				// set the horizontal offset
				if (_align == 'left') offset.x = 0;
				else if (_align == 'center') offset.x = (_rect.width - _lineWidth[i]) * 0.5;
				else if (_align == 'right') offset.x = _rect.width - _lineWidth[i];
				// iterate the line letters
				for (var j:uint = 0; j < _lineString[i].length; j++) {
					// get the letter position
					char = _font.letter(_lineString[i].charCodeAt(j));
					// check if letter exists
					if (char == null) continue;
					// render letter
					_textBitmap.copyPixels(_font.bitmap, char, offset, null, null, true);
					// add letter width to offset
					offset.x += char.width; 
					// add letter gap
					if (j + 1 < _lineString[i].length) offset.x += _letterGap;
				}
				// add line height
				offset.y += char.height;
				// add line gap
				if (i + 1 < _lineCount) offset.y += _lineGap;
			}
			
			updateBuffer();
		}
		
		/** get/set align. */
		public function get align ():String { return _align; }
		public function set align (align:String):void {
			_align = align.toLowerCase();
			createText();
		}
		
		/** get/set text. */
		public function get text ():String { return _string; }
		public function set text (string:String):void {
			_string = string;
			createText();
		}
		
	}

}
