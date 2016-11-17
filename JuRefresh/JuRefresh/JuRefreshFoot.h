//
//  JuLoadMore.h
//  JuRefresh
//
//  Created by Juvid on 16/9/7.
//  Copyright © 2016年 Juvid. All rights reserved.
//

#import "JuRefreshBase.h"
typedef NS_ENUM(NSInteger,JuLoadStatus) {
    JuLoadStatusIng,
    JuLoadStatusSuccess,
    JuLoadStatusFailure,
    JuLoadStatusFinish,
};
@interface JuRefreshFoot : JuRefreshBase
@property (nonatomic,assign) JuLoadStatus ju_LoadStatus;
-(void)juLoadMoreStatus:(JuLoadStatus)status;
-(void)juSetScrollInset;
@end
