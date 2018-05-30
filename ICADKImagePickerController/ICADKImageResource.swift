//
//  ICADKImageResource.swift
//  ICADKImagePickerController
//
//  Created by ZhangAo on 15/8/11.
//  Copyright (c) 2015年 ZhangAo. All rights reserved.
//

import UIKit

public extension Bundle {
    
  class func imagePickerControllerBundle() -> Bundle {
        let assetPath = Bundle(for: ICADKImageResource.self).resourcePath!
        return Bundle(path: (assetPath as NSString).appendingPathComponent("ICADKImagePickerController.bundle"))!
    }
  class func localisationBundle() -> Bundle {
    let lang = UserDefaults.standard.string(forKey: "LCLCurrentLanguageKey")
    let bundle: Bundle = .main
    
    if lang == nil{
      if let path = bundle.path(forResource: "en", ofType: "lproj"),
        let bundle = Bundle(path: path){
        return bundle
      }
    }
    else{
      if let path = bundle.path(forResource:lang, ofType: "lproj"),
        let bundle = Bundle(path: path){
        return bundle
      }
    }
    return bundle
  }
    
}

public class ICADKImageResource {

    private class func imageForResource(_ name: String) -> UIImage {
        let bundle = Bundle.imagePickerControllerBundle()
        let imagePath = bundle.path(forResource: name, ofType: "png", inDirectory: "Images")
        let image = UIImage(contentsOfFile: imagePath!)
        return image!
    }
	
	private class func stretchImgFromMiddle(_ image: UIImage) -> UIImage {
		let centerX = image.size.width / 2
		let centerY = image.size.height / 2
		return image.resizableImage(withCapInsets: UIEdgeInsets(top: centerY, left: centerX, bottom: centerY, right: centerX))
	}
	
    class func checkedImage() -> UIImage {
		return stretchImgFromMiddle(imageForResource("checked_background"))
    }
    
    class func blueTickImage() -> UIImage {
        return imageForResource("tick_blue")
    }
    
    class func cameraImage() -> UIImage {
        return imageForResource("camera")
    }
    
    class func videoCameraIcon() -> UIImage {
        return imageForResource("video_camera")
    }
	
	class func emptyAlbumIcon() -> UIImage {
		return stretchImgFromMiddle(imageForResource("empty_album"))
	}
    
}

public class DKImageLocalizedString {
    
    public class func localizedStringForKey(_ key: String) -> String {
      return Bundle.localisationBundle().localizedString(forKey: key, value: nil, table: nil)
  }
      
//        return NSLocalizedString(key, tableName: "ICADKImagePickerController", bundle:Bundle.imagePickerControllerBundle(), value: "", comment: "")
 //   }
    
}

public func DKImageLocalizedStringWithKey(_ key: String) -> String {
    return DKImageLocalizedString.localizedStringForKey(key)
}

