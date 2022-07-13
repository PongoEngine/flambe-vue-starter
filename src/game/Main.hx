package game;

import flambe.web.WebView;
import flambe.asset.AssetPack;
import flambe.asset.Manifest;
import flambe.System;
import flambe.display.Sprite;

class Main {
	static function main() {}

	public static var vueSplash = js.Lib.require("./src/components/Splash.vue");
	public static var vueHelloWorld = js.Lib.require("./src/components/HelloWorld.vue");

	@:expose static function start(width:Int, height:Int):Void {
		System.init();
		var mainManifest = Manifest.fromAssets("main");
		System.loadAssetPack(mainManifest).success.connect(onLoaded.bind(width, height)).once();
	}

	static function onLoaded(width:Int, height:Int, pack:AssetPack):Void {
		var container = new Container(width, height);
		System.root.add(container);
		System.stage.resize.connect(() -> {
			container.setSize(System.stage.width, System.stage.height);
		});
		System.stage.resize.emit();
		System.root.add(new Spinner(pack.getTexture("logo")));

		var inc = 0;
		var props = {name: '${inc}'};

		var splash:WebView = null;
		splash = System.web.addView(vueSplash, {
			onClick: () -> {
				pack.getSound("silence").play();
				splash.dispose();
				System.web.addView(vueHelloWorld, {
					onClick: () -> {
						trace("hello from haxe!");
					}
				}, props);
			}
		}, {width: width, height: height});

		System.root.get(Sprite).pointerDown.connect((_) -> {
			props.name = '${++inc}';
		});
	}
}
