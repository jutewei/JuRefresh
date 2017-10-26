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
@property (nonatomic,assign) JuLoadStatus ju_LoadStatus;
@property BOOL isAutoLoad;///< 是否自动刷新
@property BOOL isNoDataHide;///< 没有任何数据隐藏
-(void)juDidLoadMore;
-(void)juLoadMoreStatus:(JuLoadStatus)status;
@end
