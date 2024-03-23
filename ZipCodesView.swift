//
//  ZipCodesView.swift
//  StatesAndZipCodes
//
//  Created by Kalebu Patan on 3/14/24.
//

import SwiftUI

struct ZipCodesView: View {
    let state:String
    @Environment(StateListManager.self) private var stateListManager
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(stateListManager.getZipListBasedState(state), id: \.self) { zip in
                    NavigationLink(destination: EditZipCode(zipCode: zip, state: state )) {
                        Text(zip)
                    }
                }
            }
            .navigationTitle(state)
        }
    }
}


