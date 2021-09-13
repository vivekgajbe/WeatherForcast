//
//  coreDataStructure.swift
//  WeatherAppDemo
//
//  Created by vivek G on 12/09/21.
//

import UIKit

import Foundation
import CoreData

class coreDataStructure: NSObject {
    //MARK:- core data saving methods for Driver
    func saveCityList(data: [String:Any], completion:@escaping (_ completed:Bool)->Void)
    {
        var coreDataObj : NSManagedObject?
        
        if #available(iOS 10.0, *) {
            let entity = NSEntityDescription.entity(forEntityName: VGConstants.BookmarkCity, in: VGConstants.context)
            coreDataObj = NSManagedObject(entity: entity!, insertInto: VGConstants.context)
            
        } else {
            // Fallback on earlier versions
        }
        
        coreDataObj?.setValue(data[VGConstants.shared.cityName], forKey: VGConstants.shared.cityName)
        coreDataObj?.setValue(data[VGConstants.shared.lat], forKey: VGConstants.shared.lat)
        coreDataObj?.setValue(data[VGConstants.shared.long], forKey: VGConstants.shared.long)
        coreDataObj?.setValue(data[VGConstants.shared.locality], forKey: VGConstants.shared.locality)
        coreDataObj?.setValue(data[VGConstants.shared.postalCode], forKey: VGConstants.shared.postalCode)
        coreDataObj?.setValue(data[VGConstants.shared.country], forKey: VGConstants.shared.country)
      
        ///saving data core data Batch Report
        do {
            if #available(iOS 10.0, *) {
                try VGConstants.context.save()
            } else {
                // Fallback on earlier versions
            }
            print("Data saved successfully")
            completion(true)
        } catch {
            
            print("Failed saving Data")
            completion(false)
        }
    }
    func deleteReminderFor(strPostalCode: String, completion:@escaping (_ completed:Bool)->Void) //-> Bool
    {
        if #available(iOS 10.0, *) {

            let managedContext = VGConstants.APP_DEL.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: VGConstants.BookmarkCity)
            fetchRequest.returnsObjectsAsFaults = false
            do
            {
                let results = try managedContext.fetch(fetchRequest)
                for managedObject in results
                {
                    let managedObjectData:NSManagedObject = managedObject as! NSManagedObject
                    if managedObjectData.value(forKey: VGConstants.shared.postalCode) as? String ?? "" == strPostalCode
                    {
                        managedContext.delete(managedObjectData)
                        
                            try VGConstants.context.save()
                        completion(true)
                    }
                }
            } catch let error as NSError {
                print("Delete all data in \(strPostalCode) error : \(error) \(error.userInfo)")
                completion(false)
            }
        }
    }
    //MARK:- Get all Saved Data from Core data
    func getSavedData(entName :String ,completion:@escaping (_ response:Any?,_ completed:Bool)->Void){
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entName)
        request.returnsObjectsAsFaults = false
        do {
            if #available(iOS 10.0, *) {
                let result = try VGConstants.context.fetch(request)
                completion(result, true)
            } else {
                // Fallback on earlier versions
            }
        } catch {
            print("Failed")
        }
        completion([Any](), false)
    }
}
