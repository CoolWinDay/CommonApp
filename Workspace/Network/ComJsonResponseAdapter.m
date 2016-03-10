//
//  ComJsonResponseAdapter.m
//  CommonApp
//
//  Created by lipeng on 16/3/10.
//  Copyright © 2016年 common. All rights reserved.
//

#import "ComJsonResponseAdapter.h"

@implementation ComJsonResponseAdapter {
    Class _modelClass;
}

- (instancetype)initWithModelClass:(Class)modelClass
{
    if (self = [super init]) {
        _modelClass = modelClass;
    }
    return self;
}

- (id)buildResponse:(id)responseData
{
    if (responseData){
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
        NSLog(@"%@", dic);
            
        if (_modelClass != Nil) {
            return [_modelClass yy_modelWithDictionary:dic];
        }
    }
    return nil;
}

@end
