//
//  JuLoadMore.h
//  JuRefresh
//
//  Created by Juvid on 16/9/7.
//  Copyright © 2016年 Juvid(zhutianwei). All rights reserved.
//

#import "JuRefreshBase.h"
typedef void(^shLoadNextPage)(BOOL isNextPage);//下拉回调
typedef NS_ENUM(NSInteger,JuLoadStatus) {
    JuLoadStatusIng,
    JuLoadStatusSuccess,
    JuLoadStatusFailure,
    JuLoadStatusFinish,

};
@interface JuRefreshFoot : JuRefreshBase

+(instancetype)juFootWithhandle:(shLoadNextPage)handle;

@property BOOL isAutoLoad;///< 是否自动刷新
-(void)juDidLoadMore;
-(void)juLoadMoreStatus:(JuLoadStatus)status;
@end
