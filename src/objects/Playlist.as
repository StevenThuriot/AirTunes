package objects
{
	import mx.collections.ArrayCollection;
	
	[Bindable]
	public class Playlist
	{
		/**
		 * Collection of songs
		 */
		public var Songs:ArrayCollection = new ArrayCollection();
		
		/**
		 * Currently selected song
		 */
		public var CurrentPlayingSong:CurrentSong = new CurrentSong();
		
		/**
		 * Number of songs played.
		 */
		public var PlayedSongs:int = 0;
				
		/**
		 * Ctor
		 * @param list List of songs, still in XML form from the downloaded file
		 */
		public function Playlist(list:ArrayCollection)
		{
			for each (var song:Object in list)
			{
				var link:String = song.location;
				
				var title:String = song.title;
				var author:String = song.creator;
				
				Songs.addItem(new Song(title, author, link));
			}
		}
		
		/**
		 * Select a random song from the playlist.
		 * @return The song's location to stream from
		 */
		public function SelectRandomSong():String
		{
			var scale:Number = Songs.length - 1;
	        var songNumber:int = Math.random() * scale + 1;
	        
	        return this.SelectSong(Songs[songNumber]);
		}
		
		/**
		 * Select a song from the list to play.
		 * @return The song's location to stream from
		 */
		public function SelectSong(song:Song):String
		{
			var playing:Boolean = CurrentPlayingSong.IsPlaying;
			
			CurrentPlayingSong.SetSong(song);
			CurrentPlayingSong.IsPlaying = playing;
			
			return CurrentPlayingSong.Location;
		}
	}
}