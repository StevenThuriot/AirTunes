package objects
{
	/**
	 * Class to define the current song, making it easy to bind to the GUI.
	 */
	[Bindable]
	public class CurrentSong extends Song
	{
		/**
		 * True is current song is playing.
		 */
		public var IsPlaying:Boolean = false;
		
		/**
		 * Ctor
		 */
		public function CurrentSong()
		{
			super("", "", "");
		}
		
		/**
		 * Set the current playing song.
		 * @param song The current song
		 */
		public function SetSong(song:Song):void
		{
			this.Title = song.Title;
			this.Author = song.Author;
			this.IsPlaying = false;
			this.Location = song.Location;			
		}

	}
}