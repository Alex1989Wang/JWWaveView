# JWWaveView
[![CI Status](http://img.shields.io/travis/Alex1989Wang/JWWaveView.svg?style=flat)](https://travis-ci.org/Alex1989Wang/JWWaveView)
[![Version](https://img.shields.io/cocoapods/v/JWWaveView.svg?style=flat)](http://cocoapods.org/pods/JWWaveView)
[![License](https://img.shields.io/cocoapods/l/JWWaveView.svg?style=flat)](http://cocoapods.org/pods/JWWaveView)
[![Platform](https://img.shields.io/cocoapods/p/JWWaveView.svg?style=flat)](http://cocoapods.org/pods/JWWaveView)

JWWaveView提供了为你任何的UIView实例添加水波纹效果的简便接口。

JWWaveView的内部实现利用了CAReplicatorLayer。与使用timer来不断更新波纹path路劲获得水波纹的动画相比，使用CAReplicatorLayer是更高效的选择。

对于这使用timer驱动和使用CAReplicatorLayer这两种方式的一些比较和测量在[这篇博客](http://www.awsomejiang.com/2018/03/20/Highly-perfomant-Waving-Effect/)中有一些提到。

## Requirements

- iOS 8.0+
- ARC

## Example

使用之前可以先跑一下example项目：克隆这个repo，同时在`Example`目录下运行`pod install`。

暂停和重新启动动画的示例：

<div align='center'>
<img 
src="https://raw.githubusercontent.com/Alex1989Wang/JWWaveView/master/Example/JWWaveView/SceenShots/wave_effect_pause.gif" 
width="350" 
title = "water-waving effect pause and unpause"
alt = "water-waving effect pause and unpause"
align = center
/>
</div>

将水波纹效果添加到table view cell中的效果：

<div align='center'>
<img 
src="https://raw.githubusercontent.com/Alex1989Wang/JWWaveView/master/Example/JWWaveView/SceenShots/wave_effect_gif.gif" 
width="350" 
title = "water-waving effect"
alt = "water-waving effect"
align = center
/>
</div>

## Features

### 已完成

- [x] 支持水波的多周期
- [x] 随时暂停和开启动画 

### 待完成 

- [ ] 水波的起始绘制点可以由用户控制 
- [ ] 提供两个重叠水波来增加效果纵深
- [ ] 为UIView添加一个更加方便的category 

## Installation with CocoaPods

[CocoaPods](http://cocoapods.org)是开发iOS和OSX项目的一个第三方库依赖管理工具。它使得在你的项目中使用第三方库的过程更加自动化、更加简单。可以查阅[CocoaPods初步使用](https://github.com/Alex1989Wang/JWWaveView/blob/master/README.md)获得更多使用信息。可以通过下列命令来安装CocoaPods:

```bash
$ gem install cocoapods
```

### Podfile

如需将JWWaveView整合到你的项目之中，只需简单地在你的Podfile文件中添加下面代码：

```ruby
pod 'JWWaveView'
```

然后，在terminal下运行下列命令：

```bash
$ pod install
```

## Author

Alex1989Wang, alex1989wang@gmail.com

## License

JWWaveView由MIT license管理。如需更多信息，可以阅读LICENSE文件。
