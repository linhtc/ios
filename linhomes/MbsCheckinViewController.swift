//
//  MbsCheckinViewController.swift
//  linhomes
//
//  Created by Leon on 7/26/17.
//  Copyright © 2017 linhtek. All rights reserved.
//

import UIKit
import CoreLocation

class MbsCheckinTableViewCell: UITableViewCell {
    @IBOutlet weak var uiLabelDate: UILabel!
    @IBOutlet weak var uiViewContainerIn: UIView!
    @IBOutlet weak var uiViewContainerTimeIn: UIView!
    @IBOutlet weak var uiLabelTimeIn: UILabel!
    @IBOutlet weak var uiLabelAddressLongIn: UILabel!
    @IBOutlet weak var uiLabelAddressShortIn: UILabel!
    
    @IBOutlet weak var uiViewContainerOut: UIView!
    @IBOutlet weak var uiViewContainerTimeOut: UIView!
    @IBOutlet weak var uiLabelTimeOut: UILabel!
    @IBOutlet weak var uiLabelAddressShortOut: UILabel!
    @IBOutlet weak var uiLabelAddressLongOut: UILabel!
    

}

class MbsCheckinViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, CLLocationManagerDelegate {

    //MARK: Properties
    
    var durationFlag = false
    var addressLong = ""
    var addressShort = ""
    var fruits: [String] = []
    var currLat = 0.0
    var currLong = 0.0
    let cellIdentifier = "CellIdentifier"
    let locationMgr = CLLocationManager()
    
    @IBOutlet weak var uiImageMap: UIImageView!
    @IBOutlet weak var uiScrollView: UIScrollView!
    @IBOutlet weak var uiLabelAddressShort: UILabel!
    @IBOutlet weak var uiLabelAddressLong: UILabel!
    @IBOutlet weak var uiButtonCheckin: UIImageView!
    
    let alert = UIAlertController(title: nil, message: "Đang định vị...", preferredStyle: .alert)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // load data to history view
        fruits = ["Apple", "Pineapple", "Orange"]
        
        // 1
        let status  = CLLocationManager.authorizationStatus()
        
        // 2
        if status == .notDetermined {
            locationMgr.requestWhenInUseAuthorization()
            return
        }
        
        // 3
        if status == .denied || status == .restricted {
            let alert = UIAlertController(title: "Location Services Disabled", message: "Please enable Location Services in Settings", preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)
            
            present(alert, animated: true, completion: nil)
            return
        }
        
        // 4
        locationMgr.delegate = self
        locationMgr.startUpdatingLocation()
        
