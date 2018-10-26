# WWPasscodeInput

[![CI Status](https://img.shields.io/travis/nick@thewhitewood.com/WWPasscodeInput.svg?style=flat)](https://travis-ci.org/nick@thewhitewood.com/WWPasscodeInput)
[![Version](https://img.shields.io/cocoapods/v/WWPasscodeInput.svg?style=flat)](https://cocoapods.org/pods/WWPasscodeInput)
[![License](https://img.shields.io/cocoapods/l/WWPasscodeInput.svg?style=flat)](https://cocoapods.org/pods/WWPasscodeInput)
[![Platform](https://img.shields.io/cocoapods/p/WWPasscodeInput.svg?style=flat)](https://cocoapods.org/pods/WWPasscodeInput)

## Features
* Set the length of input required
* Set the size of input indicators
* Set colours for background and borders of input indicators for idle and completed states
* Set the border size of input indicators
* Set custom font and text color for input previews
* Check the input and completion of input via `WWPasscodeInputDelegate`

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

* iOS 9.3+
* Xcode 10.0+
* Swift 4.2+


## Installation

### CocoaPods

To integrate WWPasscodeInput into your Xcode project using CocoaPods, specify it in your Podfile:

```ruby
pod 'WWPasscodeInput'
```

### Manually

Download and add `WWPasscodeInput.swift` to your project.


## Usage

### Quick Start

Example using autolayout constraints.

```
import WWPasscodeInput

class MyViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let passcodeField = WWPasscodeInput()
        view.addSubview(passcodeField)
        
        passcodeField.translatesAutoresizingMaskIntoConstraints = false
        
        let horizontalConstraint = NSLayoutConstraint(item: passcodeField, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0)
        let verticalConstraint = NSLayoutConstraint(item: passcodeField, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: 0)
        view.addConstraints([horizontalConstraint, verticalConstraint])
    }

}
```

## Author

Website: [Nicholas Wood](www.thewhitewood.com)

Twitter: [@thewhitewood](https://twitter.com/thewhitewood)

## License

WWPasscodeInput is available under the MIT license. See the [LICENSE](https://github.com/thewhitewood/WWPasscodeInput/blob/master/LICENSE) file for more info.
