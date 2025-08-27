//
//  DocumentInformationView.swift
//  StarWars
//
//  Created by JoseAlvarez on 8/26/25.
//

import SwiftUI

struct DocumentInformationView: View {
    
    @Binding var documentType: String
    @Binding var documentNumber: String
    @FocusState private var isDocumentNumberFocused: Bool
    @State private var documentNumberFieldState: FieldState = .idle
    
    var viewModel: SignInViewModel

    var body: some View {
        Section(header: Text("ID Information").font(.headline)) {
            Picker("Select a type of document", selection: $documentType) {
                ForEach(["Passport", "ID"], id: \.self) { type in
                    Text(type)
                }
            }
            .onChange(of: documentType) { oldValue, newValue in
                if !viewModel.validateDocumentNumber(newValue, documentNumber) {
                    documentNumberFieldState = .failure
                }
            }
            .fixedSize()
            .onAppear {
                if documentType.isEmpty {
                    documentType = ""
                }
            }
            
            VStack(alignment: .leading) {
                TextField("Document Number", text: $documentNumber)
                    .focused($isDocumentNumberFocused)
                    .keyboardType(.asciiCapable)
                    .autocapitalization(.allCharacters)
                    .disabled(documentType.isEmpty)
                    .onChange(of: documentNumber) {
                        documentNumberFieldState = .typing
                    }
                    .onChange(of: isDocumentNumberFocused) { oldValue, isFocused in
                        if !isFocused {
                            if documentNumber.isEmpty {
                                documentNumberFieldState = .failure
                            } else if viewModel.validateDocumentNumber(documentType, documentNumber) {
                                documentNumberFieldState = .success
                            } else {
                                documentNumberFieldState = .failure
                            }
                        }
                    }
                
                viewModel.underlineRectangle(documentNumberFieldState)

                if documentNumberFieldState == .failure{
                    Text(
                        documentType == "ID"
                        ? "Invalid document number for selected type (ID), please use only 8 numbers."
                        : "Invalid document number for selected type (Passport), please use a letter and then 8 numbers."
                    )

                    .font(.caption)
                    .foregroundColor(.red)
                }
            }
        }
    }
}
