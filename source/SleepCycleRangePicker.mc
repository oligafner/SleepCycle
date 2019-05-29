using Toybox.Application;
using Toybox.Application.Storage;
using Toybox.Graphics;
using Toybox.WatchUi;

class SleepCycleRangePicker extends WatchUi.Picker {

	var defaults;

    function initialize() {
        var title = new WatchUi.Text({:text=>Rez.Strings.rangeTitle, :locX =>WatchUi.LAYOUT_HALIGN_CENTER, :locY=>WatchUi.LAYOUT_VALIGN_BOTTOM, :color=>Graphics.COLOR_WHITE});
        var factories = [1];
        var rangeInMinutes;
        
        factories[0] = new NumberFactory(5,60,5,{});
        defaults = new [1];
        rangeInMinutes = Storage.getValue("rangeInMinutes");
        // strange + 20 fix
        defaults[0] = factories[0].getIndex(rangeInMinutes + 20);
        Picker.initialize({:title=>title, :pattern=>factories, :defaults=>defaults});   
    }

    function onUpdate(dc) {
        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_BLACK);
        dc.clear();
        Picker.onUpdate(dc);
    }
}