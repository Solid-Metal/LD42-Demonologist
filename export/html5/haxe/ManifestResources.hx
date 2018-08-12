package;


import lime.app.Config;
import lime.utils.AssetLibrary;
import lime.utils.AssetManifest;
import lime.utils.Assets;

#if sys
import sys.FileSystem;
#end

@:access(lime.utils.Assets)


@:keep @:dox(hide) class ManifestResources {
	
	
	public static var preloadLibraries:Array<AssetLibrary>;
	public static var preloadLibraryNames:Array<String>;
	
	
	public static function init (config:Config):Void {
		
		preloadLibraries = new Array ();
		preloadLibraryNames = new Array ();
		
		var rootPath = null;
		
		if (config != null && Reflect.hasField (config, "rootPath")) {
			
			rootPath = Reflect.field (config, "rootPath");
			
		}
		
		if (rootPath == null) {
			
			#if (ios || tvos || emscripten)
			rootPath = "assets/";
			#elseif (sys && windows && !cs)
			rootPath = FileSystem.absolutePath (haxe.io.Path.directory (#if (haxe_ver >= 3.3) Sys.programPath () #else Sys.executablePath () #end)) + "/";
			#else
			rootPath = "";
			#end
			
		}
		
		Assets.defaultRootPath = rootPath;
		
		#if (openfl && !flash && !display)
		openfl.text.Font.registerFont (__ASSET__OPENFL__assets_font_bitwonder_ttf);
		openfl.text.Font.registerFont (__ASSET__OPENFL__assets_font_monsterhunterwarprotal_ttf);
		openfl.text.Font.registerFont (__ASSET__OPENFL__assets_font_pressostarto_ttf);
		openfl.text.Font.registerFont (__ASSET__OPENFL__assets_font_runescape_uf_ttf);
		openfl.text.Font.registerFont (__ASSET__OPENFL__assets_font_superstarorig_memesbruh03_ttf);
		openfl.text.Font.registerFont (__ASSET__OPENFL__assets_font_upheavtt_ttf);
		openfl.text.Font.registerFont (__ASSET__OPENFL__flixel_fonts_nokiafc22_ttf);
		openfl.text.Font.registerFont (__ASSET__OPENFL__flixel_fonts_monsterrat_ttf);
		
		#end
		
		var data, manifest, library;
		
		data = '{"name":null,"assets":"aoy4:pathy34:assets%2Fdata%2Fdata-goes-here.txty4:sizezy4:typey4:TEXTy2:idR1y7:preloadtgoR2i14328R3y4:FONTy9:classNamey34:__ASSET__assets_font_bitwonder_ttfR5y29:assets%2Ffont%2Fbitwonder.TTFR6tgoR2i89944R3R7R8y47:__ASSET__assets_font_monsterhunterwarprotal_ttfR5y42:assets%2Ffont%2Fmonsterhunterwarprotal.ttfR6tgoR2i82480R3R7R8y37:__ASSET__assets_font_pressostarto_ttfR5y32:assets%2Ffont%2Fpressostarto.ttfR6tgoR2i14248R3R7R8y37:__ASSET__assets_font_runescape_uf_ttfR5y32:assets%2Ffont%2Frunescape_uf.ttfR6tgoR2i19296R3R7R8y50:__ASSET__assets_font_superstarorig_memesbruh03_ttfR5y45:assets%2Ffont%2Fsuperstarorig_memesbruh03.ttfR6tgoR2i41836R3R7R8y33:__ASSET__assets_font_upheavtt_ttfR5y28:assets%2Ffont%2Fupheavtt.ttfR6tgoR0y33:assets%2Fimages%2FChar%2Fchar.pngR2i441R3y5:IMAGER5R21R6tgoR0y37:assets%2Fimages%2FChar%2Fchar_api.pngR2i202R3R22R5R23R6tgoR0y34:assets%2Fimages%2FChar%2Fenemy.pngR2i865R3R22R5R24R6tgoR0y36:assets%2Fimages%2FChar%2Fenemy_b.pngR2i457R3R22R5R25R6tgoR0y37:assets%2Fimages%2FEnvi%2FfireIcon.pngR2i266R3R22R5R26R6tgoR0y34:assets%2Fimages%2FEnvi%2Ftiles.pngR2i836R3R22R5R27R6tgoR0y45:assets%2Fimages%2FEnvi%2Ftotem_2%20_water.pngR2i2130R3R22R5R28R6tgoR0y36:assets%2Fimages%2FEnvi%2Ftotem_2.pngR2i2130R3R22R5R29R6tgoR0y36:assets%2Fimages%2Fimages-go-here.txtR2zR3R4R5R30R6tgoR0y35:assets%2Fimages%2FMenuUI%2Fback.pngR2i290R3R22R5R31R6tgoR0y41:assets%2Fimages%2FMenuUI%2Fbackground.jpgR2i5533R3R22R5R32R6tgoR0y39:assets%2Fimages%2FMenuUI%2FbookPage.pngR2i4931R3R22R5R33R6tgoR0y36:assets%2Fimages%2FMenuUI%2Fclose.pngR2i264R3R22R5R34R6tgoR0y39:assets%2Fimages%2FMenuUI%2FguideBut.pngR2i969R3R22R5R35R6tgoR0y40:assets%2Fimages%2FMenuUI%2FheadStaff.pngR2i879R3R22R5R36R6tgoR0y38:assets%2Fimages%2FMenuUI%2FhomeBut.pngR2i889R3R22R5R37R6tgoR0y40:assets%2Fimages%2FMenuUI%2Fleaf_fall.pngR2i837R3R22R5R38R6tgoR0y35:assets%2Fimages%2FMenuUI%2Fmenu.pngR2i41007R3R22R5R39R6tgoR0y40:assets%2Fimages%2FMenuUI%2Fmenu_Bacl.jpgR2i27212R3R22R5R40R6tgoR0y35:assets%2Fimages%2FMenuUI%2Fnext.pngR2i241R3R22R5R41R6tgoR0y38:assets%2Fimages%2FMenuUI%2FplayBut.pngR2i1166R3R22R5R42R6tgoR0y40:assets%2Fimages%2FMenuUI%2FreplayBut.pngR2i949R3R22R5R43R6tgoR0y36:assets%2Fimages%2FMenuUI%2Ftitle.pngR2i6152R3R22R5R44R6tgoR0y41:assets%2Fimages%2FMenuUI%2FtwitterBut.pngR2i813R3R22R5R45R6tgoR0y33:assets%2Fimages%2FProj%2Ffire.pngR2i189R3R22R5R46R6tgoR0y35:assets%2Fimages%2FProj%2Fplasma.pngR2i659R3R22R5R47R6tgoR0y39:assets%2Fimages%2FProj%2Fwater_ball.pngR2i255R3R22R5R48R6tgoR0y33:assets%2Fimages%2FUI%2Fsprint.pngR2i271R3R22R5R49R6tgoR0y42:assets%2Fimages%2FUI%2Fsprint_cooldown.pngR2i350R3R22R5R50R6tgoR0y36:assets%2Fimages%2FUI%2FtextBlock.pngR2i540R3R22R5R51R6tgoR2i29982R3y5:SOUNDR5y30:assets%2Fmusic%2FExplosion.wavy9:pathGroupaR53hR6tgoR2i55944R3R52R5y31:assets%2Fmusic%2Fexplosion2.wavR54aR55hR6tgoR2i129604R3R52R5y29:assets%2Fmusic%2Fgameover.wavR54aR56hR6tgoR2i13632R3R52R5y24:assets%2Fmusic%2Fhit.wavR54aR57hR6tgoR0y36:assets%2Fmusic%2Fmusic-goes-here.txtR2zR3R4R5R58R6tgoR2i12482R3R52R5y27:assets%2Fmusic%2Fpickup.wavR54aR59hR6tgoR2i10188R3R52R5y27:assets%2Fmusic%2Fselect.wavR54aR60hR6tgoR2i29898R3R52R5y26:assets%2Fmusic%2Fshoot.wavR54aR61hR6tgoR2i150018R3R52R5y33:assets%2Fmusic%2FstandonTotem.wavR54aR62hR6tgoR2i10188R3R52R5y25:assets%2Fmusic%2Ftalk.wavR54aR63hR6tgoR2i204630R3R52R5y35:assets%2Fmusic%2Ftotemdissapear.wavR54aR64hR6tgoR0y36:assets%2Fsounds%2Fsounds-go-here.txtR2zR3R4R5R65R6tgoR2i2114R3y5:MUSICR5y26:flixel%2Fsounds%2Fbeep.mp3R54aR67y26:flixel%2Fsounds%2Fbeep.ogghR6tgoR2i39706R3R66R5y28:flixel%2Fsounds%2Fflixel.mp3R54aR69y28:flixel%2Fsounds%2Fflixel.ogghR6tgoR2i5794R3R52R5R68R54aR67R68hgoR2i33629R3R52R5R70R54aR69R70hgoR2i15744R3R7R8y35:__ASSET__flixel_fonts_nokiafc22_ttfR5y30:flixel%2Ffonts%2Fnokiafc22.ttfR6tgoR2i29724R3R7R8y36:__ASSET__flixel_fonts_monsterrat_ttfR5y31:flixel%2Ffonts%2Fmonsterrat.ttfR6tgoR0y33:flixel%2Fimages%2Fui%2Fbutton.pngR2i519R3R22R5R75R6tgoR0y36:flixel%2Fimages%2Flogo%2Fdefault.pngR2i3280R3R22R5R76R6tgh","rootPath":null,"version":2,"libraryArgs":[],"libraryType":null}';
		manifest = AssetManifest.parse (data, rootPath);
		library = AssetLibrary.fromManifest (manifest);
		Assets.registerLibrary ("default", library);
		
		
		library = Assets.getLibrary ("default");
		if (library != null) preloadLibraries.push (library);
		else preloadLibraryNames.push ("default");
		
		
	}
	
	
}


#if !display
#if flash

@:keep @:bind #if display private #end class __ASSET__assets_data_data_goes_here_txt extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_font_bitwonder_ttf extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_font_monsterhunterwarprotal_ttf extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_font_pressostarto_ttf extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_font_runescape_uf_ttf extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_font_superstarorig_memesbruh03_ttf extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_font_upheavtt_ttf extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_images_char_char_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_char_char_api_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_char_enemy_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_char_enemy_b_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_envi_fireicon_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_envi_tiles_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_envi_totem_2__water_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_envi_totem_2_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_images_go_here_txt extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_images_menuui_back_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_menuui_background_jpg extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_menuui_bookpage_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_menuui_close_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_menuui_guidebut_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_menuui_headstaff_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_menuui_homebut_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_menuui_leaf_fall_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_menuui_menu_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_menuui_menu_bacl_jpg extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_menuui_next_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_menuui_playbut_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_menuui_replaybut_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_menuui_title_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_menuui_twitterbut_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_proj_fire_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_proj_plasma_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_proj_water_ball_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_ui_sprint_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_ui_sprint_cooldown_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_ui_textblock_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_music_explosion_wav extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_music_explosion2_wav extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_music_gameover_wav extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_music_hit_wav extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_music_music_goes_here_txt extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_music_pickup_wav extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_music_select_wav extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_music_shoot_wav extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_music_standontotem_wav extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_music_talk_wav extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_music_totemdissapear_wav extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_sounds_sounds_go_here_txt extends null { }
@:keep @:bind #if display private #end class __ASSET__flixel_sounds_beep_mp3 extends null { }
@:keep @:bind #if display private #end class __ASSET__flixel_sounds_flixel_mp3 extends null { }
@:keep @:bind #if display private #end class __ASSET__flixel_sounds_beep_ogg extends null { }
@:keep @:bind #if display private #end class __ASSET__flixel_sounds_flixel_ogg extends null { }
@:keep @:bind #if display private #end class __ASSET__flixel_fonts_nokiafc22_ttf extends null { }
@:keep @:bind #if display private #end class __ASSET__flixel_fonts_monsterrat_ttf extends null { }
@:keep @:bind #if display private #end class __ASSET__flixel_images_ui_button_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__flixel_images_logo_default_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__manifest_default_json extends null { }


#elseif (desktop || cpp)

@:keep @:file("assets/data/data-goes-here.txt") #if display private #end class __ASSET__assets_data_data_goes_here_txt extends haxe.io.Bytes {}
@:keep @:font("export/html5/obj/webfont/bitwonder.TTF") #if display private #end class __ASSET__assets_font_bitwonder_ttf extends lime.text.Font {}
@:keep @:font("export/html5/obj/webfont/monsterhunterwarprotal.ttf") #if display private #end class __ASSET__assets_font_monsterhunterwarprotal_ttf extends lime.text.Font {}
@:keep @:font("export/html5/obj/webfont/pressostarto.ttf") #if display private #end class __ASSET__assets_font_pressostarto_ttf extends lime.text.Font {}
@:keep @:font("export/html5/obj/webfont/runescape_uf.ttf") #if display private #end class __ASSET__assets_font_runescape_uf_ttf extends lime.text.Font {}
@:keep @:font("export/html5/obj/webfont/superstarorig_memesbruh03.ttf") #if display private #end class __ASSET__assets_font_superstarorig_memesbruh03_ttf extends lime.text.Font {}
@:keep @:font("export/html5/obj/webfont/upheavtt.ttf") #if display private #end class __ASSET__assets_font_upheavtt_ttf extends lime.text.Font {}
@:keep @:image("assets/images/Char/char.png") #if display private #end class __ASSET__assets_images_char_char_png extends lime.graphics.Image {}
@:keep @:image("assets/images/Char/char_api.png") #if display private #end class __ASSET__assets_images_char_char_api_png extends lime.graphics.Image {}
@:keep @:image("assets/images/Char/enemy.png") #if display private #end class __ASSET__assets_images_char_enemy_png extends lime.graphics.Image {}
@:keep @:image("assets/images/Char/enemy_b.png") #if display private #end class __ASSET__assets_images_char_enemy_b_png extends lime.graphics.Image {}
@:keep @:image("assets/images/Envi/fireIcon.png") #if display private #end class __ASSET__assets_images_envi_fireicon_png extends lime.graphics.Image {}
@:keep @:image("assets/images/Envi/tiles.png") #if display private #end class __ASSET__assets_images_envi_tiles_png extends lime.graphics.Image {}
@:keep @:image("assets/images/Envi/totem_2 _water.png") #if display private #end class __ASSET__assets_images_envi_totem_2__water_png extends lime.graphics.Image {}
@:keep @:image("assets/images/Envi/totem_2.png") #if display private #end class __ASSET__assets_images_envi_totem_2_png extends lime.graphics.Image {}
@:keep @:file("assets/images/images-go-here.txt") #if display private #end class __ASSET__assets_images_images_go_here_txt extends haxe.io.Bytes {}
@:keep @:image("assets/images/MenuUI/back.png") #if display private #end class __ASSET__assets_images_menuui_back_png extends lime.graphics.Image {}
@:keep @:image("assets/images/MenuUI/background.jpg") #if display private #end class __ASSET__assets_images_menuui_background_jpg extends lime.graphics.Image {}
@:keep @:image("assets/images/MenuUI/bookPage.png") #if display private #end class __ASSET__assets_images_menuui_bookpage_png extends lime.graphics.Image {}
@:keep @:image("assets/images/MenuUI/close.png") #if display private #end class __ASSET__assets_images_menuui_close_png extends lime.graphics.Image {}
@:keep @:image("assets/images/MenuUI/guideBut.png") #if display private #end class __ASSET__assets_images_menuui_guidebut_png extends lime.graphics.Image {}
@:keep @:image("assets/images/MenuUI/headStaff.png") #if display private #end class __ASSET__assets_images_menuui_headstaff_png extends lime.graphics.Image {}
@:keep @:image("assets/images/MenuUI/homeBut.png") #if display private #end class __ASSET__assets_images_menuui_homebut_png extends lime.graphics.Image {}
@:keep @:image("assets/images/MenuUI/leaf_fall.png") #if display private #end class __ASSET__assets_images_menuui_leaf_fall_png extends lime.graphics.Image {}
@:keep @:image("assets/images/MenuUI/menu.png") #if display private #end class __ASSET__assets_images_menuui_menu_png extends lime.graphics.Image {}
@:keep @:image("assets/images/MenuUI/menu_Bacl.jpg") #if display private #end class __ASSET__assets_images_menuui_menu_bacl_jpg extends lime.graphics.Image {}
@:keep @:image("assets/images/MenuUI/next.png") #if display private #end class __ASSET__assets_images_menuui_next_png extends lime.graphics.Image {}
@:keep @:image("assets/images/MenuUI/playBut.png") #if display private #end class __ASSET__assets_images_menuui_playbut_png extends lime.graphics.Image {}
@:keep @:image("assets/images/MenuUI/replayBut.png") #if display private #end class __ASSET__assets_images_menuui_replaybut_png extends lime.graphics.Image {}
@:keep @:image("assets/images/MenuUI/title.png") #if display private #end class __ASSET__assets_images_menuui_title_png extends lime.graphics.Image {}
@:keep @:image("assets/images/MenuUI/twitterBut.png") #if display private #end class __ASSET__assets_images_menuui_twitterbut_png extends lime.graphics.Image {}
@:keep @:image("assets/images/Proj/fire.png") #if display private #end class __ASSET__assets_images_proj_fire_png extends lime.graphics.Image {}
@:keep @:image("assets/images/Proj/plasma.png") #if display private #end class __ASSET__assets_images_proj_plasma_png extends lime.graphics.Image {}
@:keep @:image("assets/images/Proj/water_ball.png") #if display private #end class __ASSET__assets_images_proj_water_ball_png extends lime.graphics.Image {}
@:keep @:image("assets/images/UI/sprint.png") #if display private #end class __ASSET__assets_images_ui_sprint_png extends lime.graphics.Image {}
@:keep @:image("assets/images/UI/sprint_cooldown.png") #if display private #end class __ASSET__assets_images_ui_sprint_cooldown_png extends lime.graphics.Image {}
@:keep @:image("assets/images/UI/textBlock.png") #if display private #end class __ASSET__assets_images_ui_textblock_png extends lime.graphics.Image {}
@:keep @:file("assets/music/Explosion.wav") #if display private #end class __ASSET__assets_music_explosion_wav extends haxe.io.Bytes {}
@:keep @:file("assets/music/explosion2.wav") #if display private #end class __ASSET__assets_music_explosion2_wav extends haxe.io.Bytes {}
@:keep @:file("assets/music/gameover.wav") #if display private #end class __ASSET__assets_music_gameover_wav extends haxe.io.Bytes {}
@:keep @:file("assets/music/hit.wav") #if display private #end class __ASSET__assets_music_hit_wav extends haxe.io.Bytes {}
@:keep @:file("assets/music/music-goes-here.txt") #if display private #end class __ASSET__assets_music_music_goes_here_txt extends haxe.io.Bytes {}
@:keep @:file("assets/music/pickup.wav") #if display private #end class __ASSET__assets_music_pickup_wav extends haxe.io.Bytes {}
@:keep @:file("assets/music/select.wav") #if display private #end class __ASSET__assets_music_select_wav extends haxe.io.Bytes {}
@:keep @:file("assets/music/shoot.wav") #if display private #end class __ASSET__assets_music_shoot_wav extends haxe.io.Bytes {}
@:keep @:file("assets/music/standonTotem.wav") #if display private #end class __ASSET__assets_music_standontotem_wav extends haxe.io.Bytes {}
@:keep @:file("assets/music/talk.wav") #if display private #end class __ASSET__assets_music_talk_wav extends haxe.io.Bytes {}
@:keep @:file("assets/music/totemdissapear.wav") #if display private #end class __ASSET__assets_music_totemdissapear_wav extends haxe.io.Bytes {}
@:keep @:file("assets/sounds/sounds-go-here.txt") #if display private #end class __ASSET__assets_sounds_sounds_go_here_txt extends haxe.io.Bytes {}
@:keep @:file("D:/Program Files/HaxeToolkit/haxe/lib/flixel/4,4,2/assets/sounds/beep.mp3") #if display private #end class __ASSET__flixel_sounds_beep_mp3 extends haxe.io.Bytes {}
@:keep @:file("D:/Program Files/HaxeToolkit/haxe/lib/flixel/4,4,2/assets/sounds/flixel.mp3") #if display private #end class __ASSET__flixel_sounds_flixel_mp3 extends haxe.io.Bytes {}
@:keep @:file("D:/Program Files/HaxeToolkit/haxe/lib/flixel/4,4,2/assets/sounds/beep.ogg") #if display private #end class __ASSET__flixel_sounds_beep_ogg extends haxe.io.Bytes {}
@:keep @:file("D:/Program Files/HaxeToolkit/haxe/lib/flixel/4,4,2/assets/sounds/flixel.ogg") #if display private #end class __ASSET__flixel_sounds_flixel_ogg extends haxe.io.Bytes {}
@:keep @:font("export/html5/obj/webfont/nokiafc22.ttf") #if display private #end class __ASSET__flixel_fonts_nokiafc22_ttf extends lime.text.Font {}
@:keep @:font("export/html5/obj/webfont/monsterrat.ttf") #if display private #end class __ASSET__flixel_fonts_monsterrat_ttf extends lime.text.Font {}
@:keep @:image("D:/Program Files/HaxeToolkit/haxe/lib/flixel/4,4,2/assets/images/ui/button.png") #if display private #end class __ASSET__flixel_images_ui_button_png extends lime.graphics.Image {}
@:keep @:image("D:/Program Files/HaxeToolkit/haxe/lib/flixel/4,4,2/assets/images/logo/default.png") #if display private #end class __ASSET__flixel_images_logo_default_png extends lime.graphics.Image {}
@:keep @:file("") #if display private #end class __ASSET__manifest_default_json extends haxe.io.Bytes {}



#else

@:keep @:expose('__ASSET__assets_font_bitwonder_ttf') #if display private #end class __ASSET__assets_font_bitwonder_ttf extends lime.text.Font { public function new () { #if !html5 __fontPath = "assets/font/bitwonder"; #else ascender = 300; descender = 0; height = 300; numGlyphs = 72; underlinePosition = 0; underlineThickness = 0; unitsPerEM = 300; #end name = "8BIT WONDER Nominal"; super (); }}
@:keep @:expose('__ASSET__assets_font_monsterhunterwarprotal_ttf') #if display private #end class __ASSET__assets_font_monsterhunterwarprotal_ttf extends lime.text.Font { public function new () { #if !html5 __fontPath = "assets/font/monsterhunterwarprotal"; #else ascender = 832; descender = -163; height = 1004; numGlyphs = 221; underlinePosition = -125; underlineThickness = 50; unitsPerEM = 1000; #end name = "Monster Hunter Warped Rotalic"; super (); }}
@:keep @:expose('__ASSET__assets_font_pressostarto_ttf') #if display private #end class __ASSET__assets_font_pressostarto_ttf extends lime.text.Font { public function new () { #if !html5 __fontPath = "assets/font/pressostarto"; #else ascender = 1024; descender = 0; height = 1024; numGlyphs = 559; underlinePosition = -48; underlineThickness = 51; unitsPerEM = 1024; #end name = "Press Start 2P"; super (); }}
@:keep @:expose('__ASSET__assets_font_runescape_uf_ttf') #if display private #end class __ASSET__assets_font_runescape_uf_ttf extends lime.text.Font { public function new () { #if !html5 __fontPath = "assets/font/runescape_uf"; #else ascender = 768; descender = -256; height = 1024; numGlyphs = 97; underlinePosition = 77; underlineThickness = 51; unitsPerEM = 1024; #end name = "RuneScape UF Regular"; super (); }}
@:keep @:expose('__ASSET__assets_font_superstarorig_memesbruh03_ttf') #if display private #end class __ASSET__assets_font_superstarorig_memesbruh03_ttf extends lime.text.Font { public function new () { #if !html5 __fontPath = "assets/font/superstarorig_memesbruh03"; #else ascender = 682; descender = -192; height = 966; numGlyphs = 63; underlinePosition = -153; underlineThickness = 51; unitsPerEM = 1024; #end name = "Superstar (Original)"; super (); }}
@:keep @:expose('__ASSET__assets_font_upheavtt_ttf') #if display private #end class __ASSET__assets_font_upheavtt_ttf extends lime.text.Font { public function new () { #if !html5 __fontPath = "assets/font/upheavtt"; #else ascender = 750; descender = -150; height = 923; numGlyphs = 227; underlinePosition = -125; underlineThickness = 50; unitsPerEM = 1000; #end name = "Upheaval TT -BRK-"; super (); }}
@:keep @:expose('__ASSET__flixel_fonts_nokiafc22_ttf') #if display private #end class __ASSET__flixel_fonts_nokiafc22_ttf extends lime.text.Font { public function new () { #if !html5 __fontPath = "flixel/fonts/nokiafc22"; #else ascender = 2048; descender = -512; height = 2816; numGlyphs = 172; underlinePosition = -640; underlineThickness = 256; unitsPerEM = 2048; #end name = "Nokia Cellphone FC Small"; super (); }}
@:keep @:expose('__ASSET__flixel_fonts_monsterrat_ttf') #if display private #end class __ASSET__flixel_fonts_monsterrat_ttf extends lime.text.Font { public function new () { #if !html5 __fontPath = "flixel/fonts/monsterrat"; #else ascender = 968; descender = -251; height = 1219; numGlyphs = 263; underlinePosition = -150; underlineThickness = 50; unitsPerEM = 1000; #end name = "Monsterrat"; super (); }}


#end

#if (openfl && !flash)

@:keep @:expose('__ASSET__OPENFL__assets_font_bitwonder_ttf') #if display private #end class __ASSET__OPENFL__assets_font_bitwonder_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__assets_font_bitwonder_ttf ()); super (); }}
@:keep @:expose('__ASSET__OPENFL__assets_font_monsterhunterwarprotal_ttf') #if display private #end class __ASSET__OPENFL__assets_font_monsterhunterwarprotal_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__assets_font_monsterhunterwarprotal_ttf ()); super (); }}
@:keep @:expose('__ASSET__OPENFL__assets_font_pressostarto_ttf') #if display private #end class __ASSET__OPENFL__assets_font_pressostarto_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__assets_font_pressostarto_ttf ()); super (); }}
@:keep @:expose('__ASSET__OPENFL__assets_font_runescape_uf_ttf') #if display private #end class __ASSET__OPENFL__assets_font_runescape_uf_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__assets_font_runescape_uf_ttf ()); super (); }}
@:keep @:expose('__ASSET__OPENFL__assets_font_superstarorig_memesbruh03_ttf') #if display private #end class __ASSET__OPENFL__assets_font_superstarorig_memesbruh03_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__assets_font_superstarorig_memesbruh03_ttf ()); super (); }}
@:keep @:expose('__ASSET__OPENFL__assets_font_upheavtt_ttf') #if display private #end class __ASSET__OPENFL__assets_font_upheavtt_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__assets_font_upheavtt_ttf ()); super (); }}
@:keep @:expose('__ASSET__OPENFL__flixel_fonts_nokiafc22_ttf') #if display private #end class __ASSET__OPENFL__flixel_fonts_nokiafc22_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__flixel_fonts_nokiafc22_ttf ()); super (); }}
@:keep @:expose('__ASSET__OPENFL__flixel_fonts_monsterrat_ttf') #if display private #end class __ASSET__OPENFL__flixel_fonts_monsterrat_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__flixel_fonts_monsterrat_ttf ()); super (); }}


#end
#end