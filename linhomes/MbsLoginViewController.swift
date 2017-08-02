//
//  MbsLoginViewController.swift
//  linhomes
//
//  Created by Leon on 7/25/17.
//  Copyright © 2017 linhtek. All rights reserved.
//

import UIKit

class MbsLoginViewController: UIViewController, UITextFieldDelegate {

    //MARK: Properties
    
    @IBOutlet weak var uiTextUsername: UITextField!
    @IBOutlet weak var uiTextPassword: UITextField!
    @IBOutlet weak var uiLabelMissingPass: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let imageView = UIImageView();
        let image = UIImage(named: "ic_id");
        imageView.image = image;
        imageView.frame = CGRect(x: 25, y: 6, width: 18, height: 18)
        uiTextUsername.addSubview(imageView)
//        let leftView = UIView.init(frame: CGRect(x:87, y:0, width:18, height:18))
//        uiTextUsername.leftView = leftView;
        uiTextUsername.leftViewMode = UITextFieldViewMode.always
        
        let imageView2 = UIImageView();
        let image2 = UIImage(named: "ic_password");
        imageView2.image = image2;
        imageView2.frame = CGRect(x: 25, y: 6, width: 18, height: 18)
        uiTextPassword.addSubview(imageView2)
        uiTextPassword.leftViewMode = UITextFieldViewMode.always
        
        let border = CALayer()
        let width = CGFloat(2.0)
        border.borderColor = UIColor(red: 0.921431, green: 0.921453, blue: 0.921441, alpha: 1.0).cgColor
        border.frame = CGRect(x: 0, y: uiTextUsername.frame.size.height - width, width:  uiTextUsername.frame.size.width, height: uiTextUsername.frame.size.height)
        border.borderWidth = width
        uiTextUsername.layer.addSublayer(border)
        uiTextUsername.layer.masksToBounds = true
        
        let border2 = CALayer()
        let width2 = CGFloat(2.0)
        border2.borderColor = UIColor(red: 0.921431, green: 0.921453, blue: 0.921441, alpha: 1.0).cgColor
        border2.frame = CGRect(x: 0, y: uiTextPassword.frame.size.height - width2, width:  uiTextPassword.frame.size.width, height: uiTextPassword.frame.size.height)
        border2.borderWidth = width2
        uiTextPassword.layer.addSublayer(border2)
        uiTextPassword.layer.masksToBounds = true
        
        // delegate
        uiTextUsername.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        uiTextPassword.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        uiTextUsername.delegate = self
        uiTextUsername.returnKeyType = .next
        
        uiTextPassword.delegate = self
        uiTextPassword.returnKeyType = .done
        
        // create test user
        let user = User.init(phone: "mbs", name: "Mobiistar", password: "123", status: 0, sync: 0)
        user.display()
        if !LinhomesDB.instance.checkUserExisted(cphone: user.phone){
            let ret = LinhomesDB.instance.addUser(newUser: user)
            print("Add user \(user.phone) -> \(ret)")
        } else{
            let ret = LinhomesDB.instance.updateUser(cphone: user.phone, newUser: user)
            print("Update user \(user.phone) -> \(ret)")

        }
        
        let tapMissingPass = UITapGestureRecognizer(target: self, action: #selector(handleTapServices))
        uiLabelMissingPass.addGestureRecognizer(tapMissingPass)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == uiTextUsername{
            uiTextPassword.becomeFirstResponder()
        } else{
            textField.resignFirstResponder()
            performLogin()
        }
        return true
    }
    
    func handleTapServices(_ sender: UITapGestureRecognizer) {
        if sender.view == uiLabelMissingPass{
            print("uiLabelMissingPass");
            let VC1 = self.storyboard!.instantiateViewController(withIdentifier: "MissingPassContainerID") as! MbsMissingPassViewController
            let navController = UINavigationController(rootViewController: VC1)
            self.present(navController, animated:true, completion: nil)
        } else{
            print("Hi");
        }
    }
    
    func textFieldDidChange(_ textField: UITextField) {
        let text = textField.text ?? ""
        if text.isEmpty{
            let layer = CALayer()
            layer.frame = CGRect(x: textField.frame.size.width - 18.0, y: 6, width: 18, height: 18)
            layer.contents = UIImage(named: "ic_error")?.cgImage
            layer.name = "ic_error"
            textField.layer.addSublayer(layer)
        } else{
            for layer in textField.layer.sublayers! {
                if layer.name == "ic_error"{
                    layer.removeFromSuperlayer()
                }
            }
        }
    }
    
    // MARK: - Navigation
    
    @IBAction func login(_ sender: UIButton) {
        performLogin()
    }
    
    func performLogin(){
        print("login...")
        let phone = uiTextUsername.text ?? ""
        let password = uiTextPassword.text ?? ""
        
        if phone.isEmpty{
            if (uiTextUsername.layer.sublayers?.count)! < 4{
                let layer = CALayer()
                layer.frame = CGRect(x: uiTextUsername.frame.size.width - 18.0, y: 6, width: 18, height: 18)
                layer.contents = UIImage(named: "ic_error")?.cgImage
                layer.name = "ic_error"
                uiTextUsername.layer.addSublayer(layer)
            }
        }
        if password.isEmpty{
            if (uiTextPassword.layer.sublayers?.count)! < 4{
                let layer = CALayer()
                layer.frame = CGRect(x: uiTextPassword.frame.size.width - 18.0, y: 6, width: 18, height: 18)
                layer.contents = UIImage(named: "ic_error")?.cgImage
                layer.name = "ic_error"
                uiTextPassword.layer.addSublayer(layer)
            }
        }
        
        // perform login
        if !phone.isEmpty && !password.isEmpty{
            
            // initital loading
            let alert = UIAlertController(title: nil, message: "Đang xác thực...", preferredStyle: .alert)
            let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
            loadingIndicator.hidesWhenStopped = true
            loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
            loadingIndicator.startAnimating();
            alert.view.addSubview(loadingIndicator)
            present(alert, animated: true, completion: nil)
            
            // check logged after 3s
            perform(#selector(checkUserLogged), with: nil, afterDelay: 2)
            
            let user = LinhomesDB.instance.getUser(cphone: phone)
            if !user.phone.isEmpty && !user.password.isEmpty{
                if user.password.caseInsensitiveCompare(password) == .orderedSame{
                    user.status = 1
                    let result = LinhomesDB.instance.updateUser(cphone: phone, newUser: user)
                    print("Update user \(user.phone) -> \(result)")
                }
            }
        }
    }
    
    func checkUserLogged() {
        dismiss(animated: false, completion: nil)
        if LinhomesDB.instance.checkUserLogged(){
            print("Login success")
//            dismiss(animated: true, completion: nil)
//            let VC1 = self.storyboard!.instantiateViewController(withIdentifier: "MbsDashboardContainerID") as! MbsDashboardViewController
//            let navController = UINavigationController(rootViewController: VC1)
//            self.present(navController, animated:true, completion: nil)
            
            let mainST = UIStoryboard(name: "Main", bundle: Bundle.main)
            let VC = mainST.instantiateViewController(withIdentifier: "TabBarContainerID")
            present(VC, animated: true, completion: nil)
        } else{
            print("Login fail")
            let alert = UIAlertController(title: "Thông báo", message: "Chưa đăng nhập được!", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }

}
