require "json"

package = JSON.parse(File.read(File.join(__dir__, "package.json")))

Pod::Spec.new do |s|
  s.name         = package["name"]
  s.version      = package["version"]
  s.summary      = package["description"]
  s.homepage     = package["homepage"]
  s.license      = package["license"]
  s.authors      = package["author"]

  s.platform                  = :ios, '13.0'
  s.ios.deployment_target     = '13.0'
  s.requires_arc              = true
  s.static_framework          = true

  s.source = { :http => "https://github.com/jdarshan5/ffmpeg-kit-react-native.git" }

  s.dependency "React-Core"

  s.source_files = '**/FFmpegKitReactNativeModule.m', '**/FFmpegKitReactNativeModule.h'

  # Local FFmpeg frameworks from consuming app's ffmpeg/ios/ directory
  s.vendored_frameworks = Dir[File.join(__dir__, '..', '..', 'ffmpeg', 'ios', '*.xcframework')]
end
