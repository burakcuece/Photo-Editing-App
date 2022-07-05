//
//  CameraView.swift
//  Photo Editing App
//
//  Created by Burak Cüce on 05.07.22.
//

import SwiftUI

struct CameraView: View {
    
    @StateObject var camera = CameraModel()
    
    var body: some View {
        
        ZStack {
            
            Color.black
                .ignoresSafeArea(.all, edges: .all)
            
            VStack {
                
                if camera.isTaken {
                    Button(action: {
                        
                    }, label: {
                        Image(systemName: "arrow.triangle.2.circlepath.camera")
                            .foregroundColor(Color.black)
                            .padding()
                            .background(Color.white)
                            .clipShape(Circle())
                    })
                    .padding(.trailing, 10)
                }
                
                Spacer()
                
                HStack {
                    
                    if camera.isTaken {
                        
                        Button(action: {
                            
                        }, label: {
                            Text("Save")
                                .foregroundColor(Color.black)
                                .fontWeight(.semibold)
                                .padding(.vertical, 10)
                                .padding(.horizontal, 20)
                                .background(Color.white)
                                .clipShape(Capsule())
                        })
                        .padding(.leading)
                        
                        Spacer()
                        
                    } else {
                        Button {
                            camera.isTaken.toggle()
                        } label: {
                            
                            ZStack {
                                
                                Circle()
                                    .fill(Color.white)
                                    .frame(width: 65, height: 65)
                                
                                Circle()
                                    .stroke(Color.white, lineWidth: 2)
                                    .frame(width: 75, height: 75)
                            }
                        }
                    }
                }
                .frame(height: 75)

            }
        }
    }
}

struct CameraView_Previews: PreviewProvider {
    static var previews: some View {
        CameraView()
    }
}
