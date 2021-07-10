//
//  RealmCURDModel.swift
//  RealmTableApp
//
//  Created by UrataHiroki on 2021/07/10.
//

import Foundation
import RealmSwift

class RealmCRUDModel{
    
    var readResultRealmArray:[[String:String]] = []  //取得した値を入れる配列
    
}


extension RealmCRUDModel{ //Realmに保存
    
    func createRealm(createJp:String,createEng:String){
        
        do{
            let realm = try Realm()
            let realmDatas = RealmDatas()
            
            realmDatas.japanese = createJp
            realmDatas.english = createEng
            
            try realm.write({
                
                realm.add(realmDatas)
                
            })
            
        }catch{
            
            print(error.localizedDescription)
            
        }
    }
}


extension RealmCRUDModel{ //Realmのデータを取得
    
    func readRealm(){
        
        do{
            let realm = try Realm()
            self.readResultRealmArray = [] //取得済みの値を一度空にする
            
            for resultData in realm.objects(RealmDatas.self){
                
                self.readResultRealmArray.append(["RealmJp":resultData.japanese,"RealmEng":resultData.english])
                
            }
            
        }catch{
            
            print(error.localizedDescription)
            
        }
    }
}


extension RealmCRUDModel{  //Realmのデータを更新
    
    func updateRealm(updateJp:String,updateEng:String,selectCell:Int){
        
        do{
            let realm = try Realm()
            let readRealm = realm.objects(RealmDatas.self)
            
            try realm.write({
                
                if (updateJp.isEmpty && updateEng.isEmpty) != true{
                    
                    readRealm[selectCell].japanese = updateJp
                    readRealm[selectCell].english = updateEng
                    self.readRealm()  //データに変更が加わったので、取得をやり直す
                
                }else if updateJp.isEmpty != true && updateEng.isEmpty == true{
                    
                    readRealm[selectCell].japanese = updateJp
                    self.readRealm()  //データに変更が加わったので、取得をやり直す
                    
                }else{
                    
                    readRealm[selectCell].english = updateEng
                    self.readRealm()  //データに変更が加わったので、取得をやり直す
                    
                }
            })
            
        }catch{
            
            print(error.localizedDescription)
            
        }
    }
}


extension RealmCRUDModel{  //Realmのデータを全て削除
    
    func allDeleteRealm(){
        
        do{
            let realm = try Realm()
            
            try realm.write({
                
                realm.delete(realm.objects(RealmDatas.self))
                self.readResultRealmArray = []
                
            })
            
        }catch{
            
            print(error.localizedDescription)
            
        }
    }
}


extension RealmCRUDModel{  //Realmの選択したデータを削除
    
    func selectDeleteRealm(selectCell:Int){
        
        do{
            let realm = try Realm()
            
            try realm.write({
                
                realm.delete(realm.objects(RealmDatas.self)[selectCell])
                self.readResultRealmArray.remove(at: selectCell)
                
            })
            
        }catch{
            
            print(error.localizedDescription)
            
        }
        
    }
    
}
