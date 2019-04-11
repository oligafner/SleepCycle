using Toybox.WatchUi;
using Toybox.Sensor;
using Toybox.System;
using Toybox.Timer;
using Toybox.Application.Storage;

class SleepCycleAlarmView extends WatchUi.View {

	var sensor_data;
	var graph;
	var myTimer;

    function initialize() {
        View.initialize();
        System.println("AlarmView initialized");
        sensor_data = "Beep";
    }

    // Load your resources here
    function onLayout(dc) {
    	myTimer = new Timer.Timer();
    	myTimer.start(method(:timerCallback), 1000, true);
        setLayout(Rez.Layouts.MainLayout(dc));
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() {
    }

    // Update the view
    function onUpdate(dc) {
        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);
        dc.drawText(dc.getWidth() / 2, dc.getHeight() / 2, Graphics.FONT_LARGE, sensor_data, Graphics.TEXT_JUSTIFY_CENTER);
        
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() {
    	myTimer.stop();
    }
    
    function timerCallback() {
    	System.println("AlarmView timer tick");
    	if(Attention has :playTone){
    		System.println("Has playTone");
    		Attention.playTone(Attention.TONE_TIME_ALERT);
    	}
	}

}
