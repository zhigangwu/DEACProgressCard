# DEACProgressCard

[![CI Status](https://img.shields.io/travis/12740181/DEACProgressCard.svg?style=flat)](https://travis-ci.org/12740181/DEACProgressCard)
[![Version](https://img.shields.io/cocoapods/v/DEACProgressCard.svg?style=flat)](https://cocoapods.org/pods/DEACProgressCard)
[![License](https://img.shields.io/cocoapods/l/DEACProgressCard.svg?style=flat)](https://cocoapods.org/pods/DEACProgressCard)
[![Platform](https://img.shields.io/cocoapods/p/DEACProgressCard.svg?style=flat)](https://cocoapods.org/pods/DEACProgressCard)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

```
let progressCardImageView = DEACProgressCardImageView(frame: CGRect(x: 100, y: 100, width: 180, height: 180))

self.view.addSubview(progressCardImageView)
progressCardImageView.cardImage = "card.jpeg"
progressCardImageView.totaldurationSecond = 30
progressCardImageView.movingBlockColor = UIColor.red
    
```

## Requirements

## Installation

DEACProgressCard is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
source 'https://github.com/zhigangwu/DEACProgressCardSpec.git'

pod 'DEACProgressCard'
```

## Author

zhigangwu, 1402832352@qq.com

## License

DEACProgressCard is available under the MIT license. See the LICENSE file for more info.
