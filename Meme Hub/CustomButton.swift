//
//  CustomButton.swift
//  Meme Hub
//
//  Created by Abdelrahman Yasser on 05/07/2025.
//

import SwiftUI

// MARK: - Button Variant Enum
enum ButtonVariant {
    case primary
    case secondary
    case error
    case success
    
    var backgroundColor: Color {
        switch self {
        case .primary:
            return .blue
        case .secondary:
            return .gray
        case .error:
            return .red
        case .success:
            return .green
        }
    }
    
    var foregroundColor: Color {
        switch self {
        case .primary, .error, .success:
            return .white
        case .secondary:
            return .primary
        }
    }
    
    var borderColor: Color {
        switch self {
        case .primary:
            return .blue
        case .secondary:
            return .gray
        case .error:
            return .red
        case .success:
            return .green
        }
    }
    
    var disabledBackgroundColor: Color {
        switch self {
        case .primary, .error, .success:
            return backgroundColor.opacity(0.3)
        case .secondary:
            return Color.gray.opacity(0.2)
        }
    }
    
    var disabledForegroundColor: Color {
        switch self {
        case .primary, .error, .success:
            return .white.opacity(0.7)
        case .secondary:
            return .gray.opacity(0.5)
        }
    }
}

// MARK: - Button Size Enum
enum ButtonSize {
    case small
    case medium
    case large
    
    var padding: EdgeInsets {
        switch self {
        case .small:
            return EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16)
        case .medium:
            return EdgeInsets(top: 12, leading: 20, bottom: 12, trailing: 20)
        case .large:
            return EdgeInsets(top: 16, leading: 24, bottom: 16, trailing: 24)
        }
    }
    
    var fontSize: CGFloat {
        switch self {
        case .small:
            return 14
        case .medium:
            return 16
        case .large:
            return 18
        }
    }
    
    var cornerRadius: CGFloat {
        switch self {
        case .small:
            return 6
        case .medium:
            return 8
        case .large:
            return 10
        }
    }
}

// MARK: - Custom Button Component
struct CustomButton: View {
    // MARK: - Properties
    let title: String
    let variant: ButtonVariant
    let size: ButtonSize
    let isLoading: Bool
    let isDisabled: Bool
    let action: () -> Void
    
    // Optional icon
    let icon: String?
    let iconPosition: IconPosition
    
    // MARK: - Initializers
    init(
        title: String,
        variant: ButtonVariant = .primary,
        size: ButtonSize = .medium,
        isLoading: Bool = false,
        isDisabled: Bool = false,
        icon: String? = nil,
        iconPosition: IconPosition = .leading,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.variant = variant
        self.size = size
        self.isLoading = isLoading
        self.isDisabled = isDisabled
        self.icon = icon
        self.iconPosition = iconPosition
        self.action = action
    }
    
    // MARK: - Computed Properties
    private var shouldDisableButton: Bool {
        isDisabled || isLoading
    }
    
    private var backgroundColor: Color {
        shouldDisableButton ? variant.disabledBackgroundColor : variant.backgroundColor
    }
    
    private var foregroundColor: Color {
        shouldDisableButton ? variant.disabledForegroundColor : variant.foregroundColor
    }
    
    // MARK: - Body
    var body: some View {
        Button(action: {
            if !shouldDisableButton {
                // Add haptic feedback
                let impactFeedback = UIImpactFeedbackGenerator(style: .light)
                impactFeedback.impactOccurred()
                action()
            }
        }) {
            HStack(spacing: 8) {
                if isLoading {
                    loadingView
                } else {
                    contentView
                }
            }
            .font(.system(size: size.fontSize, weight: .medium))
            .foregroundColor(foregroundColor)
            .padding(size.padding)
            .background(backgroundColor)
            .cornerRadius(size.cornerRadius)
            .overlay(
                RoundedRectangle(cornerRadius: size.cornerRadius)
                    .stroke(variant.borderColor.opacity(shouldDisableButton ? 0.3 : 1), lineWidth: 1)
            )
            .scaleEffect(shouldDisableButton ? 1.0 : 1.0)
            .animation(.easeInOut(duration: 0.1), value: shouldDisableButton)
        }
        .disabled(shouldDisableButton)
        .buttonStyle(CustomButtonStyle())
    }
    
