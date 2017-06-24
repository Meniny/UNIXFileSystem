Pod::Spec.new do |s|
  s.name             = 'UNIXFileSystem'
  s.summary          = 'UNIXFileSystem is an UNIX file system framework for iOS/macOS/tvOS/watchOS platforms.'
  s.version          = '1.0.0'
  s.homepage         = 'https://github.com/Meniny/UNIXFileSystem'
  s.license          = 'MIT'
  s.author           = { "Meniny" => "Meniny@qq.com" }
  s.source           = { :git => "https://github.com/Meniny/UNIXFileSystem.git", :tag => s.version.to_s }
  s.social_media_url = 'https://meniny.cn/'

  s.ios.deployment_target     = '8.0'
  s.osx.deployment_target     = '10.10'
  s.tvos.deployment_target    = '9.0'
  s.watchos.deployment_target = '2.0'

  s.source_files = 'UNIXFileSystem/Source/*.swift'
  s.requires_arc = true
  s.frameworks   = 'Foundation'
end
