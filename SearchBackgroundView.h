//
//  SearchBackgroundView.h
//  CloudDisk
//
//  Created by suorui on 16/9/8.
//  Copyright © 2016年 suorui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"

@protocol SearchBackgroundViewDelegate <NSObject>

-(void)removeSearchBackgroundView;

@end
@interface SearchBackgroundView : UIView

@property(nonatomic,assign)id<SearchBackgroundViewDelegate>searchBackgroundViewDelegate;
@end
