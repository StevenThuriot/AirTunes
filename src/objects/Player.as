package objects
{
	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.net.URLRequest;
	
	import mx.collections.ArrayCollection;
	
	[Bindable]
	public class Player
	{
		/**
		 * MP3 Streamer
		 */
		private var _SoundRequest:URLRequest;
		
		/**
		 * The sound
		 */
		private var _MySound:Sound;
		
		/**
		 * Sound control (eg volume)
		 */
		private var _SoundControl:SoundChannel;
		
		/**
		 * Sound control (eg volume)
		 */
		private var _Transform:SoundTransform;
		
		/**
		 * True when selecting a new song. Used in case of huge lag so the user wouldn't overclick and make it worse.
		 */
		public var IsSelectingANewSong:Boolean;
		
		/**
		 * The playlist of songs
		 */
		public var SongPlaylist:Playlist;
		
		/**
		 * Flag to see if the player should keep playing
		 * True when the player should stop at the next song.
		 */
		 private var _StopFlag:Boolean;
		
		/**
		 * Ctor
		 */
		public function Player()
		{
			_SoundRequest = new URLRequest();
			_MySound = new Sound();
			_SoundControl = new SoundChannel();
			_Transform = new SoundTransform(1, 0);
			
			IsSelectingANewSong = false;
			_StopFlag = false;
		}
		
		/**
		 * Creating a playlist
		 * @param list The list of songs, still in XML form from the downloaded file
		 */
		public function CreatePlaylist(list:ArrayCollection):void
		{
			SongPlaylist = new Playlist(list);
		}
		
		/**
		 * Song finished playing, select the next one
		 */
		private function Finished(event:Event):void
		{
			SongPlaylist.PlayedSongs++;
			this.SelectRandomSong();
		}
		
		/**
		 * Start playing the music.
		 */
		public function PlaySound():void
		{
			if (!SongPlaylist.CurrentPlayingSong.IsPlaying) 
			{
				_SoundControl = _MySound.play();
				_SoundControl.addEventListener(Event.SOUND_COMPLETE, Finished);
				
				SongPlaylist.CurrentPlayingSong.IsPlaying = true;
				
				_SoundControl.soundTransform = _Transform;
			}
		}
		
		/**
		 * Stop playing the music.
		 */
		public function StopSound():void
		{
			if (SongPlaylist.CurrentPlayingSong.IsPlaying) 
			{
				_SoundControl.stop();
				SongPlaylist.CurrentPlayingSong.IsPlaying = false;
			}
		}
		
		/**
		 * Change volume (in percentage)
		 * @param volume The new volume.
		 */
		public function set Volume(volume:Number):void
		{
			_Transform.volume = (volume / 100);
		    _SoundControl.soundTransform = _Transform;
		}
		
		/**
		 * Get the current volume in percentage.
		 */
		public function get Volume():Number
		{
			return _Transform.volume * 100;
		}

		/**
		 * Select a song of choice
		 * @param song Song to select
		 */
		public function SelectSong(song:Song):void
		{
			Select(SongPlaylist.SelectSong(song));
		}		
		
		/**
		 * Select a random song
		 */
		public function SelectRandomSong():void
		{
			Select(SongPlaylist.SelectRandomSong());
		}
		
		/**
		 * Methode to tell the player to stop at the next song
		 * @param value True to set stopflag, false to unset. Standard = true
		 */
		public function SetStopFlag(value:Boolean = true):void
		{
			_StopFlag = value;
		}
		
		/**
		 * Select function to make the previous two easier.
		 * @param location The location of the song that you want to stream.
		 */
		private function Select(location:String):void
		{
			if ( _StopFlag )
			{
				_StopFlag = false;
				this.StopSound();
			} else {
				IsSelectingANewSong = true;
				
				this.StopSound();
				
				_SoundRequest.url = location;
				
				_MySound = new Sound();			  
				_MySound.load(_SoundRequest);
	
				IsSelectingANewSong = false;
				this.PlaySound();
			}
		}

	}
}