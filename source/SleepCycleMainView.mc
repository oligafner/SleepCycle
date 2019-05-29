using Toybox.WatchUi;
using Toybox.Timer;
using Toybox.Application.Storage;
using Toybox.System;

class SleepCycleMainView extends WatchUi.View {
	
	//time
	var rangeDesc;
	var currentHour;
	var currentMinute;
	var currentSecond;
	var batteryString;
	var batteryIcon;
	var batteryLowIcon;
	var boldTimeFont;
	var thinTimeFont;

    function initialize() {
        View.initialize();
    }

    // Loading resources here
    function onLayout(dc) {
    	setLayout(Rez.Layouts.MainLayout(dc));
    	batteryIcon = new WatchUi.Bitmap({:rezId=>Rez.Drawables.BatteryIcon, :locX=>dc.getWidth() / 2 + 46, :locY=> 9});
    	batteryLowIcon = new WatchUi.Bitmap({:rezId=>Rez.Drawables.BatteryLowIcon, :locX=>dc.getWidth() / 2 + 46, :locY=> 9});
    	
    	boldTimeFont = WatchUi.loadResource( Rez.Fonts.bebasNeueBold );
    	thinTimeFont = WatchUi.loadResource( Rez.Fonts.bebasNeueBook );
    }

    function onShow() {
    	//load the set alarm, range and values
    	var alarmInMinutes = Storage.getValue("alarmInMinutes");
    	var rangeInMinutes = Storage.getValue("rangeInMinutes");
    	rangeDesc = ((alarmInMinutes-rangeInMinutes) / 60).format("%02d") + ":" + ((alarmInMinutes-rangeInMinutes) % 60).format("%02d") 
    	+ " - " + (alarmInMinutes / 60).format("%02d") + ":" + (alarmInMinutes % 60).format("%02d");
    }

    // Update the view
    function onUpdate(dc) {
        View.onUpdate(dc);    	
        
        // sets the foreground color to white and the background to black (important because that way only the battery status color changes later)
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
        
        // draw clock
        var time = System.getClockTime();
    	currentHour = time.hour.format("%02d");
    	currentMinute = time.min.format("%02d");
    	currentSecond = time.sec.format("%02d");
        dc.drawText(dc.getWidth() / 2 - 4, dc.getHeight() / 2 - 58, boldTimeFont, currentHour, Graphics.TEXT_JUSTIFY_RIGHT);
        dc.drawText(dc.getWidth() / 2, dc.getHeight() / 2 - 63, thinTimeFont, currentMinute, Graphics.TEXT_JUSTIFY_LEFT);
        dc.drawText(dc.getWidth() - 2, dc.getHeight()/2, Graphics.FONT_LARGE, currentSecond, Graphics.TEXT_JUSTIFY_VCENTER);
        
        // draw range
        dc.drawText(dc.getWidth() / 2, dc.getHeight() - 30, Graphics.FONT_LARGE, rangeDesc, Graphics.TEXT_JUSTIFY_CENTER);
        
        // draw battery
        var battery = System.getSystemStats().battery;
        batteryString = battery.format("%02d") + "%";
        if(battery < 16){
        	batteryLowIcon.draw(dc);
        	dc.setColor(Graphics.COLOR_RED, Graphics.COLOR_BLACK);
       	} else {
        	batteryIcon.draw(dc);
        }
        dc.drawText(150, 5, Graphics.FONT_SMALL, batteryString, Graphics.TEXT_JUSTIFY_RIGHT);
    }
}