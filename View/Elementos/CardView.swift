//
//  CardView.swift
//  IphoneIpadFirebase
//
//  Created by Rober on 10-07-22.
//

import Foundation
import SwiftUI

struct CardView : View {
    var body: some View {
        VStack(spacing: 20){
            Image("imagen")
                .resizable()
                .aspectRatio(contentMode: .fit)
            Text("TitanFall 2")
                .font(.title)
                .bold()
                .foregroundColor(.black)
        }.padding()
            .background(Color.white)
            .cornerRadius(20)
    }
}
