package game;

import flambe.math.Rectangle;
import flambe.display.Graphics;
import flambe.display.Sprite;

class Container extends Sprite {
	public function new(width:Int, height:Int):Void {
		super();
		this._width = width;
		this._height = height;
		this.scissor = new Rectangle(0, 0, this._width, this._height);
	}

	override public function getNaturalWidth():Float {
		return this._width;
	}

	override public function getNaturalHeight():Float {
		return this._height;
	}

	override public function draw(g:Graphics) {
		g.fillRect(0x333333, 0, 0, this._width, this._height);
	}

	public function setSize(containerWidth:Int, containerHeight:Int):Container {
		var imgRatio = (this._height / this._width); // original img ratio
		var containerRatio = (containerHeight / containerWidth); // container ratio

		var finalWidth = 0.0; // the scaled img width
		var finalHeight = 0.0;

		if (containerRatio < imgRatio) {
			finalHeight = containerHeight;
			finalWidth = (containerHeight / imgRatio);
		} else {
			finalWidth = containerWidth;
			finalHeight = (containerWidth * imgRatio);
		}

		var gameScale = finalWidth / this._width;
		var offsetX = (containerWidth - finalWidth) / 2;
		var offsetY = (containerHeight - finalHeight) / 2;

		this.setScale(gameScale);
		this.setXY(offsetX, offsetY);

		return this;
	}

	private var _width:Int;
	private var _height:Int;
}
