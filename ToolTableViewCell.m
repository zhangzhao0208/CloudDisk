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
    NSArray*fileNameArray =[ NSArray arrayWithObjects:@"上传文件",@"下载文件",@"删除文件",@"更多", nil];
    self.backgroundColor= REB(240, 240, 240, 1);
    UIButton*lastButton =nil;
    float rowSpace = (WIDTH-(120.0f*WIDTH/720.0f)*4-(25.0f*WIDTH/720.0f)*2)/3.0f;
    for (int i =0; i<4; i++) {
        UIButton * fileButton =[UIButton buttonWithType:UIButtonTypeCustom];
        fileButton.backgroundColor = [UIColor yellowColor];
        [fileButton setBackgroundImage:[UIImage imageNamed:@"menubg"] forState:UIControlStateNormal];
        [fileButton setBackgroundImage:[UIImage imageNamed:@"off"] forState:UIControlStateHighlighted];
             [fileButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [fileButton setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
        
        [fileButton setTitle:fileNameArray[i] forState:UIControlStateNormal];
        
        fileButton.tag = 100+i;
        [fileButton addTarget:self action:@selector(clickFileButton:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:fileButton];
        [fileButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(10);
            make.bottom.offset(-10);
            if (lastButton) {
                make.left.equalTo(lastButton.mas_right);
                make.width.equalTo(lastButton.mas_width);
            }else
            {
                make.left.offset(60);
            }
            if (i==3) {
                make.right.offset(-60);
            }
  
        }];
        lastButton = fileButton;
        
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
