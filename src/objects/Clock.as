package objects
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import mx.controls.CheckBox;
    
	public class Clock
	{
		/**
		 * The Timer that will be used for the alarm.
		 */
		private var _AlarmTimer:Timer;
		
		/**
		 * The Timer that will be used to fall alseep.
		 */
		private var _DozeTimer:Timer;
		
		/**
		* The player var
		*/		
		private var _Player:objects.Player;
		
		/**
		 * Needed to turn off the doze checkbox after the timer event.
		 */
		private var _DozeBox:CheckBox;
		
		/**
		 * Wether to set the volume to max before triggering the alarm clock. 
		 */
		private var _MaxVolume:Boolean;
		
		/**
		 * Set the player
		 */
		public function set Player(player:objects.Player):void
		{
			_Player = player;	
		}
		
		/**
		 * Set the doze Checkbox
		 */
		public function set DozeBox(box:CheckBox):void
		{
			_DozeBox = box;	
		} 
		
		/**
		 * Wether to set the volume to max before triggering the alarm clock. 
		 */
		public function set TriggerMaxVolume(max:Boolean):void
		{
			_MaxVolume = max;
		}
		
		/**
		 * Get the wake up Checkbox
		 */
		public function get IsAlarmEnabled():Boolean
		{
			return _AlarmTimer.running;	
		}
		
		/**
		 * Ctor
		 * @param p The player
		 */
		public function Clock()
		{	
			_AlarmTimer = new Timer(0, 1);
		    _AlarmTimer.addEventListener(TimerEvent.TIMER, OnAlarm);
		    
			_DozeTimer = new Timer(0, 1);
		    _DozeTimer.addEventListener(TimerEvent.TIMER, OnDoze);
		}
		
		 /**
		 * Sets the time at which the alarm should go off.
		 * @param hour The hour portion of the alarm time.
		 * @param minutes The minutes portion of the alarm time.
		 */
		public function SetAlarmTimer(hour:Number, minutes:Number):void
		{
		   	var alarmTime:Date = new Date();
		    alarmTime.hours = hour;
		    alarmTime.minutes = minutes;
		    alarmTime.seconds = 0;
	
			Set(_AlarmTimer, alarmTime);
		}
		
		/**
		 * Sets the time at which you should have fallen asleep, so it can stop playing.
		 * @param minutes The number of minutes it should take to fall asleep
		 */
		public function SetDozeTimer(minutes:Number = 0):void
		{			
			var dozeTime:Date = new Date();			
			dozeTime.setTime( dozeTime.time + (minutes * 60000) );
			
			Set(_DozeTimer, dozeTime);
		}
		
		/**
		 * Methode to set a given timer to go off at a given time
		 * @param timer The timer to start
		 * @param date When the timer should go off 
		 */
		private function Set(timer:Timer, date:Date):void
		{
			var now:Date = new Date();
			
			if (date <= now)
		    {
		        date.setTime(date.time + (1000 * 60 * 60 * 24) );
		    }
			
			timer.reset();
			timer.delay = Math.max(1000, date.time - now.time);
			timer.start();
		}
		
		
		/**
		 * Called when the alarmTimer event is dispatched.
		 */
		public function OnAlarm(event:TimerEvent):void 
		{
		    _AlarmTimer.stop();
		       
		    if ( _MaxVolume )
		    	_Player.Volume = 100;
		 	   
		    _Player.SelectRandomSong();

			var now:Date = new Date();
			SetAlarmTimer(now.hours, now.minutes);
		}
		
		
		/**
		 * Called when the dozeTimer event is dispatched.
		 */
		public function OnDoze(event:TimerEvent):void 
		{
		    _DozeTimer.stop();
		    
		    _Player.SetStopFlag();
		    _DozeBox.selected = false;
		}

		/**
		 * User turned off the doze checkbox
		 */
		public function StopDoze():void
		{
			_DozeTimer.stop();
		
			_Player.SetStopFlag( false );
		}
		
		/**
		 * User turned off the alarm checkbox
		 */
		public function StopAlarm():void
		{
			_AlarmTimer.stop();
		}
	}
}