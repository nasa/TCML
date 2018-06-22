function blkStruct = slblocks
  % Specify that the product should appear in the library browser
  % and be cached in its repository
  Browser.Library = 'lib_TCML';
  Browser.Name    = 'TCML';
  Browser(1).Choice = 1; 
  blkStruct.Browser = Browser;