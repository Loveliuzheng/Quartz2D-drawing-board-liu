//
//  PathModel.h
//  画板课堂
//
//  Created by GG on 16/5/11.
//  Copyright © 2016年 GG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface PathModel : NSObject

@property (nonatomic,strong) UIBezierPath *bezierPath;


@property (nonatomic,strong) UIColor *color;

@property (nonatomic,assign) CGFloat lineWidth;


@end
