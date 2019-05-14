using Toybox.WatchUi;

class SleepCycleConfirmView extends WatchUi.View {
	
	function initialize() {
        View.initialize();
    }
    
    function onLayout(dc) {
    	setLayout(Rez.Layouts.MainLayout(dc));
    }
    
    function onShow() {
    }
    
    function onUpdate(dc) {
        View.onUpdate(dc);
        var message = "Are you sure\nyou want to\nclose the App?";
        dc.drawText(dc.getWidth() / 2, dc.getHeight() / 2 - 40, Graphics.FONT_LARGE, message, Graphics.TEXT_JUSTIFY_CENTER);
    }
}