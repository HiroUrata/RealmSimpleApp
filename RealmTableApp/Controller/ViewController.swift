//
//  ViewController.swift
//  RealmTableApp
//
//  Created by UrataHiroki on 2021/07/10.
//

import UIKit
import ViewAnimator

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    @IBOutlet weak var japaneseTextField: UITextField!
    @IBOutlet weak var englishTextField: UITextField!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    
    let realmCRUDModel = RealmCRUDModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.realmCRUDModel.readRealm()
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.addButton.layer.cornerRadius = 17.0
        
        tableView.reloadData()
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 65
        
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return realmCRUDModel.readResultRealmArray.count
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let cellJapaneseLabel = cell.contentView.viewWithTag(1) as! UILabel
        let cellEnglishLabel = cell.contentView.viewWithTag(2) as! UILabel
        
        cellJapaneseLabel.text = self.realmCRUDModel.readResultRealmArray[indexPath.row]["RealmJp"]
        cellEnglishLabel.text = self.realmCRUDModel.readResultRealmArray[indexPath.row]["RealmEng"]
        
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == UITableViewCell.EditingStyle.delete {
            
            self.realmCRUDModel.selectDeleteRealm(selectCell: indexPath.row)
            self.tableView.deleteRows(at: [indexPath as IndexPath], with: .automatic)
            self.tableView.reloadData()
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.createTextFieldAlert(deleteCellNumber: indexPath.row)
        
    }
    
    
//追加ボタン処理
    @IBAction func add(_ sender: Any) {
        
        self.realmCRUDModel.createRealm(createJp: japaneseTextField.text!, createEng: englishTextField.text!)
        
        self.japaneseTextField.text = ""
        self.englishTextField.text = ""
    
        self.realmCRUDModel.readRealm()
        self.tableView.reloadData()
        
    }
    
    
//Realmに保存してあるデータを全て削除
    @IBAction func allDelete(_ sender: Any) {
        
        self.realmCRUDModel.allDeleteRealm()
        self.tableView.reloadData()
        
    }
    
}
