using Toybox.WatchUi;
using Toybox.Timer;
using Toybox.Application.Storage;

class SleepCycleMainView extends WatchUi.View {
	
	//time
	var alarmTimeString;
	var currentTimeString;

    function initialize() {
        View.initialize();
    }

    // Load your resources here
    function onLayout(dc) {
    	setLayout(Rez.Layouts.MainLayout(dc));
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() {
    	var clockTime = System.getClockTime();
    	currentTimeString = clockTime.hour.format("%02d") + ":" + clockTime.min.format("%02d");
    	if(Storage.getValue("alarmInMinutes") != null && Storage.getValue("rangeInMinutes") != null){
    		var alarmInMinutes = Storage.getValue("alarmInMinutes");
    		var rangeInMinutes = Storage.getValue("rangeInMinutes");
    		alarmTimeString = (alarmInMinutes / 60).format("%02d") + ":" + (alarmInMinutes % 60).format("%02d") + " " + rangeInMinutes.toString();
    	} else {
    		alarmTimeString = "set alarm & range";
    	}
    }

    // Update the view
    function onUpdate(dc) {
        View.onUpdate(dc);
        
        var clockTime = System.getClockTime();
    	currentTimeString = clockTime.hour.format("%02d") + ":" + clockTime.min.format("%02d") + ":" + clockTime.sec.format("%02d");
        
        //var lifxAccessToken = Application.getApp().getProperty("LifxAccessToken");
        
        dc.drawText(dc.getWidth() / 2, dc.getHeight() / 2, Graphics.FONT_LARGE, currentTimeString, Graphics.TEXT_JUSTIFY_CENTER);
        dc.drawText(dc.getWidth() / 2, dc.getHeight() / 2 + 50, Graphics.FONT_LARGE, alarmTimeString, Graphics.TEXT_JUSTIFY_CENTER);
        //dc.drawText(dc.getWidth() / 2, dc.getHeight() / 2 -30, Graphics.FONT_SMALL, lifxAccessToken, Graphics.TEXT_JUSTIFY_CENTER);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() {
    }
}