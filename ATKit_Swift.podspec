Pod::Spec.new do |s|
  s.name             = 'ATKit_Swift'
  s.version          = '0.1.8'
  s.summary          = 'Some classes and class category commonly used in iOS rapid development'
  s.description      = <<-DESC
                       Some classes and class category commonly used in iOS rapid development.
                       DESC
  s.homepage         = 'http://blog.cocoachina.com/227971'
  s.license          = 'MIT'
  s.author           = { 'tianya2416' => '1203123826@qq.com' } 
  s.source           = { :git => 'https://github.com/tianya2416/ATKit_Swift.git', :tag => s.version }
  s.requires_arc = true
  s.ios.deployment_target = '10.0'
  s.source_files     = 'Source/*.swift'
  s.swift_version    = '5.0'
  
end

