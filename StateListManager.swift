//
//  StateListManager.swift
//  StatesAndZipCodes
//
//  Created by Kalebu Patan on 3/14/24.
//

import Foundation

@Observable
class StateListManager {
    
    private var stateDict = [String:[String]]()
    
    init() {
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        if let localUrl = documentDirectory?.appendingPathComponent(K.dictPlist), !FileManager.default.fileExists(atPath: localUrl.path){
            self.copyFileToDocumentsFolder(nameForFile: K.stateDictPath, extForFile: K.stateDictExt)
        }
        self.getStateDict()
    }
    
    private func getStateDict() {
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent(K.dictPlist)
        let data = try! Data(contentsOf: url)
        let decoder = PropertyListDecoder()
        stateDict =  try! decoder.decode([String:[String]].self, from: data)
    }
    
    func getStateList() -> [String] {
        stateDict.keys.sorted(by: <)
    }
    
    func getZipListBasedState(_ key:String) -> [String] {
        stateDict[key] ?? []
    }
    
    func updateZipForKey(_ oldZip:String,_ newZip:String, _ key:String) {
        var zipcodes = stateDict[key] ?? []
        if let index = zipcodes.firstIndex(where: {$0 == oldZip}) {
            zipcodes[index] = newZip
            self.updateZipForKeyInPlist(key, index, newZip)
        }
        stateDict[key] = zipcodes
    }
    
    private func updateZipForKeyInPlist(_ key:String,_ index:Int,_ newZip:String) {
        
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent(K.dictPlist)
        let stateDictionary = NSMutableDictionary(contentsOf: url)
        let zipsArray = stateDictionary?.object(forKey: key) as? NSMutableArray
        zipsArray?[index] = newZip
        try? stateDictionary?.write(to: url)
    }
    
    private func copyFileToDocumentsFolder(nameForFile: String, extForFile: String) {
        
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        let destURL = documentsURL!.appendingPathComponent(nameForFile).appendingPathExtension(extForFile)
        guard let sourceURL = Bundle.main.url(forResource: nameForFile, withExtension: extForFile) else {
            return
        }
        let fileManager = FileManager.default
        try? fileManager.copyItem(at: sourceURL, to: destURL)
    }
}
