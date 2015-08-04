package jp.co.dk.haxesample;

import js.Browser;
import three.BoxGeometry;
import three.DirectionalLight;
import three.Mesh;
import three.MeshLambertMaterial;
import three.PerspectiveCamera;
import three.PointLight;
import three.Scene;
import three.Vector3;
import three.WebGLRenderer;
/**
 * ...
 * @author nabe
 */

class Main3d
{

    private  var _scene     :Scene;
    private  var _camera        :PerspectiveCamera;
    private  var _renderer  :WebGLRenderer;
    private  var _mouseX    :Float = 0;
    private  var _mouseY    :Float = 0;
    private  var _amp       :Float = 400;

    var _down:Bool=false;

    public function new() 
    {
    }

    public function init() 
    {

        _scene = new Scene();
        _camera = new PerspectiveCamera(60, Browser.window.innerWidth / Browser.window.innerHeight, 10, 50000);

        _camera.near = 5;
        _camera.far = 40000;

        _scene.add(new PointLight(0xffffff, 3));
        var d:DirectionalLight = new DirectionalLight(0xffffff);
        d.position.set(1000, 1000, 100);
        _scene.add(d);

        _renderer = new WebGLRenderer();
        _renderer.setSize(Browser.window.innerWidth, Browser.window.innerHeight);
        Browser.document.body.appendChild(_renderer.domElement);

        //マウスの座標とってる
        _renderer.domElement.onmousemove = function(e){
            _mouseX = e.clientX;
            _mouseY = e.clientY;
        }

        //箱200個おいてる
        for(i in 0...200){
            var geo:BoxGeometry = new BoxGeometry(10,10,10);
            var mat:MeshLambertMaterial = new MeshLambertMaterial( { color:0xffffff * Math.random() } );
            var mesh:Mesh = new Mesh(geo, mat);
            mesh.position.set(
                1000 * (Math.random() - 0.5),
                1000 * (Math.random() - 0.5),
                1000 * (Math.random() - 0.5)
            );
            _scene.add( mesh ); 
        }

        _run();

    }

    private function _run():Void
    {
        //マウスによってカメラ動かしてる
        var rad:Float = _mouseX / Browser.window.innerWidth * Math.PI * 2;
        _camera.position.x = _amp * Math.cos(rad);
        _camera.position.y = 0;
        _camera.position.z = _amp * Math.sin(rad);
        _camera.lookAt(new Vector3());

        _renderer.render(_scene, _camera, null, false);     
        Three.requestAnimationFrame( untyped _run);
    }

}