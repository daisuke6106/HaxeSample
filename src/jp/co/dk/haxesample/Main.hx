package jp.co.dk.haxesample;

import js.Browser;
import js.Lib;

class Main 
{

    private static var _main:Main3d;

    static function main() 
    {
        Browser.window.onload = untyped _init;
    }

    static private function _init() 
    {
        _main = new Main3d();
        _main.init();
    }

}