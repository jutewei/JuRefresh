//
//  UIScrollView+JuRefresh.m
//  JuRefresh
//
//  Created by Juvid on 16/9/7.
//  Copyright © 2016年 Juvid(zhutianwei). All rights reserved.
//

#import "UIScrollView+JuRefresh.h"
#import <objc/runtime.h>

static const char* juLoadMore="load_more";;
@implementation UIScrollView (JuRefresh)

-(void)setJu_RefreshFoot:(JuRefreshFoot *)ju_RefreshFoot{
    if (ju_RefreshFoot!=self.ju_RefreshFoot) {
        if (self.ju_RefreshFoot) {
            [self.ju_RefreshFoot removeFromSuperview];
        }
        if (ju_RefreshFoot)[self insertSubview:ju_RefreshFoot atIndex:0];
        objc_setAssociatedObject(self, &juLoadMore, ju_RefreshFoot,OBJC_ASSOCIATION_ASSIGN);
    }

}

-(JuRefreshFoot *)ju_RefreshFoot{
    return objc_getAssociatedObject(self, &juLoadMore);
}

-(void)setJu_RefreshHead:(JuRefreshHead *)ju_RefreshHead{
    if (ju_RefreshHead!=self.ju_RefreshHead) {
        if (self.ju_RefreshHead) {
            [self.ju_RefreshHead removeFromSuperview];
        }
        if (ju_RefreshHead)[self insertSubview:ju_RefreshHead atIndex:0];
        objc_setAssociatedObject(self, @selector(ju_RefreshHead), ju_RefreshHead,OBJC_ASSOCIATION_ASSIGN);
    }
}
-(JuRefreshHead *)ju_RefreshHead{
    return objc_getAssociatedObject(self, @selector(ju_RefreshHead));
}

//-(JuLoadPageType)juLoadMorePage{
//    if (self.ju_RefreshFoot&&!self.ju_RefreshFoot.hidden&&self.contentOffset.y>=self.contentSize.height-self.frame.size.height&&self.contentOffset.y>0) {
//        if (self.ju_RefreshFoot.ju_LoadStatus==JuLoadStatusIng||self.ju_RefreshFoot.ju_LoadStatus==JuLoadStatusFinish) return JuLoadPageNone;
//        else {
//
//            if (self.ju_RefreshFoot.ju_LoadStatus==JuLoadStatusSuccess) {
//                return JuLoadPageNext;
//            }else{
//                return JuLoadPageCurrent;
//            }
//
//        }
//    }
//    return JuLoadPageNone;
//}
@end
