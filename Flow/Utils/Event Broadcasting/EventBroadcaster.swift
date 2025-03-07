//
//  EventBroadcaster.swift
//  Flow
//
//  Created by Kevin Chan on 09/12/2017.
//  Copyright © 2017 MusicG. All rights reserved.
//

import Foundation

class EventBroadcaster {
    
    // MARK: Shared instance
    static let instance = EventBroadcaster()
    
    // MARK: Properties
    private var eventObservers: [String: ObserverList]
    
    private init() {
        self.eventObservers = [:]
    }
    
    func addObserver(event: String, observer: Observer) {
        if let observers = self.eventObservers[event] {
            observers.addObserver(observer)
        } else {
            let observerList = ObserverList()
            observerList.addObserver(observer)
            self.eventObservers.updateValue(observerList, forKey: event)
        }
    }
    
    func removeObservers(event: String) {
        self.eventObservers.removeValue(forKey: event)
    }
    
    func removeObserver(event: String, observer: Observer) {
        if let observers = self.eventObservers[event] {
            observers.removeObserver(observer)
        }
    }
    
    func removeAllObservers() {
        self.eventObservers.removeAll()
    }
    
    func postEvent(event: String) {
        if let observers = self.eventObservers[event] {
            observers.notifyObservers()
        }
    }
    
    func postEvent(event: String, params: Parameters) {
        if let observers = self.eventObservers[event] {
            observers.notifyObservers(params)
        }
    }
}
