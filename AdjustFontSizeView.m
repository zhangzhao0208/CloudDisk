//
//  AdjustFontSizeView.m
//  YYModelText
//
//  Created by suorui on 16/9/2.
//  Copyright © 2016年 suorui. All rights reserved.
//

#import "AdjustFontSizeView.h"
static float smallScreenTextFont=16;
static float bigScreenTextFont=18;
static float ipadScreenTextFont=20;
static float smallScreenTitleFont=16;
static float bigScreenTitleFont=18;
static float ipadScreenTitleFont=24;
@implementation AdjustFontSizeView

+(void)adjustTextFontSize:(float )width WithView:(UIView*)currentView
{
    if ([currentView isKindOfClass:[UIButton class]]) {
        
         UIButton*button =(UIButton*)currentView;
        if (width==320) {
            button.titleLabel.font =[UIFont systemFontOfSize:smallScreenTextFont];
            
        }else if (width>320||width<=414)
        {
             button.titleLabel.font =[UIFont systemFontOfSize:bigScreenTextFont];
        }else
        {
            button.titleLabel.font =[UIFont systemFontOfSize:ipadScreenTextFont];
        }
       
        
    }
    
    if ([currentView isKindOfClass:[UILabel class]]) {
        UILabel*label = (UILabel*)currentView;
        if (width==320) {
            
            label.font = [UIFont systemFontOfSize:smallScreenTextFont];
            
        }else if(width>320||width<=414)
        {
            label.font = [UIFont systemFontOfSize:bigScreenTextFont];
        }else
        {
            label.font = [UIFont systemFontOfSize:ipadScreenTextFont];
        }
        
    }

}
+(CGSize)labelAdjustString:(NSString*)string WithWidth:(float)LabelWidth WithHeight:(float)LabelHeight withFont:(UIFont*)font
{

    NSDictionary *attribute = @{NSFontAttributeName: font};
    
    CGSize retSize = [string boundingRectWithSize:CGSizeMake(LabelWidth, LabelHeight) options:
                      NSStringDrawingTruncatesLastVisibleLine |NSStringDrawingUsesLineFragmentOrigin |
                      NSStringDrawingUsesFontLeading
                                       attributes:attribute
                                          context:nil].size;
    
    return retSize;
}


+(void)adjustTextFontSize:(float )width WithAttributedString:(NSMutableAttributedString*)text
{
    
    if ([text isKindOfClass:[NSMutableAttributedString class]]) {
       
        if (width==320) {
            
            text.yy_font = [UIFont boldSystemFontOfSize:smallScreenTextFont];
            
        }else if(width>320||width<=414)
        {
          text.yy_font = [UIFont boldSystemFontOfSize:bigScreenTextFont];
        }else
        {
            text.yy_font  = [UIFont boldSystemFontOfSize:ipadScreenTextFont];
        }
        
    }
    
}

+(void)adjustTitleFontSize:(float )width WithView:(UIView*)currentView
{
    if ([currentView isKindOfClass:[UIButton class]]) {
        
        UIButton*button =(UIButton*)currentView;
        if (width==320) {
            button.titleLabel.font =[UIFont systemFontOfSize:smallScreenTitleFont];
            
        }else if (width>320||width<=414)
        {
            button.titleLabel.font =[UIFont systemFontOfSize:bigScreenTitleFont];
        }else
        {
            button.titleLabel.font =[UIFont systemFontOfSize:ipadScreenTitleFont];
        }
    }
    
    if ([currentView isKindOfClass:[UILabel class]]) {
        UILabel*label = (UILabel*)currentView;
        if (width==320) {
            
            label.font = [UIFont systemFontOfSize:smallScreenTitleFont];
            
        }else if(width>320||width<=414)
        {
            label.font = [UIFont systemFontOfSize:bigScreenTitleFont];
        }else
        {
            label.font = [UIFont systemFontOfSize:ipadScreenTitleFont];
        }
        
    }

}

@end
