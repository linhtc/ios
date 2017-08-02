//
//  MbsMissingPassViewController.swift
//  linhomes
//
//  Created by Leon on 7/31/17.
//  Copyright © 2017 linhtek. All rights reserved.
//

import UIKit

class MbsMissingPassViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var uiLabelSuggestion: UILabel!
    @IBOutlet weak var uiTextEmail: UITextField!
    @IBOutlet weak var uiLabelLogin: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        uiLabelSuggestion.lineBreakMode = .byWordWrapping
        uiLabelSuggestion.numberOfLines = 0;
        
        let tapMissingPass = UITapGestureRecognizer(target: self, action: #selector(handleTapServices))
        uiLabelLogin.addGestureRecognizer(tapMissingPass)
        
        let imageView = UIImageView();
        let image = UIImage(named: "ic_mail");
        imageView.image = image;
        imageView.frame = CGRect(x: 25, y: 10, width: 18, height: 12)
        uiTextEmail.addSubview(imageView)
        //        let leftView = UIView.init(frame: CGRect(x:87, y:0, width:18, height:18))
        //        uiTextUsername.leftView = leftView;
        uiTextEmail.leftViewMode = UITextFieldViewMode.always
        let border = CALayer()
        let width = CGFloat(2.0)
        border.borderColor = UIColor(red: 0.921431, green: 0.921453, blue: 0.921441, alpha: 1.0).cgColor
        border.frame = CGRect(x: 0, y: uiTextEmail.frame.size.height - width, width:  uiTextEmail.frame.size.width, height: uiTextEmail.frame.size.height)
        border.borderWidth = width
        uiTextEmail.layer.addSublayer(border)
        uiTextEmail.layer.masksToBounds = true
        
        uiTextEmail.delegate = self
        uiTextEmail.returnKeyType = .done
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        rePassword()
        return true
    }
    
    func handleTapServices(_ sender: UITapGestureRecognizer) {
        if sender.view == uiLabelLogin{
            print("uiLabelLogin");
            dismiss(animated: true, completion: nil)
        } else{
            print("Hi");
        }
    }
    
    @IBAction func repassword(_ sender: UIButton) {
        rePassword()
    }
    
    func rePassword(){
        // initital loading
        let alert = UIAlertController(title: nil, message: "Đang xác thực...", preferredStyle: .alert)
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        loadingIndicator.startAnimating();
        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: nil)
        
        // check logged after 3s
        perform(#selector(requestNewPass), with: nil, afterDelay: 2)
    }
    
    func requestNewPass() {
        dismiss(animated: false, completion: nil)
        print("Login fail")
        let alert = UIAlertController(title: "Thông báo", message: "Thành công! Vui lòng kiểm tra hộp thư", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
