//
//  ViewController.swift
//  textToImageDemo
//
//  Created by Harmis 1 on 22/11/18.
//  Copyright © 2018 harmis technology. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
	
	
	@IBOutlet weak var txtItem: UITextField!
	@IBOutlet weak var imgItem: UIImageView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
	}
	
	@IBAction func btnCreateImageAction(_ sender: Any) {
		self.imgItem.image = textToImage(drawText: txtItem.text!, inImage: UIImage(named: "imageWithoutText")!)
		
	}
	
	func textToImage(drawText text: String, inImage image: UIImage) -> UIImage {
		let textColor = UIColor.green
		let textFont = UIFont(name: "Helvetica Bold", size: 12)!
		
		let scale = UIScreen.main.scale
		UIGraphicsBeginImageContextWithOptions(image.size, false, scale)
		
		let text_style = NSMutableParagraphStyle()
		text_style.alignment = NSTextAlignment.center
		
		let textFontAttributes = [
			NSAttributedString.Key.font: textFont,
			NSAttributedString.Key.foregroundColor: textColor,
			NSAttributedString.Key.paragraphStyle:text_style
			] as [NSAttributedString.Key : Any]
		image.draw(in: CGRect(origin: CGPoint.zero, size: image.size))
		
		let height = text.height(withConstrainedWidth: image.size.width, font: textFont)
		let text_rect = CGRect(x: 0, y: (image.size.height - height)/2, width: image.size.width, height: image.size.height)
		text.draw(in: text_rect.integral, withAttributes: textFontAttributes)
		let result = UIGraphicsGetImageFromCurrentImageContext()
		UIGraphicsEndImageContext()
		return result!
	}
}

extension String {
	func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
		let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
		let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
		return ceil(boundingBox.height)
	}
	
	func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
		let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
		let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
		return ceil(boundingBox.width)
	}
}
