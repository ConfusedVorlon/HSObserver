#
# Be sure to run `pod lib lint HSNotification.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'HSNotification'
  s.version          = '0.3.0'
  s.summary          = 'Nicer Notifications for Swift. - Better creation, activation/deactivation and cleanup'

  s.description      = <<-DESC
Better Notifications for Swift.
* Simpler API with sensible defaults
* Easier to avoid 'dangling' notifications
* Easy activation/deactivation
* Simple integration with view controller lifecycles
                       DESC

  s.homepage         = 'https://github.com/ConfusedVorlon/HSNotification'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'ConfusedVorlon' => 'rob@hobbyistsoftware.com' }
  s.source           = { :git => 'https://github.com/ConfusedVorlon/HSNotification.git', :tag => s.version.to_s }
  s.swift_version = '4.2'

  s.ios.deployment_target = '10.0'
  s.osx.deployment_target = '10.12'
  s.tvos.deployment_target = '10.0'
  s.watchos.deployment_target = '2.0'

  s.source_files = 'HSNotification/Classes/**/*'

  # s.resource_bundles = {
  #   'HSNotification' => ['HSNotification/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
