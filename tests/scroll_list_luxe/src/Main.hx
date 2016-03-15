
import luxe.Input;
import luxe.Color;
import luxe.Vector;

import mint.Control;
import mint.types.Types;
import mint.render.luxe.*;
import mint.layout.margins.Margins;
import mint.focus.Focus;

import AutoCanvas;

class Main extends luxe.Game {

    var focus: Focus;
    var layout: Margins;
    var canvas: AutoCanvas;
    var rendering: LuxeMintRender;

    var itemW : mint.Window;
    var itemList : mint.List;

    override function config(config:luxe.AppConfig) {

        return config;

    } //config

    override function ready() {

        rendering = new LuxeMintRender();
        layout = new Margins();

        canvas = new AutoCanvas({
            name:'canvas',
            rendering: rendering,
            options: { color:new Color(1,1,1,0) },
            x: 0, y:0, w: Luxe.screen.w, h: Luxe.screen.h
        });

        focus = new Focus(canvas);
        canvas.auto_listen();

        new mint.Button({
            parent: canvas,
            name: 'add',
            x: 90, y: 40, w: 60, h: 32,
            text: 'Add item',
            text_size: 14,
            options: { label: { color:new Color().rgb(0x9dca63) } },
            onclick: function(e,c) { create_item(itemList); trace('add item! ${Luxe.time}' ); }
        });

        create_window();

    } //ready

    function create_window() {
      itemW = new mint.Window({
          parent: canvas,
          name: 'wind',
          title: 'Window',
          options: {
              color:new Color().rgb(0x121212),
              color_titlebar:new Color().rgb(0x191919),
              label: { color:new Color().rgb(0x06b4fb) },
              close_button: { color:new Color().rgb(0x06b4fb) },
          },
          x:320, y:0, w:320, h: 480,
          w_min: 256, h_min:256,
          collapsible:true
      });

      itemList = new mint.List({
          parent: itemW,
          name: 'itemList',
          options: { view: { color:new Color().rgb(0x19191c) } },
          x: 5, y: 37, w: 310, h: 480,
      });
    } //create_plus_window

    function create_item(list: mint.List) {
      var idx = list.items.length;

      var _item = new mint.Label({
          parent: list,
          name: '${list.name}_${idx}',
          x:5, y:2, w:300, h:32,
          text_size: 22,
          align: TextAlign.center, align_vertical: TextAlign.center, bounds_wrap: true,
          text: '${idx}, click to remove',
          onclick: function(e,c) { list.remove_item(c); }
      });

      list.add_item(_item);
    }


    override function onkeyup( e:luxe.KeyEvent ) {

        if(e.keycode == Key.escape) {
            Luxe.shutdown();
        }

    } //onkeyup

} //Main
