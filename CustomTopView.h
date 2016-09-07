//
//  CustomTopView.h
//  CloudDisk
//
//  Created by suorui on 16/9/5.
//  Copyright © 2016年 suorui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTopView : UIView


@property(nonatomic,assign)float width;

@property(nonatomic,assign)float height;

-(instancetype)initWithWidth:(float)width WithHeight:(float)height;
-(void)createTopView;
@end
