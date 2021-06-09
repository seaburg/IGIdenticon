Pod::Spec.new do |s|
  s.name                =  "IGIdenticon"
  s.version             =  "0.8.0"
  s.summary             =  "Swift identicon generator"
  s.description         =  "This library is a port of [identicon](https://github.com/donpark/identicon) library that generates identicon."
  s.homepage            =  "https://github.com/Seaburg/IGIdenticon"
  s.screenshots         =  "https://raw.github.com/seaburg/IGIdenticon/master/Screenshot/screenshot.png"
  s.license             =  { :type => "MIT", :file => "LICENSE" }
  s.author              =  { "Evgeniy Yurtaev" => "evgeniyyurt@gmail.com" }
  s.platform            =  :ios, "9.0"
  s.source              =  { :git => "https://github.com/seaburg/IGIdenticon.git", :tag => "0.8.0" }
  s.source_files        =  "Identicon/*.swift"
  s.framework           =  "CoreGraphics"
  s.requires_arc        =  true
  s.swift_versions      =  ["5.0", "5.1", "5.2", "5.3"]
end
