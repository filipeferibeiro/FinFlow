import SwiftUI
import Foundation

public extension Color {
    init?(hex: String) {
        // Trim and remove leading '#'
        var hexString = hex.trimmingCharacters(in: .whitespacesAndNewlines)
            .uppercased()
        if hexString.hasPrefix("#") {
            hexString.removeFirst()
        }
        
        // Expand shorthand forms: RGB (3) or RGBA (4)
        if hexString.count == 3 || hexString.count == 4 {
            var expanded = ""
            for ch in hexString { expanded.append(ch); expanded.append(ch) }
            hexString = expanded
        }
        
        // Now expect 6 (RRGGBB) or 8 (RRGGBBAA)
        guard hexString.count == 6 || hexString.count == 8 else { return nil }
        
        var rgbaValue: UInt64 = 0
        guard Scanner(string: hexString).scanHexInt64(&rgbaValue) else { return nil }
        
        let r, g, b, a: CGFloat
        if hexString.count == 6 {
            r = CGFloat((rgbaValue & 0xFF0000) >> 16) / 255.0
            g = CGFloat((rgbaValue & 0x00FF00) >> 8) / 255.0
            b = CGFloat(rgbaValue & 0x0000FF) / 255.0
            a = 1.0
        } else { // 8 characters: RRGGBBAA
            r = CGFloat((rgbaValue & 0xFF000000) >> 24) / 255.0
            g = CGFloat((rgbaValue & 0x00FF0000) >> 16) / 255.0
            b = CGFloat(rgbaValue & 0x0000FF00 >> 8) / 255.0
            a = CGFloat(rgbaValue & 0x000000FF) / 255.0
        }
        
        self = Color(.sRGB, red: r, green: g, blue: b, opacity: a)
    }
    
    func toHex() -> String {
        let uiColor = UIColor(self)
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        
        uiColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        let r = Int(red * 255.0)
        let g = Int(green * 255.0)
        let b = Int(blue * 255.0)
        
        return String(format: "#%02X%02X%02X", r, g, b)
    }
}
