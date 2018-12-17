//
//  ViewController.swift
//  popupTests
//
//  Created by Clément on 13/12/2018.
//  Copyright © 2018 hoop. All rights reserved.
//

import UIKit
import SwiftEntryKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // doSomething()
    }
    
//    func displaySimple() {
//
//        SwiftEntryKit.display(entry: contentView, using: attributes)
//    }
    
    func showProcessingNote() {
        var attributes: EKAttributes
        
        // fill the attributes
        attributes = .topNote
        attributes.hapticFeedbackType = .none
        attributes.displayDuration = .infinity
        attributes.popBehavior = .animated(animation: .translation)
        attributes.entryBackground = .color(color: .blue)
        attributes.statusBar = .light

        // Fill up the Note message View
        let text = "Envoi en cours"
        let style = EKProperty.LabelStyle(font: MainFont.light.with(size: 14), color: .white, alignment: .center)
        let labelContent = EKProperty.LabelContent(text: text, style: style)
        
        let contentView = EKProcessingNoteMessageView(with: labelContent, activityIndicator: .white)
        SwiftEntryKit.display(entry: contentView, using: attributes)
    }
    
    func showDoneNote() {
        var attributes: EKAttributes
        
        // fill the attributes
        attributes = .topNote
        attributes.hapticFeedbackType = .success
        attributes.displayDuration = 2.0
        attributes.popBehavior = .animated(animation: .translation)
        attributes.entryBackground = .color(color: .green)
        attributes.statusBar = .light
        
        // Fill up the Note message View
        let text = "Envoi réussi"
        let style = EKProperty.LabelStyle(font: MainFont.light.with(size: 14), color: .white, alignment: .center)
        let labelContent = EKProperty.LabelContent(text: text, style: style)
        
        let contentView = EKNoteMessageView(with: labelContent)
        SwiftEntryKit.display(entry: contentView, using: attributes)
    }
    
    func showErrorNote() {
        var attributes: EKAttributes
        
        // Fill the attribute structure
        attributes = .topNote
        attributes.hapticFeedbackType = .error
        attributes.displayDuration = .infinity
        attributes.popBehavior = .animated(animation: .translation)
        attributes.entryBackground = .color(color: .red)
        attributes.statusBar = .light
        
        // Fill up the Note message View
        let text = "Echec de l'envoi"
        let style = EKProperty.LabelStyle(font: MainFont.light.with(size: 14), color: .white, alignment: .center)
        let labelContent = EKProperty.LabelContent(text: text, style: style)
        
        let contentView = EKNoteMessageView(with: labelContent)
        SwiftEntryKit.display(entry: contentView, using: attributes)
    }
    
    func showFormPopup() {
        var attributes: EKAttributes
        
        attributes = .float
        attributes.windowLevel = .normal
        attributes.position = .center
        attributes.displayDuration = .infinity
        
        attributes.entranceAnimation = .init(translate: .init(duration: 0.65, anchorPosition: .bottom,  spring: .init(damping: 1, initialVelocity: 0)))
        attributes.exitAnimation = .init(translate: .init(duration: 0.65, anchorPosition: .top, spring: .init(damping: 1, initialVelocity: 0)))
        attributes.popBehavior = .animated(animation: .init(translate: .init(duration: 0.65, spring: .init(damping: 1, initialVelocity: 0))))
        
        attributes.entryInteraction = .absorbTouches
        attributes.screenInteraction = .dismiss
        
        attributes.entryBackground = .color(color: .white)
        attributes.screenBackground = .color(color: .gray)
        
        attributes.border = .value(color: UIColor(white: 0.6, alpha: 1), width: 1)
        attributes.shadow = .active(with: .init(color: .black, opacity: 0.3, radius: 3))
        attributes.scroll = .enabled(swipeable: false, pullbackAnimation: .jolt)
        attributes.statusBar = .light
        
        let contentView = MessagePopupView(recipient: "Sophie 27", thumbString: "sophie", sendClosure: {
            self.doProcessing((Any).self)
            }, cancelClosure: nil)
        SwiftEntryKit.display(entry: contentView, using: attributes, presentInsideKeyWindow: true)
        
    }

    func showTwoChoicesPopup() {
        
    }
    
    func showInformPopup() {
        
    }
    
    func showMessageToast() {
        var attributes: EKAttributes
        
        // Fill the attribute structure
        attributes = .topToast
        attributes.hapticFeedbackType = .success
        attributes.entryBackground = .color(color: .blue)
        attributes.entranceAnimation = .translation
        attributes.exitAnimation = .translation
        attributes.scroll = .edgeCrossingDisabled(swipeable: true)
        attributes.displayDuration = 4
        attributes.shadow = .active(with: .init(color: .black, opacity: 0.5, radius: 10))
        
        // Fill up the toast
        let title = EKProperty.LabelContent(text: "Sophie", style: .init(font: MainFont.medium.with(size: 14), color: .white))
        let description = EKProperty.LabelContent(text: "Salut on va manger un 🍲 ce midi", style: .init(font: MainFont.light.with(size: 12), color: .white))
        let time = EKProperty.LabelContent(text: "09:00", style: .init(font: MainFont.light.with(size: 10), color: .white))
        let image = EKProperty.ImageContent.thumb(with: "sophie", edgeSize: 35)
        let simpleMessage = EKSimpleMessage(image: image, title: title, description: description)
        let notificationMessage = EKNotificationMessage(simpleMessage: simpleMessage, auxiliary: time)
        
        let contentView = EKNotificationMessageView(with: notificationMessage)
        SwiftEntryKit.display(entry: contentView, using: attributes)
    }
    
    // =================
    
    @IBAction func doForm(_ sender: Any) {
        showFormPopup()
    }
    
    @IBAction func doProcessing(_ sender: Any) {
        showProcessingNote()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.showDoneNote()
        }
    }
    
    @IBAction func doDone(_ sender: Any) {
        showDoneNote()
    }
    
    @IBAction func doError(_ sender: Any) {
        showErrorNote()
    }
    
    @IBAction func doMessage(_ sender: Any) {
        showMessageToast()
    }
    
    
    
}


