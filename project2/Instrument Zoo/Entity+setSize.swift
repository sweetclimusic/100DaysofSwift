//
//  Entity+setSize.swift
//  Instrument Zoo
//
//  Remixed Ashlee Muscroft on 1/16/20.
//  Copyright © 2020 Ashlee Muscroft. All rights reserved.
//

import RealityKit

extension Entity {
    func setSize(_ size: Float, relativeTo entity: Entity?) {
        let currentSize = self.visualBounds(recursive: true, relativeTo: entity, excludeInactive: false).extents.max()
        let scaleFactor = size / currentSize
        setScale([scaleFactor, scaleFactor, scaleFactor], relativeTo: entity)
    }
}
