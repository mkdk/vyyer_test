//
//  HomeView.swift
//  vyyer_test
//
//  Created by Eugen K on 20.03.2025.
//

import SwiftUI
import SDWebImageSwiftUI

struct ScansView: View {
    @EnvironmentObject var rootCoordinator: RootCoordinator
    @ObservedObject var viewModel: ScansViewModel
    
    var body: some View {
        VStack {
            List {
                ForEach(viewModel.scans) { scan in
                    HStack {
                        WebImage(url: scan.imageURL) { image in
                            image.resizable()
                        } placeholder: {
                            Rectangle().foregroundColor(.gray.opacity(0.5))
                        }
                        .indicator(.activity)
                        .transition(.fade(duration: 0.5))
                        .scaledToFit()
                        .frame(width: 50)
                        .cornerRadius(10)
                        VStack(alignment: .leading) {
                            Text(scan.name)
                                .font(.headline)
                            Text("\(scan.formattedCreatedAt), \(scan.valid)")
                                .font(.subheadline)
                        }
                    }
                    .onAppear {
                        viewModel.loadMoreIfNeeded(currentItem: scan)
                    }
                }
                
                if viewModel.isLoading {
                    HStack {
                        Spacer()
                        ProgressView()
                            .tint(.red)
                            .padding()
                        Spacer()
                    }
                }
            }
            .navigationTitle("Scans")
            .onAppear {
                if viewModel.scans.isEmpty {
                    viewModel.fetchScans()
                }
            }
        }
        .navigationTitle("Scans")
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    viewModel.logout()
                }) {
                    Text("Logout")
                        .foregroundColor(.red)
                }
            }
        }
    }
}
