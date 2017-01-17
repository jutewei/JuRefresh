//
//  UIScrollView+JuRefresh.h
//  JuRefresh
//
//  Created by Juvid on 16/9/7.
//  Copyright © 2016年 Juvid(zhutianwei). All rights reserved.
//

#import "JuRefreshFoot.h"
#import "JuRefreshHead.h"

@interface UIScrollView (JuRefresh)

@property (nonatomic,strong) JuRefreshHead *ju_RefreshHead;///< 下拉刷新
@property (nonatomic,strong) JuRefreshFoot *ju_RefreshFoot;///< 上拉加载更多

@end
