//
//  ViewController.swift
//  KeyChainShareApp2
//
//  Created by Ashwin Ganesh on 4/15/19.
//  Copyright © 2019 Arwin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var outputTextField: UITextField?
    let keychainAccessGroupName = "ZY26UYFWUF.arwinKeyChainShareGroup1"
    let itemKey = "InputAttribute"
    
    @IBAction func getData(sender: UIButton) {
        let queryLoad: [String: AnyObject] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: itemKey as AnyObject,
            kSecReturnData as String: kCFBooleanTrue,
            kSecMatchLimit as String: kSecMatchLimitOne,
            kSecAttrAccessGroup as String: keychainAccessGroupName as AnyObject
        ]
        
        var result: AnyObject?
        
        let resultCodeLoad = withUnsafeMutablePointer(to: &result) {
            SecItemCopyMatching(queryLoad as CFDictionary, UnsafeMutablePointer($0))
        }
        
        if resultCodeLoad == noErr {
            if let result = result as? Data,
                let keyValue = NSString(data: result,
                                        encoding: String.Encoding.utf8.rawValue) as String? {
                
                // Found successfully
                print(keyValue)
                outputTextField?.text = keyValue
            }
        } else {
            print("Error loading from Keychain: \(resultCodeLoad)")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


}

