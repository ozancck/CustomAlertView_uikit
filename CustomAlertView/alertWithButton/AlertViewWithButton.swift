//
//  AlertViewWithButton.swift
//  CustomAlertView
//
//  Created by Ozan Çiçek on 2.11.2023.
//

import UIKit

class AlertViewWithButton: UIView {

    @IBOutlet var parentView: UIView!
    
    @IBOutlet weak var background: UIView!
    
    @IBOutlet weak var alertView: UIView!
    
    @IBOutlet weak var img: UIImageView!
    
    @IBOutlet weak var mainTitle: UILabel!
    
    @IBOutlet weak var message: UILabel!
    
    @IBOutlet weak var okButton: UIButton!
    
    var buttonClicked = false
    
    
    var image: UIImage?
    var title: String?
    var messageText: String?
    var completionHandler: (() -> Void)?
    
    init( image: UIImage? = UIImage(systemName: "info"), title: String?, messageText: String?, completionHandler: (() -> Void)? = nil) {
        self.image = image
        self.title = title
        self.messageText = messageText
        self.completionHandler = completionHandler
        
        
        
        super.init(frame: UIScreen.main.bounds)
        Bundle.main.loadNibNamed("AlertWithButton", owner: self, options: nil)
        
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit(){
        
        alertView.layer.shadowColor = UIColor.black.cgColor
        alertView.layer.shadowOffset = CGSize(width: 0, height: 1)
        alertView.layer.shadowOpacity = 0.5
        alertView.layer.shadowRadius = 4.0
        alertView.layer.cornerRadius = 16
        
        okButton.setTitle("Tamam", for: .normal)
        okButton.setTitle("Tamam", for: .highlighted)
        okButton.layer.cornerRadius = 24
            
        
        
        
        parentView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        parentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        
    }
    
    
    func showAlert(){
        mainTitle.text = title
        message.text = messageText
        img.image = image
        
        if let keyWindow = UIApplication.shared.connectedScenes
            .filter({ $0.activationState == .foregroundActive })
            .map({ $0 as? UIWindowScene })
            .compactMap({ $0 })
            .first?.windows
            .filter({ $0.isKeyWindow }).first {
            keyWindow.addSubview(parentView)
        }
        
        
        alertWithAnimation()
        self.completionHandler?()

        DispatchQueue.main.asyncAfter(deadline: .now() + 6.0) {
            
            if self.buttonClicked == false {
                
                UIView.animate(withDuration: 0.3, animations: {
                    self.parentView.alpha = 0
                }, completion: { _ in
                    self.parentView.removeFromSuperview()
                })

                UIView.animate(withDuration: 0.3, animations: {
                    self.alertView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
                }, completion: { _ in
                    self.alertView.removeFromSuperview()
                })
            }
            

           
        }
        
        
        
    }
    
    func alertWithAnimation() {
        background.alpha = 0
        alertView.alpha = 0
        alertView.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)

        UIView.animate(withDuration: 0.7) {
            self.background.alpha = 1
            self.alertView.alpha = 1
            self.alertView.transform = CGAffineTransform.identity
        }
    }
    
    
    
    
    @IBAction func button_Clicked(_ sender: Any) {
        
        buttonClicked = true
        
        UIView.animate(withDuration: 0.3, animations: {
            self.parentView.alpha = 0
        }, completion: { _ in
            self.parentView.removeFromSuperview()
        })

        UIView.animate(withDuration: 0.3, animations: {
            self.alertView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        }, completion: { _ in
            self.alertView.removeFromSuperview()
        })
    }
    
    
    
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
