//
//  SuccesAlert1.swift
//  CustomAlertView
//
//  Created by Ozan Çiçek on 23.11.2023.
//

import UIKit
import Lottie
import SwiftUI

class SuccesAlert1: UIView {
    
    @IBOutlet var content_view: UIView!
    
    @IBOutlet weak var background_view: UIView!
    
    @IBOutlet weak var alert_view: UIView!
    
    @IBOutlet weak var image_view: UIImageView!
    
    @IBOutlet weak var main_title: UILabel!
    
    @IBOutlet weak var description_title: UILabel!
    
    @IBOutlet weak var ok_button: UIButton!
    
    var animationView: LottieAnimationView?
    
    var isClicked = false
    
    var image: UIImage?
    var mainTitle: String?
    var descriptionTitle: String?
    var completionHandler: (()-> Void)?
    
    
    init(image: UIImage? = nil, mainTitle: String?, descriptionTitle: String?, completionHandler: (() -> Void)? = nil) {
        self.image = image
        self.mainTitle = mainTitle
        self.descriptionTitle = descriptionTitle
        self.completionHandler = completionHandler
        
        
        super.init(frame: UIScreen.main.bounds)
        Bundle.main.loadNibNamed("SuccesAlert1", owner: self, options: nil)
        
        
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    func showAlert(){
        
        if let keyWindow = UIApplication.shared.connectedScenes
            .filter({ $0.activationState == .foregroundActive })
            .map({ $0 as? UIWindowScene })
            .compactMap({ $0 })
            .first?.windows
            .filter({ $0.isKeyWindow }).first {
            keyWindow.addSubview(content_view)
        }
        
        
        
    DispatchQueue.main.asyncAfter(deadline: .now() + 6.0){
        
        if self.isClicked == false {
            UIView.animate(withDuration: 0.3, animations: {
                self.content_view.alpha = 0
            }, completion: { _ in
                self.content_view.removeFromSuperview()
            })
            
            UIView.animate(withDuration: 0.3, animations: {
                self.alert_view.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            }, completion: { _ in
                self.alert_view.removeFromSuperview()
            })
            
            self.completionHandler?()
        }
    }
        
        alertWithAnimation()
        
    }
    
    func alertWithAnimation() {
        background_view.alpha = 0
        alert_view.alpha = 0
        alert_view.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)

        UIView.animate(withDuration: 0.7) {
            self.background_view.alpha = 1
            self.alert_view.alpha = 1
            self.alert_view.transform = CGAffineTransform.identity
        }
    }
    
    
    
    
    func commonInit(){
        setupAlertView()
        setupButton()
        setupContentView()
        setupImage()
        setupLabels()
        setupAnimation()
        tappedBackground()
        
    }
    
    func setupLabels(){
        main_title.text = mainTitle
        description_title.text = descriptionTitle
    }
    
    func setupImage(){
        if let image = image {
            image_view.image = image
        }
    }
    
    
    func setupAlertView(){
        alert_view.layer.shadowColor = UIColor.black.cgColor
        alert_view.layer.shadowOffset = CGSize(width: 0, height: 1)
        alert_view.layer.shadowOpacity = 0.5
        alert_view.layer.shadowRadius = 4.0
        alert_view.layer.cornerRadius = 16
    }
    
    func setupButton(){
        ok_button.setTitle("Ok", for: .normal)
        ok_button.titleLabel?.font = UIFont(name: "HKNova-BoldR", size: 12.0)
      
    }
    
    func setupContentView(){
        content_view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        content_view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    func setupAnimation() {
        
        
        animationView = .init(name: "succes1")
        animationView?.frame = image_view.bounds
        //animationView?.loopMode = .loop
        animationView?.animationSpeed = 0.5
        image_view.addSubview(animationView!)
        animationView?.play()
    }
    
    @IBAction func button_clicked(_ sender: Any) {
        
        self.isClicked = true
        
        UIView.animate(withDuration: 0.3, animations: {
            self.content_view.alpha = 0
        }, completion: { _ in
            self.content_view.removeFromSuperview()
        })
        
        UIView.animate(withDuration: 0.3, animations: {
            self.alert_view.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        }, completion: { _ in
            self.alert_view.removeFromSuperview()
        })
        
        self.completionHandler?()
        
    }
    
    func tappedBackground(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.tappedMethod))
        background_view.addGestureRecognizer(tap)
        background_view.isUserInteractionEnabled = true
    }
    
    @objc func tappedMethod(){
        self.isClicked = true
        
        UIView.animate(withDuration: 0.3, animations: {
            self.content_view.alpha = 0
        }, completion: { _ in
            self.content_view.removeFromSuperview()
        })
        
        UIView.animate(withDuration: 0.3, animations: {
            self.alert_view.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        }, completion: { _ in
            self.alert_view.removeFromSuperview()
        })
        
        self.completionHandler?()
    }
    
    /*
     
     // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
