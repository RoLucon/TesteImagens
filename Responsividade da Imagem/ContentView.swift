//
//  ContentView.swift
//  Responsividade da Imagem
//
//  Created by Rogerio Lucon on 30/06/21.
//

import SwiftUI

class ViewModel: ObservableObject {
    let screenSize = UIScreen.main.bounds.size
    var width: CGFloat { UIScreen.main.bounds.size.width }
    var height: CGFloat { UIScreen.main.bounds.size.height }
    
    func start() {
        print("Screen: \(screenSize)")
        print("\(screenSize.height / screenSize.width)")
    }
    
    func isSE() -> Bool {
        let screen = UIScreen.main.bounds.size
        
        let value = screen.height / screen.width
        return value < 1.779 ? true : false
    }
}

struct ContentView: View {
    @ObservedObject var vm = ViewModel()
    
    // Proporção
    let scale: CGFloat = 16 / 9
    
    var body: some View {
        
        //        Resizeble()
        
        Adjust()
            .ignoresSafeArea()
    }
}

struct Resizeble: View {
    @ObservedObject var vm = ViewModel()
    
    let scale: CGFloat = 16 / 9
    
    var body: some View {
        Image("ImagemTeste")
            .resizable()
            .frame(width: vm.height / scale, height: vm.height, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            .ignoresSafeArea()
            .onAppear {
                vm.start()
            }
    }
}

struct Adjust: View {
    @ObservedObject var vm = ViewModel()
    
    let scale: CGFloat = 16 / 9
    
    var body: some View {
        
        GeometryReader { _ in
            Group {
                if vm.isSE() {
                    HStack {
                        Spacer()
                        Image("PigPage1")
                            .resizable()
                            .scaledToFit()
                        Spacer()
                            
                    }
                    .background(Color.black)
                } else {
                    Image("PigPage1")
                        .resizable()
                        .scaledToFill()
                }
                
            }
            .onAppear {
                vm.start()
        }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice(PreviewDevice(rawValue: "iPhone SE"))
            .previewDisplayName("iPhone SE")
        
        ContentView()
            .previewDevice(PreviewDevice(rawValue: "iPhone 11"))
            .previewDisplayName("iPhone 11")
        
        ContentView()
            .previewDevice(PreviewDevice(rawValue: "iPhone 12"))
            .previewDisplayName("iPhone 12")
    }
}
