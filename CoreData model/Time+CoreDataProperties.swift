//
//  Time+CoreDataProperties.swift
//  Alarm
//
//  Created by Dheepthaa Anand on 23/11/17.
//  Copyright © 2017 Dheepthaa Anand. All rights reserved.
//
//

import Foundation
import CoreData


extension Time {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Time> {
        return NSFetchRequest<Time>(entityName: "Time")
    }

    @NSManaged public var time: String?
    @NSManaged public var label: String?
    @NSManaged public var days: String?
    @NSManaged public var isOn: Bool

}
