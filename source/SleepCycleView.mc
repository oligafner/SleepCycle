using Toybox.WatchUi;
using Toybox.Timer;

class SleepCycleView extends WatchUi.View {

	var debug_string;
	var graph;
	var graph2;
	var past_accel = new [3];
	var prior_value_exists = false;
	var sum = 0;
	var sum_new = 0;

    function initialize() {
        View.initialize();
        //Sensor.setEnabledSensors([Sensor.SENSOR_HEARTRATE]);
        //Sensor.enableSensorEvents(method(:onSensor));
        debug_string = "no data yet";
        var dataTimer = new Timer.Timer();
		dataTimer.start(method(:timerCallback), 100, true); // A one-second timer
		
		graph = new LineGraph(80, 10, Graphics.COLOR_BLUE);
		graph2 = new LineGraph(80, 10, Graphics.COLOR_RED);
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
        dc.drawText(dc.getWidth() / 2, dc.getHeight() / 2, Graphics.FONT_LARGE, debug_string, Graphics.TEXT_JUSTIFY_CENTER);
        
        graph.draw(dc, [0, 0], [dc.getWidth(), dc.getHeight()]);
        graph2.draw(dc, [0, 0], [dc.getWidth(), dc.getHeight()]);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() {
    }

	function onSensor(sensor_info){
    	if(sensor_info.heartRate != null){
    		debug_string = sensor_info.heartRate;
    	}
    	WatchUi.requestUpdate();
    }
    
    function timerCallback() {
    	var sensorInfo = Sensor.getInfo();
    	if (sensorInfo has :accel && sensorInfo.accel != null) {
        	var accel = sensorInfo.accel;
        	var xAccel = accel[0];
        	var yAccel = accel[1];
        	//debug_string = accel[0] + " " + accel[1] + " " + accel[2];
        	
        	if (prior_value_exists){
        		sum = ((past_accel[0] - accel[0]).abs() + (past_accel[1] - accel[1]).abs() + (past_accel[2] - accel[2]).abs());
        		sum_new = Math.floor(Math.sqrt((accel[0] * accel[0]) + (accel[1] * accel[1]) + (accel[2] * accel[2]))).toNumber();
        		graph.addItem(sum);
        		graph2.addItem(sum_new);
        		debug_string = sum + "   " + sum_new;
        	}
        	
        	past_accel[0] = accel[0];
        	past_accel[1] = accel[1];
        	past_accel[2] = accel[2];
        	
        	prior_value_exists = true;
        	
        	WatchUi.requestUpdate();
    	}
	}
}
