IGIdenticon
===========
This library is a port of [identicon](https://github.com/donpark/identicon) library that generates identicon.  
![Screenshot example](https://raw.github.com/Seaburg/IGIdenticon/master/Screenshot/screenshot.png)

Installation
------------
### Using CocoaPods
```
pod 'IGIdenticon', '~> 0.3.0'
```
### Manually
Copy all files from `IGIdenticon` folder in your project.

**Note:** You need to link the `CoreGraphics` framework.

**Note:** This project requires ARC.
Usage
-----
    #import "IGIdenticon.h"
    
        ...
            
    IGImageGenerator *imageGenerator = [[IGImageGenerator alloc] initWithImageProducer:[IGSimpleIdenticon new] hashFunction:IGJenkinsHashFromData];
    UIImage *image = [imageGenerator imageFromUInt32:arc4random() size:iconSize]
