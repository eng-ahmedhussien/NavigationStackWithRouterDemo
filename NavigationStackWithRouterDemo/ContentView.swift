//
//  ContentView.swift
//  NavigationStackWithRouterDemo
//
//  Created by ahmed hussien on 27/01/2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        RouterView {
            TapBarView()
        }
    }
}

#Preview {
    ContentView()
}

struct ViewA: View {
    @EnvironmentObject var router: Router
    @State private var showNavigationBar = true
    var body: some View {
        NavigationView{
            VStack() {
                Button("Go to View B") {
                    router.navigateTo(.viewB(""))
                }
                Button("Go to View C") {
                    router.navigateTo(.viewC)
                }
                
                Button("Show ViewB (Modal)") {
                    router.showView(.SheetView)
                }
                
                Button("backTo Root") {
                    router.popToRoot()
                }
                
                NavigationLink("View Details") {
                    DetailView()
                }
             
                
            }
           
            .navigationBarWithLogo()
            .navigationTitle("View A")
        }
       
    }
}

struct ViewB: View {
    @EnvironmentObject var router: Router
    let description: String
    
    var body: some View {
        VStack() {
            Text(description)
            Button("Go to View A") {
                router.navigateTo(.viewA)
            }
            Button("Go to View C") {
                router.navigateTo(.viewC)
            }
            
            Button("Show ViewB (Modal)") {
                router.showView(.SheetView)
            }
            Button("backTo Root") {
                router.popToRoot()
            }
        }
        .navigationTitle("View B")
    }
}

struct ViewC: View {
    @EnvironmentObject var router: Router
    
    var body: some View {
        VStack() {
            Button("Go to View B") {
                router.navigateTo(.viewB("Got here from C"))
            }
            Button("Go back") {
                router.navigateBack()
            }
            Button("backTo Root") {
                router.popToRoot()
            }
        }
       
        .navigationTitle("View C")
    }
}

struct SheetView: View {
    @EnvironmentObject var router: Router
    
    var body: some View {
        VStack() {
            Button("Go to View B") {
                router.navigateTo(.viewB("Got here from C"))
            }
            Button("Go back") {
                router.navigateBack()
            }
            
            Button("Dismiss") {
                router.dismissPresentedView() // Dismiss the full-screen modal
            }
            .padding()
            .foregroundColor(.white)
            .background(Color.blue)
            .cornerRadius(10)
            
            Button("backTo Root") {
                router.popToRoot()
            }
        }
        .navigationTitle("View C")
    }
}


struct DetailView: View {
    @State private var showNavigationBar = true

    var body: some View {
        Text("Detail View")
            .toolbar(showNavigationBar ? .visible : .hidden,for: .tabBar)
            .onTapGesture {
                withAnimation {
                    showNavigationBar.toggle()
                }
            }
    }
}
