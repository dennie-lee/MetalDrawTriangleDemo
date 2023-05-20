//
//  ViewController.m
//  HelloTriangleDemo
//
//  Created by liqinghua on 18.4.23.
//

#import "ViewController.h"
#import <MetalKit/MetalKit.h>
#import "TriangleRender.h"


@implementation ViewController{
    MTKView* _view;
    TriangleRender *_render;
}

- (void)loadView{
    self.view = [[MTKView alloc] init];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _view = (MTKView*)self.view;
    _view.device = MTLCreateSystemDefaultDevice();
    NSAssert(_view.device, @"the device is not support metal");
    _render = [[TriangleRender alloc] initWithMetalKitView:_view];
    NSAssert(_render, @"render initialize failed");
    [_render mtkView:_view drawableSizeWillChange:_view.drawableSize];
    _view.delegate = _render;
}


@end
