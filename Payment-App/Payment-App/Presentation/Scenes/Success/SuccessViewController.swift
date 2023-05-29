//
//  SuccessViewController.swift
//  Payment-App
//
//  Created by aleksandre on 29.05.23.
//

import UIKit

final class SuccessViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        let image = UIImage(systemName: "checkmark.circle.fill")
        let imageView = UIImageView(image: image)
        imageView.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        imageView.contentMode = .scaleToFill
        imageView.tintColor = .blue
        imageView.center = self.view.center
        self.view.addSubview(imageView)

    }
}
