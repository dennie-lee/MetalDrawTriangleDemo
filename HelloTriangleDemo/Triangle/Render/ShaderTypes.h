//
//  ShaderTypes.h
//  HelloTriangleDemo
//
//  Created by liqinghua on 27.4.23.
//

#ifndef ShaderTypes_h
#define ShaderTypes_h

#include <simd/simd.h>

//定点函数参数缓存区表示
typedef enum AAPLVertexInputIndex
{
    VertexInputIndexVertices     = 0,
    VertexInputIndexViewportSize = 1,
} AAPLVertexInputIndex;

//输入的顶点数据信息
typedef struct {
    //向量：顶点位置
    vector_float2 position;
    //向量：颜色值
    vector_float4 color;
} Vertex;


#endif /* ShaderTypes_h */
