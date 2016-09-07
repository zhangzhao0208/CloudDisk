//
//  CustomTopView.m
//  CloudDisk
//
//  Created by suorui on 16/9/5.
//  Copyright © 2016年 suorui. All rights reserved.
//

#import "CustomTopView.h"
#import "Masonry.h"
#import "SRConst.h"
#import "YYText.h"
#import "AdjustFontSizeView.h"
@implementation CustomTopView



-(instancetype)initWithWidth:(float)width WithHeight:(float)height
{
    self =[super init];
    if (self) {
        
        _width = width;
        _height=height;
        [self createTopView];
        
    }
    
    return self;
}

-(void)createTopView
{
    self.backgroundColor =[UIColor blackColor];
    
     YYLabel*topLabel =[YYLabel new];
    [self addSubview:topLabel];
    topLabel.text = publicCloud;
//    topLabel.lineBreakMode = 10;
    topLabel.textColor = [UIColor whiteColor];
    [AdjustFontSizeView adjustTitleFontSize:_width WithView:topLabel];
    [topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.top.offset(20);
        make.width.offset(100);
        make.bottom.offset(-10);
        
    }];
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
