using Toybox.Application;
using Toybox.WatchUi;
using Toybox.Timer;

class SleepCycleApp extends Application.AppBase {
	
	//counters
	var counterSecond = 0;
	var counter = 0;
	
	//sensor values
	var sum = 0;
	var sum_new = 0;
	var max_sum = 0;
	var max_sum_new = 0;
	var pulse_sum = 0;
	var past_accel = new [3];
	var prior_value_exists = false;
	
	//constants
	var movementThreshold = 1000;
	var debug = true;

    function initialize() {
        AppBase.initialize();
    }

    // onStart() is called on application start up
    function onStart(state) {
    	//Storage.clearValues();
    	Storage.setValue("alarm", false);
    	var myTimer = new Timer.Timer();
    	myTimer.start(method(:timerCallback), 100, true);
    }

    // onStop() is called when your application is exiting
    function onStop(state) {
    }

    // Return the initial view of your application here
    function getInitialView() {
        return [ new SleepCycleMainView(), new SleepCycleMainDelegate() ];
    }

	function timerCallback() {
		counterSecond += 1;
		if(counterSecond >= 10){ //should be 600 once a minute
			counterSecond = 0;
    		WatchUi.requestUpdate();
		}
    	
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
            
        if (counter >= 10){ //should be 600 once per minute
        	var clockTime = System.getClockTime();
        	var timeInMinutes = clockTime.hour * 60 + clockTime.min;
        	var alarmInMinutes = (Storage.getValue("alarmInMinutes") != null) ? Storage.getValue("alarmInMinutes") : 0;
       		var rangeInMinutes = (Storage.getValue("rangeInMinutes") != null) ? Storage.getValue("rangeInMinutes") : 0;
        	
        	var timeInRange = (timeInMinutes >= alarmInMinutes - rangeInMinutes && timeInMinutes < alarmInMinutes);
        	var movmentDetected = (max_sum >= movementThreshold);
        	
        	//log_text = time.min.format("%02d") + ";" + max_sum_new.toString() + ";" + max_sum.toString() + ";" + (pulse_sum/600).toString();
        	//System.println(log_text);
        	
        	if (Storage.getValue("alarm") == false && ((timeInRange && movmentDetected) || timeInMinutes == alarmInMinutes)){
        		log("there we go");
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
    	var url = "https://api.lifx.com/v1/lights/d073d5010de1/toggle";
       	var params = {};
		var options = {           
			:method => Communications.HTTP_REQUEST_METHOD_POST,
			:headers => {"Authorization" => "Bearer c6c6347d1e0c152cb5e765093831af9e6c2fcd840d5400915d9a75e65810abe8"}
		};
		var responseCallback = method(:onReceive);

		Communications.makeWebRequest(url, params, options, method(:onReceive));
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
