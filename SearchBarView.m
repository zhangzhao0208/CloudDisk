//
//  SearchBarView.m
//  CloudDisk
//
//  Created by suorui on 16/9/8.
//  Copyright © 2016年 suorui. All rights reserved.
//

#import "SearchBarView.h"

@implementation SearchBarView

-(instancetype)initWithFrame:(CGRect)frame
{
    self =[super initWithFrame:frame];
    
    if (self) {
        
        [self createSearchView];
    }
    
    return self;
}

-(void)createSearchView

{
    UIView *searchBackView =[UIView new];
    [self addSubview:searchBackView];
    [searchBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    UIButton*addFolder =[UIButton buttonWithType:UIButtonTypeCustom];
    addFolder.backgroundColor =[UIColor redColor];
    [addFolder setBackgroundImage:[UIImage imageNamed:@"menubg"] forState:UIControlStateNormal];
    [addFolder addTarget:self action:@selector(clickAddFolderButton) forControlEvents:UIControlEventTouchUpInside];
    [searchBackView addSubview:addFolder];
    [addFolder mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.top.offset(10);
        make.bottom.offset(-10);
        make.width.equalTo(addFolder.mas_height);
    }];
    
    UITextField*searchTextField =[UITextField new];
    [searchBackView addSubview: searchTextField ];
    searchTextField.borderStyle = UITextBorderStyleRoundedRect;
    [searchTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(addFolder.mas_right).offset(30);
        make.right.offset (-10);
        make.top.offset(10);
        make.bottom.offset(-10);
    }];
    
    UIImageView*searchImageView =[UIImageView new];
    [searchTextField addSubview:searchImageView];
    [searchImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(10);
        make.bottom.offset(-10);
        make.left.offset(10);
        make.width.equalTo(searchImageView.mas_height);
    }];
    UIButton*searchButton =[UIButton buttonWithType:UIButtonTypeCustom];
    [searchButton addTarget:self action:@selector(clickSearchButton) forControlEvents:UIControlEventTouchUpInside];
    [searchTextField addSubview:searchButton];
    [searchButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(searchTextField);
    }];
   
}

-(void)clickAddFolderButton
{
    self.addFolserBlock();
}

-(void)clickSearchButton
{
    self.searchBlock();
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
