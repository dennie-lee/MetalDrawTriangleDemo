//
//  TriangleRender.m
//  HelloTriangleDemo
//
//  Created by liqinghua on 18.4.23.
//

#import "TriangleRender.h"
#import "ShaderTypes.h"


@implementation TriangleRender{
    id<MTLDevice> _device;
    id<MTLRenderPipelineState> _pipelineState;
    id<MTLCommandQueue> _commandQueue;
    
    vector_uint2 _viewPortSize;
}

- (instancetype)initWithMetalKitView:(MTKView *)view{
    self = [super init];
    if (self){
        _device = view.device;
        //顶点函数和片元函数已经完成，可以创建一个使用它们的渲染管道。首先，获取默认库并为每个函数获取一个MTLFunction对象
        id<MTLLibrary> defaultLibrary = [_device newDefaultLibrary];
        id<MTLFunction> vertexFunction = [defaultLibrary newFunctionWithName:@"vertexShader"];
        id<MTLFunction> fragmentFunction = [defaultLibrary newFunctionWithName:@"fragmentShader"];
        
        //创建一个 MTLRenderPipelineState 对象。渲染管道有更多阶段需要配置，可以使用 MTLRenderPipelineDescriptor 来配置管道
        NSError *error;
        MTLRenderPipelineDescriptor *descriptor = [[MTLRenderPipelineDescriptor alloc] init];
        descriptor.label = @"Simple pipeline";
        descriptor.vertexFunction = vertexFunction;
        descriptor.fragmentFunction = fragmentFunction;
        descriptor.colorAttachments[0].pixelFormat = view.colorPixelFormat;
        
        _pipelineState = [_device newRenderPipelineStateWithDescriptor:descriptor error:&error];
        NSAssert(_pipelineState, @"Failed to create pipeline state object:%@",error);
        
        _commandQueue = [_device newCommandQueue];
    }
    return self;
}

- (void)mtkView:(MTKView *)view drawableSizeWillChange:(CGSize)size{
    _viewPortSize.x = size.width;
    _viewPortSize.y = size.height;
}

- (void)drawInMTKView:(MTKView *)view{
    ////三个顶点位置和颜色值
    static const Vertex vertices[] = {
        //位置       //颜色值
        {{250,-250},{1.0,0.0,0.0,1.0}},
        {{-250,-250},{0.0,1.0,0.0,1.0}},
        {{0,250},   {0.0,0.0,1.0,1.0}},
    };
    
    id<MTLCommandBuffer> commandBuffer = [_commandQueue commandBuffer];
    commandBuffer.label = @"MyCommand";
    MTLRenderPassDescriptor *passDescriptor = view.currentRenderPassDescriptor;
    
    if (passDescriptor != nil){
        id<MTLRenderCommandEncoder> commandEncoder = [commandBuffer renderCommandEncoderWithDescriptor:passDescriptor];
        commandEncoder.label = @"MyCommandencoder";
        
        //设置视口
        [commandEncoder setViewport:(MTLViewport){0.0,0.0,_viewPortSize.x,_viewPortSize.y,0.0,1.0}];
        [commandEncoder setRenderPipelineState:_pipelineState];
        
        //设置顶点着色器参数
        [commandEncoder setVertexBytes:vertices length:sizeof(vertices) atIndex:VertexInputIndexVertices];
        [commandEncoder setVertexBytes:&_viewPortSize length:sizeof(_viewPortSize) atIndex:VertexInputIndexViewportSize];
        
        //指定图元的种类、起始索引和顶点数。渲染三角形时，将使用vertexID参数的值 0、1 和2调用顶点函数
        [commandEncoder drawPrimitives:MTLPrimitiveTypeTriangle vertexStart:0 vertexCount:3];
        [commandEncoder endEncoding];
        [commandBuffer presentDrawable:view.currentDrawable];
    }
    
    [commandBuffer commit];
}
@end
