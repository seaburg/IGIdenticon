# IGIdenticon
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![CocoaPods Compatible](https://img.shields.io/cocoapods/v/IGIdenticon.svg)](https://img.shields.io/cocoapods/v/IGIdenticon.svg)

This library is a port of [identicon](https://github.com/donpark/identicon) library that generates identicon.  
![Screenshot example](https://raw.github.com/Seaburg/IGIdenticon/master/Screenshot/screenshot.png)

Installation
------------
Carthage
```
github "seaburg/IGIdenticon"
```
CocoaPods
```
pod 'IGIdenticon'
```
Usage
-----
    imageView.image = Identicon().icon(from: "string", size: CGSize(width: 100, height: 100))
-----
