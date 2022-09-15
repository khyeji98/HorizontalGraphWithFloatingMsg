//
//  ContentView.swift
//  HorizontalGraphWithFloatingMsg
//
//  Created by 김혜지 on 2022/09/16.
//

import SwiftUI

struct ContentView: View {
    @State private var isAnimating: Bool = false
    @State private var longerWidth: CGFloat = 0
    @State private var shorterWidth: CGFloat = 0
    
    
    let screenSize: CGSize = UIScreen.main.bounds.size
    let currentValue: Double = 144
    let currentMaximumValue: Double = 200
    let maximumValue: Double = 300
    
    var body: some View {
        VStack {
            ZStack {
                Text("화이팅")
                    .foregroundColor(.white)
                    .padding([.vertical, .horizontal], 8)
                    .background {
                        RoundedRectangle(cornerRadius: 10)
                            .frame(height: 20)
                    }
            }
            .offset(x: self.calculateFloatingOffset())
            
            HStack {
                VStack {
                    ZStack {
                        HStack {
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: self.isAnimating ? self.longerWidth : 0, height: 20)
                                .foregroundColor(.black.opacity(0.5))
                            
                            Spacer()
                        }
                        
                        HStack {
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: self.isAnimating ? self.shorterWidth : 0, height: 20)
                                .foregroundColor(.black)
                            
                            Spacer()
                        }
                    }
                }
                
                Spacer()
            }
        }
        .padding(.horizontal, 20)
        .onAppear {
            self.viewAppeared()
        }
    }
    
    private func viewAppeared() {
        self.longerWidth = self.calculateWidth(by: self.currentMaximumValue)
        self.shorterWidth = self.calculateWidth(by: self.currentValue)
        
        withAnimation(.linear(duration: 1)) {
            self.isAnimating = true
        }
    }
    
    private func calculateWidth(by value: Double) -> CGFloat {
        withAnimation(.linear(duration: 2)) {
            let rate: Double = value / self.maximumValue
            return (self.screenSize.width - 40) * CGFloat(rate)
        }
    }
    
    private func calculateFloatingOffset() -> CGFloat {
        let xPosition: CGFloat = self.shorterWidth + ((self.longerWidth - self.shorterWidth) / 2) + 20
        return (xPosition - self.screenSize.width / 2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice("iPhone 13 Pro")
    }
}
