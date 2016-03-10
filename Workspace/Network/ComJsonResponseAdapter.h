//
//  ComJsonResponseAdapter.h
//  CommonApp
//
//  Created by lipeng on 16/3/10.
//  Copyright © 2016年 common. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ComRequest.h"

@interface ComJsonResponseAdapter : NSObject <ResponseDelegate>

- (instancetype)initWithModelClass:(Class)modelClass;

@end
