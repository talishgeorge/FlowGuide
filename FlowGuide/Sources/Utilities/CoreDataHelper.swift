//
//  CoreDataHelper.swift
//  FlowGuide
//
//  Created by Talish George on 22/05/20.
//  Copyright © 2020 Talish George. All rights reserved.
//

import CoreData

@objcMembers final class CoreDataHelper: NSObject {
    
    static func getObjectsForEntity(_ entityName: String,
                                    andContext managedObjectContext: NSManagedObjectContext,
                                    withPredicate predicate: NSPredicate? = nil,
                                    withSortKey sortKey: String? = nil,
                                    isAscending sortAscending: Bool = false,
                                    withNoFaults: Bool = false) -> [NSManagedObject]? {

        let fetchRequest = self.fetchRequest(forEntity: entityName, withContext: managedObjectContext)
        fetchRequest.returnsObjectsAsFaults = withNoFaults
        if let predicate = predicate {
            fetchRequest.predicate = predicate
        }
        if let sortKey = sortKey {
            let sortDescriptor = NSSortDescriptor(key: sortKey, ascending: sortAscending)
            fetchRequest.sortDescriptors = [sortDescriptor]
        }
        do {
            guard let result = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject] else {
                return nil
            }
            return result
        } catch _ as NSError {
            return nil
        }
    }

    static func countForEntity(_ entityName: String,
                               andContext managedObjectContext: NSManagedObjectContext,
                               withPredicate predicate: NSPredicate? = nil) -> Int {

        let fetchRequest = self.fetchRequest(forEntity: entityName, withContext: managedObjectContext)
        fetchRequest.includesPropertyValues = false
        if let predicate = predicate {
            fetchRequest.predicate = predicate
        }
        do {
            let count = try managedObjectContext.count(for: fetchRequest)
            return count
        } catch let _ as NSError {
            return 0
        }
    }

    static func deleteAllObjectsForEntity(_ entityName: String,
                                          andContext managedObjectContext: NSManagedObjectContext,
                                          withPredicate predicate: NSPredicate? = nil) {

        let fetchRequest = self.fetchRequest(forEntity: entityName, withContext: managedObjectContext)
        fetchRequest.includesPropertyValues = false
        if let predicate = predicate {
            fetchRequest.predicate = predicate
        }
        do {
            if let result = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject] {
                for managedObject in result {
                    managedObjectContext.delete(managedObject)
                }
            }
        } catch _ as NSError {
        }
    }

    static private func fetchRequest(forEntity entityName: String,
                                     withContext context: NSManagedObjectContext) -> NSFetchRequest<NSFetchRequestResult> {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>()
        let entityDescription = NSEntityDescription.entity(forEntityName: entityName, in: context)
        fetchRequest.entity = entityDescription
        return fetchRequest
    }
}
