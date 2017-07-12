//
//  AddPointViewController.swift
//  Alertas10
//
//  Created by Luis Llorente Tovar on 14/6/17.
//  Copyright © 2017 UPM. All rights reserved.
//

import UIKit

class AddPointViewController: UIViewController {
    
    var direccion2 : String!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    @IBAction func addTrackingPoint(){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        print(direccion2!)
//        print(contador)
        let addTrck = [ "jsonrpc": "2.0", "method": "eth_sendTransaction","id": "1","params": [["from": "0x1054665d4c139f467c92f5f97dad9526067e34b0", "to":"0x78b5c6570a2685a17a10b3f646e8f15542233c09","gas":"0x77777", "data": "0xdf178373000000000000000000000000000000000000000000000000000000000000006000000000000000000000000000000000000000000000000000000000000000a000000000000000000000000000000000000000000000000000000000000000e000000000000000000000000000000000000000000000000000000000000000064d616472696400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001310000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000013200000000000000000000000000000000000000000000000000000000000000"]]] as [String : Any]
        
        guard let dataAddTrck = try? JSONSerialization.data(withJSONObject: addTrck) else {
            return
        }
        
        let DATA_URL = "http://localhost:8545"
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
//                                    self.label.text = "addTrackingPoint"
                                    
                                    let alertController = UIAlertController(title: "Gracias", message: "Se ha añadido la nueva localización del producto", preferredStyle: .alert)
                                    
                                    let defaultAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default , handler: nil)
                                    alertController.addAction(defaultAction)
                                    
                                    self.present(alertController, animated: true, completion: nil)
                                    //                                    if resultArr.count > 0 {
                                    //                                        self.accounts += resultArr
                                    //                                    }
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
        
//        contador = contador + 1;
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "addr3" {
            if let vc = segue.destination as? AddPointViewController {
                vc.direccion2 = direccion2!
            }
        }
    }



}
