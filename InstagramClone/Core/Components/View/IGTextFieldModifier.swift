//
//  IGTextFieldModifier.swift
//  InstagramClone
//
//  Created by Mark Cherenov on 27.11.2023.
//

import Foundation
import SwiftUI

struct IGTextFieldModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .autocorrectionDisabled()
            .padding(12)
            .background(Color(.systemGray6))
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .padding(.horizontal, 24)
    }
}
