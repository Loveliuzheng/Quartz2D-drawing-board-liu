//
//  SelectColorView.h
//  画板课堂
//
//  Created by GG on 16/5/11.
//  Copyright © 2016年 GG. All rights reserved.
//

#import "BaseView.h"

typedef void(^SelectColorBlock)(UIColor *color);

@interface SelectColorView : BaseView

- (void)afterSelected:(SelectColorBlock)selectBlock;

@end
