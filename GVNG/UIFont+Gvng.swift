//
//  UIFont+Gvng.swift
//  GVNG
//
//  Created by Alex Samarchi on 9/2/17.
//  Copyright © 2017 Gvng Gvng. All rights reserved.
//

import Foundation
// Text styles

extension UIFont {
    class func gvngErrorTitleFont() -> UIFont {
        return UIFont.systemFont(ofSize: 40.0, weight: UIFontWeightBold)
    }

    class func gvngOnboardingHeaderFont() -> UIFont {
        return UIFont.systemFont(ofSize: 26.0, weight: UIFontWeightBold)
    }
    
    class func gvngOnboardingTextFieldFont() -> UIFont {
        return UIFont.systemFont(ofSize: 26.0, weight: UIFontWeightRegular)
    }
    
    class func gvngOnboardingCountryCodeFont() -> UIFont {
        return UIFont.systemFont(ofSize: 14.0, weight: UIFontWeightBold)
    }
    
    class func gvngErrorSubtitleFont() -> UIFont {
        return UIFont.systemFont(ofSize: 20.0, weight: UIFontWeightRegular)
    }
    
    class func gvngHeaderFont() -> UIFont {
        return UIFont.systemFont(ofSize: 20.0, weight: UIFontWeightBold)
    }
    
    class func gvngSectionHeaderFont() -> UIFont {
        return UIFont.systemFont(ofSize: 20.0, weight: UIFontWeightBold)
    }
    
    class func gvngSelecttextFont() -> UIFont {
        return UIFont.systemFont(ofSize: 15.0, weight: UIFontWeightBold)
    }
    
    class func gvngSongNameFont() -> UIFont {
        return UIFont.systemFont(ofSize: 15.0, weight: UIFontWeightBold)
    }
    
    class func gvngArtistFont() -> UIFont {
        return UIFont.systemFont(ofSize: 13.0, weight: UIFontWeightRegular)
    }
    
    class func gvngSmallHandleFont() -> UIFont {
        return UIFont.systemFont(ofSize: 11.0, weight: UIFontWeightBold)
    }
    
    class func gvngSmallNameFont() -> UIFont {
        return UIFont.systemFont(ofSize: 11.0, weight: UIFontWeightRegular)
    }
    
    class func gvngTinnyStatsFont() -> UIFont {
        return UIFont.systemFont(ofSize: 10.0, weight: UIFontWeightBold)
    }
}