    // MARK: - View Components
    @ViewBuilder
    private var loadingView: some View {
        ProgressView()
            .progressViewStyle(CircularProgressViewStyle(tint: foregroundColor))
            .scaleEffect(0.8)
        
        Text(title)
    }
    
    @ViewBuilder
    private var contentView: some View {
        if let icon = icon {
            switch iconPosition {
            case .leading:
                Image(systemName: icon)
                Text(title)
            case .trailing:
                Text(title)
                Image(systemName: icon)
            case .only:
                Image(systemName: icon)
            }
        } else {
            Text(title)
        }
    }
}

// MARK: - Icon Position Enum
enum IconPosition {
    case leading
    case trailing
    case only
}

// MARK: - Custom Button Style
struct CustomButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .opacity(configuration.isPressed ? 0.8 : 1.0)
            .animation(.easeInOut(duration: 0.1), value: configuration.isPressed)
    }
}

#Preview {
    ScrollView {
        VStack(spacing: 20) {
            // Basic variants
            Group {
                Text("Basic Variants")
                    .font(.headline)
                    .padding(.top)
                
                CustomButton(title: "Primary Button", variant: .primary) {
                    print("Primary tapped")
                }
                
                CustomButton(title: "Secondary Button", variant: .secondary) {
                    print("Secondary tapped")
                }
                
                CustomButton(title: "Error Button", variant: .error) {
                    print("Error tapped")
                }
                
                CustomButton(title: "Success Button", variant: .success) {
                    print("Success tapped")
                }
            }
            
            // Sizes
            Group {
                Text("Sizes")
                    .font(.headline)
                    .padding(.top)
                
                CustomButton(title: "Small", variant: .primary, size: .small) {
                    print("Small tapped")
                }
                
                CustomButton(title: "Medium", variant: .primary, size: .medium) {
                    print("Medium tapped")
                }
                
                CustomButton(title: "Large", variant: .primary, size: .large) {
                    print("Large tapped")
                }
            }
            
            // States
            Group {
                Text("States")
                    .font(.headline)
                    .padding(.top)
                
                CustomButton(title: "Loading", variant: .primary, isLoading: true) {
                    print("Loading tapped")
                }
                
                CustomButton(title: "Disabled", variant: .primary, isDisabled: true) {
                    print("Disabled tapped")
                }
                
                CustomButton(title: "Disabled Loading", variant: .secondary, isLoading: true, isDisabled: true) {
                    print("Disabled Loading tapped")
                }
            }
            
            // With icons
            Group {
                Text("With Icons")
                    .font(.headline)
                    .padding(.top)
                
                CustomButton(title: "Download", variant: .primary, icon: "arrow.down.circle", iconPosition: .leading) {
                    print("Download tapped")
                }
                
                CustomButton(title: "Share", variant: .secondary, icon: "square.and.arrow.up", iconPosition: .trailing) {
                    print("Share tapped")
                }
                
                CustomButton(title: "Delete", variant: .error, icon: "trash", iconPosition: .leading) {
                    print("Delete tapped")
                }
                
                CustomButton(title: "", variant: .success, icon: "checkmark", iconPosition: .only) {
                    print("Check tapped")
                }
            }
            
            // Error states
            Group {
                Text("Error States")
                    .font(.headline)
                    .padding(.top)
                
                CustomButton(title: "Retry", variant: .error, isLoading: true) {
                    print("Retry tapped")
                }
                
                CustomButton(title: "Disabled Error", variant: .error, isDisabled: true) {
                    print("Disabled Error tapped")
                }
            }
            
            // Success states
            Group {
                Text("Success States")
                    .font(.headline)
                    .padding(.top)
                
                CustomButton(title: "Save", variant: .success, icon: "checkmark.circle", iconPosition: .leading) {
                    print("Save tapped")
                }
                
                CustomButton(title: "Saving...", variant: .success, isLoading: true) {
                    print("Saving tapped")
                }
            }
        }
        .padding()
    }
    .scrollIndicators(.hidden)
}

