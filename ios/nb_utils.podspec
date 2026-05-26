#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint nb_utils.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'nb_utils'
  s.version          = '7.3.4'
  s.summary          = 'Collection of Widgets and helpful Methods that every developer needs.'
  s.description      = <<-DESC
Collection of Widgets and helpful Methods that every developer needs.
                       DESC
  s.homepage         = 'https://github.com/bhoominn/nb_utils'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Bhoomin Naik' => 'bhoominn@gmail.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*.swift'
  s.dependency 'Flutter'
  s.platform = :ios, '13.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'

  s.resource_bundles = {'nb_utils_privacy' => ['Resources/PrivacyInfo.xcprivacy']}
end
