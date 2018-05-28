//
//  ICADKImagePickerControllerDefaultUIDelegate.swift
//  ICADKImagePickerControllerDemo
//
//  Created by ZhangAo on 16/3/7.
//  Copyright © 2016年 ZhangAo. All rights reserved.
//

import UIKit

@objc
open class ICADKImagePickerControllerDefaultUIDelegate: NSObject, ICADKImagePickerControllerUIDelegate {
	
	open weak var imagePickerController: ICADKImagePickerController!
	
	open var doneButton: UIButton?
	
	open func createDoneButtonIfNeeded() -> UIButton {
        if self.doneButton == nil {
            let button = UIButton(type: UIButtonType.custom)
            button.setTitleColor(UINavigationBar.appearance().tintColor ?? self.imagePickerController.navigationBar.tintColor, for: .normal)
            button.addTarget(self.imagePickerController, action: #selector(ICADKImagePickerController.done), for: UIControlEvents.touchUpInside)
            self.doneButton = button
            self.updateDoneButtonTitle(button)
        }
		
		return self.doneButton!
	}
    
  open func updateDoneButtonTitle(_ button: UIButton) {
    if self.imagePickerController.selectedAssets.count > 0 {
      button.setTitle(DKImageLocalizedStringWithKey("kDoneText"), for: .normal)
    } else {
      button.setTitle(DKImageLocalizedStringWithKey(""), for: .normal)
    }
    
    button.sizeToFit()
  }
	
	// Delegate methods...
	
	open func prepareLayout(_ imagePickerController: ICADKImagePickerController, vc: UIViewController) {
		self.imagePickerController = imagePickerController
		vc.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: self.createDoneButtonIfNeeded())
	}
    
	open func imagePickerControllerCreateCamera(_ imagePickerController: ICADKImagePickerController,
	                                              didCancel: @escaping (() -> Void),
	                                              didFinishCapturingImage: @escaping ((_ image: UIImage) -> Void),
	                                              didFinishCapturingVideo: @escaping ((_ videoURL: URL) -> Void)) -> UIViewController {
		
		let camera = ICADKCamera()
		
		camera.didCancel = { () -> Void in
			didCancel()
		}
		
		camera.didFinishCapturingImage = { (image) in
			didFinishCapturingImage(image)
		}
		
		self.checkCameraPermission(camera)
	
		return camera
	}
	
	open func layoutForImagePickerController(_ imagePickerController: ICADKImagePickerController) -> UICollectionViewLayout.Type {
		return ICADKAssetGroupGridLayout.self
	}
	
	open func imagePickerController(_ imagePickerController: ICADKImagePickerController,
                                  showsCancelButtonForVC vc: UIViewController) {

    let cancelBtn =  UIBarButtonItem(title: DKImageLocalizedStringWithKey("KCancelText"), style: .plain, target: imagePickerController, action: #selector(imagePickerController.dismiss as () -> Void))
    let attributes = [NSForegroundColorAttributeName : UIColor.white]
    
    cancelBtn.setTitleTextAttributes(attributes, for: .normal)
    vc.navigationItem.leftBarButtonItem =  cancelBtn
  }
	
	open func imagePickerController(_ imagePickerController: ICADKImagePickerController,
	                                  hidesCancelButtonForVC vc: UIViewController) {
		vc.navigationItem.leftBarButtonItem = nil
	}
	
	open func imagePickerController(_ imagePickerController: ICADKImagePickerController, didSelectAsset: ICADKAsset) {
		self.updateDoneButtonTitle(self.createDoneButtonIfNeeded())
	}
    
    open func imagePickerController(_ imagePickerController: ICADKImagePickerController, didSelectAssets: [ICADKAsset]) {
        self.updateDoneButtonTitle(self.createDoneButtonIfNeeded())
    }
	
	open func imagePickerController(_ imagePickerController: ICADKImagePickerController, didDeselectAsset: ICADKAsset) {
		self.updateDoneButtonTitle(self.createDoneButtonIfNeeded())
	}
    
    open func imagePickerController(_ imagePickerController: ICADKImagePickerController, didDeselectAssets: [ICADKAsset]) {
        self.updateDoneButtonTitle(self.createDoneButtonIfNeeded())
    }
	
  open func imagePickerControllerDidReachMaxLimit(_ imagePickerController: ICADKImagePickerController) {
    let alert = UIAlertController(title: DKImageLocalizedStringWithKey("maxImg"), message:String(format: "\(DKImageLocalizedStringWithKey("youCanAddMaximumOf")) \(imagePickerController.maxSelectableCount) \(DKImageLocalizedStringWithKey("imagesPerListing"))"), preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: DKImageLocalizedStringWithKey("KOKText"), style: .cancel) { _ in })
    imagePickerController.present(alert, animated: true) {}
  }
	
	open func imagePickerControllerFooterView(_ imagePickerController: ICADKImagePickerController) -> UIView? {
		return nil
	}
    
    open func imagePickerControllerCameraImage() -> UIImage {
        return ICADKImageResource.cameraImage()
    }
    
    open func imagePickerControllerCheckedNumberColor() -> UIColor {
        return UIColor.white
    }
    
    open func imagePickerControllerCheckedNumberFont() -> UIFont {
        return UIFont.boldSystemFont(ofSize: 14)
    }
    
    open func imagePickerControllerCheckedImageTintColor() -> UIColor? {
        return nil
    }
    
    open func imagePickerControllerCollectionViewBackgroundColor() -> UIColor {
        return UIColor.white
    }
    
    open func selectedLabelPosition() -> DKCheckedLabelPosition {
        return .defaultPosition
    }
    
    open func shouldUseCheckedImage() -> Bool {
        return true
    }

	// Internal
	
	public func checkCameraPermission(_ camera: ICADKCamera) {
		func cameraDenied() {
			DispatchQueue.main.async {
				let permissionView = ICADKPermissionView.permissionView(.camera)
				camera.cameraOverlayView = permissionView
			}
		}
		
		func setup() {
			camera.cameraOverlayView = nil
		}
		
		ICADKCamera.checkCameraPermission { granted in
			granted ? setup() : cameraDenied()
		}
	}
		
}
