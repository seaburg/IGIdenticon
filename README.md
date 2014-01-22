IGIdenticon
===========
This library is a port of [identicon](https://github.com/donpark/identicon) library that generates identicon.  
Usage
-----
    #import "IGIdenticon.h"
    
        ...
            
    UIImage *identicon = [IGIdenticon identiconWithString:@"example" size:64 backgroundColor:[UIColor whiteColor]];
    identicon = [IGIdenticon identiconWithUInt32:arc4random() size:120];

***Note:** You need to link the `CoreGraphics` framework.*
Screenshot example
-----
![Screenshot example](https://raw.github.com/Seaburg/IGIdenticon/master/Screenshot/screenshot.jpg)
