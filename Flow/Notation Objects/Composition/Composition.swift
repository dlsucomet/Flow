//
//  Composition.swift
//  Flow
//
//  Created by Kevin Chan on 04/12/2017.
//  Copyright © 2017 MusicG. All rights reserved.
//

import Foundation

class Composition {
    // Holds information about the composition
    var compositionInfo: CompositionInfo
    var staffList: [Staff]
    public var tempo: Double

    var isEnsembleStaff: Bool {
        return self.staffList.count > 1
    }
    var numStaves: Int {
        return self.staffList.count
    }
    var numMeasures: Int {
        var measureNum = 0
        
        for staff in staffList {
            measureNum += staff.measures.count
        }
        
        return measureNum
    }
    var all: [MusicNotation] {
        var notations = [MusicNotation]()
        
        for staff in staffList {
            for measure in staff.measures {
                notations.append(contentsOf: measure.notationObjects)
            }
        }
        return notations
    }
    
    init(compositionInfo: CompositionInfo = CompositionInfo(), staffList: [Staff] = []) {
        self.compositionInfo = compositionInfo
        self.staffList = staffList
        self.tempo = 120
    }
    
    func addStaff(_ staff: Staff) {
        self.staffList.append(staff)
    }

    func addGrandStaff() {
        //for _  in 1...2 {

            for staff in staffList {

                let lastMeasure = staff.measures[staff.measures.count - 1]

                staff.addMeasure(Measure(keySignature: lastMeasure.keySignature, timeSignature: lastMeasure.timeSignature, clef: lastMeasure.clef, loading: false))

            }
        //}
    }
    
    func getMeasureOfNote(note: MusicNotation) -> Measure? {
        for staff in staffList {
            for measure in staff.measures {
                if let _ = measure.notationObjects.index(where: {$0 === note}) {
                    return measure
                }
            }
        }
        
        return nil
    }

    func isLastMeasureFull() -> Bool {
        for staff in staffList {
            if staff.measures[staff.measures.count - 1].timeSignature.getMaxBeatValue() == staff.measures[staff.measures.count - 1].getTotalBeats() {
                if !staff.measures[staff.measures.count - 1].containsRest() {
                    return true
                }
            }
        }

        return false
    }

    
    func getDivisions(at index: Int) -> Int{
        var divisions = 1
        
        for staff in self.staffList {
            if staff.measures.count > index {
                divisions = max(staff.measures[index].divisions, divisions)
            }
        }
        
        return divisions
    }
}
