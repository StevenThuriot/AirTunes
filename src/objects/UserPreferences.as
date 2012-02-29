package objects
{
  [RemoteClass]
  public class UserPreferences
  {
    public var DozeOff:Number = 20;
    public var WakeUpHour:Number = 7;
    public var WakeUpMinute:Number = 30;
    
    public var EnableAlarm:Boolean = false;
    
    public var AppPosX:Number; 
    public var AppPosY:Number;
    
    public var CurrentState:String = '';
    public var PreviousState:String = '';
    
    public var MaxVolume:Boolean = false;
  }
}