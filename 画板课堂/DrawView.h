//
//  DrawView.h
//  画板课堂
//
//  Created by GG on 16/5/11.
//  Copyright © 2016年 GG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DrawView : UIView

@property (nonatomic,strong) UIColor *drawColor;

@property (nonatomic,assign) CGFloat drawLineWidth;

- (void)undo;

- (void)clear;

- (void)save;

@end
