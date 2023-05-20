//
//  TriangleRender.h
//  HelloTriangleDemo
//
//  Created by liqinghua on 18.4.23.
//

#import <Foundation/Foundation.h>
#import <MetalKit/MetalKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TriangleRender : NSObject<MTKViewDelegate>

- (instancetype)initWithMetalKitView:(MTKView*)view;

@end

NS_ASSUME_NONNULL_END
