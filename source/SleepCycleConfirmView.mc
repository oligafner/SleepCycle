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
        dc.drawText(dc.getWidth() / 2, dc.getHeight() / 2 - 40, Graphics.FONT_LARGE, WatchUi.loadResource(Rez.Strings.confMsg), Graphics.TEXT_JUSTIFY_CENTER);
    }
}