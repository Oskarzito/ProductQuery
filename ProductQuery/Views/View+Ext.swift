//
//  View+Ext.swift
//  ProductQuery
//
//  Created by Oskar Emilsson on 2025-03-05.
//

import SwiftUI

extension View {
    public func toastView(toast: Binding<Toast?>) -> some View {
        self.modifier(ToastModifier(toast: toast))
    }
}
