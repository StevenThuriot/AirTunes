package objects
{
  import flash.filesystem.File;
  import flash.filesystem.FileMode;
  import flash.filesystem.FileStream;
 
  public class FileSerializer
  {
  	/**
  	 * Serialize object to file
  	 * @param object The object to write to the HD
  	 * @param fname The file name to write it to.
  	 */
    public static function writeObjectToFile(object:Object, fname:String):void
    {
      var file:File = File.applicationStorageDirectory.resolvePath(fname);

      var fileStream:FileStream = new FileStream();
      fileStream.open(file, FileMode.WRITE);
      fileStream.writeObject(object);
      fileStream.close();
    }
   
   	/**
   	 * Read serialized object from file
   	 * @param fname The file name to read from
   	 */
    public static function readObjectFromFile(fname:String):Object
    {
      var file:File = File.applicationStorageDirectory.resolvePath(fname);

      if(file.exists) {
        var obj:Object;
        var fileStream:FileStream = new FileStream();
        fileStream.open(file, FileMode.READ);
        obj = fileStream.readObject();
        fileStream.close();
        return obj;
      }
      return null;
    }
  }
}