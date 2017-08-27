Pod::Spec.new do |s|
  s.name = 'Quickly'
  s.version = '0.0.1'
  s.homepage = 'http://www.globus-ltd.com'
  s.summary = 'Globus components for iOS'
  s.license = { :type => 'MIT', :file => 'LICENSE' }
  s.author = {
    'Alexander Trifonov' => 'a.trifonov@globus-ltd.com'
  }
  s.source = {
    :git => 'https://github.com/fgengine/quickly.git',
    :tag => s.version.to_s
  }
  s.ios.deployment_target = '8.0'
  s.requires_arc = true

  s.public_header_files = 'Quickly/**/*.{h}'
  s.source_files = 'Quickly/**/*.{swift,m}'
  s.ios.frameworks = 'Foundation'
  s.ios.frameworks = 'UIKit'
end
