require "json"

package = JSON.parse(File.read(File.join(__dir__, "package.json")))

Pod::Spec.new do |s|
  s.name         = "RNSplashScreen"
  s.version      = package["version"]
  s.summary      = package["description"]
  s.author       = 'taehyun'
  s.homepage     = package["homepage"]
  s.license      = package["license"]
  s.platform     = :ios, "9.0"
  s.source       = { :git => "https://github.com/HwangTaehyun/react-native-lottie-splash-screen", :tag => "v#{s.version}" }
  s.source_files = "ios/**/*.{h,m}"
  s.requires_arc = true
  s.dependency "React-Core"
end
