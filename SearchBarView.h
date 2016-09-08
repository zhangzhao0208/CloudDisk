//
//  SearchBarView.h
//  CloudDisk
//
//  Created by suorui on 16/9/8.
//  Copyright © 2016年 suorui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"

typedef void(^AddFolderBlock)();
typedef void(^SearchBarBlock)();
@interface SearchBarView : UIView

@property(nonatomic,copy)AddFolderBlock addFolserBlock;
@property(nonatomic,copy)SearchBarBlock searchBlock;

@end
