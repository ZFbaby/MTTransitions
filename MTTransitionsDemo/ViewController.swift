//
//  ViewController.swift
//  MTTransitionsDemo
//
//  Created by xu.shuifeng on 2019/1/24.
//  Copyright © 2019 xu.shuifeng. All rights reserved.
//

import UIKit
import MetalPetal
import MTTransitions

class ViewController: UIViewController {

     private var imageView: MTIImageView!
    
    private var wipeUpTransition: MTTransition?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupImageView()
        setupTransition()
    }
    
    private func setupImageView() {
        imageView = MTIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = resourceImage(named: "1")
        view.addSubview(imageView)
        imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 120).isActive = true
        imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 400.0/512.0).isActive = true
    }
    
    private func setupTransition() {
        wipeUpTransition = MTTransition()
        wipeUpTransition?.inputImage = resourceImage(named: "1")
        wipeUpTransition?.destImage = resourceImage(named: "2")
    }

    @IBAction func buttonTapped(_ sender: Any) {
        
        var progress: Float = 0.0
        let t = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { timer in
            progress += 0.01
            if progress >= 1.0 {
                timer.invalidate()
            }
            print(progress)

            self.wipeUpTransition?.progress = progress
            self.imageView.image = self.wipeUpTransition?.outputImage
        }
        t.fire()
    }
    
    func resourceImage(named: String) -> MTIImage? {
        if let imageUrl = Bundle.main.url(forResource: named, withExtension: "jpg") {
            let ciImage = CIImage(contentsOf: imageUrl)
            return MTIImage(ciImage: ciImage!, isOpaque: true)
        }
        return nil
    }
}
