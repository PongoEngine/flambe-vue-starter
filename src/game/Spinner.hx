package game;

import flambe.display.ImageSprite;
import flambe.display.Texture;
import flambe.display.Sprite;
import flambe.Entity;
import flambe.Component;

class Spinner extends Component {
	public function new(logo :Texture):Void {
		this._root = new Entity();
		var spr = new ImageSprite(logo);
        spr.centerAnchor();
        spr.setXY(200, 200);
		this._root.add(spr);
	}

	override public function onAdded():Void {
		this.owner.addChild(this._root);
	}

	override public function onRemoved():Void {
		this.owner.removeChild(this._root);
	}

    override function onUpdate(dt:Float) {
        this._root.get(Sprite).rotation._ += dt * 50;
    }

	private var _root:Entity;
}
