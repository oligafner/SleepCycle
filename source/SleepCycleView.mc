using Toybox.WatchUi;
using Toybox.Timer;

class SleepCycleView extends WatchUi.View {

	var debug_string;
	var prior_value_exists = false;
	var sum = 0;
	var sum_new = 0;
	var myTime;
	var past_accel = new [3];
	var max_sum = 0;
	var max_sum_new = 0;
	var counter = 0;

    function initialize() {
        View.initialize();
        var dataTimer = new Timer.Timer();
		dataTimer.start(method(:timerCallback), 100, true);
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
        View.onUpdate(dc);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() {
    }
    
    function timerCallback() {
    	var log_text;
    	
    	var sensorInfo = Sensor.getInfo();
    	if (sensorInfo has :accel && sensorInfo.accel != null) {
        	var accel = sensorInfo.accel;
        	sum_new = Math.floor(Math.sqrt((accel[0] * accel[0]) + (accel[1] * accel[1]) + (accel[2] * accel[2]))).toNumber();
        	if(prior_value_exists){
        		sum = ((past_accel[0] - accel[0]).abs() + (past_accel[1] - accel[1]).abs() + (past_accel[2] - accel[2]).abs());
        	}
            if (sum_new.abs() > max_sum_new) {
               	max_sum_new = sum_new.abs();
            }
            if (sum.abs() > max_sum) {
               	max_sum = sum.abs();
            }
            counter++;
        	prior_value_exists = true;
        	if (counter >= 600){
        		myTime = System.getClockTime();
        		log_text = myTime.min.format("%02d") + ";" + max_sum_new.toString() + ";" + max_sum.toString();
        		System.println(log_text);
        		
        		counter = 0;
        		max_sum_new = 0;
        		max_sum = 0;
        	}
        	past_accel[0] = accel[0];
        	past_accel[1] = accel[1];
        	past_accel[2] = accel[2];
    	}
	}
}
