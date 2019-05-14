using Toybox.Application;
using Toybox.Application.Storage;
using Toybox.Graphics;
using Toybox.WatchUi;

class SleepCycleSetTimerPicker extends WatchUi.Picker {

    function initialize() {
        var title = new WatchUi.Text({:text=>"Set Timer", :locX =>WatchUi.LAYOUT_HALIGN_CENTER, :locY=>WatchUi.LAYOUT_VALIGN_BOTTOM, :color=>Graphics.COLOR_WHITE});
        var factories;
        var defaults = new [3];
        factories = new [3];
        //Create pickers
        factories[0] = new NumberFactory(0, 23, 1, {});
        factories[1] = new WatchUi.Text({:text=>Rez.Strings.timeSeparator, :font=>Graphics.FONT_MEDIUM, :locX =>WatchUi.LAYOUT_HALIGN_CENTER, :locY=>WatchUi.LAYOUT_VALIGN_CENTER, :color=>Graphics.COLOR_WHITE});
        factories[2] = new NumberFactory(0, 59, 1, {});
        //Set default values
        if(Storage.getValue("alarmInMinutes") != null){
        	var alarmInMinutes = Storage.getValue("alarmInMinutes");
        	var hours = alarmInMinutes / 60;
        	var mins = alarmInMinutes % 60;
        	defaults[0] = factories[0].getIndex(hours);
        	defaults[2] = factories[2].getIndex(mins);
        } else {
        	defaults[0] = factories[0].getIndex(0);
        	defaults[2] = factories[2].getIndex(0);
        }
        //Initialize picker    
        Picker.initialize({:title=>title, :pattern=>factories, :defaults=>defaults}); 
    }

    function onUpdate(dc) {
        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_BLACK);
        dc.clear();
        Picker.onUpdate(dc);
    }
}