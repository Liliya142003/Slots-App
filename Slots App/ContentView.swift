//
//  ContentView.swift
//  Slots App
//
//  Created by Лілія on 08.02.2023.
//

import SwiftUI

struct ContentView: View {
    @State private var symbols = ["apple", "cherry", "star"]
    @State private var numbers = Array(repeating: 0, count: 9)
    @State private var credits = 1000
    @State private var backgrounds = Array(repeating: Color.white, count: 9)
    @State private var isMatched  = false
    @State private var  win = false
    private var betAmount = 5
    var body: some View {
        ZStack{
            Rectangle()
                .foregroundColor(Color (red: 200/255, green: 143/255, blue: 32/255))
                .edgesIgnoringSafeArea(.all)
            Rectangle().foregroundColor(Color(red: 228/255, green: 195/255, blue: 77/255)).rotationEffect(Angle(degrees: 45)).edgesIgnoringSafeArea(.all)
            VStack{
                //Title
                Spacer()
                HStack{
                    Image(systemName: "star.fill").foregroundColor(.yellow)
                    Text("SwiftUI Slots").foregroundColor(.white).fontWeight(.bold)
                    
                    Image(systemName: "star.fill").foregroundColor(.yellow)
                }.scaleEffect(2)
                //Credits counter
                Spacer()
                Text ("Credits: \(credits)")
                    .padding(.all, 10)
                    .foregroundColor(.black)
                    .background(win ? Color.green .opacity(0.5) : Color.white .opacity(0.5))
                    .animation(.none)
                    .cornerRadius(20)
                    .scaleEffect(win ? 1.2 : 1)
                    .animation(.spring(response: 0.7, dampingFraction: 0.3))
                Spacer()
                //Cards
                VStack{
                    HStack{
                        Spacer()
                        CardUIView(symbol: $symbols[numbers[0]], background: $backgrounds[0])
                        CardUIView(symbol: $symbols[numbers[1]], background: $backgrounds[1])
                        CardUIView(symbol: $symbols[numbers[2]], background: $backgrounds[2])
                        Spacer()
                    }
                    HStack{
                        Spacer()
                        CardUIView(symbol: $symbols[numbers[3]], background: $backgrounds[3])
                        CardUIView(symbol: $symbols[numbers[4]], background: $backgrounds[4])
                        CardUIView(symbol: $symbols[numbers[5]], background: $backgrounds[5])
                        Spacer()
                    }
                    HStack{
                        Spacer()
                        CardUIView(symbol: $symbols[numbers[6]], background: $backgrounds[6])
                        CardUIView(symbol: $symbols[numbers[7]], background: $backgrounds[7])
                        CardUIView(symbol: $symbols[numbers[8]], background: $backgrounds[8])
                        Spacer()
                    }
                }
                Spacer()
                //  VStack{
                HStack(spacing: 20){
                    VStack{
                        Button ("Spin") {
                            // Process a single spin
                            self.processResult()
                            
                        } .padding()
                        
                            .padding([.leading, .trailing], 40)
                            .foregroundColor(.white)
                            .background(Color(.systemPink))
                            .cornerRadius(25)
                            .font(.system(size: 18, weight: .bold, design: .default))
                        Text ("\(betAmount) Credits").padding(.top, 10).font(.footnote)
                        
                    }
                    VStack{
                        Button ("Max Spin") {
                            self.processResult(true)
                        }.padding()
                        
                            .padding([.leading, .trailing], 40)
                            .foregroundColor(.white)
                            .background(Color(.systemPink))
                            .cornerRadius(25)
                            .font(.system(size: 18, weight: .bold, design: .default))
                        Text ("Credits").padding(.top, 10).font(.footnote)
                    }
                }
                Spacer()
            }
        }
        
        .animation(.easeOut)
    }
    func processResult(_ isMax:Bool = false){
        self.backgrounds = self.backgrounds.map {_ in
            Color.white
        }
        
        if isMax {
            //Spin all the cards
            self.numbers = self.numbers.map({ _ in
                Int.random(in: 0...symbols.count - 1 )
            })
        } else {
            // Spin the middle row
            self.numbers[3] = Int.random(in: 0...self.symbols.count - 1)
            self.numbers[4] = Int.random(in: 0...self.symbols.count - 1)
            self.numbers[5] = Int.random(in: 0...self.symbols.count - 1)
        }
        processWin(isMax)
        
    }
    func processWin(_ isMax:Bool = false){
        var matches = 0
        // processing for single spin
        if !isMax{
            
            if isMatch(3, 4, 5){matches += 1}
            
        } else {
            //Processing for max spin
            //Top row
            if isMatch(0, 1, 2){matches += 1}
            
            // Middle row
            if isMatch(3, 4, 5){matches += 1}
            
            //Bottom row
            if isMatch(6, 7, 8){matches += 1}
            
            //Diagonal top left to bottom right
            if isMatch(0, 4, 8){matches += 1}
            
            //Diagonal top right to bottom  left
            if isMatch(2, 4, 6){matches += 1}
           
        }
        
        self.win = false
        //Check matches and destribute credits
        if matches > 0 {
            // At least one win
            self.credits +=  matches * betAmount * 2
            self.win = true
        } else if !isMax {
            // 0 win, single spin
            self.credits -= betAmount
        } else {
            // 0 wins, max spin
            self.credits -= betAmount * 5
        }
    }
    
    func isMatch(_ index1: Int, _ index2: Int, _ index3: Int) -> Bool{
        if self.numbers[index1] == self.numbers[index2] && self.numbers[index2] == self.numbers[index3] {
            self.backgrounds[index1] = Color.green
            self.backgrounds[index2] = Color.green
            self.backgrounds[index3] = Color.green
            return true
        }
        return false
    }
    
}





struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
