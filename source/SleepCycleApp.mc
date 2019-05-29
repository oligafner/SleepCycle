using Toybox.Application;
using Toybox.WatchUi;
using Toybox.Timer;

class SleepCycleApp extends Application.AppBase {
	
	var counter = 0;
	
	// sensor values
	var accelerationVector = 0;
	var maxAccelerationVector = 0;
	var movementCounter = 0;
	
	// set values from menu
	var alarmInMinutes;
	var rangeInMinutes;
	var movementThreshold;
	
	// check to open alarmView only once
	var alarmTriggered = false;
	
	// constants
	const DEFAULT_WAKE_TIME_IN_MINUTES = 8 * 30;
	const DEFALUT_WAKE_RANGE_IN_MINUTES = 30;
	const DEFAULT_WAKE_SENSITIVITY = 3;
	const WAKE_SENSITIVITY_MULTIPLIER = 30;
	const WAKE_SENSITIVITY_RANGE = 5;
	const LIFX_ACCESS_TOKEN_LENGTH = 64;
	const DEBUG = true;

    function initialize() {
        AppBase.initialize();
    }

    // onStart() is called on application start up
    function onStart(state) {    	
    	if(Storage.getValue("alarmInMinutes") == null) {
    		Storage.setValue("alarmInMinutes", DEFAULT_WAKE_TIME_IN_MINUTES);
    	}
    	if(Storage.getValue("rangeInMinutes") == null) {
    		Storage.setValue("rangeInMinutes", DEFALUT_WAKE_RANGE_IN_MINUTES);
    	}
    	if(Storage.getValue("sensitivity") == null) {
    		Storage.setValue("sensitivity", DEFAULT_WAKE_SENSITIVITY);
    	}
    	
    	var timer = new Timer.Timer();
    	timer.start(method(:everyTenthOfSecond), 100, true);
    }

    // Return the initial view of your application here
    function getInitialView() {
    	return [ new SleepCycleMainView(), new SleepCycleMainDelegate() ];
    }

	// callback function running every tenth of a second / main loop
	function everyTenthOfSecond() {   
	
		counter++;
		// gather information and store max    	
    	
        alarmInMinutes = Storage.getValue("alarmInMinutes");
       	rangeInMinutes = Storage.getValue("rangeInMinutes");
       	var time = System.getClockTime();
        var timeInMinutes = time.hour * 60 + time.min;
    	var timeInRange = (timeInMinutes >= (alarmInMinutes - rangeInMinutes) && timeInMinutes < alarmInMinutes);
    	
        // update ui every second
        if(counter >= 10){
        	counter = 0;
        	WatchUi.requestUpdate();
        }	
    	
    	// gather sensor data
    	var sensorInfo = Sensor.getInfo();
    	movementThreshold = (WAKE_SENSITIVITY_RANGE + 1 - Storage.getValue("sensitivity")) * WAKE_SENSITIVITY_MULTIPLIER;
    	if (timeInRange && sensorInfo has :accel && sensorInfo.accel != null) {
        	var accel = sensorInfo.accel;
        	accelerationVector = (Math.sqrt((Math.pow(accel[0],2) + Math.pow(accel[1],2) + Math.pow(accel[2],2))).toNumber() - 1000).abs();
            if (accelerationVector > maxAccelerationVector) {
               	maxAccelerationVector = accelerationVector;
            }
            if (accelerationVector >= movementThreshold){
            	movementCounter++;
            	
            }
    	}
            
        // check if it's time to wake up
        var movementDetected = (maxAccelerationVector >= movementThreshold);
        var latestWakeupTime = (timeInMinutes == alarmInMinutes);
        if  (((timeInRange && movementDetected) || latestWakeupTime) && !alarmTriggered){
        	alarmTriggered = true;
        	var lifxAccessToken = Application.getApp().getProperty("LifxAccessToken");
			makeLifxRequest(lifxAccessToken);
        	WatchUi.pushView(new SleepCycleAlarmView(), new SleepCycleAlarmDelegate(), WatchUi.SLIDE_IMMEDIATE);
        }
    }
	
	function makeLifxRequest(lifxAccessToken) {
		var lifxAccessToken = Application.getApp().getProperty("LifxAccessToken");
		if (lifxAccessToken != null && lifxAccessToken.length == LIFX_ACCESS_TOKEN_LENGTH) {
			var url = "https://api.lifx.com/v1/lights/all/toggle";
       		var params = {};
			var options = {           
				:method => Communications.HTTP_REQUEST_METHOD_POST,
				:headers => {"Authorization" => "Bearer " + lifxAccessToken}
			};
			Communications.makeWebRequest(url, params, options, method(:onLifxReceive));
		}
	}
	
	
	function onLifxResponse(responseCode, data) {
        if (responseCode != 207) {
            log(responseCode.toString());
        }
    }
    
    function log(data) {
        if (DEBUG) {
        	System.println(data);
        }
    }
}
