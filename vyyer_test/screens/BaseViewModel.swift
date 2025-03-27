//
//  BaseViewModel.swift
//  vyyer_test
//
//  Created by Eugen K on 20.03.2025.
//

import Foundation

class BaseViewModel: ObservableObject {
    let foundation: AppFoundationProtocol
    
    init(foundation: AppFoundationProtocol) {
        self.foundation = foundation
    }
}
