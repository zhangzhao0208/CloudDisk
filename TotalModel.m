//
//  TotalModel.m
//  CloudDisk
//
//  Created by suorui on 16/9/7.
//  Copyright © 2016年 suorui. All rights reserved.
//

#import "TotalModel.h"

@implementation TotalModel
//对象序列化
//数据转码
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    //通过aCoder把对象的属性转化为二进制数据
    [aCoder encodeObject:self.tname forKey:@"tname"];
    [aCoder encodeObject:self.length forKey:@"length"];
    [aCoder encodeInteger:self.selectedRow forKey:@"selectedRow"];
    [aCoder encodeBool:self.selectedButton forKey:@"selectedButton"];
    [aCoder encodeBool:self.isFromToolCell forKey:@"isFromToolCell"];
     [aCoder encodeBool:self.isEnterDownloadControl forKey:@"isEnterDownloadControl"];
    [aCoder encodeInteger:self.fileButtonState  forKey:@"fileButtonState"];
}

//数据解码
- (id)initWithCoder:(NSCoder *)aDecoder
{
    //
    self = [super init];
    if (self) {
        //取出数据，并赋值给这个对象的属性
        self.tname = [aDecoder decodeObjectForKey:@"tname"];
        self.length = [aDecoder decodeObjectForKey:@"length"];
        self.selectedRow = [aDecoder decodeIntegerForKey:@"selectedRow"];
        self.isFromToolCell = [aDecoder decodeBoolForKey:@"isFromToolCell"];
          self.selectedButton = [aDecoder decodeBoolForKey:@"selectedButton"];
         self.isEnterDownloadControl = [aDecoder decodeBoolForKey:@"isEnterDownloadControl"];
        self.fileButtonState = [aDecoder decodeIntegerForKey:@"fileButtonState"];
        
    }
    return self;
}

@end
