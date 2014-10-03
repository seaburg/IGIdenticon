IGIdenticon
===========
This library is a port of [identicon](https://github.com/donpark/identicon) library that generates identicon.  
![Screenshot example](https://raw.github.com/Seaburg/IGIdenticon/master/Screenshot/screenshot.png)

Installation
------------
### Using CocoaPods
```
pod 'IGIdenticon', '~> 0.2.0'
```
### Manually
Copy `IGIdenticon.h` and `IGIdenticon.m` in your project.

**Note:** You need to link the `CoreGraphics` framework.

**Note:** This project requires ARC.
Usage
-----
    #import "IGIdenticon.h"
    
        ...
            
    UIImage *identicon = [IGIdenticon identiconWithString:@"example" size:64 backgroundColor:[UIColor whiteColor]];
    identicon = [IGIdenticon identiconWithUInt32:arc4random() size:120];
