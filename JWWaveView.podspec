#
# Be sure to run `pod lib lint JWWaveView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'JWWaveView'
  s.version          = '0.2.4'
  s.summary          = 'Providing a water waving effect for any of your UIView instance.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
JWWaveView offers an easy way to add water waving effect to parts of your UIView instances. 

JWWaveView is made possible by using CAReplicatorLayer as its core. Comparing to using timer to update the wave path continuously to get the water-waving effect, it's more efficient. 
                       DESC

  s.homepage         = 'https://github.com/Alex1989Wang/JWWaveView'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Alex1989Wang' => 'alex1989wang@gmail.com' }
  s.source           = { :git => 'https://github.com/Alex1989Wang/JWWaveView.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'JWWaveView/Classes/*'
  
  # s.resource_bundles = {
  #   'JWWaveView' => ['JWWaveView/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
