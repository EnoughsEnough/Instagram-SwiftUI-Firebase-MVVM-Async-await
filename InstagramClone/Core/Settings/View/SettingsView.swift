//
//  SettingsView.swift
//  InstagramClone
//
//  Created by Mark Cherenov on 05.12.2023.
//

//import SwiftUI
//
//struct Setting: Identifiable, Hashable {
//    var id: Int
//    var icon: String
//    var title: String
//}
//
//struct BottomSheetView: View {
//    @Binding var isSheetOpen: Bool
//    @Environment(\.colorScheme) var colorScheme
//    @State private var offset: CGFloat = 0
//    
//    let settings: [Setting] = [
//         Setting(id: 1,icon: "gear", title: "Edit Profile"),
//         Setting(id: 2,icon: "door.left.hand.open", title: "Sign out"),
//        ]
//    
//    var body: some View {
//        NavigationView {
//            VStack {
//                RoundedRectangle(cornerRadius: 10)
//                    .frame(width: 50, height: 5)
//                    .padding(.bottom)
//                    .foregroundStyle(colorScheme == .dark ? .gray : Color(.darkGray))
//                
//                ForEach(settings) { setting in
//                    SettingsRowView(title: setting.title, icon: setting.icon)
//                        .padding(.bottom, 14)
//                    
//                }
//                Spacer()
//            }
//        }
//        .padding(.top, 12)
//              .frame(height: 300)
//              .background(Color.modalBackground)
//              .offset(y: max(offset, 0))
//              .clipShape(RoundedRectangle(cornerRadius: 10))
//              .gesture(
//                  DragGesture()
//                      .onChanged { value in
//                          withAnimation {
//                              offset = value.translation.height
//                          }
//                      }
//                      .onEnded { value in
//                          let halfHeight = UIScreen.main.bounds.height / 2
//                          if abs(offset) > halfHeight {
//                              isSheetOpen = false
//                          } else {
//                              offset = 0
//                          }
//                      }
//              )
//              .animation(.spring())
//                     .shadow(radius: 5)
//                     .ignoresSafeArea(.all)
//                     .onChange(of: isSheetOpen) { newValue in
//                         if !newValue {
//                             offset = 0 // Сбрасываем offset при закрытии модального окна
//                         }
//                     }
//    }
//    
//}
//
//#Preview {
//    BottomSheetView(isSheetOpen: .constant(true))
//}
