//
//  ScansViewModel.swift
//  vyyer_test
//
//  Created by Eugen K on 20.03.2025.
//

import Foundation
import SDWebImageSwiftUI


class ScansViewModel: BaseViewModel {
    
    @Published var scans: [ScansDTO] = []
    @Published var isLoading = false
    @Published var currentPage = 1
    @Published var navigateToLogin: Bool = false
    private let pageSize = 10
    
    var rootCoorinator: RootCoordinator?
    
    func fetchScans() {
        guard !isLoading else { return }
        isLoading = true
        
        Task {
            let newScans = try! await foundation.userDataUseCase.getScans(page: currentPage, perPage: pageSize)
            DispatchQueue.main.async {
                self.scans.append(contentsOf: newScans)
                self.currentPage += 1
                self.isLoading = false
            }
        }
    }
    
    func loadMoreIfNeeded(currentItem: ScansDTO?) {
        guard let currentItem = currentItem else {
            fetchScans()
            return
        }
        
        let thresholdIndex = scans.index(scans.endIndex, offsetBy: -5)
        if scans.firstIndex(where: { $0.id == currentItem.id }) == thresholdIndex {
            fetchScans()
        }
    }
    
    func logout() {
        foundation.clearUserData()
        navigateToLogin = true
        rootCoorinator?.screen = .login
    }
}