        // show loading
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        loadingIndicator.startAnimating();
        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: nil)

        // load map to view
        perform(#selector(loadMap), with: nil, afterDelay: 0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
//        uiScrollView.contentSize = CGSize(width: 1.0, height: 1200.0)
//        self.automaticallyAdjustsScrollViewInsets = false
        
    }
    
    // 1
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let currentLocation = locations.last!
        print("Current location: \(currentLocation)")
        currLat = currentLocation.coordinate.latitude
        currLong = currentLocation.coordinate.longitude
        print("Lat: \(currLat), Long: \(currLong)")
        
    }
    
    // 2
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error \(error)")
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self) {
                if CLLocationManager.isRangingAvailable() {
                    // show loading
                    let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
                    loadingIndicator.hidesWhenStopped = true
                    loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
                    loadingIndicator.startAnimating();
                    alert.view.addSubview(loadingIndicator)
                    self.present(alert, animated: true, completion: nil)
                    
                    // load map to view
                    perform(#selector(loadMap), with: nil, afterDelay: 0)
                }
            }
        }
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
    
    func customLines(cell: MbsCheckinTableViewCell) {
        
        let tableWidth = cell.uiViewContainerIn.frame.size.width
        let color = UIColor(red: 0.347604, green: 0.718512, blue: 0.896682, alpha: 1.0).cgColor
        let width = CGFloat(1.0)
        let br = CALayer()
        br.borderColor = color
        br.borderWidth = width
        br.frame = CGRect(x: tableWidth - width, y: 0, width: width, height: cell.uiViewContainerIn.frame.size.height)
        
        let bt = CALayer()
        bt.borderColor = color
        bt.borderWidth = width
        bt.frame = CGRect(x: 35.0, y: 0, width: tableWidth - 35.0 - width, height: width)
        
        let bb = CALayer()
        bb.borderColor = color
        bb.borderWidth = width
        bb.frame = CGRect(x: 0, y: cell.uiViewContainerIn.frame.size.height - width, width: tableWidth - width, height: width)
        
        let bl = CALayer()
        bl.borderColor = color
        bl.borderWidth = width
        bl.frame = CGRect(x: 0, y: 35.0, width: width, height: cell.uiViewContainerIn.frame.size.height - 35.0)
        
        let bl1 = CALayer()
        bl1.borderColor = color
        bl1.borderWidth = width
        bl1.frame = CGRect(x: 0, y: 0, width: width, height: 10.0)
        
        let bl2 = CALayer()
        bl2.borderColor = color
        bl2.borderWidth = width
        bl2.frame = CGRect(x: 0, y: 15.0, width: width, height: 5.0)
        
        let bl3 = CALayer()
        bl3.borderColor = color
        bl3.borderWidth = width
        bl3.frame = CGRect(x: 0, y: 25.0, width: width, height: 5.0)
        
        let br1 = CALayer()
        br1.borderColor = color
        br1.borderWidth = width
        br1.frame = CGRect(x: 0, y: 0, width: 10.0, height: width)
        
        let br2 = CALayer()
        br2.borderColor = color
        br2.borderWidth = width
        br2.frame = CGRect(x: 15.0, y: 0, width: 5.0, height: width)
        
        let br3 = CALayer()
        br3.borderColor = color
        br3.borderWidth = width
        br3.frame = CGRect(x: 25.0, y: 0, width: 5.0, height: width)
        
        cell.uiViewContainerIn.layer.addSublayer(br)
        cell.uiViewContainerIn.layer.addSublayer(bt)
        cell.uiViewContainerIn.layer.addSublayer(bb)
        cell.uiViewContainerIn.layer.addSublayer(bl)
        cell.uiViewContainerIn.layer.addSublayer(bl1)
        cell.uiViewContainerIn.layer.addSublayer(bl2)
        cell.uiViewContainerIn.layer.addSublayer(bl3)
        cell.uiViewContainerIn.layer.addSublayer(br1)
        cell.uiViewContainerIn.layer.addSublayer(br2)
        cell.uiViewContainerIn.layer.addSublayer(br3)
        cell.uiViewContainerIn.layer.masksToBounds = true
        
        let rectShape = CAShapeLayer()
        rectShape.bounds = cell.uiViewContainerTimeIn.frame
        rectShape.position = cell.uiViewContainerTimeIn.center
        let trianglePath = UIBezierPath()
        trianglePath.move(to: CGPoint(x: 0.0, y: 0.0))
        trianglePath.addLine(to: CGPoint(x: 0.0, y: 0.0))
        trianglePath.addLine(to: CGPoint(x: cell.uiViewContainerTimeIn.bounds.width, y: 0.0))
        trianglePath.addLine(to: CGPoint(x: cell.uiViewContainerTimeIn.bounds.width, y: cell.uiViewContainerTimeIn.bounds.height))
        trianglePath.addLine(to: CGPoint(x: 10.0, y: cell.uiViewContainerTimeIn.bounds.height))
        rectShape.path = trianglePath.cgPath
        
        cell.uiViewContainerTimeIn.layer.backgroundColor = color
        cell.uiViewContainerTimeIn.layer.mask = rectShape
        
        // column check out
        
        let bro = CALayer()
        bro.borderColor = color
        bro.borderWidth = width
        bro.frame = CGRect(x: tableWidth - width, y: 0, width: width, height: cell.uiViewContainerOut.frame.size.height)
        
        let bto = CALayer()
        bto.borderColor = color
        bto.borderWidth = width
        bto.frame = CGRect(x: 35.0, y: 0, width: tableWidth - 35.0, height: width)
        
        let bbo = CALayer()
        bbo.borderColor = color
        bbo.borderWidth = width
        bbo.frame = CGRect(x: 0, y: cell.uiViewContainerOut.frame.size.height - width, width: tableWidth, height: width)
        
        let blo = CALayer()
        blo.borderColor = color
        blo.borderWidth = width
        blo.frame = CGRect(x: 0, y: 35.0, width: width, height: cell.uiViewContainerOut.frame.size.height - 35.0)
        
        let bl1o = CALayer()
        bl1o.borderColor = color
        bl1o.borderWidth = width
        bl1o.frame = CGRect(x: 0, y: 0, width: width, height: 10.0)
        
        let bl2o = CALayer()
        bl2o.borderColor = color
        bl2o.borderWidth = width
        bl2o.frame = CGRect(x: 0, y: 15.0, width: width, height: 5.0)
        
        let bl3o = CALayer()
        bl3o.borderColor = color
        bl3o.borderWidth = width
        bl3o.frame = CGRect(x: 0, y: 25.0, width: width, height: 5.0)
        
        let br1o = CALayer()
        br1o.borderColor = color
        br1o.borderWidth = width
        br1o.frame = CGRect(x: 0, y: 0, width: 10.0, height: width)
        
        let br2o = CALayer()
        br2o.borderColor = color
        br2o.borderWidth = width
        br2o.frame = CGRect(x: 15.0, y: 0, width: 5.0, height: width)
        
        let br3o = CALayer()
        br3o.borderColor = color
        br3o.borderWidth = width
        br3o.frame = CGRect(x: 25.0, y: 0, width: 5.0, height: width)
        
        cell.uiViewContainerOut.layer.addSublayer(bro)
        cell.uiViewContainerOut.layer.addSublayer(bto)
        cell.uiViewContainerOut.layer.addSublayer(bbo)
        cell.uiViewContainerOut.layer.addSublayer(blo)
        cell.uiViewContainerOut.layer.addSublayer(bl1o)
        cell.uiViewContainerOut.layer.addSublayer(bl2o)
        cell.uiViewContainerOut.layer.addSublayer(bl3o)
        cell.uiViewContainerOut.layer.addSublayer(br1o)
        cell.uiViewContainerOut.layer.addSublayer(br2o)
        cell.uiViewContainerOut.layer.addSublayer(br3o)
        cell.uiViewContainerOut.layer.masksToBounds = true
        
        let rectShapeo = CAShapeLayer()
        rectShapeo.bounds = cell.uiViewContainerTimeOut.frame
        rectShapeo.position = cell.uiViewContainerTimeOut.center
        let trianglePatho = UIBezierPath()
        trianglePatho.move(to: CGPoint(x: 0.0, y: 0.0))
        trianglePatho.addLine(to: CGPoint(x: 0.0, y: 0.0))
        trianglePatho.addLine(to: CGPoint(x: cell.uiViewContainerTimeOut.bounds.width, y: 0.0))
        trianglePatho.addLine(to: CGPoint(x: cell.uiViewContainerTimeOut.bounds.width, y: cell.uiViewContainerTimeOut.bounds.height))
        trianglePatho.addLine(to: CGPoint(x: 10.0, y: cell.uiViewContainerTimeOut.bounds.height))
        rectShapeo.path = trianglePatho.cgPath
        
        cell.uiViewContainerTimeOut.layer.backgroundColor = color
        cell.uiViewContainerTimeOut.layer.mask = rectShapeo
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath as IndexPath)
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? MbsCheckinTableViewCell else {
            fatalError("The dequeued cell is not an instance of MbsCheckinTableViewCell.")
        }
        
        // disable separator line
        tableView.separatorStyle = .none
        
        // Fetch Fruit
