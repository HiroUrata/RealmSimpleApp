//
//  Alert.swift
//  RealmTableApp
//
//  Created by UrataHiroki on 2021/07/10.
//

import Foundation
import UIKit


extension ViewController{
    
    func createTextFieldAlert(deleteCellNumber:Int){

       var jpTextField:UITextField?
       var engTextField:UITextField?

       let alert = UIAlertController(title: "変更確認アラート", message:"変更する場合は、値を入力して下さい", preferredStyle: .alert)

       alert.addTextField { (alertJpTextField:UITextField) in

            alertJpTextField.placeholder = "日本語"
            jpTextField = alertJpTextField

       }

       alert.addTextField { (alertEngTextField:UITextField) in

            alertEngTextField.placeholder = "英語"
             engTextField = alertEngTextField

       }

       alert.addAction(UIAlertAction(title: "キャンセル", style: .default, handler: nil))
       
       alert.addAction(UIAlertAction(title: "変更", style: .default, handler: { _ in

            self.realmCRUDModel.updateRealm(updateJp: (jpTextField?.text)!, updateEng: (engTextField?.text)!, selectCell: deleteCellNumber)

            self.realmCRUDModel.readRealm()
            print("成功")
            self.tableView.reloadData()

        }))

        present(alert, animated: true, completion: nil)

   }
    
}
