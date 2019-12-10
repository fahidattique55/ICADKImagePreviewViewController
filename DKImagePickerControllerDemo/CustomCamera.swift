//
//  CustomCamera.swift
//  ICADKImagePickerControllerDemo
//
//  Created by ZhangAo on 16/3/17.
//  Copyright © 2016年 ZhangAo. All rights reserved.
//

import UIKit
import MobileCoreServices

open class CustomUIDelegate: ICADKImagePickerControllerDefaultUIDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
	
	var didCancel: (() -> Void)?
	var didFinishCapturingImage: ((_ image: UIImage) -> Void)?
	var didFinishCapturingVideo: ((_ videoURL: URL) -> Void)?
	
	open override func imagePickerControllerCreateCamera(_ imagePickerController: ICADKImagePickerController,
	                                                       didCancel: @escaping (() -> Void),
	                                                       didFinishCapturingImage: @escaping ((_ image: UIImage) -> Void),
	                                                       didFinishCapturingVideo: @escaping ((_ videoURL: URL) -> Void)
	                                                       ) -> UIViewController {
		self.didCancel = didCancel
		self.didFinishCapturingImage = didFinishCapturingImage
		self.didFinishCapturingVideo = didFinishCapturingVideo
		
		let picker = UIImagePickerController()
		picker.delegate = self
		picker.sourceType = .camera
		picker.mediaTypes = [kUTTypeImage as String, kUTTypeMovie as String]
		
		return picker
	}
	
	// MARK: - UIImagePickerControllerDelegate methods
	
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let mediaType = info[UIImagePickerController.InfoKey.mediaType] as! String
        if mediaType == kUTTypeImage as String {
            let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
            self.didFinishCapturingImage?(image)
        } else if mediaType == kUTTypeMovie as String {
            let videoURL = info[UIImagePickerController.InfoKey.mediaURL] as! URL
            self.didFinishCapturingVideo?(videoURL)
        }
    }
	
	open func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
		self.didCancel?()
	}
	
}
