Pod::Spec.new do |s|
 
  s.name         = "WZYKeyboard"
  s.version      = "1.0.0"
  s.summary      = "An easy to use keyboard, you can get sent content and keyboard up and down callback."
  s.description  = <<-DESC
An easy to use keyboard, you can get sent content and keyboard up and down callback.
                   DESC
  s.homepage     = "https://github.com/CoderZYWang/WZYKeyboard"
  s.license      = "MIT"
  s.author             = { "CoderZYWang" => "294250051@qq.com" }
  s.social_media_url   = "http://blog.csdn.net/felicity294250051"
  s.platform     = :ios
  s.source       = { :git => "https://github.com/CoderZYWang/WZYKeyboard.git", :tag => "1.0.0" }
  s.source_files  = "WZYKeyboard/*.{h,m,swift}"
  s.frameworks = 'UIKit', 'Foundation'
  s.requires_arc = true
end
