//
//  LoginScreenView.swift
//  IOSProject_MVVM
//
//  Created by Vishal Bhapkar on 25/08/23.
//

import SwiftUI

// A view for the login screen.
struct LoginScreenView: View {
    @StateObject var loginViewModel: LoginViewModel = LoginViewModel()

    var body: some View {
        NavigationStack {
            ZStack {
                // Background view for the login screen (You can replace LoginBackgroundView with your own)
                LoginBackgroundView

                VStack {
                    // Title of the login screen
                    LoginTitleView
                    
                    // Email input field
                    EmailTextInputFieldView

                    // Password input field
                    PasswordTextInputFieldView

                    // Display error messages
                    ErrorMessageFieldView

                    // Keep signed in and forgot password options
                    KeepSignedForgotPasswordFieldView

                    // Login button
                    LoginButtonFieldView
                }
                .padding()
                .navigationDestination(isPresented: $loginViewModel.isLoggedIn) {
                    LandmarkScreenView()
                        .environmentObject(loginViewModel)
                }
                .onAppear(){
                    loginViewModel.isLogging = false
                }
                .blur(radius: loginViewModel.isLogging ? 1 : 0) // Adjust the radius as needed
            }
            .overlay(content: {
                if loginViewModel.isLogging {
                    CustomProgressView()
                }
            })
        }
    }
}

// Preview for the LoginScreenView.
struct LoginScreenView_Previews: PreviewProvider {
    static var previews: some View {
        LoginScreenView()
    }
}







