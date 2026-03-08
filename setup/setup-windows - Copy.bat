@echo off
color 0a
cd ..
@echo on
echo Installing dependencies.
haxelib remove lime
haxelib remove openfl
haxelib remove flixel
haxelib remove flixel-addons
haxelib remove flixel-ui
haxelib remove flixel-tools
haxelib remove hxCodec
haxelib remove tjson
haxelib remove flxanimate
haxelib remove linc_luajit
haxelib remove hxdiscord_rpc
echo Finished!
pause
