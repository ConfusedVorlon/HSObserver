#
# Be sure to run `pod lib lint HSObserver.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'HSObservern'
  s.version          = '0.3.0'
  s.summary          = 'Nicer Notification Observers for Swift. - Better creation, activation/deactivation and cleanup'

  s.description      = <<-DESC
Better Notification Observer for Swift.
* Simpler API with sensible defaults
* Easier to avoid 'dangling' notifications
* Easy activation/deactivation
* Simple integration with view controller lifecycles
                       DESC

  s.homepage         = 'https://github.com/ConfusedVorlon/HSObserver'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'ConfusedVorlon' => 'rob@hobbyistsoftware.com' }
  s.source           = { :git => 'https://github.com/ConfusedVorlon/HSObserver.git', :tag => s.version.to_s }
  s.swift_version = '5.0'

  s.ios.deployment_target = '10.0'
  s.osx.deployment_target = '10.12'
  s.tvos.deployment_target = '10.0'
  s.watchos.deployment_target = '2.0'

  s.source_files = 'HSObserver/Classes/**/*'

end
