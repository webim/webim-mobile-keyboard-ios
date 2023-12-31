Pod::Spec.new do |s|
  s.name             = 'WebimKeyboard'
  s.version          = '1.0.2'
  s.summary          = 'Webim.ru keyboard module'

  s.homepage         = 'https://webim.ru/integration/mobile-sdk/ios-sdk-howto/'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Webim.ru Ltd' => 'webimdev@gmail.com' }
  s.source           = { :git => 'https://github.com/webim/webim-mobile-keyboard-ios.git', :tag => s.version.to_s }
  s.swift_version = '5.5'
  s.ios.deployment_target = '10.0'
  s.source_files = 'WebimKeyboard/**/*'
  
end
