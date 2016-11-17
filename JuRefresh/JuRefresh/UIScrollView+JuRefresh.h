//
//  UIScrollView+JuRefresh.h
//  JuRefresh
//
//  Created by Juvid on 16/9/7.
//  Copyright © 2016年 Juvid. All rights reserved.
//

#import "JuRefreshFoot.h"
#import "JuRefreshHead.h"

typedef NS_ENUM(NSInteger,JuLoadPageType) {
    JuLoadPageNone,
    JuLoadPageNext,
    JuLoadPageCurrent,
};
@interface UIScrollView (JuRefresh)

@property (nonatomic,strong) JuRefreshHead *ju_RefreshHead;///< 全部约束
@property (nonatomic,strong) JuRefreshFoot *ju_RefreshFoot;///< 全部约束

-(JuLoadPageType)juLoadMorePage;
@end
