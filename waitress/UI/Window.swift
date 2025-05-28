//
//  ContentView.swift
//  waitress
//

import Cocoa

import SwiftUI

struct ContentView: View {
    @State private var selectedItem: String? = nil
    
    var body: some View {
        
        NavigationView {
            SidebarView(selection: "General")
            
            Text("Select an item")
                .frame(minWidth: 400, maxWidth: .infinity, minHeight: 400, maxHeight: .infinity)
        }
        .navigationViewStyle(.columns)
    }
}

struct DetailView: View {
    
    var selection: String
    
    var body: some View {
        self.containedView()
    }
    
    private func containedView() -> AnyView {
        switch selection {
        case "Advanced":
            return AnyView(AdvancedView())
        case "Icon Settings":
            return AnyView(CView())
        default:
            return AnyView(GeneralView() /*defaultView()*/)
        }
    }
}
    
struct SidebarView: View {
    
//    private let tabs: [(title: String, icon: String)] = [
//            ("General",      "house"),
//            ("Advanced",  "folder"),
//            ("Icon Settings",  "gearshape")
//        ]
    
    let buttons = ["General", "Advanced", "Icon Settings"]
    let selection: String
        
    var body: some View {
        
        Section {
            
        } header: {
            Text("Settings")
                .font(.largeTitle.bold())
                .padding(.top, 24)
        }
        .headerProminence(.increased)
        
        
        List(buttons, id: \.self /*selection: $selectedItem*/) { item in
            NavigationLink(destination: DetailView(selection: item)) {
                Label("\(item)", systemImage: "gearshape")
            }
            
        }
        .listStyle(SidebarListStyle())
            
    }
}
        

//struct defaultView: View {
//
//    var body: some View {
//
//    }
//
//
//}

struct AdvancedView: View {
    // RGB components in the 0‒1 range
    @State private var bgColor =
        Color(.sRGB, red: 0.98, green: 0.9, blue: 0.2)
    @State private var spacing: Double = 0.5
    
    var body: some View {
        VStack(spacing: 24) {
            
            Text("Menu Bar Color")
                .font(.title)
                .frame(width: 200, alignment: .leading)
                .padding(.horizontal)


            VStack {
                ColorPicker("Alignment Guides", selection: $bgColor)
            }
        }
            
            
        HStack {
            Text("Icon Spacing")
                .font(.title)
                .frame(width: 200, alignment: .leading)
                //.padding(.horizontal)
            //maybe add some like thing to show icons for later
        }
        
        RoundedRectangle(cornerRadius: 10).fill(Color.black).frame(height: 60).brightness(0.2)
            .overlay (
                HStack {
                    SpacingSlider(value: $spacing, label: "Spacing", tint: .gray)
                }.padding(.horizontal))
        .padding(.horizontal)
            
    }
}

private struct SpacingSlider: View {
    @Binding var value: Double
    let label: String
    let tint: Color
    
    var body: some View {
        HStack {
            Text(label)
                .frame(width: 50, alignment: .leading)
            Slider(value: $value, in: 0...1)
                .tint(tint)
                .padding(.horizontal)
            Text(String(format: "%3.0f", value*15))
                .monospacedDigit()
                .frame(width: 40, alignment: .trailing)
        }
    }
}

private struct RGBSlider: View {
    @Binding var value: Double
    let label: String
    let tint: Color
    
    var body: some View {
        HStack {
            Text(label)
                .frame(width: 50, alignment: .leading)
            
            Slider(value: $value, in: 0...1)
                .tint(tint)
                .padding(.horizontal)
            
            Text(String(format: "%3.0f", value * 255))
                .monospacedDigit()
                .frame(width: 40, alignment: .trailing)
        }
    }
}
        
struct GeneralView: View {
    
    @State private var loginLaunchEnabled = false
    @State private var iconShowEnabled = false
    @State private var usingWaitressEnabled = false
    @State private var showHideItemsEnabled = false
    
    var body: some View {
        RoundedRectangle(cornerRadius: 10).fill(Color.black).frame(height: 175).brightness(0.2)
            .overlay(
        VStack (alignment: .leading, spacing: 12) {
            
            
            ToggleRow(label: "Login on Launch", isOn: $loginLaunchEnabled)
            ToggleRow(label: "Use Waitress", isOn: $usingWaitressEnabled)
                .padding(.bottom)
            ToggleRow(label: "Show Icon", isOn: $iconShowEnabled)
            ToggleRow(label: "Show/Hide Sometimes Hidden Items", isOn: $showHideItemsEnabled)
            
            
            Spacer()
          
        }.padding(.horizontal).padding(.top))
        
        .padding(.horizontal)
        .padding(.top, 16)
        
        .frame(maxWidth: .infinity,
               maxHeight: .infinity,
               alignment: .topLeading)
    }
    
}

private struct ToggleRow: View {
    let label: String
    @Binding var isOn : Bool
    
    var body: some View {
        HStack {
            Text (label)
            
            Spacer(minLength: 0)
            
            Toggle("", isOn: $isOn)
                .labelsHidden()
                .toggleStyle(.switch)
        }
    }
}
        

struct CView: View {
    var body: some View {
        VStack {
            Text("Icon Storage")
                .font(.title)
                .padding(.top, 16)
                .padding(.bottom, 16)
                .frame(maxWidth: .infinity,
                       alignment: .leading)
            
            Text("Always Shown")
                .frame(maxWidth: .infinity,
                       alignment: .leading)
                
            RoundedRectangle(cornerRadius: 10).fill(Color.black).frame(height: 60).brightness(0.2)
            
            Text("Sometimes Hidden")
                .frame(maxWidth: .infinity,
                       alignment: .leading)
                
            
            RoundedRectangle(cornerRadius: 10).fill(Color.black).frame(height: 60).brightness(0.2)
            
            Text("Always Hidden")
                .frame(maxWidth: .infinity,
                       alignment: .leading)
                
            RoundedRectangle(cornerRadius: 10).fill(Color.black).frame(height: 60).brightness(0.2)
            
        }
        .padding(.horizontal)
        .frame(maxWidth: .infinity,
               maxHeight: .infinity,
               alignment: .topLeading)
        
    }
    
}
