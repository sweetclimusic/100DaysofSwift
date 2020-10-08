//
//  ViewController.swift
//  Instrument Zoo
//
//  Remixed Ashlee Muscroft on 03/09/20.
//  Copyright © 2020 Ashlee Muscroft. All rights reserved.
//

import Combine
import Lottie
import RealityKit
import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var arView: ARView!
    // 70cm spacing
    let xCoordinates: [Float] = [-0.7, 0, 0.7, 1.4]
    // to prevent taps on a instrument that is in it's animation playback
    var tappedEntity: [InstrumentEntity] = [InstrumentEntity]()
    var modelsLoaded: Bool = false
    // Create the lottie AnimationView, private so only this view controls it
    private var animationView: AnimationView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        createAnimationView()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGestureRecognizer()
        
        // built in feature to detects all horizontal planes and creates references
        let horizontalAnchor = AnchorEntity(plane: .horizontal)
        arView.scene.addAnchor(horizontalAnchor)
        
        //load entities onto the horizontalAnchor
        loadEntityInstruments(horizontalAnchor: horizontalAnchor)
    }
    // loads entityies in the background using combine.
    func loadEntityInstruments(horizontalAnchor anchor : AnchorEntity) {
        //MARK: when does a entity get added to a anchor. or when
        _ = arView.scene.subscribe(to: SceneEvents.AnchoredStateChanged.self, on: anchor) {
            (event) in
            if event.isAnchored {
                let allChildrenAnchored = anchor.children.allSatisfy{
                    $0.isAnchored == true
                }
                if allChildrenAnchored {
                    self.modelsLoaded = true
                    self.controlLoadingAnimation()
                }
            }
        }
        
        //reference to cancaellable type in Combine as the loading runs on the background
        var cancellable : AnyCancellable?
        //stack all models in to a collection
        cancellable = ModelEntity.loadModelAsync(named: "guitar")
            .append(ModelEntity.loadModelAsync(named: "trumpet"))
            .append(ModelEntity.loadModelAsync(named: "drums"))
            .append(ModelEntity.loadModelAsync(named: "djembe"))
        .collect()
        .sink(receiveCompletion: {
                (error) in
                    cancellable?.cancel()
                    self.modelsLoaded = true
                    self.controlLoadingAnimation()
        },
              receiveValue: {
                (entities) in
                    for (item, entity) in entities.enumerated() {
                        let instrument = InstrumentEntity(modelEntity: entity)
                        //add models to anchor
                        anchor.addChild(instrument)
                        //move every enity for correct placement
                        //MARK: Doesn't work, items on top of each other.
                        instrument.position.x = self.xCoordinates[item]
                        instrument.position.z = -1.0
                        
                        if AudioFiles.all[item] != "djembe" {
                            //add sound file to entity
                            instrument.instrument = InstrumentComponent.init(audioFile: AudioFiles.all[item], audioFiles: nil)
                        } else {
                            //add sound array for talking drum entity
                            instrument.instrument = InstrumentComponent.init(audioFile: AudioFiles.all[item], audioFiles: AudioFiles.djembeAll)
                        }
                    }
                cancellable?.cancel()
        })
    }
    
    //loading animation
    func createAnimationView() {
        animationView = .init(name: "7314-loading")
        animationView.contentMode = .center
        animationView.backgroundBehavior = .pauseAndRestore
        //same same as arView
        animationView.frame = view.bounds
        animationView.loopMode = .loop
        //animationView.backgroundColor = UIColor(white: 1, alpha: 0) //transparent
        view.addSubview(animationView)
        animationView.play()
        view.bringSubviewToFront(animationView)
    }
    private func controlLoadingAnimation() {
        //animation view has been loaded toggle play/stop
        if let _ = animationView {
            //hide when models have loading
            if modelsLoaded {
                view.sendSubviewToBack(animationView)
                animationView.stop()
            }
        }
    }
}

// MARK: Gesture Handling
extension ViewController {
    func setupGestureRecognizer() {
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        arView.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        //MARK: multiple taps cause the insturment to continue to scale. need a guard if animation is down or not.
       let tapLocation = sender.location(in: arView)
        // arview can translate 2d screen space to world space allowing us to find the entity.
        guard let touchedInstrument = arView.entity(at: tapLocation) as? InstrumentEntity else { return }
        if touchedInstrument.animating { return }
        //tappedEntity.append(touchedInstrument)
        touchedInstrument.animating = true
        touchedInstrument.scale()
        touchedInstrument.makeSound()
        //subscribe to event on the RealityScene with a new Cancellable
        var scaleCancellable: Cancellable? = nil
        var soundCancellable: Cancellable? = nil
        scaleCancellable = arView.scene.subscribe(to: AnimationEvents.PlaybackCompleted.self, on: touchedInstrument) {
            (event) in
            touchedInstrument.shrink()
            //clean up
            scaleCancellable?.cancel()
        }
        soundCancellable = arView.scene.subscribe(to: AudioEvents.PlaybackCompleted.self, on: touchedInstrument) {
            (event) in
                //clean up
                soundCancellable?.cancel()
                touchedInstrument.animating = false
        }
    }
    @objc func handelSwipe(_ sender: UISwipeGestureRecognizer) {
        let swipeDirection = sender.direction
        // Play all sounds
        if swipeDirection.contains([.right,.left]) {
            //need to detect if entities were in the swipe
            //arView.entities(at: <#T##CGPoint#>)
        }
    }
}

// MARK: File Names
extension ViewController {
    struct InstrumentFiles {
        static let guitar = "guitar.usdz"
        static let trumpet = "trumpet.usdz"
        static let drums = "drums.usdz"
        static let djembe = "djembe.usdz"
    }
    
    struct AudioFiles {
        static let guitar = "guitar.wav"
        static let trumpet = "trumpet.mp3"
        static let drums = "drums.wav"
        static let djembe = "talkingdrum_phrase_2.wav"
        // randomly play a 'rift' of a talking drum.
        static var djembeAll: [String] {
            let fm = FileManager()
            let path = Bundle.main.resourcePath!
            // force try as this app shouldn't run without audio resources
            let resources = try! fm.contentsOfDirectory(atPath: path)
            return resources.filter{ $0.hasPrefix("talkingdrum") }.sorted()
        }
        static let all = [guitar, trumpet, drums, djembe]
    }
}
