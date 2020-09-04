//
//  InstrumentEntity.swift
//  Instrument Zoo
//
//  Remixed Ashlee Muscroft on 03/09/20.
//  Copyright © 2020 Ashlee Muscroft. All rights reserved.
//

import RealityKit
// let the entity of a instrument be affected by a tab gesture, you have to enable Modle and collision.
class InstrumentEntity: Entity, HasCollision, HasModel {
    var instrument: InstrumentComponent?
    var animating: Bool = false
    required init() {
        super.init()
    }
    
    convenience init(modelEntity: ModelEntity) {
        self.init()
        // take a reference to the model object and it's transform
        self.model = modelEntity.model
        self.transform = modelEntity.transform
        //scale size in meters, relative to nil makes it relative to absolute space
        setSize(0.8, relativeTo: nil)
        //automatically add a collision Shape and any child models as well.
        generateCollisionShapes(recursive: true)
    }
    
    func scale() {
        var scaleTransform = self.transform
        scaleTransform.scale = [1.5, 1.5, 1.5]
        move(to: scaleTransform, relativeTo: self, duration: 1, timingFunction: .easeInOut)
    }
    
    func shrink() {
        var scaleTransform = self.transform
        scaleTransform.scale = [0.66, 0.66, 0.66]
        // position hack to get the model back in place.
        scaleTransform.translation = .zero
        move(to: scaleTransform, relativeTo: self, duration: 1, timingFunction: .easeInOut)
    }
    
    func makeSound() {
        //get the instrument component and if there's a array of audioFiles randomly choose one to load and play over the audioFile.
        guard let entity = instrument else { return }
        let selectedAudio = entity.audioFiles?.randomElement() ?? entity.audioFile
        
        let audioResource = try! AudioFileResource.load(named: selectedAudio, in: nil, inputMode: .spatial, loadingStrategy: .preload,shouldLoop: false)
        playAudio(audioResource)
        
    }
}
