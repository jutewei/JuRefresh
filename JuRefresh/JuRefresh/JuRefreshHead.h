//
//  JuRreshen.h
//  JuRefresh
//
//  Created by Juvid on 16/9/1.
//  Copyright © 2016年 Juvid(zhutianwei). All rights reserved.
//

#import "JuRefreshBase.h"

@interface JuRefreshHead : JuRefreshBase

+(instancetype)juHeadWithhandle:(dispatch_block_t)handle;

-(void)juStartRefresh;
-(void)juEndRefresh;

@end
