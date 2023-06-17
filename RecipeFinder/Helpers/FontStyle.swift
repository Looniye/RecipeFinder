import UIKit

enum Font: String {
	case regular = "SFProText-Regular"
	case bold = "SFProText-Bold"
	
	var name: String {
		return self.rawValue
	}
}

struct FontDescription {
	let font: Font
	let size: CGFloat
}

enum TextStyle {
	case ultraBig //80pt, Bold
	case bigTitle //30pt, Bold
	case miniBigTitle //20pt, Bold
	case largeTitle //24pt, Bold
	case smallTitle //14pt, Bold
	case largeLabel //16pt, Bold
	case smallLabel //14pt, Bold
	case mini //10pt, Bold
	
}

extension TextStyle {
	private var fontDescription: FontDescription {
		switch self {
		case.ultraBig:
			return FontDescription(font: .bold, size: 80)
		case.bigTitle:
			return FontDescription(font: .bold, size: 30)
		case.miniBigTitle:
			return FontDescription(font: .bold, size: 20)
		case .largeTitle:
			return FontDescription(font: .bold, size: 24)
		case .smallTitle:
			return FontDescription(font: .bold, size: 14)
		case .largeLabel:
			return FontDescription(font: .bold, size: 16)
		case .smallLabel:
			return FontDescription(font: .bold, size: 14)
		case .mini:
			return FontDescription(font: .bold, size: 10)
		}
	}
}

extension TextStyle {
	var font: UIFont {
		guard let font = UIFont(name: fontDescription.font.name, size: fontDescription.size) else { return self.font }
		return font
	}
}
