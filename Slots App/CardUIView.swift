//
//  CardUIView.swift
//  Slots App
//
//  Created by Лілія on 08.02.2023.
//

import SwiftUI

struct CardUIView: View {
    @Binding var symbol: String
    @Binding var background: Color
    private let transition: AnyTransition = AnyTransition.move(edge: .bottom )
    var body: some View {
        VStack {
            if symbol == "cherry" {
                Image(symbol).resizable()
                .aspectRatio(1, contentMode: .fit)
                .transition(transition)
            } else if symbol == "apple" {
                Image(symbol).resizable()
                .aspectRatio(1, contentMode: .fit)
                .transition(transition)
            } else {
                Image(symbol).resizable()
                .aspectRatio(1, contentMode: .fit)
                .transition(transition)
            }
        } .background(background .opacity(0.5)
            .cornerRadius(20))
    }
       
}

struct CardUIView_Previews: PreviewProvider {
    static var previews: some View {
        CardUIView(symbol: Binding.constant("apple"), background: Binding.constant(.white))
    }
}
