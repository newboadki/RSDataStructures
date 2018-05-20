#
# Be sure to run `pod lib lint RSDataStructures.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'RSDataStructures'
  s.version          = '0.1.0'
  s.summary          = 'Basic data structures and some related algorithms.'
  s.swift_version    = '4.1'
# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
Basic data structures and some related algorithms. The implementation follows Swifts Standard Library approach, favoring protocols and protocol extensions over inheritance. Copy on write has been implemented on certain data structures to optimise copies and to support the implementation based on value semantics.
                       DESC

  s.homepage         = 'https://github.com/newboadki/RSDataStructures'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Borja Arias Drake' => 'borja.arias@gmail.com' }
  s.source           = { :git => 'git@github.com:newboadki/RSDataStructures.git', :tag => s.version.to_s }
  

  s.ios.deployment_target = '8.0'

  s.source_files = 'RSDataStructures/Classes/**/*'
  
  # s.resource_bundles = {
  #   'RSDataStructures' => ['RSDataStructures/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
