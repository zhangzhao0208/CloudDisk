//
//  BottomFileView.m
//  CloudDisk
//
//  Created by suorui on 16/9/5.
//  Copyright © 2016年 suorui. All rights reserved.
//

#import "BottomFileView.h"
#define REB(R,E,D,A) ([UIColor  colorWithRed:R/255.0 green:E/255.0 blue:D/255.0 alpha:A])
#define USERD [NSUserDefaults standardUserDefaults]
#define WIDTH self.frame.size.width
@implementation BottomFileView


-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self createBottmButtonView];
        
    }
    
    return self;
}

-(void)createBottmButtonView
{
    NSArray*fileNameArray =[ NSArray arrayWithObjects:@"上传文件",@"下载文件",@"删除文件",@"更多", nil];
    self.backgroundColor= REB(240, 240, 240, 1);
    UIView*lastView =nil;
    float rowSpace = (WIDTH-(120.0f*WIDTH/720.0f)*4-(25.0f*WIDTH/720.0f)*2)/3.0f;
    for (int i =0; i<4; i++) {
        
        UIView*fileView =[UIView new];
        [self addSubview:fileView];
//        fileView.backgroundColor = [UIColor redColor];
       [fileView mas_makeConstraints:^(MASConstraintMaker *make) {
           make.top.offset(5);
           make.bottom.offset(-5);
           make.width.offset(120.0f*WIDTH/720.0f);
           if (lastView) {
               make.left.equalTo(lastView.mas_right).offset(rowSpace);
               
           }else
           {
               make.left.offset(25.0f*WIDTH/720.0f);
           }
           if (i==3) {
//                fileView.backgroundColor = [UIColor blueColor];
               make.right.offset(-25.0f*WIDTH/720.0f);
           }
           
       }];
        
        
        lastView =fileView;
        
        UIImageView*imageView =[UIImageView new];
        imageView.image = [UIImage imageNamed:@"off"];
        [fileView addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(0);
            make.left.offset(30.0f*WIDTH/720.0f);
            make.right.offset(-30.0f*WIDTH/720.0f);
            if (WIDTH==320) {
                make.bottom.offset(-15);
            }else if (WIDTH>320&&WIDTH<768){
                make.bottom.offset(-18);
                
            }else
            {
                make.bottom.offset(-18);
            }
            
        }];
        
        
        YYLabel*fileLabel =[YYLabel new];
        [fileView addSubview:fileLabel];
        NSMutableAttributedString*context =[[NSMutableAttributedString alloc]initWithString:fileNameArray[i]];
//        [AdjustFontSizeView adjustTextFontSize:WIDTH WithAttributedString:context ];
        context.yy_alignment = NSTextAlignmentCenter;
        if (WIDTH==320) {
             context.yy_font = [UIFont boldSystemFontOfSize:10];
        }else if (WIDTH>320&&WIDTH<768){
         context.yy_font = [UIFont boldSystemFontOfSize:14];
        }else
        {
              context.yy_font = [UIFont boldSystemFontOfSize:14];
        }
        
        context.yy_color = REB(90, 89, 89, 1);
        fileLabel.attributedText= context;
        [fileLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(0);
            make.right.and.bottom.offset(0);
            make.top.equalTo(imageView.mas_bottom).offset(3);
        }];
        
        UIButton * fileButton =[UIButton buttonWithType:UIButtonTypeCustom];
//        fileButton.backgroundColor = [UIColor yellowColor];
        fileButton.tag = 100+i;
        [fileButton addTarget:self action:@selector(clickFileButton:) forControlEvents:UIControlEventTouchUpInside];
        [fileView addSubview:fileButton];
       [fileButton mas_makeConstraints:^(MASConstraintMaker *make) {
           make.edges.equalTo(fileView);
       }];
        
    }
}

-(void)clickFileButton:(UIButton*)sender
{
    NSLog(@"邮编按钮");
    if (sender.tag==103) {
        
        sender.selected = !sender.selected;
        if (sender.selected==YES) {
            if ([self.BottomFileDelegate respondsToSelector:@selector(changeMoreOperationViewPosition)]) {
                [self.BottomFileDelegate changeMoreOperationViewPosition];
            }
        }else
        {
            if ([self.BottomFileDelegate respondsToSelector:@selector(removeMoreOperationView)]) {
                [self.BottomFileDelegate removeMoreOperationView];
            }

        }
        
    }
}



- (void)setFrame:(CGRect)frame
{
    frame.size.width = [UIScreen mainScreen].bounds.size.width;
    [super setFrame:frame];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
