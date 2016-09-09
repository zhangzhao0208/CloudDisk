//
//  AdjustFontSizeView.h
//  YYModelText
//
//  Created by suorui on 16/9/2.
//  Copyright © 2016年 suorui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YYText.h"
@interface AdjustFontSizeView : UIView
+(void)adjustTextFontSize:(float )width WithView:(UIView*)currentView ;
+(CGSize)labelAdjustString:(NSString*)string WithWidth:(float)LabelWidth WithHeight:(float)LabelHeight withFont:(UIFont*)font;
+(void)adjustTextFontSize:(float )width WithAttributedString:(NSMutableAttributedString*)text;
+(void)adjustTitleFontSize:(float )width WithView:(UIView*)currentView;

@end
