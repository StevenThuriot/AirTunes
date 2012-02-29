package objects
{
	import mx.utils.StringUtil;
	
	/**
	 * Song object, created while parsing the XML list. Each item defines one Song object.
	 */
	[Bindable]
	public class Song
	{
		/**
		 * Title of the song
		 */
		public var Title:String;
		
		/**
		 * Author of the song
		 */
		public var Author:String;
		
		/**
		 * Where to stream this song from
		 */
		public var Location:String;
		
		/**
		 * Ctor
		 * @param title The song's title
		 * @param author The song's author
		 * @param location The link to stream to song from
		 */
		public function Song(title:String, author:String, location:String)
		{
			title = toTitleCase( title );
			author = toTitleCase( author );
				
			Title = title;
			Author = author;
			Location = location;
		}
		
		/**
		 * Parse strings to delete trailing and leading whitespace and set the correct casing using toInitialCap().
		 * @param original The original string to adjust
		 * @return The new string with correct casing
		 */
		private function toTitleCase( original:String ):String {
	    	original = StringUtil.trim( original );
	    	var words:Array = original.split( " " );
	    	
	    	for (var i:int = 0; i < words.length; i++) {
	    		words[i] = toInitialCap( words[i] );
	    	}
	    	return ( words.join( " " ) );
	    }
	    
	    /**
	    * Capitalizes the first letter and sets the rest of the word to lowercase
	    * @param original One word
	    * @return Word with correct casing
	    */
	    private function toInitialCap( original:String ):String {
	    	var str:String = "";
	    	
	    	for (var i:int = 0; i < original.length; i++)
			{
				if ( !isAlpha( original.charAt( i ) ) )
				{
			    	str += original.charAt( i );
	    			original = original.substr(1);
	   			} else {
	   				break;
	   			}	   			
			}
	    	
	    	return str + original.charAt( 0 ).toUpperCase(  ) + original.substr( 1 ).toLowerCase(  );
	    } 
	    
	    /**
	    * Check if current char is in the Latin alphabet
	    * @param theChar One letter
	    * @return True if the letter is part of the latin alphabet, otherwise false.
	    */
	    private function isAlpha(theChar:String):Boolean
	    {
	    	if (theChar.length == 1)
	    	{
	    		if ((theChar >= "A" && theChar <= "Z") || (theChar >= "a" && theChar <= "z"))
				{
					return true;
				}	
	    	}
	    	
	    	return false;
	    }
	}
	
	    
}