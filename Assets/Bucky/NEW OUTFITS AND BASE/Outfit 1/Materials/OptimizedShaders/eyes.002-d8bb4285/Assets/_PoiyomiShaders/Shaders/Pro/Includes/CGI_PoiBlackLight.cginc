#ifndef POI_BLACKLIGHT
    #define POI_BLACKLIGHT
    
    float4 _BlackLightMaskStart;
    float4 _BlackLightMaskEnd;
    float4 _BlackLightMaskKeys;
    float _BlackLightMaskDebug;
    float _BlackLightMaskDissolve;
    float _BlackLightMaskMetallic;
    float _BlackLightMaskClearCoat;
    float _BlackLightMaskMatcap;
    float _BlackLightMaskMatcap2;
    float _BlackLightMaskEmission;
    float _BlackLightMaskEmission2;
    float _BlackLightMaskFlipbook;
    float _BlackLightMaskPanosphere;
    float _BlackLightMaskIridescence;
    
    half _BlackLightMaskGlitter;
    
    half4 blackLightMask;
    
    void createBlackLightMask()
    {
        blackLightMask = 0;
        #ifdef VERTEXLIGHT_ON
            
            for (int lightIndex = 0; lightIndex < 4; lightIndex ++)
            {
                float3 lightPos = float3(unity_4LightPosX0[lightIndex], unity_4LightPosY0[lightIndex], unity_4LightPosZ0[lightIndex]);
                if (!distance(unity_LightColor[lightIndex].rgb, float3(0, 0, 0)))
                {
                    for (int maskIndex = 0; maskIndex < 4; maskIndex ++)
                    {
                        float4 comparison = float4(2,3,4,5);
                        if(unity_LightColor[lightIndex].a == comparison[maskIndex])
                        {
                            blackLightMask[maskIndex] = max(blackLightMask[maskIndex], smoothstep(float4(1,1,1,1)[maskIndex], float4(0,0,0,0)[maskIndex], distance(poiMesh.worldPos, lightPos)));
                        }
                    }
                }
            }
        #endif
    }
#endif

/*
#ifdef POI_BLACKLIGHT
    if (float(4) != 4)
    {
        blackLightMask[mask];
    }
#endif
*/
