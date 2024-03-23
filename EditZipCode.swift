//
//  EditZipCode.swift
//  StatesAndZipCodes
//
//  Created by Kalebu Patan on 3/14/24.
//

import SwiftUI
import Combine

struct EditZipCode: View {
    
    let zipCode: String
    let state:String
    @Environment(\.dismiss) private var dismiss
    @Environment(StateListManager.self) private var stateListManager
    @State private var newZipCode: String = K.emptyString
    
    var body: some View {
        VStack(spacing: 35) {
            Text(K.editZipCode)
                .font(.title)
            VStack(spacing: 25) {
                Text(zipCode)
                    .font(.title3)
                TextField(K.editNewZipCode, text: $newZipCode)
                    .textFieldStyle(.roundedBorder)
                    .frame(alignment:.center)
                    .frame(width: 180)
                    .multilineTextAlignment(.center)
                    .keyboardType(.numberPad)
                    .onReceive(Just(newZipCode)) { newValue in
                        if newValue.count < 6 {
                            self.newZipCode = newValue
                        } else {
                            let endIndex = newValue.index(newValue.startIndex, offsetBy: 5)
                            let range: Range<String.Index> = newValue.startIndex..<endIndex
                            self.newZipCode = String(newValue[range])
                        }
                    }
                Button(action: {
                    if newZipCode != K.emptyString {
                        stateListManager.updateZipForKey(zipCode, newZipCode, state)
                    }
                    dismiss()
                }) {
                    Text(K.ok)
                        .foregroundStyle(.black)
                }
                .frame(width: 80,height: 30)
                .background(Color(uiColor: .green))
            }
        }
        Spacer()
        
    }
}

