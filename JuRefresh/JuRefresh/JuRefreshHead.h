//
//  JuRreshen.h
//  JuRefresh
//
//  Created by Juvid on 16/9/1.
//  Copyright © 2016年 Juvid. All rights reserved.
//

#import "JuRefreshBase.h"

@interface JuRefreshHead : JuRefreshBase{
    BOOL isBeginRefresh;///< 即将开始刷新
}

-(void)juStartRefresh;
-(void)juEndRefresh;

@end
