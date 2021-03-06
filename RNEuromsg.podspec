
Pod::Spec.new do |s|
  package = JSON.parse(File.read(File.join(__dir__, 'package.json')))
  s.name         = "RNEuromsg"
  s.version      = package['version']
  s.summary      = "RNEuromsg"
  s.description  = <<-DESC
                  RNEuromsg
                   DESC
  s.homepage     = "https://github.com/saitbnzl/ReactNativeEuromsg@readme"
  s.license      = "MIT"
  # s.license      = { :type => "MIT", :file => "FILE_LICENSE" }
  s.author             = { "saitbnzl" => "saitbnzl@gmail.com" }
  s.platform     = :ios, '8.0'
  s.source       = { :git => "https://github.com/saitbnzl/ReactNativeEuromsg.git", :tag => "v#{s.version}" }
  s.source_files = "ios/**/*.{h,m}"

  s.dependency "React"
end