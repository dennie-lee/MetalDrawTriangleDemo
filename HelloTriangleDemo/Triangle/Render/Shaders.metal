//
//  Shaders.metal
//  HelloTriangleDemo
//
//  Created by liqinghua on 25.4.23.
//

#include <metal_stdlib>
using namespace metal;

#include "ShaderTypes.h"

struct RasterizerData{
    //[[position]]:在顶点着色函数中，表示当前的顶点信息，类型是float4、
    //还可以表示描述了片元的窗口的相对坐标（x，y，z，1/w），
    //即该像素点在屏幕上的位置信息
    float4 position [[position]];
    
    float4 color;
    //有时希望一个值由一个顶点生成并在整个图元中保持不变,将[[flat]]限定符添加到其颜色字段
    //float4 color [[flat]];
};

//[[vertex_id]] ：顶点id标识符，并不由开发者传递
//属性修饰符"[[buffer(index)]]" 为着色函数参数设定了缓存的位置
vertex RasterizerData vertexShader(uint vertexID [[vertex_id]],
                                   constant Vertex* vertices [[buffer(VertexInputIndexVertices)]],
                                   constant vector_uint2 *viewPortSizePointer [[buffer(VertexInputIndexViewportSize)]]){
    RasterizerData out;
    
    float2 pixelSpaceXY = vertices[vertexID].position.xy;
    vector_float2 viewPortSize = vector_float2(*viewPortSizePointer);
    
    out.position = vector_float4(0,0,0,1.0);
    out.position.xy = pixelSpaceXY / (viewPortSize / 2);
    
    out.color = vertices[vertexID].color;
    
    return out;
};

fragment float4 fragmentShader(RasterizerData in [[stage_in]]){
    return in.color;
};
