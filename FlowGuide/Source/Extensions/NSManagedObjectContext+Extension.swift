//
//  NSManagedObject+Extension.swift
//  CoreAppRedesign_iPhone
//
//  Created by Talish George on 17/01/2020.
//  Copyright © 2020 KLM. All rights reserved.
//

import Foundation
import CoreData

extension NSManagedObjectContext {
  public func insert<T: NSManagedObject>(_ type: T.Type) -> T? {
    let entityName = T.description()
    let entity = NSEntityDescription.insertNewObject(forEntityName: entityName, into: self)
    return entity as? T
  }
}
