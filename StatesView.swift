//
//  StatesView.swift
//  StatesAndZipCodes
//
//  Created by Kalebu Patan on 3/14/24.
//

import SwiftUI

struct StatesView: View {
    
    @Environment(StateListManager.self) private var stateListManager
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(stateListManager.getStateList(), id: \.self) { key in
                    NavigationLink(destination: ZipCodesView(state: key)) {
                        Text(key)
                    }
                }
            }
            .navigationTitle(K.states)
        }
    }
}

#Preview {
    StatesView()
}


