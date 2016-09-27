//
//  PublicModel.m
//  CloudDisk
//
//  Created by suorui on 16/9/26.
//  Copyright © 2016年 suorui. All rights reserved.
//

#import "PublicModel.h"
#import "YYModel.h"
@implementation PublicModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"resultList" : [PublicListModel class],
             };
}
@end

@implementation PublicListModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"PublicDescription" : @"description",
             @"fileID" : @"id",
            };
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    //通过aCoder把对象的属性转化为二进制数据
    [aCoder encodeObject:self.createdate forKey:@"createdate"];
    [aCoder encodeObject:self.PublicDescription forKey:@"PublicDescription"];

    [aCoder encodeObject:self.fileID forKey:@"fileID"];
    [aCoder encodeObject:self.islock forKey:@"islock"];

    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.parentId forKey:@"parentId"];

    [aCoder encodeObject:self.password forKey:@"password"];
    [aCoder encodeObject:self.path forKey:@"path"];
    [aCoder encodeObject:self.size forKey:@"size"];
    [aCoder encodeObject:self.type forKey:@"type"];
    [aCoder encodeObject:self.userId forKey:@"userId"];
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
          self.createdate = [aDecoder decodeObjectForKey:@"createdate"];
          self.PublicDescription = [aDecoder decodeObjectForKey:@"PublicDescription"];
          self.fileID = [aDecoder decodeObjectForKey:@"fileID"];
          self.islock = [aDecoder decodeObjectForKey:@"islock"];
          self.name = [aDecoder decodeObjectForKey:@"name"];
          self.parentId = [aDecoder decodeObjectForKey:@"parentId"];
          self.password = [aDecoder decodeObjectForKey:@"password"];
          self.path = [aDecoder decodeObjectForKey:@"path"];
          self.size = [aDecoder decodeObjectForKey:@"size"];
        self.type = [aDecoder decodeObjectForKey:@"type"];
        self.userId = [aDecoder decodeObjectForKey:@"userId"];
    }
    return self;
}



@end