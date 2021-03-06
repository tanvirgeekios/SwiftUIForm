//
//  HomeView.swift
//  Form
//
//  Created by MD Tanvir Alam on 15/1/21.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var girlVM = GirlViewModel()
    var body: some View {
        VStack{
            Image(uiImage: girlVM.image ?? UIImage(named: "placeholder")!)
                .resizable()
                .frame(width: 200, height: 200)
                .aspectRatio(contentMode: .fit)
                .clipped()
                .cornerRadius(20)
                .overlay(RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.blue, lineWidth: 4))
                .shadow(radius: 10)
                .padding(.bottom,25)
                .onTapGesture(count:1) {
                    girlVM.showActionSheet = true
                }
            
            Spacer()
            
            Form{
                Section(header: Text("Girl's Description").foregroundColor(.blue)){
                    TextField("FullName", text: $girlVM.fullname)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                    TextField("Age", text: $girlVM.age)
                        .keyboardType(.numberPad)
                    
                    Toggle(isOn: $girlVM.isHot, label: {
                        Text("Hot")
                    })
                }
                Section(header: Text("Sexual Orientation").foregroundColor(.blue)){
                    Picker(selection: $girlVM.sexualOrientation, label: Text("Choose"), content: {
                        
                        ForEach(girlVM.sexualOrientationArray, id:\.self){
                            Text($0)
                        }
                        
                    })
                }
                
            }
            
            Button(action: {
                print(girlVM.fullname)
                print(girlVM.age)
                print(girlVM.isHot)
                print(girlVM.sexualOrientation)
                print(girlVM.image as Any)
                print(girlVM.userLocation.coordinate.latitude)
                print(girlVM.userLocation.coordinate.longitude)
                
            }, label: {
                Text("Submit")
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(5)
            })
        }.navigationBarTitle("Girls")
        .actionSheet(isPresented: $girlVM.showActionSheet, content: {
            ActionSheet(title: Text("Select a photo"), message: Text("Choose"), buttons: [.default(Text("Photo Library")){
                girlVM.showImagePicker = true
                girlVM.sourceType = .photoLibrary
            },
            .default(Text("Camera")){
                girlVM.showImagePicker = true
                girlVM.sourceType = .camera
            },
            .cancel()
            ])
        })
        .sheet(isPresented: $girlVM.showImagePicker) {
            ImagePicker(image: $girlVM.image, isShown: $girlVM.showImagePicker, sourceType: girlVM.sourceType)
        }
        .onAppear {
            girlVM.locationManager.delegate = girlVM
            girlVM.locationManager.requestWhenInUseAuthorization()
            
            print("I am onAppear")
        }
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
