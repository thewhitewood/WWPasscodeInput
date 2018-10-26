#
# Be sure to run `pod lib lint WWPasscodeInput.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'WWPasscodeInput'
  s.version          = '0.1.0'
  s.summary          = 'Customisable passcode input view'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
WWPasscodeInput is a customisable number passcode view written in Swift.
                       DESC

  s.homepage         = 'https://github.com/thewhitewood/WWPasscodeInput'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'nick@thewhitewood.com' => 'nick@thewhitewood.com' }
  s.source           = { :git => 'https://github.com/thewhitewood/WWPasscodeInput.git', :tag => s.version.to_s }
   s.social_media_url = 'https://twitter.com/thewhitewood'

  s.ios.deployment_target = '9.3'
  s.swift_version = '4.2'

  s.source_files = 'WWPasscodeInput/Classes/**/*'
  
  # s.resource_bundles = {
  #   'WWPasscodeInput' => ['WWPasscodeInput/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
