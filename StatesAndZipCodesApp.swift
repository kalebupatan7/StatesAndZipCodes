//
//  StatesAndZipCodesApp.swift
//  StatesAndZipCodes
//
//  Created by Kalebu Patan on 3/14/24.
//

import SwiftUI

@main
struct StatesAndZipCodesApp: App {
    var body: some Scene {
        WindowGroup {
            StatesView()
                .environment(StateListManager())
        }
    }
}
