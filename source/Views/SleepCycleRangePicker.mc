using Toybox.Application;
using Toybox.Graphics;
using Toybox.WatchUi;

class SleepCycleRangePicker extends WatchUi.Picker {

    function initialize() {
        var title = new WatchUi.Text({:text=>"Range", :locX =>WatchUi.LAYOUT_HALIGN_CENTER, :locY=>WatchUi.LAYOUT_VALIGN_BOTTOM, :color=>Graphics.COLOR_WHITE});
        Picker.initialize({:title=>title, :pattern=>[new NumberFactory(5,60,5,null)]});
		System.println("Picker Initialized");    
    }

    function onUpdate(dc) {
        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_BLACK);
        dc.clear();
        Picker.onUpdate(dc);
    }
}