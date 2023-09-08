//
//  LandMarkScreenView.swift
//  IOSProject_MVVM
//
//  Created by Vishal Bhapkar on 08/08/23.
//

import Foundation
import SwiftUI

// A view for the landmark screen.
struct LandmarkScreenView: View {
    @StateObject var landMarkViewModel: LandmarkViewModel = LandmarkViewModel()
    @EnvironmentObject var loginViewModel: LoginViewModel

    var body: some View {
        VStack {

            switch landMarkViewModel.state {
                case .none :
                    LandmarkSearchBarView
                    StaticlandmarkDataView
                case .success:
                    LandMarkListView // Display the list of landmarks when successful
                case .dataEmpty:
                    DataEmptyView // Display a view for empty data
                case .loading:
                    LandmarkProgressView // Display a loading indicator
                case .noTextInput:
                    LandmarkSearchBarView
                    NoInputView // Display a view when there's no user input
                    StaticlandmarkDataView
                default:
                    EmptyView() // Display an empty view for other cases
            }
        }
        .alert(isPresented: $landMarkViewModel.hasError) { errorAlert } // Show an error alert if there's an error
        .navigationBarBackButtonHidden()
        .navigationTitle("Welcome to Hotels")
        .navigationBarItems(trailing: LogoutButton) // Add a logout button to the navigation bar
        .navigationBarItems(leading: HomeButton) // Add a home button to the navigation bar
    }
}

// Preview for the LandmarkScreenView.
struct LandMarkScreenView_Previews: PreviewProvider {
    static var previews: some View {
        LandmarkScreenView()
            .environmentObject(LoginViewModel())
    }
}








