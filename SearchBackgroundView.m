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
  
    self.backgroundColor = [UIColor whiteColor];
    UIView*searchView =[UIView new];
    [self addSubview:searchView];
    searchView.frame = CGRectMake(0, 0, WIDTH, 80);
    searchView.backgroundColor = [UIColor whiteColor];
    UITextField*searchTextField =[UITextField new];
    searchTextField.borderStyle = UITextBorderStyleRoundedRect;
    searchTextField.backgroundColor =  REB(200, 200, 200, 1);
    [searchTextField becomeFirstResponder ];
    [searchView addSubview:searchTextField];
    [searchTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.top.offset(30);
        make.bottom.offset(-10);
        make.right.offset(-60);
    }];
    UIView*leftView =[UIView new];
    leftView.frame = CGRectMake(0, 0, 40, 40);
      searchTextField.leftView = leftView;
    searchTextField.leftViewMode = UITextFieldViewModeAlways;
    
    UIImageView*leftImageView =[UIImageView new];
    leftImageView.image = [UIImage imageNamed:@"menubg"];
    leftImageView.frame = CGRectMake(10, 5, 30, 30);
    [leftView addSubview:leftImageView];
    
    UIButton*cancleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [searchView addSubview:cancleButton];
    [cancleButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(searchTextField.mas_right).offset(10);
        make.top.offset(30);
        make.bottom.offset(-10);
        make.right.offset(-10);
    }];
    [cancleButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancleButton setTitleColor:REB(65, 147, 248, 1) forState:UIControlStateNormal];
    [cancleButton addTarget:self action:@selector(clickCancleButton) forControlEvents:UIControlEventTouchUpInside];
    UIView*lineView =[UIView new];
    [searchView addSubview:lineView];
    lineView.backgroundColor = REB(170, 170, 170, 1);
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.offset(0);
        make.top.offset(79);
        make.height.offset(1);
    }];

    
}

-(void)clickCancleButton
{
    if ([self.searchBackgroundViewDelegate respondsToSelector:@selector(removeSearchBackgroundView)]) {
        [self.searchBackgroundViewDelegate removeSearchBackgroundView];
        
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
