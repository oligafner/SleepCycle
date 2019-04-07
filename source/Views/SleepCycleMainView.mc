using Toybox.WatchUi;
using Toybox.Timer;
using Toybox.Application.Storage;
using Toybox.Timer;

class SleepCycleMainView extends WatchUi.View {

	var debug_string;
	var graph;
	var graph2;
	var past_accel = new [3];
	var prior_value_exists = false;
	var sum = 0;
	var sum_new = 0;
	var time;
	//For the generation of the log
	var max_sum_new;
	var counter = 0;
	//Strings used to draw the time
	var clock;
	var set_time;

    function initialize() {
        View.initialize();
    }

    // Load your resources here
    function onLayout(dc) {
    	time = System.getClockTime();
    	clock = time.hour.format("%02d") + ":" + time.min.format("%02d") + ":" + time.sec.format("%02d");
        var myTimer = new Timer.Timer();
    	myTimer.start(method(:timerCallback), 1000, true);
    	setLayout(Rez.Layouts.MainLayout(dc));
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() {
    	if(Storage.getValue("set_time") != null){
    		var hours = Storage.getValue("timer_hoursOfDay");
    		var mins = Storage.getValue("timer_minutesOfDay");
    		set_time = hours.format("%02d") + ":" + mins.format("%02d");
    	} else {
    		set_time = "No timer set";
    	}
    }

    // Update the view
    function onUpdate(dc) {
        View.onUpdate(dc);
        dc.drawText(dc.getWidth() / 2, dc.getHeight() / 2, Graphics.FONT_LARGE, clock, Graphics.TEXT_JUSTIFY_CENTER);
        dc.drawText(dc.getWidth() / 2, dc.getHeight() / 2 + 50, Graphics.FONT_LARGE, set_time, Graphics.TEXT_JUSTIFY_CENTER);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() {
    }
    
    function timerCallback() {
    	//counter += 1;
    	//if (counter >= 10 && Attention has :playTone) {
   		//	Attention.playTone(Attention.TONE_TIME_ALERT);
   		//	//counter = 0;
		//}
		
		time = System.getClockTime();
     	clock = time.hour.format("%02d") + ":" + time.min.format("%02d") + ":" + time.sec.format("%02d");
		
		if(Storage.getValue("set_time") != null  && Attention has :playTone){
    		var hours = Storage.getValue("timer_hoursOfDay");
    		var mins = Storage.getValue("timer_minutesOfDay");
    		if (time.hour >= hours && time.min >= mins){
    			Attention.playTone(Attention.TONE_TIME_ALERT);
    		}	
    	}
    	
    	WatchUi.requestUpdate();
	}
    
    /*
    function timerCallback() {
    	//System.println("Test");
    	//Variable to store stuff for the log file
    	var log_text;
    	
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
        	if (prior_value_exists) {
            	if (sum_new > max_sum_new) {
                	max_sum_new = sum_new;
            	}
            	counter++;
        	}
        	if (counter == 60){
        		//building the text for the log file
        		myTime = System.getClockTime();
        		log_text = myTime.min.format("%02d") + ";" + sum_new.toString();
        		//Printing the log info
        		System.println(log_text);
        		
        		counter=0;
        	}
        	
        	past_accel[0] = accel[0];
        	past_accel[1] = accel[1];
        	past_accel[2] = accel[2];
        	
        	prior_value_exists = true;
        	
        	
        	WatchUi.requestUpdate();
    	}
    	
	}
	*/
}
