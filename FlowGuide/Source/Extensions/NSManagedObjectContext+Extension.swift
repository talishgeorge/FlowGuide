//
//  PresenterManager.swift
//  FlowGuide
//
//  Created by Talish George on 22/05/20.
//  Copyright © 2020 Talish George. All rights reserved.
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
