//
//  UserProfile.swift
//  LittleLemon
//
//  Created by Amir T Mgr on 19.11.25.
//

import SwiftUI

struct UserProfile: View {
    @StateObject private var viewModel = ViewModel()
    
    @Environment(\.presentationMode) var presentation
    
    @State private var orderStatus = true
    @State private var passwordChanges = true
    @State private var specialOffers = true
    @State private var newsletter = true
    
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var email = ""
    @State private var phoneNumber = ""
    
    @State private var isLoggedOut = false
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            NavigationLink(destination: Onboarding(), isActive: $isLoggedOut) { }
            VStack(spacing: 5) {
                VStack {
                    Text("Avatar")
                        .onboardingTextStyle()
                    HStack(spacing: 0) {
                        Image("Profile")
                            .resizable()
                            .aspectRatio( contentMode: .fit)
                            .frame(maxHeight: 75)
                            .clipShape(Circle())
                            .padding(.trailing)
                        Button("Change") { }
                            .buttonStyle(ButtonStylePrimaryColor1())
                        Button("Remove") { }
                            .buttonStyle(ButtonStylePrimaryColorReverse())
                        Spacer()
                    }
                }
                
                VStack{
                    Text("First name")
                        .onboardingTextStyle()
                    TextField("First Name", text: $firstName)
                }
                
                VStack {
                    Text("Last name")
                        .onboardingTextStyle()
                    TextField("Last Name", text: $lastName)
                    
                }
                
                VStack {
                    Text("E-mail")
                        .onboardingTextStyle()
                    TextField("E-mail", text: $email)
                        .keyboardType(.emailAddress)
                }
                
                VStack {
                    Text("Phone number")
                        .onboardingTextStyle()
                    TextField("Phone number", text: $phoneNumber)
                        .keyboardType(.default)
                }
            }
            .textFieldStyle(.roundedBorder)
            .disableAutocorrection(true)
            .padding()
            
            
            VStack(alignment: .leading, spacing: 16) {
                Text("Email notifications")
                    .font(Font.custom("Karla", size: 16).weight(.bold))
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                
                CheckBoxRow(title: "Order statuses", isChecked: $orderStatus)
                    .padding(.horizontal)
                CheckBoxRow(title: "Password changes", isChecked: $passwordChanges)
                    .padding(.horizontal)
                CheckBoxRow(title: "Special offers", isChecked: $specialOffers)
                    .padding(.horizontal)
                CheckBoxRow(title: "Newsletter", isChecked: $newsletter)
                    .padding(.horizontal)
                
            }
            
            
            Button("Log out") {
                UserDefaults.standard.set(false, forKey: kIsLoggedIn)
                UserDefaults.standard.set("", forKey: kFirstName)
                UserDefaults.standard.set("", forKey: kLastName)
                UserDefaults.standard.set("", forKey: kEmail)
                UserDefaults.standard.set("", forKey: kPhoneNumber)
                UserDefaults.standard.set(false, forKey: kOrderStatus)
                UserDefaults.standard.set(false, forKey: kPasswordChanges)
                UserDefaults.standard.set(false, forKey: kSpecialOffers)
                UserDefaults.standard.set(false, forKey: kNewsletter)
                isLoggedOut = true
            }
            .buttonStyle(ButtonStyleYellowColorWide())
            Spacer(minLength: 20)
            HStack {
                Button("Discard Changes") {
                    firstName = viewModel.firstName
                    lastName = viewModel.lastName
                    email = viewModel.email
                    phoneNumber = viewModel.phoneNumber
                    
                    orderStatus = viewModel.orderStatus
                    passwordChanges = viewModel.passwordChanges
                    specialOffers = viewModel.specialOffers
                    newsletter = viewModel.newsletter
                    self.presentation.wrappedValue.dismiss()
                }
                    .buttonStyle(ButtonStylePrimaryColorReverse())
                Button("Save changes") {
                    if viewModel.validateUserInput(firstName: firstName, lastName: lastName, email: email, phoneNumber: phoneNumber) {
                        UserDefaults.standard.set(firstName, forKey: kFirstName)
                        UserDefaults.standard.set(lastName, forKey: kLastName)
                        UserDefaults.standard.set(email, forKey: kEmail)
                        UserDefaults.standard.set(phoneNumber, forKey: kPhoneNumber)
                        UserDefaults.standard.set(orderStatus, forKey: kOrderStatus)
                        UserDefaults.standard.set(passwordChanges, forKey: kPasswordChanges)
                        UserDefaults.standard.set(specialOffers, forKey: kSpecialOffers)
                        UserDefaults.standard.set(newsletter, forKey: kNewsletter)
                        self.presentation.wrappedValue.dismiss()
                    }
                }
                    .buttonStyle(ButtonStylePrimaryColor1())
            }
            if viewModel.errorMessageShow {
                withAnimation() {
                    Text(viewModel.errorMessage)
                        .foregroundColor(.red)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading)
                }
            }
            
        }
        .onAppear {
            firstName = viewModel.firstName
            lastName = viewModel.lastName
            email = viewModel.email
            phoneNumber = viewModel.phoneNumber
            
            orderStatus = viewModel.orderStatus
            passwordChanges = viewModel.passwordChanges
            specialOffers = viewModel.specialOffers
            newsletter = viewModel.newsletter
        }
        .navigationTitle(Text("Personal information"))
        .navigationBarTitleDisplayMode(.inline)
    }
}


struct CheckBoxRow: View {
    let title: String
    @Binding var isChecked: Bool
    
    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: isChecked ? "checkmark.square.fill" : "square")
                .foregroundColor(isChecked ? .green : .gray)
                .frame(width: 22, height: 22)
                .onTapGesture {
                    isChecked.toggle()
                }
            
            Text(title)
                .foregroundColor(.black)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .onTapGesture {
            isChecked.toggle()
        }
    }
}

struct UserProfile_Previews: PreviewProvider {
    static var previews: some View {
        UserProfile()
    }
}
