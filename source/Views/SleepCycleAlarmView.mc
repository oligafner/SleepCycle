using Toybox.WatchUi;
using Toybox.Sensor;
using Toybox.System;
using Toybox.Timer;

class SleepCycleAlarmView extends WatchUi.View {

	var sensor_data;
	var graph;

    function initialize() {
        View.initialize();
        //Sensor.setEnabledSensors([Sensor.SENSOR_HEARTRATE]);
        //Sensor.enableSensorEvents(method(:onSensor));
        sensor_data = "hello";
        var dataTimer = new Timer.Timer();
		dataTimer.start(method(:timerCallback), 1000, true); // A one-second timer
		
		graph = new LineGraph( 20, 10, Graphics.COLOR_RED );
    }

    // Load your resources here
    function onLayout(dc) {
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
        
        draw(dc, [0, 0], [dc.getWidth(), dc.getHeight()]);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() {
    }
    
    function onSensor(sensor_info){
    	if(sensor_info.heartRate != null){
    		sensor_data = sensor_info.heartRate;
    	}
    	WatchUi.requestUpdate();
    }
    
    function timerCallback() {
    var sensorInfo = Sensor.getInfo();
    if (sensorInfo has :accel && sensorInfo.accel != null) {
        var accel = sensorInfo.accel;
        var xAccel = accel[0];
        var yAccel = accel[1];
        sensor_data = accel[0] + " " + accel[1] + " " + accel[2];
        WatchUi.requestUpdate();
    }
	}

}
