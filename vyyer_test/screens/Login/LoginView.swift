//
//  LoginView.swift
//  vyyer_test
//
//  Created by Eugen K on 20.03.2025.
//

import SwiftUI

struct LoginView: View {
    @ObservedObject private var viewModel: LoginViewModel
    @EnvironmentObject private var rootCoordinator: RootCoordinator
    
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                TextField("Login", text: $viewModel.login)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .padding(.horizontal)
                
                SecureField("Password", text: $viewModel.password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                
                if viewModel.isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                } else {
                    Button(action: {
                        Task {
                            await viewModel.loginUser()
                        }
                    }) {
                        Text("Login")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding(.horizontal)
                }
            }
            .padding()
            .navigationTitle("Login")
            .alert(isPresented: $viewModel.showErrorAlert) {
                Alert(
                    title: Text("Error"),
                    message: Text(viewModel.errorMessage),
                    dismissButton: .default(Text("OK")) {
                        viewModel.errorMessage = ""
                    }
                )
            }
            .navigationDestination(isPresented: $viewModel.navigateToHome) {
                ScansView(viewModel: .init(foundation: rootCoordinator.foundation))
            }
        }
    }
}
