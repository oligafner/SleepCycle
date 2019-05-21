using Toybox.WatchUi;
using Toybox.Timer;
using Toybox.Application.Storage;
using Toybox.System;

class SleepCycleMainView extends WatchUi.View {
	
	//time
	var alarmTimeString;
	var currentTimeString;
	var batteryString;
	var batteryIcon;
	var batteryLowIcon;

    function initialize() {
        View.initialize();
    }

    // Load your resources here
    function onLayout(dc) {
    	setLayout(Rez.Layouts.MainLayout(dc));
    	batteryIcon = new WatchUi.Bitmap({:rezId=>Rez.Drawables.BatteryIcon, :locX=>dc.getWidth() / 2 - 26, :locY=>dc.getHeight() / 2 - 46});
    	batteryLowIcon = new WatchUi.Bitmap({:rezId=>Rez.Drawables.BatteryLowIcon, :locX=>dc.getWidth() / 2 - 26, :locY=>dc.getHeight() / 2 - 46});
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
        var battery = System.getSystemStats().battery;
        
    	currentTimeString = clockTime.hour.format("%02d") + ":" + clockTime.min.format("%02d") + ":" + clockTime.sec.format("%02d");
        batteryString = battery.format("%02d") + "%";
        //var lifxAccessToken = Application.getApp().getProperty("LifxAccessToken");
        
        //dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
        dc.drawText(dc.getWidth() / 2, dc.getHeight() / 2 - 30, Graphics.FONT_NUMBER_HOT, currentTimeString, Graphics.TEXT_JUSTIFY_CENTER);
        dc.drawText(dc.getWidth() / 2, dc.getHeight() / 2 + 50, Graphics.FONT_LARGE, alarmTimeString, Graphics.TEXT_JUSTIFY_CENTER);
        //dc.drawText(dc.getWidth() / 2, dc.getHeight() / 2 -30, Graphics.FONT_SMALL, lifxAccessToken, Graphics.TEXT_JUSTIFY_CENTER);
        if(battery < 16){
        	dc.setColor(Graphics.COLOR_RED, Graphics.COLOR_BLACK);
        	batteryLowIcon.draw(dc);
        	dc.drawText(dc.getWidth() / 2 + 15, dc.getHeight() / 2 - 50, Graphics.FONT_SMALL, batteryString, Graphics.TEXT_JUSTIFY_CENTER);
        } else {
        	batteryIcon.draw(dc);
        	dc.drawText(dc.getWidth() / 2 + 15, dc.getHeight() / 2 - 50, Graphics.FONT_SMALL, batteryString, Graphics.TEXT_JUSTIFY_CENTER);
        }
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() {
    }
}