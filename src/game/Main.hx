package game;

import flambe.asset.AssetPack;
import flambe.asset.Manifest;
import flambe.System;
import flambe.display.Sprite;

class Main {
	static function main() {}

	@:expose static function start(width:Int, height:Int):Void {
		System.init();
		var container = new Container(width, height);
		System.root.add(container);
		System.stage.resize.connect(() -> {
			container.setSize(System.stage.width, System.stage.height);
		});
		System.stage.resize.emit();
		var mainManifest = Manifest.fromAssets("main");
		System.loadAssetPack(mainManifest).success.connect(onLoaded).once();
	}

	static function onLoaded(pack:AssetPack):Void {
		System.root.add(new Spinner(pack.getTexture("logo")));

		var inc = 0;
		var props = {name: '${inc}'};

		System.web.addView(js.Lib.require("./src/components/HelloWorld.vue"), {
			onClick: () -> {
				trace("hello from haxe!");
			}
		}, props);

		System.root.get(Sprite).pointerDown.connect((_) -> {
			pack.getSound("silence").play();
			props.name = '${++inc}';
		}).once();
	}
}
