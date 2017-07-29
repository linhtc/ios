//
//  MbsNotiViewController.swift
//  linhomes
//
//  Created by Leon on 7/27/17.
//  Copyright © 2017 linhtek. All rights reserved.
//

import UIKit

class MbsNotiTableViewCell: UITableViewCell {
    @IBOutlet weak var uiLabelTitle: UILabel!
    @IBOutlet weak var uiLabelSummary: UILabel!
    @IBOutlet weak var uiLabelDate: UILabel!
}

class MbsNotiViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var indexTab = 0
    var fruits: [String] = []
    let cellIdentifier = "CellIdentifier"
    @IBOutlet weak var uiBtnPublic: UIButton!
    @IBOutlet weak var uiBtnPrivate: UIButton!
    @IBOutlet weak var uiTableViewMessage: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // load data to history view
        fruits = ["Apple", "Pineapple", "Orange", "Blackberry", "Banana", "Lemon", "Coconut", "Cherry"]
        
        // resent tab button
        perform(#selector(presentButton), with: nil, afterDelay: 0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    func presentButton(){
        print("present button")
        // present tab button
        let color = UIColor(red: 0.347604, green: 0.718512, blue: 0.896682, alpha: 1.0).cgColor
        let width = CGFloat(4.0)
        let br = CALayer()
        br.borderColor = color
        br.borderWidth = width
        br.frame = CGRect(x: 10.0, y: uiBtnPrivate.frame.size.height - 10.0, width: uiBtnPrivate.frame.size.width - 20.0, height: width)
        uiBtnPrivate.layer.addSublayer(br)
        uiBtnPrivate.layer.masksToBounds = true
        indexTab = 0
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fruits.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let numberOfRows = fruits.count
        return numberOfRows
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath as IndexPath)
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? MbsNotiTableViewCell else {
            fatalError("The dequeued cell is not an instance of MbsNotiTableViewCell.")
        }
        
        let text = fruits[indexPath.row]
        
        // disable separator line
//        tableView.separatorStyle = .none
        cell.layoutMargins = UIEdgeInsets.zero
        cell.separatorInset = UIEdgeInsets.zero
        cell.preservesSuperviewLayoutMargins = false
        
        cell.uiLabelTitle?.text = text+" ipsum dolor sit amet"
        cell.uiLabelSummary?.text = "Lorem ipsum dolor sit amet Consectetur adipiscing elit. Pellentesque et varius ex. Aliquam mauris leo, tempor ac tortor quis, ornare ornare velit. Suspendisse dapibus feugiat tellus at feugiat."
        cell.uiLabelDate?.text = "10:00 AM | 19/09/1993"
        
        // cell.uiLabelSummary.adjustsFontSizeToFitWidth = true
        cell.uiLabelSummary.lineBreakMode = .byWordWrapping
        cell.uiLabelSummary.numberOfLines = 0;
        
//        print(cell.backgroundColor as Any)
        
        if indexPath.row > 3{
            cell.backgroundColor = UIColor(red: 0.898903, green: 0.905574, blue: 0.911905, alpha: 1.0)
        }
        
        return cell
    }
    
    // MARK: - Navigation
    
    @IBAction func privateMessage(_ sender: UIButton) {
        if indexTab > 0{
            if (uiBtnPublic.layer.sublayers?.count)! > 1{
                let ret = uiBtnPublic.layer.sublayers?.popLast()
                print("popLast -> \(String(describing: ret))")
            }
            uiBtnPublic.setTitleColor(UIColor(red: 0.574149, green: 0.574163, blue: 0.574155, alpha: 1.0), for: .normal)
            uiBtnPublic.backgroundColor = UIColor(red: 0.959395, green: 0.959418, blue: 0.959406, alpha: 1.0)
        
            let color = UIColor(red: 0.347604, green: 0.718512, blue: 0.896682, alpha: 1.0).cgColor
            let width = CGFloat(4.0)
            let br = CALayer()
            br.borderColor = color
            br.borderWidth = width
            br.frame = CGRect(x: 10.0, y: uiBtnPrivate.frame.size.height - 10.0, width: uiBtnPrivate.frame.size.width - 20.0, height: width)
            uiBtnPrivate.layer.addSublayer(br)
            uiBtnPrivate.layer.masksToBounds = true
            uiBtnPrivate.backgroundColor = UIColor.white
            uiBtnPrivate.setTitleColor(UIColor(red: 0.347604, green: 0.718512, blue: 0.896682, alpha: 1.0), for: .normal)
            indexTab = 0
            
            fruits = ["Apple", "Pineapple", "Orange", "Blackberry", "Banana", "Lemon", "Coconut", "Cherry"]
            self.uiTableViewMessage.reloadData()
        }
    }
    @IBAction func publicMessage(_ sender: UIButton) {
        if indexTab == 0{
            if (uiBtnPrivate.layer.sublayers?.count)! > 1{
                let ret = uiBtnPrivate.layer.sublayers?.popLast()
                print("popLast -> \(String(describing: ret))")
            }
            uiBtnPrivate.setTitleColor(UIColor(red: 0.574149, green: 0.574163, blue: 0.574155, alpha: 1.0), for: .normal)
            uiBtnPrivate.backgroundColor = UIColor(red: 0.959395, green: 0.959418, blue: 0.959406, alpha: 1.0)
            
            let color = UIColor(red: 0.347604, green: 0.718512, blue: 0.896682, alpha: 1.0).cgColor
            let width = CGFloat(4.0)
            let br = CALayer()
            br.borderColor = color
            br.borderWidth = width
            br.frame = CGRect(x: 10.0, y: uiBtnPublic.frame.size.height - 10.0, width: uiBtnPublic.frame.size.width - 20.0, height: width)
            uiBtnPublic.layer.addSublayer(br)
            uiBtnPublic.layer.masksToBounds = true
            uiBtnPublic.backgroundColor = UIColor.white
            uiBtnPublic.setTitleColor(UIColor(red: 0.347604, green: 0.718512, blue: 0.896682, alpha: 1.0), for: .normal)
            indexTab = 1
            
            fruits = ["Coconut", "Cherry", "Pie", "Pic", "Pu", "Pe", "Pa", "Apple", "Pineapple", "Orange", "Blackberry", "Banana", "Lemon"]
            self.uiTableViewMessage.reloadData()
        }
    }
    
    /*
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
