require "json"

package = JSON.parse(File.read(File.join(__dir__, "package.json")))

# Resolve the absolute path to FFmpeg frameworks at pod install time
# From node_modules/ffmpeg-kit-react-native/ -> ../../ffmpeg/ios/
ffmpeg_ios_path = File.expand_path('../../ffmpeg/ios', __dir__)

# Validate frameworks exist at pod install time
unless Dir.exist?(ffmpeg_ios_path)
  Pod::UI.warn "FFmpeg frameworks directory not found at: #{ffmpeg_ios_path}"
  Pod::UI.warn "Please ensure xcframeworks are placed in your app's ffmpeg/ios/ directory"
end

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

  s.source       = { :git => "https://github.com/jasondavis87/ffmpeg-kit-react-native.git" }
  s.source_files = 'ios/**/*.{h,m}'

  s.dependency "React-Core"

  # Vendored frameworks - resolved at pod install time
  s.vendored_frameworks = Dir[File.join(ffmpeg_ios_path, '*.xcframework')]

  # System frameworks required by FFmpeg
  s.frameworks = 'AudioToolbox', 'AVFoundation', 'CoreMedia', 'VideoToolbox'

  # System libraries required by FFmpeg
  s.libraries = 'z', 'bz2', 'iconv'

  # Header search paths for direct imports (#import "FFmpegKitConfig.h")
  s.pod_target_xcconfig = {
    'HEADER_SEARCH_PATHS' => [
      "\"#{ffmpeg_ios_path}/ffmpegkit.xcframework/ios-arm64/ffmpegkit.framework/Headers\"",
      "\"#{ffmpeg_ios_path}/ffmpegkit.xcframework/ios-arm64_x86_64-simulator/ffmpegkit.framework/Headers\""
    ].join(' ')
  }
end
