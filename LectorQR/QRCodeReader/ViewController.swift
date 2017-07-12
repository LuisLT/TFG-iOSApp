//
//  ViewController.swift
//  Alertas10
//
//  Created by Luis Llorente Tovar on 10/6/17.
//  Copyright © 2017 UPM. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var address : String!
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var name: UITextView!
    @IBOutlet weak var company: UITextView!
    
    @IBOutlet weak var off: UIImageView!
    @IBOutlet weak var on: UIImageView!
    
    @IBOutlet weak var lab: UILabel!
    @IBOutlet weak var alert: UITextView!
    
    var counter = 0
    var urlD = "http://95.60.130.50:8545"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        getName()
//        getCompany()
//        off.alpha = 1
        on.alpha = 1
        lab.text = address!
        
//        showEnable()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func recharge(){
        getName()
        getCompany()
        off.alpha = 1
        on.alpha = 1
        showEnable()
    }
    @IBAction func getName(){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        let name = [ "jsonrpc":"2.0", "method": "eth_call", "params": [[ "from": "0x1054665d4c139f467c92f5f97dad9526067e34b0", "to": address! , "data": "0x06fdde03"],"latest"], "id": counter] as [String : Any]
        
        guard let dataName = try? JSONSerialization.data(withJSONObject: name) else {
            return
        }
        
        let DATA_URL = urlD
        let url = URL(string: DATA_URL)!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json; charset=utf-8",forHTTPHeaderField: "Content-Type")
        
        
        let sessionConf = URLSessionConfiguration.ephemeral
        let session = URLSession(configuration: sessionConf)
        
        let uploadTask = session.uploadTask(with: request, from: dataName) { (data: Data?, response: URLResponse?, error: Error?) in
            DispatchQueue.main.async {
                if error != nil {
                    self.title = "Error"
                    print("Error 1: \(error?.localizedDescription)")
                } else {
                    let code = (response as! HTTPURLResponse).statusCode
                    if code != 200 {
                        self.title = "Error"
                        print("Error 2: \(HTTPURLResponse.localizedString(forStatusCode: code))")
                    } else {
                        // Extraer el array de datos del JSON
                        do {
                            if let dic = try JSONSerialization.jsonObject(with: data!) as? [String:Any] {
                                if let resultArr = dic["result"] as! String! {
                                    
                                    let sssaa = self.dataWithHexString(hex: resultArr)
                                    let str2: String! = String(data: sssaa,
                                                               encoding: String.Encoding.utf8)
                                    
                                    self.label.text = "Información"
                                    self.name.text = str2!
                                    
                                    
                                } else {
                                    self.title = "Error"
                                    print("Error 5: El JSON es rarito.")
                                }
                            }
                        } catch let err as NSError {
                            self.title = "Error"
                            print("Error 3: \(err.localizedDescription)")
                        } catch {
                            self.title = "Error"
                            print("Error 4")
                        }
                    }
                }
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
        }
        uploadTask.resume()
        
        counter += 1;
    }
    @IBAction func getCompany(){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        let company = [ "jsonrpc":"2.0", "method": "eth_call", "params": [[ "from": "0x1054665d4c139f467c92f5f97dad9526067e34b0", "to": address! , "data": "0x6904c94d"],"latest"], "id": counter] as [String : Any]
        
        guard let dataCompany = try? JSONSerialization.data(withJSONObject: company) else {
            return
        }
        
        let DATA_URL = urlD
        let url = URL(string: DATA_URL)!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json; charset=utf-8",forHTTPHeaderField: "Content-Type")
        
        let sessionConf = URLSessionConfiguration.ephemeral
        let session = URLSession(configuration: sessionConf)
        
        let uploadTask = session.uploadTask(with: request, from: dataCompany) { (data: Data?, response: URLResponse?, error: Error?) in
            DispatchQueue.main.async {
                if error != nil {
                    self.title = "Error"
                    print("Error 1: \(error?.localizedDescription)")
                } else {
                    let code = (response as! HTTPURLResponse).statusCode
                    if code != 200 {
                        self.title = "Error"
                        print("Error 2: \(HTTPURLResponse.localizedString(forStatusCode: code))")
                    } else {
                        // Extraer el array de datos del JSON
                        do {
                            if let dic = try JSONSerialization.jsonObject(with: data!) as? [String:Any] {
                                if let resultArr = dic["result"] as! String! {
                                    
                                    let sssaa = self.dataWithHexString(hex: resultArr)
                                    let str2: String! = String(data: sssaa,
                                                               encoding: String.Encoding.utf8)
                                    
                                    self.company.text = str2!
                                    
                                } else {
                                    self.title = "Error"
                                    print("Error 5: El JSON es rarito.")
                                }
                            }
                        } catch let err as NSError {
                            self.title = "Error"
                            print("Error 3: \(err.localizedDescription)")
                        } catch {
                            self.title = "Error"
                            print("Error 4")
                        }
                    }
                }
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
        }
        uploadTask.resume()
        
        counter += 1;
    }
    
    
    @IBAction func getNalerts(){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        let alert = [ "jsonrpc":"2.0", "method": "eth_call", "params": [[ "from": "0x1054665d4c139f467c92f5f97dad9526067e34b0", "to": address! , "data": "0xf49eb670"],"latest"], "id": counter] as [String : Any]
        
        guard let dataAlerts = try? JSONSerialization.data(withJSONObject: alert) else {
            return
        }
        
        let DATA_URL = urlD
        let url = URL(string: DATA_URL)!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json; charset=utf-8",forHTTPHeaderField: "Content-Type")
        
        
        let sessionConf = URLSessionConfiguration.ephemeral
        let session = URLSession(configuration: sessionConf)
        
        let uploadTask = session.uploadTask(with: request, from: dataAlerts) { (data: Data?, response: URLResponse?, error: Error?) in
            DispatchQueue.main.async {
                if error != nil {
                    self.title = "Error"
                    print("Error 1: \(error?.localizedDescription)")
                } else {
                    let code = (response as! HTTPURLResponse).statusCode
                    if code != 200 {
                        self.title = "Error"
                        print("Error 2: \(HTTPURLResponse.localizedString(forStatusCode: code))")
                    } else {
                        // Extraer el array de datos del JSON
                        do {
                            if let dic = try JSONSerialization.jsonObject(with: data!) as? [String:Any] {
                                //                                print("dic", dic)
                                if let resultArr = dic["result"] as! String! {
                                    
                                    if resultArr != "0x0000000000000000000000000000000000000000000000000000000000000000"{
                                        let alert = UIAlertController(title : " Alerta", message: "Este producto contiene elementos nocivos para la salud", preferredStyle: UIAlertControllerStyle.alert)
                                        alert.addAction(UIAlertAction(title: "WARNING" , style : .destructive))
                                        
                                        
                                        self.present(alert, animated: true, completion : nil)
                                        
                                        self.label.text="ALERTA"
                                    } else{
                                        let alertController = UIAlertController(title: "Apto", message: "Este producto es apto para el consumo", preferredStyle: .alert)
                                        
                                        let defaultAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default , handler: nil)
                                        alertController.addAction(defaultAction)
                                        
                                        self.present(alertController, animated: true, completion: nil)
                                        self.label.text="APTO"
                                    }
                                } else {
                                    self.title = "Error"
                                    print("Error 5: El JSON es rarito.")
                                }
                            }
                        } catch let err as NSError {
                            self.title = "Error"
                            print("Error 3: \(err.localizedDescription)")
                        } catch {
                            self.title = "Error"
                            print("Error 4")
                        }
                    }
                }
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
            
        }
        uploadTask.resume()
        
        counter += 1;
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        let alertName = [ "jsonrpc":"2.0", "method": "eth_call", "params": [[ "from": "0x1054665d4c139f467c92f5f97dad9526067e34b0", "to": address! , "data": "0x171d073a0000000000000000000000000000000000000000000000000000000000000000"],"latest"], "id": counter] as [String : Any]
        
        guard let dataAlertName = try? JSONSerialization.data(withJSONObject: alertName) else {
            return
        }
        
        let uploadTask2 = session.uploadTask(with: request, from: dataAlertName) { (data: Data?, response: URLResponse?, error: Error?) in
            DispatchQueue.main.async {
                if error != nil {
                    self.title = "Error"
                    print("Error 1: \(error?.localizedDescription)")
                } else {
                    let code = (response as! HTTPURLResponse).statusCode
                    if code != 200 {
                        self.title = "Error"
                        print("Error 2: \(HTTPURLResponse.localizedString(forStatusCode: code))")
                    } else {
                        // Extraer el array de datos del JSON
                        do {
                            if let dic = try JSONSerialization.jsonObject(with: data!) as? [String:Any] {
                                print("dicAlerta", dic)
                                if let resultArr = dic["result"] as! String! {
                                    
                                    let sssaa = self.dataWithHexString(hex: resultArr)
                                    let str2: String! = String(data: sssaa,
                                                               encoding: String.Encoding.utf8)
                                    self.alert.text = "\(str2!) "
                                    
                                } else {
                                    self.title = "Error"
                                    print("Error 5: El JSON es rarito.")
                                }
                            }
                        } catch let err as NSError {
                            self.title = "Error"
                            print("Error 3: \(err.localizedDescription)")
                        } catch {
                            self.title = "Error"
                            print("Error 4")
                        }
                    }
                }
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
        }
        uploadTask2.resume()
        
        counter += 1;
        
    }
    
    @IBAction func addTrackingPoint(){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        let addTrck = [ "jsonrpc": "2.0", "method": "eth_sendTransaction","id": counter,"params": [["from": "0x1054665d4c139f467c92f5f97dad9526067e34b0", "to":address!,"gas":"0x77777", "data": "0xdf178373000000000000000000000000000000000000000000000000000000000000006000000000000000000000000000000000000000000000000000000000000000a000000000000000000000000000000000000000000000000000000000000000e000000000000000000000000000000000000000000000000000000000000000064d616472696400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001310000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000013200000000000000000000000000000000000000000000000000000000000000"]]] as [String : Any]
        
        guard let dataAddTrck = try? JSONSerialization.data(withJSONObject: addTrck) else {
            return
        }
        
        let DATA_URL = urlD
        let url = URL(string: DATA_URL)!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json; charset=utf-8",forHTTPHeaderField: "Content-Type")
        
        
        let sessionConf = URLSessionConfiguration.ephemeral
        let session = URLSession(configuration: sessionConf)
        
        let uploadTask = session.uploadTask(with: request, from: dataAddTrck) { (data: Data?, response: URLResponse?, error: Error?) in
            DispatchQueue.main.async {
                if error != nil {
                    self.title = "Error"
                    print("Error 1: \(error?.localizedDescription)")
                } else {
                    let code = (response as! HTTPURLResponse).statusCode
                    if code != 200 {
                        self.title = "Error"
                        print("Error 2: \(HTTPURLResponse.localizedString(forStatusCode: code))")
                    } else {
                        // Extraer el array de datos del JSON
                        do {
                            print(data!)
                            if let dic = try JSONSerialization.jsonObject(with: data!) as? [String:Any] {
                                print("dic", dic)
                                if let resultArr = dic["result"] as! String! {
                                    print("addLocat",resultArr)
                                    self.label.text = "Localización enviada"
                                    self.title = "Producto"
                                } else {
                                    self.title = "Error"
                                    print("Error 5: El JSON es rarito.")
                                }
                            }
                        } catch let err as NSError {
                            self.title = "Error"
                            print("Error 3: \(err.localizedDescription)")
                        } catch {
                            self.title = "Error"
                            print("Error 4")
                        }
                    }
                }
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
        }
        uploadTask.resume()
        
        counter += 1;
    }
    
    
    @IBAction func changeToOff(){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        let off = ["jsonrpc": "2.0", "method": "eth_sendTransaction","id": counter,"params": [["from": "0x1054665d4c139f467c92f5f97dad9526067e34b0", "to": address!, "gas":"0x77777","data": "0x275949fe"]]] as [String : Any]
        
        guard let dataOff = try? JSONSerialization.data(withJSONObject: off) else {
            return
        }
        
        let DATA_URL = urlD
        let url = URL(string: DATA_URL)!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json; charset=utf-8",forHTTPHeaderField: "Content-Type")
        
        let sessionConf = URLSessionConfiguration.ephemeral
        let session = URLSession(configuration: sessionConf)
        
        let uploadTask = session.uploadTask(with: request, from: dataOff) { (data: Data?, response: URLResponse?, error: Error?) in
            DispatchQueue.main.async {
                if error != nil {
                    self.title = "Error"
                    print("Error 1: \(error?.localizedDescription)")
                } else {
                    let code = (response as! HTTPURLResponse).statusCode
                    if code != 200 {
                        self.title = "Error"
                        print("Error 2: \(HTTPURLResponse.localizedString(forStatusCode: code))")
                    } else {
                        // Extraer el array de datos del JSON
                        do {
                            if let dic = try JSONSerialization.jsonObject(with: data!) as? [String:Any] {
                                if let resultArr = dic["result"] as! String! {
                                    self.label.text = "OFF"
                                    let offAlert = UIAlertController(title: "Dar de baja", message: "Se va a dar de baja el producto", preferredStyle: UIAlertControllerStyle.alert)
                                    
                                    offAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
                                        print("Handle Cancel Logic here")
                                    }))
                                    
                                    
                                    offAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                                        print("Handle Ok logic here")
                                    }))
                                    
                                    
                                    self.present(offAlert, animated: true, completion: nil)
                                    
                                } else {
                                    self.title = "Error"
                                    print("Error 5: El JSON es rarito.")
                                }
                            }
                        } catch let err as NSError {
                            self.title = "Error"
                            print("Error 3: \(err.localizedDescription)")
                        } catch {
                            self.title = "Error"
                            print("Error 4")
                        }
                    }
                }
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
        }
        uploadTask.resume()
        
        counter += 1;
    }
    
    func showEnable(){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        let enabled = [ "jsonrpc":"2.0", "method": "eth_call", "params": [[ "from": "0x1054665d4c139f467c92f5f97dad9526067e34b0", "to": address! , "data": "0x02fb0c5e"],"latest"], "id": counter] as [String : Any]
        
        guard let dataEnabled = try? JSONSerialization.data(withJSONObject: enabled) else {
            return
        }
        
        let DATA_URL = urlD
        let url = URL(string: DATA_URL)!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json; charset=utf-8",forHTTPHeaderField: "Content-Type")
        
        let sessionConf = URLSessionConfiguration.ephemeral
        let session = URLSession(configuration: sessionConf)
        
        let uploadTask = session.uploadTask(with: request, from: dataEnabled) { (data: Data?, response: URLResponse?, error: Error!) in
            DispatchQueue.main.async {
                if error != nil {
                    self.title = "Error"
                    print("Error 1: \(error.localizedDescription)")
                } else {
                    let code = (response as! HTTPURLResponse).statusCode
                    if code != 200 {
                        self.title = "Error"
                        print("Error 2: \(HTTPURLResponse.localizedString(forStatusCode: code))")
                    } else {
                        // Extraer el array de datos del JSON
                        do {
                            if let dic = try JSONSerialization.jsonObject(with: data!) as? [String:Any] {
                                
                                if let resultArr = dic["result"] as! String! {
                                    if (resultArr == "0x0000000000000000000000000000000000000000000000000000000000000000"){
                                        self.on.alpha = 0;
                                    }else{
                                        self.off.alpha = 0;
                                    }
                                    
                                } else {
                                    self.title = "Error"
                                    print("Error 5: El JSON es rarito.")
                                }
                            }
                        } catch let err as NSError {
                            self.title = "Error"
                            print("Error 3: \(err.localizedDescription)")
                        } catch {
                            self.title = "Error"
                            print("Error 4")
                        }
                    }
                }
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
        }
        uploadTask.resume()
        
        counter += 1;
    }
    
    
    
    //convierte hexadecimal a ascii
    private func dataWithHexString(hex: String) -> Data {
        var hex = hex
        var data = Data()
        while(hex.characters.count > 0) {
            let c: String = hex.substring(to: hex.index(hex.startIndex, offsetBy: 2))
            hex = hex.substring(from: hex.index(hex.startIndex, offsetBy: 2))
            var ch: UInt32 = 0
            Scanner(string: c).scanHexInt32(&ch)
            var char = UInt8(ch)
            data.append(&char, count: 1)
        }
        return data
    }
    
}

