require "json"

package = JSON.parse(File.read(File.join(__dir__, "package.json")))

Pod::Spec.new do |s|
  s.name         = package["name"]
  s.version      = package["version"]
  s.summary      = package["description"]
  s.homepage     = package["homepage"]
  s.license      = package["license"]
  s.authors      = package["author"]

  s.platform              = :ios, '13.0'
  s.ios.deployment_target = '13.0'
  s.requires_arc          = true
  s.static_framework      = true

  s.source       = { :git => "https://github.com/jasondavis87/ffmpeg-kit-react-native-local.git" }
  s.source_files = 'ios/*.{h,m}'

  s.dependency "React-Core"

  # Bundled FFmpeg frameworks (included in this package via Git LFS)
  s.vendored_frameworks = 'ios/Frameworks/*.xcframework'

  # System frameworks required by FFmpeg
  s.frameworks = 'AudioToolbox', 'AVFoundation', 'CoreMedia', 'VideoToolbox'

  # System libraries required by FFmpeg
  s.libraries = 'z', 'bz2', 'iconv'

  # Header search paths using $(PODS_TARGET_SRCROOT) which reliably points to this pod's source
  s.pod_target_xcconfig = {
    'HEADER_SEARCH_PATHS' => [
      '"$(PODS_TARGET_SRCROOT)/ios/Frameworks/ffmpegkit.xcframework/ios-arm64/ffmpegkit.framework/Headers"',
      '"$(PODS_TARGET_SRCROOT)/ios/Frameworks/ffmpegkit.xcframework/ios-arm64_x86_64-simulator/ffmpegkit.framework/Headers"'
    ].join(' ')
  }
end
