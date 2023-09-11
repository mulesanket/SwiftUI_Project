//
//  ExtensionLoginScreen.swift
//  IOSProject_MVVM
//
//  Created by Vishal Bhapkar on 30/08/23.
//

import Foundation
import SwiftUI

// Extension of LoginScreenView for creating subviews.
extension LoginScreenView {

    // View for the login screen background (You can replace LoginScreenBackground with your own)
    var LoginBackgroundView: some View {
        LoginScreenBackground()
    }

    // View for the login screen title (You can replace LoginTitle with your own)
    var LoginTitleView: some View {
       LoginTitle()
    }

    // View for the email input field (You can replace EmailInputFieldView with your own)
    var EmailTextInputFieldView: some View {
        EmailInputFieldView(loginViewModel: loginViewModel)
            .padding(.bottom)
    }

    // View for the password input field (You can replace PasswordInputFieldView with your own)
    var PasswordTextInputFieldView: some View {
        PasswordInputFieldView(loginViewModel: loginViewModel)
    }

    // View for displaying error messages (You can replace ErrorMessageView with your own)
    var ErrorMessageFieldView: some View {
        ErrorMessageView(loginViewModel: loginViewModel)
    }

    // View for keeping signed in and forgot password options (You can replace KeepSignedForgotPasswordView with your own)
    var KeepSignedForgotPasswordFieldView: some View {
        KeepSignedForgotPasswordView(loginViewModel: loginViewModel)
    }

    // View for the login button (You can replace LoginButtonView with your own)
    var LoginButtonFieldView: some View {
        LoginButtonView(loginViewModel: loginViewModel)
    }
}




// Background Screen for Login page
struct LoginScreenBackground: View {
    var body: some View {
        LinearGradient(
//            gradient: Gradient(colors: [Color("PrimaryBlue"), Color("SecondaryTeal")]),
            gradient: Gradient(colors: [Color("BackGround"), Color("BackGround")]),
            startPoint: .top,
            endPoint: .bottomLeading
        )
        .ignoresSafeArea()
    }
}

// View for the login screen title
struct LoginTitle: View {
    var body: some View {
        VStack {
            SwiftUI.Image("SplashScreenImage")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(.vertical)

            Text("Login")
                .font(.system(size: 34, weight: .bold, design: .default))
                .foregroundColor(.blue)
        }
        .padding(.vertical) // Center content vertically
    }
}

// View for the email input field
struct EmailInputFieldView: View {
    @StateObject var loginViewModel: LoginViewModel

    var body: some View {
        VStack {
            HStack {
                SwiftUI.Image(systemName: "envelope")
                    .foregroundColor(.black)
                    .padding(.leading, 10) // Keep the same leading padding for both images

                TextField("Email", text: $loginViewModel.username)
                                .autocapitalization(.none)
                                .disableAutocorrection(true)
                                .padding(.horizontal)
                                .onTapGesture {
                                    loginViewModel.errorMessage = ""
                                }
                        }
                        .environment(\.colorScheme, loginViewModel.isDarkMode ? .dark : .light)
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.white)
                    .shadow(color: Color.gray.opacity(0.3), radius: 5, x: 0, y: 2)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.black, lineWidth: 1)
            )
        }
    }

// View for the password input field
struct PasswordInputFieldView: View {
    @StateObject var loginViewModel: LoginViewModel
    @State private var isPasswordVisible = false

    var body: some View {
        VStack {
            HStack {
                SwiftUI.Image(systemName: "lock")
                    .foregroundColor(.black)
                    .padding(.leading, 10) // Keep the same leading padding for both images

                if isPasswordVisible {
                    TextField("Password", text: $loginViewModel.password)
                        .onTapGesture {
                            loginViewModel.errorMessage = ""
                        }
                        .environment(\.colorScheme, loginViewModel.isDarkMode ? .dark : .light)
                } else {
                    SecureField("Password", text: $loginViewModel.password)
                        .onTapGesture {
                            loginViewModel.errorMessage = ""
                        }
                        .environment(\.colorScheme, loginViewModel.isDarkMode ? .dark : .light)
                }

                Button(action: {
                    isPasswordVisible.toggle()
                }) {
                    SwiftUI.Image(systemName: isPasswordVisible ? "eye.slash.fill" : "eye.fill")
                        .foregroundColor(.gray)
                }
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.white)
                    .shadow(color: Color.gray.opacity(0.3), radius: 5, x: 0, y: 2)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.black, lineWidth: 1)
            )
        }
    }
}


// View for displaying error messages
struct ErrorMessageView: View {
    @StateObject var loginViewModel: LoginViewModel

    var body: some View {
        Text(loginViewModel.errorMessage)
            .foregroundColor(.red)
            .padding()
    }
}

// View for the login button
struct LoginButtonView: View {
    @StateObject var loginViewModel: LoginViewModel

    var body: some View {
        Button(action: {
            Task {
                await loginViewModel.login()
            }
        }) {
            Text("Login")
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.blue.opacity(0.8))
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.blue, lineWidth: 2)
                )
                .padding([.horizontal, .bottom], 20)
        }
        .disabled(loginViewModel.isLoggedIn)
        .opacity(loginViewModel.isLoggedIn ? 0.6 : 1)
        .onTapGesture {
            withAnimation(.easeInOut) {

            }
        }
    }
}

// View for keeping signed in and forgot password options
struct KeepSignedForgotPasswordView: View {
    @StateObject var loginViewModel: LoginViewModel

    var body: some View {
        HStack {
            Toggle("Keep me signed-in", isOn: $loginViewModel.keepSignedIn)
                .toggleStyle(RectangleCheckboxStyle())

            Text("Forgot Password?")
                .foregroundColor(.gray)
        }
    }
}

struct RectangleCheckboxStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        Button(action: { configuration.isOn.toggle() }) {
            HStack {
                RoundedRectangle(cornerRadius: 4)
                    .frame(width: 18, height: 18)
                    .foregroundColor(configuration.isOn ? Color.blue : Color.gray)
                    .overlay(
                        SwiftUI.Image(systemName: "checkmark")
                            .foregroundColor(.white)
                            .font(.system(size: 12, weight: .bold))
                            .opacity(configuration.isOn ? 1 : 0)
                    )

                configuration.label
            }
        }
    }
}

struct LoginProgressView: View {
    var body: some View {
        VStack {
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: Color.blue)) // Customize the color
                .scaleEffect(2.0, anchor: .center) // Adjust the scale as needed for size
                .padding()
                .background(Color.white.opacity(0.8))
                .cornerRadius(10)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black.opacity(0.4).edgesIgnoringSafeArea(.all))
    }
}
