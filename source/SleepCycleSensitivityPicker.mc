using Toybox.Application;
using Toybox.Application.Storage;
using Toybox.WatchUi;

class SleepCycleSensitivityPicker extends WatchUi.Picker {

	var defaults;

    function initialize() {
        var title = new WatchUi.Text({:text=>Rez.Strings.sensTitle, :locX =>WatchUi.LAYOUT_HALIGN_CENTER, :locY=>WatchUi.LAYOUT_VALIGN_BOTTOM, :color=>Graphics.COLOR_WHITE});
        var factories = [1];
        var sens;
        
        factories[0] = new NumberFactory(1,5,1,{});
        defaults = new [1];
        //If the user already set a sensitivity, we use that as the default value.
        if(Storage.getValue("sensitivity") != null){
        	sens = Storage.getValue("sensitivity");
        } else {
        	sens = 3;
        }
        defaults[0] = factories[0].getIndex(sens);
        Picker.initialize({:title=>title, :pattern=>factories, :defaults=>defaults});   
    }

    function onUpdate(dc) {
        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_BLACK);
        dc.clear();
        Picker.onUpdate(dc);
    }
}