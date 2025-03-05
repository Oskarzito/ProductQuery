//
//  Toast.swift
//  ProductQuery
//
//  Created by Oskar Emilsson on 2025-03-05.
//

import SwiftUI

public enum ToastStyle {
    case success
}

public struct Toast: Equatable {
    var style: ToastStyle
    var message: String
    var duration: Double
    var width: Double
    
    public init(
        style: ToastStyle,
        message: String,
        duration: Double = 2,
        width: Double = .infinity
    ) {
        self.style = style
        self.message = message
        self.duration = duration
        self.width = width
    }
}


extension ToastStyle {
    var themeColor: Color {
        switch self {
        case .success: return Color.green
        }
    }
    
    var icon: Image {
        switch self {
        case .success: return Image(systemName: "hammer.circle")
        }
    }
}

struct ToastView: View {
    
    var style: ToastStyle
    var message: String
    var width = CGFloat.infinity
    
    var body: some View {
        HStack(alignment: .center, spacing: 12) {
            style.icon
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 24, height: 24)
                .foregroundStyle(Color.green)
            
            Text(message)
                .font(.caption)
                .fontWeight(.bold)
                .foregroundColor(Color.green)
            
            Spacer(minLength: 10)
        }
        .padding()
        .frame(minWidth: 0, maxWidth: width)
        .background(Color.green.opacity(0.05))
        .cornerRadius(8)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.green, lineWidth: 1)
        )
        .padding(.horizontal, 16)
    }
}

#Preview {
    ToastView(
        style: .success,
        message: "Toast message"
    )
}
