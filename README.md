# JWWaveView
[![CI Status](http://img.shields.io/travis/Alex1989Wang/JWWaveView.svg?style=flat)](https://travis-ci.org/Alex1989Wang/JWWaveView)
[![Version](https://img.shields.io/cocoapods/v/JWWaveView.svg?style=flat)](http://cocoapods.org/pods/JWWaveView)
[![License](https://img.shields.io/cocoapods/l/JWWaveView.svg?style=flat)](http://cocoapods.org/pods/JWWaveView)
[![Platform](https://img.shields.io/cocoapods/p/JWWaveView.svg?style=flat)](http://cocoapods.org/pods/JWWaveView)

JWWaveView provides a convenient way to add water-waving effect to any of your UIView instance. 

JWWaveView is made possible by using CAReplicatorLayer as its core. Comparing to using timer to update the wave path continuously to get the water-waving effect, it's more efficient. 

Some comparisons and measurements carried out between timer-driven waving animation and CAReplicatorLayer-based animation are laid out in this [blog post](http://www.awsomejiang.com/2018/03/20/Highly-perfomant-Waving-Effect/).

## Requirements

- iOS 8.0+
- ARC

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

<div align='center'>
<img 
src="https://github.com/Alex1989Wang/JWWaveView/blob/master/Example/JWWaveView/SceenShots/wave_effect_gif.gif" 
width="300" 
title = "water-waving effect"
alt = "water-waving effect"
align = center
/>
</div>

## Installation with CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for developing iOS or OSX apps, which automates and simplifies the process of using 3rd-party libraries in your projects. See the ["Getting Started" guide for more information](https://guides.cocoapods.org/using/getting-started.html). You can install it with the following command:

```bash
$ gem install cocoapods
```

### Podfile

To integrate JWWaveView into your Xcode project using [CocoaPods](http://cocoapods.org), simply add the following line to your Podfile:

```ruby
pod 'JWWaveView'
```

Then, run the following command:

```bash
$ pod install
```

## Author

Alex1989Wang, alex1989wang@gmail.com

## License

JWWaveView is available under the MIT license. See the LICENSE file for more info.
