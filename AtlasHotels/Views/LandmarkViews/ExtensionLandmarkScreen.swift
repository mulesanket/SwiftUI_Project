
//
//  ExtensionLandmarkScreen.swift
//  IOSProject_MVVM
//
//  Created by Vishal Bhapkar on 30/08/23.
//

import Foundation
import SwiftUI

// Extension for subviews in the LandmarkScreenView
extension LandmarkScreenView {

    // View for the landmark search bar
    var LandmarkSearchBarView: some View {
        SearchBarView(
            textInput: $landMarkViewModel.textInputForLocation,
            searchAction: { landMarkViewModel.fetchLandMarks() }
        )
    }

    // View for displaying the list of landmarks
    var LandMarkListView: some View {
        LandmarkListView(entities: landMarkViewModel.entities, landMarkViewModel: landMarkViewModel)
            .navigationBarTitle("Landmarks")
            .environmentObject(loginViewModel)
    }

    // View for displaying a message when no data is found
    var DataEmptyView: some View {
        Text("No Data Found for this location")
    }

    // View for displaying a progress indicator while fetching landmarks
    var LandmarkProgressView: some View {
        VStack {
            CustomProgressView()
            Text("Fetching landmarks...")
        }
    }

    // View for displaying a message when no input is provided
    var NoInputView: some View {
        Text("Enter some location")
    }

    // View for displaying static landmark data
    var StaticlandmarkDataView: some View {
        StaticLandMarkViews(landMarkViewModel: landMarkViewModel)
    }

    // Alert view for displaying errors
    var errorAlert: Alert {
        Alert(
            title: Text("Error"),
            message: Text(landMarkViewModel.state.localizedDescription),
            primaryButton: .default(Text("Retry"), action: landMarkViewModel.fetchLandMarks),
            secondaryButton: .cancel(Text("Cancel"))
        )
    }

    // View for the home button
    var HomeButton: some View {
        Button(action: {
            landMarkViewModel.textInputForLocation = ""
            landMarkViewModel.state = .none
        }) {
            SwiftUI.Image(systemName: "house.fill") // Use your back arrow icon here
                .foregroundColor(.blue) // Adjust color as needed
                .imageScale(.large)
        }
    }

    // View for the logout button
    var LogoutButton: some View {
        Button(action: {
            landMarkViewModel.logout()
            loginViewModel.isLoggedIn = false
        }) {
            Text("Logout")
                .foregroundColor(.red)
        }
    }
}



// View for a search bar with a text input field and search button
struct SearchBarView: View {
    @Binding var textInput: String
    var searchAction: () -> Void

    var body: some View {
        HStack {
            TextField("Enter location", text: $textInput)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .background(Color.white)
                .shadow(color: Color.black.opacity(0.06), radius: 5, x: 5, y: 5)
                .shadow(color: Color.black.opacity(0.06), radius: 5, x: -5, y: -5)

            Button(action: searchAction) {
                SwiftUI.Image(systemName: "magnifyingglass")
                    .font(.title)
            }
            .padding()
        }
        .padding(.horizontal)
    }
}

// View for displaying a list of landmarks
struct LandmarkListView: View {
    var entities: [Entity]
    @EnvironmentObject var loginViewModel: LoginViewModel
    @ObservedObject var landMarkViewModel: LandmarkViewModel

    var body: some View {
        Text("Showing results for \(landMarkViewModel.textInputForLocation)")
            .foregroundColor(.blue)
            .font(.headline)

        List(entities) { landmark in
            NavigationLink {
               HotelListScreenView(geoId: landmark.geoId)
                    .environmentObject(loginViewModel)
            } label: {
                Text(landmark.name)
                    .foregroundColor(Color.primary)
                    .font(.body)
                    .padding(.vertical)
                Spacer() // Add space to the right
            }
        }
        .background(Color.white) // Set the background color of each row
                        .cornerRadius(10) // Apply corner radius for rounded corners
                        .padding(.horizontal, 16) // Apply horizontal padding
                        .padding(.vertical, 4) // Apply vertical padding
                        .shadow(color: Color.gray.opacity(0.3), radius: 3, x: 0, y: 2) // Add a shadow
    }
}

struct CustomProgressView: View {
    var body: some View {
        VStack {
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: Color.blue)) // Customize the color
                .scaleEffect(2.0, anchor: .center) // Adjust the scale as needed for size
                .padding()
                .background(Color.white.opacity(0.8))
                .cornerRadius(10)
        }
//        .frame(maxWidth: .infinity, maxHeight: .infinity)
//        .background(Color.black.opacity(0.4).edgesIgnoringSafeArea(.all))
    }
}


