using Toybox.Application;
using Toybox.WatchUi;
using Toybox.Timer;

class SleepCycleApp extends Application.AppBase {
	
	// counters
	var counter = 0;
	
	// sensor values
	var sum = 0;
	var sum_new = 0;
	var max_sum = 0;
	var max_sum_new = 0;
	var pulse_sum = 0;
	var past_accel = new [3];
	var prior_value_exists = false;
	var movementThreshold;
	
	// constants
	//var movementThreshold = 200;
	var debug = true;

    function initialize() {
        AppBase.initialize();
    }

    // onStart() is called on application start up
    function onStart(state) {
    	Storage.setValue("alarm", false);
    	var timer = new Timer.Timer();
    	timer.start(method(:everyTenthOfSecond), 100, true);
    }

    // onStop() is called when your application is exiting
    function onStop(state) {
    }

    // Return the initial view of your application here
    function getInitialView() {
        return [ new SleepCycleMainView(), new SleepCycleMainDelegate() ];
    }

	// callback function running every tenth of a second / main loop
	function everyTenthOfSecond() {    	
	
		// gather information and store max
    	var sensorInfo = Sensor.getInfo();
    	if (sensorInfo has :accel && sensorInfo.accel != null) {
        	var accel = sensorInfo.accel;
        	if(prior_value_exists){
        		sum = ((past_accel[0] - accel[0]).abs() + (past_accel[1] - accel[1]).abs() + (past_accel[2] - accel[2]).abs());
        	}
            if (sum_new.abs() > max_sum_new) {
               	max_sum_new = sum_new.abs();
            }
            if (sum.abs() > max_sum) {
               	max_sum = sum.abs();
            }
    		pulse_sum += (sensorInfo.heartRate != null) ? sensorInfo.heartRate : 0;
    		
    		past_accel = accel;
        	prior_value_exists = true;
    	}
    	
		
    	
    	counter ++;
    	// redraw UI
    	if(counter % 10 == 0){ //should MAYBE be 600 once a minute
    		WatchUi.requestUpdate();
		}
            
        // check if it's time to wake up
        if (counter >= 10){ //should be 600 once per minute
        	var clockTime = System.getClockTime();
        	var timeInMinutes = clockTime.hour * 60 + clockTime.min;
        	var alarmInMinutes = (Storage.getValue("alarmInMinutes") != null) ? Storage.getValue("alarmInMinutes") : 0;
       		var rangeInMinutes = (Storage.getValue("rangeInMinutes") != null) ? Storage.getValue("rangeInMinutes") : 0;
       		switch(Storage.getValue("sensitivity")){
       			case 1: movementThreshold = 500;
       			break;
       			case 2: movementThreshold = 300;
       			break;
       			case 3: movementThreshold = 200;
       			break;
       			case 4: movementThreshold = 125;
       			break;
       			case 5: movementThreshold = 50;
       			break;
       			default: movementThreshold = 200;
       			break;
       		}
        	
        	var timeInRange = (timeInMinutes >= alarmInMinutes - rangeInMinutes && timeInMinutes < alarmInMinutes);
        	var movmentDetected = (max_sum >= movementThreshold);
        	var alarmNotYetTriggered = Storage.getValue("alarm") == false;
        	
        	if (alarmNotYetTriggered && ((timeInRange && movmentDetected) || timeInMinutes == alarmInMinutes)){
        		log("Alarm!!!");
        		Storage.setValue("alarm", true);
        		makeRequest();
        		WatchUi.pushView(new SleepCycleAlarmView(), new SleepCycleAlarmDelegate(), WatchUi.SLIDE_IMMEDIATE);
        	}        		
        	counter = 0;
        	max_sum_new = 0;
        	max_sum = 0;
        	pulse_sum = 0;
        }
    }
	
	function makeRequest() {
		var lifxAccessToken = Application.getApp().getProperty("LifxAccessToken");
		if (lifxAccessToken != null) {
			var url = "https://api.lifx.com/v1/lights/all/toggle";
       		var params = {};
			var options = {           
				:method => Communications.HTTP_REQUEST_METHOD_POST,
				:headers => {"Authorization" => "Bearer " + lifxAccessToken}
			};
			var responseCallback = method(:onReceive);

			Communications.makeWebRequest(url, params, options, method(:onReceive));
		}
	}
	
	
	function onReceive(responseCode, data) {
        if (responseCode == 207) {
            log("Sucessful enlightment!");
        } else {
            log(responseCode.toString());
        }
    }
    
    function log(data) {
        if (debug) {
        	System.println(data);
        }
    }
}
