//
//  HTTPRequestManager.m
//  CloudDisk
//
//  Created by suorui on 16/9/13.
//  Copyright © 2016年 suorui. All rights reserved.
//

#import "HTTPRequestManager.h"

@implementation HTTPRequestManager
+(void)HTTPRequestPublicCloudInformationList:(NSInteger)publicID WithCompletion:(CompletionBlock)completionBlock
{
    NSString*public =[NSString stringWithFormat:@"%ld",publicID];
    NSDictionary*dic =@{@"parentId":public};
    AFHTTPSessionManager*manager =[AFHTTPSessionManager manager];
    [manager POST:homeInformationList parameters:dic success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
//        NSLog(@"=====%@",responseObject);
        completionBlock(responseObject,nil);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (error) {
              NSLog(@"=====%@",error);
            completionBlock(nil,error);
        }
    }];
    
}
@end
