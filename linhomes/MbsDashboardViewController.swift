//
//  MbsDashboardViewController.swift
//  linhomes
//
//  Created by Leon on 7/25/17.
//  Copyright © 2017 linhtek. All rights reserved.
//

import UIKit

class MbsDashboardViewController: UIViewController {

    //MARK: Properties
    
    var flagCustomLines = false
    
    @IBOutlet weak var uiViewGeneralChild: UIView!
    @IBOutlet weak var uiViewGeneral: UIView!
    @IBOutlet weak var uiViewContract: UIView!
    @IBOutlet weak var uiViewWorkTable: UIView!
    @IBOutlet weak var uiViewAskToOff: UIView!
    @IBOutlet weak var uiViewAskToExtra: UIView!
    
    @IBOutlet weak var uiViewAdvanceChild: UIView!
    @IBOutlet weak var uiViewAdvance: UIView!
    @IBOutlet weak var uiViewBasic: UIView!
    @IBOutlet weak var uiViewStaff: UIView!
    @IBOutlet weak var uiViewSalary: UIView!
    @IBOutlet weak var uiViewApproval: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        perform(#selector(customLines), with: nil, afterDelay: 0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func customLines() {
        if !flagCustomLines{
            flagCustomLines = true
            
            self.uiViewGeneral.layer.borderWidth = 1.0
            self.uiViewGeneral.layer.borderColor = UIColor(red: 0.794417, green: 0.794435, blue: 0.794425, alpha: 1.0).cgColor
            self.uiViewGeneral.layer.cornerRadius = 9.0
            
            //uiViewContract.setNeedsLayout()
            //uiViewContract.layoutIfNeeded()
            let border = CALayer()
            let width = CGFloat(1.0)
            border.borderColor = UIColor(red: 0.794417, green: 0.794435, blue: 0.794425, alpha: 1.0).cgColor
            border.frame = CGRect(x: uiViewContract.frame.size.width - width, y: 0, width: width, height: uiViewContract.bounds.height - 8.0)
            border.borderWidth = width
            uiViewContract.layer.addSublayer(border)
            //uiViewContract.layer.masksToBounds = true
            
            //uiViewWorkTable.setNeedsLayout()
            //uiViewWorkTable.layoutIfNeeded()
            let border2 = CALayer()
            let width2 = CGFloat(1.0)
            border2.borderColor = UIColor(red: 0.794417, green: 0.794435, blue: 0.794425, alpha: 1.0).cgColor
            border2.frame = CGRect(x: uiViewWorkTable.frame.size.width - width2, y: 0, width: width2, height: uiViewWorkTable.frame.size.height - 8.0)
            border2.borderWidth = width2
            uiViewWorkTable.layer.addSublayer(border2)
            //uiViewWorkTable.layer.masksToBounds = true
            
            //uiViewAskToOff.setNeedsLayout()
            //uiViewAskToOff.layoutIfNeeded()
            let border3 = CALayer()
            let width3 = CGFloat(1.0)
            border3.borderColor = UIColor(red: 0.794417, green: 0.794435, blue: 0.794425, alpha: 1.0).cgColor
            border3.frame = CGRect(x: uiViewWorkTable.frame.size.width - width3, y: 8.0, width: width3, height: uiViewAskToOff.frame.size.height - 8.0)
            border3.borderWidth = width3
            uiViewAskToOff.layer.addSublayer(border3)
            uiViewAskToOff.layer.masksToBounds = true
            
            //uiViewAskToExtra.setNeedsLayout()
            //uiViewAskToExtra.layoutIfNeeded()
            let border4 = CALayer()
            let width4 = CGFloat(1.0)
            border4.borderColor = UIColor(red: 0.794417, green: 0.794435, blue: 0.794425, alpha: 1.0).cgColor
            border4.frame = CGRect(x: uiViewAskToExtra.frame.size.width - width4, y: 8.0, width: width4, height: uiViewAskToExtra.frame.size.height - 8.0)
            border4.borderWidth = width4
            uiViewAskToExtra.layer.addSublayer(border4)
            uiViewAskToExtra.layer.masksToBounds = true
            
            
            // sector 2
            
            
            self.uiViewAdvance.layer.borderWidth = 1.0
            self.uiViewAdvance.layer.borderColor = UIColor(red: 0.794417, green: 0.794435, blue: 0.794425, alpha: 1.0).cgColor
            self.uiViewAdvance.layer.cornerRadius = 9.0
            
            //uiViewBasic.setNeedsLayout()
            //uiViewBasic.layoutIfNeeded()
            let border5 = CALayer()
            let width5 = CGFloat(1.0)
            border5.borderColor = UIColor(red: 0.794417, green: 0.794435, blue: 0.794425, alpha: 1.0).cgColor
            border5.frame = CGRect(x: uiViewBasic.frame.size.width - width5, y: 0, width: width5, height: uiViewBasic.frame.size.height - 8.0)
            border5.borderWidth = width5
            uiViewBasic.layer.addSublayer(border5)
            uiViewBasic.layer.masksToBounds = true
            
            //uiViewStaff.setNeedsLayout()
            //uiViewStaff.layoutIfNeeded()
            let border6 = CALayer()
            let width6 = CGFloat(1.0)
            border6.borderColor = UIColor(red: 0.794417, green: 0.794435, blue: 0.794425, alpha: 1.0).cgColor
            border6.frame = CGRect(x: uiViewStaff.frame.size.width - width6, y: 0, width: width6, height: uiViewStaff.frame.size.height - 8.0)
            border6.borderWidth = width6
            uiViewStaff.layer.addSublayer(border6)
            uiViewStaff.layer.masksToBounds = true
            
            //uiViewSalary.setNeedsLayout()
            //uiViewSalary.layoutIfNeeded()
            let border7 = CALayer()
            let width7 = CGFloat(1.0)
            border7.borderColor = UIColor(red: 0.794417, green: 0.794435, blue: 0.794425, alpha: 1.0).cgColor
            border7.frame = CGRect(x: uiViewSalary.frame.size.width - width7, y: 8.0, width: width7, height: uiViewSalary.frame.size.height - 8.0)
            border7.borderWidth = width7
            uiViewSalary.layer.addSublayer(border7)
            uiViewSalary.layer.masksToBounds = true
            
            //uiViewApproval.setNeedsLayout()
            //uiViewApproval.layoutIfNeeded()
            let border8 = CALayer()
            let width8 = CGFloat(1.0)
            border8.borderColor = UIColor(red: 0.794417, green: 0.794435, blue: 0.794425, alpha: 1.0).cgColor
            border8.frame = CGRect(x: uiViewApproval.frame.size.width - width8, y: 8.0, width: width8, height: uiViewApproval.frame.size.height - 8.0)
            border8.borderWidth = width8
            uiViewApproval.layer.addSublayer(border8)
            uiViewApproval.layer.masksToBounds = true        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
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
