//
//  DrawView.m
//  画板课堂
//
//  Created by GG on 16/5/11.
//  Copyright © 2016年 GG. All rights reserved.
//

#import "DrawView.h"
#import "PathModel.h"
@interface DrawView ()

//当前正在绘制的路径
@property (nonatomic,assign) CGMutablePathRef path;

//已经绘制过的路径
@property (nonatomic,strong) NSMutableArray *pathArray;

//判断当前路径是否被释放
@property (nonatomic,assign) BOOL isReleasePath;

@end

@implementation DrawView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.drawColor = [UIColor blackColor];
        
        self.drawLineWidth = 4;
    }
    return self;
}


- (void)drawRect:(CGRect)rect{
    
    //1. 获取上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [self drawView:context];
    
}

//通过touchbegan获取到路径的起点
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    CGPoint point = [[touches anyObject] locationInView:self];
    
    //路径新创建时，将isReleasePath设置NO，表明当前路径没有被释放
    self.isReleasePath = NO;
    
    //2.创建路径
    self.path = CGPathCreateMutable();
    
    //2.1 给路径设置起点
    CGPathMoveToPoint(self.path, NULL, point.x, point.y);
    
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    CGPoint point = [[touches anyObject] locationInView:self];
    
    //2.1 追加路径
    CGPathAddLineToPoint(self.path, NULL, point.x, point.y);
    
    //不能直接调用drawRect方法，使用setNeedsDisplay方法来触发drawRect执行
    [self setNeedsDisplay];
}


- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    if (self.pathArray == nil) {
        
        self.pathArray = [NSMutableArray array];
    }
    
    //使用贝塞尔曲线，将CGPath包装成对象
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithCGPath:self.path];
    
    PathModel *pathModel = [[PathModel alloc]init];
    
    pathModel.bezierPath = bezierPath;
    pathModel.color = self.drawColor;
    pathModel.lineWidth = self.drawLineWidth;
    
    
    [self.pathArray addObject:pathModel];
    
    //6. 释放路径
    CGPathRelease(self.path);
    
    //路径被释放
    self.isReleasePath = YES;
    
}

- (void)drawView:(CGContextRef)context{
    
    
    for (PathModel *pathModel in self.pathArray) {
        
        CGContextAddPath(context, pathModel.bezierPath.CGPath);
        
        [pathModel.color setStroke];
        
        CGContextSetLineWidth(context, pathModel.lineWidth);
        
        CGContextDrawPath(context, kCGPathStroke);

    }
    
    if(self.isReleasePath == NO){
        
        //3. 把路径添加到上下文
        CGContextAddPath(context, self.path);
        
        //4. 给上下文设置状态
        [self.drawColor setStroke];
        
        CGContextSetLineWidth(context, self.drawLineWidth);
        
        //5. 绘制路径
        CGContextDrawPath(context, kCGPathStroke);
        
    }
    
}

- (void)undo{
    
    [self.pathArray removeLastObject];
    
    [self setNeedsDisplay];
    
}

- (void)clear{
    
    [self.pathArray removeAllObjects];
    
    [self setNeedsDisplay];
}

- (void)save{
    
    UIGraphicsBeginImageContext(CGSizeMake(CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)));
    
    //获取到当前指定试图上的内容，并把它放到画板上面
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    
    UIGraphicsEndImageContext();
    
    UIImageWriteToSavedPhotosAlbum(image, nil, nil, NULL);
    
}

@end