//        let fruit = fruits[indexPath.row]
//        print(fruit)
        // Configure Cell
//        cell.textLabel?.text = fruit
        cell.uiLabelDate?.text = "Thứ 2, 01/01/9999"
        
        cell.uiLabelAddressShortIn?.text = "40 Phạm Ngọc Thạch"
        cell.uiLabelAddressShortIn.sizeToFit()
        cell.uiLabelAddressLongIn?.text = "Phường 6, Quận 3, Hồ Chí Minh"
        cell.uiLabelAddressLongIn.sizeToFit()
        cell.uiLabelTimeIn?.text = "08:00 AM"
        
        cell.uiLabelAddressShortOut?.text = "41 Thạch Ngọc Phạm"
        cell.uiLabelAddressShortOut.sizeToFit()
        cell.uiLabelAddressLongOut?.text = "Phường 3, Quận 6, Hồ Chí Minh"
        cell.uiLabelAddressLongOut.sizeToFit()
        cell.uiLabelTimeOut?.text = "05:30 PM"
        
        perform(#selector(customLines), with: cell, afterDelay: 0)
        
        return cell
    }
    
    func loadMap(){
        print("loadMap...")
//        let lat = currLat// 10.785092
//        let long = currLong// 106.6913373
        
        let lat = currLat// 10.785092
        let long = currLong// 106.6913373
        
        let staticMapUrl: String = "http://maps.google.com/maps/api/staticmap?markers=color:red|\(lat),\(long)&\("zoom=16&size=\(1 * Int(uiImageMap.frame.size.width))x\(1 * Int(uiImageMap.frame.size.height))")&sensor=true"
        print(staticMapUrl)
        let url = URL(string: staticMapUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
        
        do {
            let data = try NSData(contentsOf: url!, options: NSData.ReadingOptions())
            uiImageMap.image = UIImage(data: data as Data)
        } catch {
            uiImageMap.image = UIImage()
        }
        
        // get street, district, ...
        let requestURL: NSURL = NSURL(string: "https://maps.googleapis.com/maps/api/geocode/json?latlng=\(lat),\(long)&key=AIzaSyBKHUXIZMUPwiRMru_6bLPQ74yg4gNoIjA")!
        let urlRequest: NSMutableURLRequest = NSMutableURLRequest(url: requestURL as URL)
        let session = URLSession.shared
        let task = session.dataTask(with: urlRequest as URLRequest) {
            (data, response, error) -> Void in
            
            let httpResponse = response as! HTTPURLResponse
            let statusCode = httpResponse.statusCode
            
            if (statusCode == 200) {
                print("Everyone is fine, file downloaded successfully.")
                if let jsonObj = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSDictionary {
                    
                    //printing the json in console
                    //                    print(jsonObj!.value(forKey: "results")!)
                    
                    //getting the avengers tag array from json and converting it to NSArray
                    if let heroeArray = jsonObj!.value(forKey: "results") as? NSArray {
                        //looping through all the elements
                        for heroe in heroeArray{
                            
                            //converting the element to a dictionary
                            if let heroeDict = heroe as? NSDictionary {
                                
                                // get address component
                                if let addressComponents = heroeDict.value(forKey: "address_components") as? NSArray {
                                    for component in addressComponents{
                                        if let componentDict = component as? NSDictionary {
                                            if let shortName = componentDict.value(forKey: "short_name") {
                                                print(shortName as! String)
                                            }
                                        }
                                    }
                                }
                                
                                //getting the name from the dictionary
                                if let name = heroeDict.value(forKey: "formatted_address") {
                                    print(name as! String)
                                    if self.addressShort.isEmpty && self.addressLong.isEmpty{
                                        let string = name as? String ?? ""
                                        let needle: Character = ","
                                        if let idx = string.characters.index(of: needle) {
                                            let pos = string.characters.distance(from: string.startIndex, to: idx)
                                            print("Found \(needle) at position \(pos)")
                                            self.addressShort = (string as NSString).substring(to: pos)
                                            self.addressLong = (string as NSString).substring(from: pos + 2)
                                        }
                                    }
                                }
                            }
                        }
                    }
                    
                    OperationQueue.main.addOperation({
                        //calling another function after fetching the json
                        //it will show the names to label
                        print("queue -> \(self.addressShort) => \(self.addressLong)")
                        self.dismiss(animated: false, completion: nil)
                        
                        self.uiLabelAddressShort.text = self.addressShort
                        self.uiLabelAddressLong.text = self.addressLong
                        
                        // animation uiimage button
                        let destinationY:CGFloat = self.uiImageMap.bounds.height - 160 // Your destination Y
                        UIView.animate(withDuration: 0.3, delay: 1.0, options: [UIViewAnimationOptions.curveLinear], animations: {
                            self.uiButtonCheckin.center.y = destinationY
                        }, completion: nil)
                        let destinationY2:CGFloat = self.uiImageMap.bounds.height - 140 // Your destination Y
                        UIView.animate(withDuration: 0.3, delay: 1.3, options: [UIViewAnimationOptions.curveLinear], animations: {
                            self.uiButtonCheckin.center.y = destinationY2
                        }, completion: nil)
                        let destinationY3:CGFloat = self.uiImageMap.bounds.height - 160 // Your destination Y
                        UIView.animate(withDuration: 0.3, delay: 1.6, options: [UIViewAnimationOptions.curveLinear], animations: {
                            self.uiButtonCheckin.center.y = destinationY3
                        }, completion: nil)
                        let destinationY4:CGFloat = self.uiImageMap.bounds.height - 140 // Your destination Y
                        UIView.animate(withDuration: 0.3, delay: 1.9, options: [UIViewAnimationOptions.curveLinear], animations: {
                            self.uiButtonCheckin.center.y = destinationY4
                        }, completion: nil)
                        let destinationY5:CGFloat = self.uiImageMap.bounds.height - 160 // Your destination Y
                        UIView.animate(withDuration: 0.3, delay: 2.2, options: [UIViewAnimationOptions.curveLinear], animations: {
                            self.uiButtonCheckin.center.y = destinationY5
                        }, completion: nil)
                        let destinationY6:CGFloat = self.uiImageMap.bounds.height - 140 // Your destination Y
                        UIView.animate(withDuration: 0.3, delay: 2.5, options: [UIViewAnimationOptions.curveLinear], animations: {
                            self.uiButtonCheckin.center.y = destinationY6
                        }, completion: nil)
                    })
                }
            } else  {
                print("Failed")
            }
        }
        task.resume()
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
