//
//  ToolTableViewCell.m
//  CloudDisk
//
//  Created by suorui on 16/9/7.
//  Copyright © 2016年 suorui. All rights reserved.
//

#import "ToolTableViewCell.h"
#define REB(R,E,D,A) ([UIColor  colorWithRed:R/255.0 green:E/255.0 blue:D/255.0 alpha:A])
#define USERD [NSUserDefaults standardUserDefaults]
#define WIDTH self.frame.size.width
@implementation ToolTableViewCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self createBottmButtonView];
    }
    return self;
}
-(void)createBottmButtonView
{
    NSArray*fileNameArray =[ NSArray arrayWithObjects:@"下载文件",@"打开文件", nil];
    self.backgroundColor= REB(225, 255, 255, 1);
    UIButton*lastButton =nil;
//    float rowSpace = (WIDTH-(120.0f*WIDTH/720.0f)*fileNameArray.count-(25.0f*WIDTH/720.0f)*2)/(fileNameArray.count-1);
    for (int i =0; i<fileNameArray.count; i++) {
        UIButton * fileButton =[UIButton buttonWithType:UIButtonTypeCustom];
//        [fileButton setBackgroundImage:[UIImage imageNamed:@"menubg"] forState:UIControlStateNormal];
        [fileButton setImage:[UIImage imageNamed:@"menuarrow"] forState:UIControlStateNormal];
             [fileButton setTitleColor:REB(54, 183, 254, 1) forState:UIControlStateNormal];
//        [fileButton setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
        
        [fileButton setTitle:fileNameArray[i] forState:UIControlStateNormal];
        fileButton.titleLabel.font =[UIFont systemFontOfSize:16];
       
        fileButton.tag = 100+i;
        [fileButton addTarget:self action:@selector(clickFileButton:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:fileButton];
        [fileButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(10);
            make.bottom.offset(-10);
            if (lastButton) {
                make.left.equalTo(lastButton.mas_right).offset(40);
                make.width.equalTo(lastButton.mas_width);
            }else
            {
                make.left.offset(20);
            }
            if (i==fileNameArray.count-1) {
                make.right.offset(-20);
            }
  
        }];
        
        [fileButton layoutIfNeeded];
        NSLog(@"--%f",fileButton.titleLabel.frame.size.width);
           fileButton.imageEdgeInsets = UIEdgeInsetsMake(5,0,5,0);
          fileButton.titleEdgeInsets = UIEdgeInsetsMake(5, 0, 5, 0);
        fileButton.imageView.bounds = CGRectMake(0, 0, 20, 20);
//        [fileButton setContentEdgeInsets:UIEdgeInsetsMake(70, 0, 0, 0)];//
        
        
//           fileButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;//设置button的内容横向居中。。设置content是title和image一起变化
        lastButton = fileButton;
        
    }
}

-(void)clickFileButton:(UIButton*)sender
{
    
    if (sender.tag==100) {
        
        
    }else
    {
        
    }
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
