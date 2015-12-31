//
//  NSManagedObjectRestKitExtensions.swift
//  BMHelper
//
//  Created by John Kueh on 1/01/2016.
//  Copyright © 2016 Beaconmaker. All rights reserved.
//
// Examples
// ------------------------------
// User.rk_findAll()
// User.rk_findAllSortedBy(sortTerm: "id", ascending: true)
// User.rk_findAllWithPredicate(predicate: predicate)
// User.rk_findByAttribute(attribute: "active", searchValue: true, orderedBy: "id", ascending: true)

import Foundation
import RestKit

extension NSManagedObject {
    class func rk_setupFetchRequest() -> (NSFetchRequest, NSManagedObjectContext) {
        let context = RKManagedObjectStore.defaultStore().mainQueueManagedObjectContext
        
        let fetchRequest = NSFetchRequest()
        let entity = NSEntityDescription.entityForName(NSStringFromClass(self), inManagedObjectContext: context)
        
        fetchRequest.entity = entity
        
        return (fetchRequest, context)
    }
    
    class func rk_findAll() -> Array<AnyObject> {
        let (fetchRequest, context) = self.rk_setupFetchRequest()
        
        var results:Array<AnyObject>
        
        do {
            results = try context.executeFetchRequest(fetchRequest)
            
        } catch {
            results = []
        }
        
        return results
    }
    
    class func rk_findAllSortedBy(sortTerm: String, ascending: Bool) -> Array<AnyObject> {
        let (fetchRequest, context) = self.rk_setupFetchRequest()
        
        let sortDescriptor:NSSortDescriptor = NSSortDescriptor(key: sortTerm, ascending: ascending)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        var results:Array<AnyObject>
        
        do {
            results = try context.executeFetchRequest(fetchRequest)
            
        } catch {
            results = []
        }
        
        return results
    }
    
    class func rk_findAllWithPredicate(predicate: NSPredicate) -> Array<AnyObject> {
        let (fetchRequest, context) = self.rk_setupFetchRequest()
    
        fetchRequest.predicate = predicate
        
        var results:Array<AnyObject>
        
        do {
            results = try context.executeFetchRequest(fetchRequest)
            
        } catch {
            results = []
        }
        
        return results
    }
    
    class func rk_findByAttribute(attribute: String, value:AnyObject, orderedBy: String, ascending: Bool) -> Array<AnyObject> {
        let (fetchRequest, context) = self.rk_setupFetchRequest()
        let sortDescriptor:NSSortDescriptor = NSSortDescriptor(key: orderedBy, ascending: ascending)
        let predicate:NSPredicate = NSPredicate(format: "%K = %@", attribute, value.stringValue)
        
        fetchRequest.sortDescriptors = [sortDescriptor]
        fetchRequest.predicate = predicate
        
        var results:Array<AnyObject>
        
        do {
            results = try context.executeFetchRequest(fetchRequest)
            
        } catch {
            results = []
        }
        
        return results
    }
}
