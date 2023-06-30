//
//  WelcomePage.swift
//  OrderAppA
//
//

import SwiftUI

struct WelcomePage: View {
    @State var dynamicA : CGFloat = 0
    @State var isSlideDone :Bool = false
    
    var test  = MenuItemLoader()
    
    var body: some View {
        ZStack {
            
            if (!isSlideDone) {
                Color.theme.orange.edgesIgnoringSafeArea(.all)
                bodyContainer
            } else {
                MenuItemPickUI(isDone: $isSlideDone)
                    .onAppear {
                        dynamicA = 0
                    }
            }
            
            
        }
    }
}


extension WelcomePage {
    
    private var bodyContainer :some View {
        VStack(spacing:20) {
            Text("Bienvenue.")
                .foregroundColor(.white)
                .fontWeight(.bold)
                .font(.system(size: 65))
            
            Image("_logo")
                .resizable()
                .scaledToFit()
                .clipShape(RoundedRectangle(cornerRadius: 80))
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 80)
                        .fill(Color.theme.purple)
                        .padding(.all,11)
                    )
            
            Text("""
                 Cest comme
                 manager a la maison.
                 """)
            .fontWeight(.bold)
            .multilineTextAlignment(.center)
            .foregroundColor(.white)
            .padding(.bottom,50)
            
            ZStack {
                
                sliddingCapsule
                    .overlay(
                        HStack {
                            Capsule()
                                .fill(.green)
                                .frame(width: dynamicA == 0 ? 75 : dynamicA + 75)
                                .padding(.leading,5)
                                .opacity(1)
                            
                            Spacer()
                        }
                    )
                    
                
                HStack {
                    sliddingButton
                        .offset(x: dynamicA, y: 0)
                        .gesture(DragGesture().onChanged({ val in
                            
                            if (UIScreen.main.bounds.size.width > val.location.x + 110) {
                                withAnimation(.linear(duration: 2)) {
                                    
                                    dynamicA = val.location.x
                                }
                                
                            }
                            
                            
                        })
                            .onEnded({ val in
                                if (UIScreen.main.bounds.size.width / 2 < val.location.x + 60)
                                {
                                    withAnimation(.linear) {
                                        dynamicA = UIScreen.main.bounds.size.width - 110
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                            withAnimation(.easeIn) {
                                                isSlideDone.toggle()
                                            }
                                        }
                                    }
                                    
                                } else {
                                    withAnimation {
                                        dynamicA = 0
                                    }
                                    
                                }
                                
                            })
                                 
                                 
                        )
                    Spacer()
                }
                
            }.padding()
        }
    }
    
    private var sliddingCapsule :some View {
        Capsule()
            .fill(.white)
            .frame(height:80)
            .frame(maxWidth:.infinity)
            .opacity(0.2)
            .overlay(
                Capsule()
                    .fill(.white)
                    .frame(height:65)
                    .frame(maxWidth:.infinity)
                    .opacity(0.3)
                    .padding(.horizontal,10)
                    .overlay(
                        Text("Commander")
                            .fontWeight(.heavy)
                            .foregroundColor(.white)
                    )
            )
    }
    
    private var sliddingButton : some View {
        Circle()
            .fill(.green)
            .scaledToFit()
            .frame(height:80)
            .overlay(
                Circle()
                    .fill()
                    .frame(height:60)
                    .opacity(0.1)
                    .overlay(
                        Image(systemName: "chevron.right.2")
                            .resizable()
                            .scaledToFit()
                            .frame(height:20)
                            .foregroundColor(.white)
                    )
            )
    }
}

struct WelcomePage_Previews: PreviewProvider {
    static var previews: some View {
        WelcomePage()
    }
}
