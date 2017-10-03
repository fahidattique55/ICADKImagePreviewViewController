Pod::Spec.new do |s|
  s.name          = "ICADKImagePickerController"
  s.version       = "3.4.2"
  s.summary       = "It's a Facebook style Image Picker Controller by Swift3."
  s.homepage      = "https://github.com/zhangao0086/DKImagePickerController"
  s.license       = { :type => "MIT", :file => "LICENSE" }
  s.author        = { "Bannings" => "zhangao0086@gmail.com" }
  s.platform      = :ios, "8.0"
  s.source        = { :git => "https://github.com/terenzeyuen/DKImagePickerController.git", 
                     :tag => s.version.to_s }
  s.source_files  = "ICADKImagePickerController/**/*.{h,swift}"

  s.resource      = "ICADKImagePickerController/ICADKImagePickerController.bundle"
  s.frameworks    = "Foundation", "UIKit", "Photos"
  s.requires_arc  = true

  s.pod_target_xcconfig = { 'SWIFT_VERSION' => '3.0' }

  s.subspec 'Camera' do |camera|

    camera.ios.source_files = "ICADKCamera/ICADKCamera.swift"
    camera.resource = "ICADKCamera/ICADKCameraResource.bundle"
  end

  s.subspec 'ImageManager' do |image|

    image.ios.source_files = "ICADKImageManager/**/*.swift"
  end

end
