//
//  UpdateStore.swift
//  DesignCodePlitz
//
//  Created by Norman Pleitez on 3/11/23.
//

import SwiftUI
import Combine

class UpdateStore: ObservableObject {
    @Published var updates: [Update] = updateData
}
