using Toybox.WatchUi;
using Toybox.Timer;
using Toybox.Application.Storage;

class SleepCycleAlarmView extends WatchUi.View {

	var myTimer;
	var watchRight;
	var watchLeft;
	var rightFrame;

    function initialize() {
        View.initialize();
    }

    // Load your resources here
    function onLayout(dc) {
    	myTimer = new Timer.Timer();
    	myTimer.start(method(:alarmBehaviour), 1000, true);
        setLayout(Rez.Layouts.MainLayout(dc));
        watchRight = new WatchUi.Bitmap({:rezId=>Rez.Drawables.AlarmRightIcon, :locX=>dc.getWidth() / 4 - 20, :locY=>dc.getHeight() / 4});
        watchLeft = new WatchUi.Bitmap({:rezId=>Rez.Drawables.AlarmLeftIcon, :locX=>dc.getWidth() / 4 - 20, :locY=>dc.getHeight() / 4});
        rightFrame = false;
    }

    // Update the view
    function onUpdate(dc) {
        View.onUpdate(dc);
        if(rightFrame){
        	watchRight.draw(dc);
        } else {
        	watchLeft.draw(dc);
        }
        
    }

    function onHide() {
    	myTimer.stop();
    }
    
    function alarmBehaviour() {
    	if(Attention has :playTone){
    		Attention.playTone(Attention.TONE_TIME_ALERT);
    		Attention.backlight(true);
    	}
    	//Change the clock image every update to simulate an animation
    	rightFrame = !rightFrame;
	}

}
