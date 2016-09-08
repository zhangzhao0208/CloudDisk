//
//  SearchBackgroundView.m
//  CloudDisk
//
//  Created by suorui on 16/9/8.
//  Copyright © 2016年 suorui. All rights reserved.
//

#import "SearchBackgroundView.h"
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height
#define REB(R,E,D,A) ([UIColor  colorWithRed:R/255.0 green:E/255.0 blue:D/255.0 alpha:A])
@implementation SearchBackgroundView


-(instancetype)initWithFrame:(CGRect)frame
{
    self =[super initWithFrame:frame];
    if (self) {
        
        [self createSearchBackgroundView];
    }
    
    return self;
}

-(void)createSearchBackgroundView
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    self.backgroundColor = REB(25, 25, 25, 0.3);
    UIView*searchView =[UIView new];
    [self addSubview:searchView];
    searchView.frame = CGRectMake(0, 0, WIDTH, 80);
    searchView.backgroundColor =[UIColor whiteColor];
    UITextField*searchTextField =[UITextField new];
    searchTextField.borderStyle = UITextBorderStyleRoundedRect;
    [searchView addSubview:searchTextField];
    [searchTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.top.offset(30);
        make.bottom.offset(-10);
        make.right.offset(-60);
    }];
    UIImageView*leftImageView =[UIImageView new];
    leftImageView.image = [UIImage imageNamed:@"menubg"];
    leftImageView.frame = CGRectMake(10, 5, 30, 30);
    searchTextField.leftView = leftImageView;
    searchTextField.leftViewMode = UITextFieldViewModeAlways;
    
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
