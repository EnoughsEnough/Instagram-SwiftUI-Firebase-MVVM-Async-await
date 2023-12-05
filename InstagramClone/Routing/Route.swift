//
//  Route.swift
//  InstagramClone
//
//  Created by Mark Cherenov on 02.12.2023.
//

import Foundation

enum Route: Hashable {
    case profile(User)
    case chatView(User)
}
