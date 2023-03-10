#ifndef POI_DEPTH_COLOR
    #define POI_DEPTH_COLOR
    
    float4 _DepthGlowColor;
    float _DepthGlowEmission;
    float _FadeLength;
    float _DepthAlphaMin;
    float _DepthAlphaMax;
    POI_TEXTURE_NOSAMPLER(_DepthGradient);
    POI_TEXTURE_NOSAMPLER(_DepthMask);
    float _DepthGradientTextureUV;
    float _DepthGradientBlend;
    
    /*
    void applyDepthColor(inout float4 finalColor, inout float3 depthTouchEmission, inout float3 finalEmission, float4 worldDirection, float4 clipPos)
    {
        float3 touchEmission = 0;
        if (!IsInMirror())
        {
            float fadeLength = float(20);
            fadeLength *= 0.01;
            float depth = DecodeFloatRG(tex2Dproj(_CameraDepthTexture, worldDirection));
            depth = Linear01Depth(depth);
            if(depth != 1)
            {
                float diff = distance(depth, Linear01Depth(clipPos.z));
                float intersect = 0;
                if(diff > 0)
                {
                    intersect = clamp(1 - smoothstep(0, _ProjectionParams.w * fadeLength, diff), 0, 1);
                }
                half4 depthGradient = UNITY_SAMPLE_TEX2D_SAMPLER(_DepthGradient, _MainTex, intersect);
                half3 depthMask = UNITY_SAMPLE_TEX2D_SAMPLER(_DepthMask, _MainTex, poiMesh.uv[0]);
                half3 depthColor = depthGradient.rgb * float4(1,1,1,1).rgb;
                finalColor.rgb = lerp(finalColor.rgb, depthColor, intersect * depthMask);
                finalColor.a *= lerp(float(1), float(1), intersect);
                touchEmission = depthColor * float(3) * intersect * depthMask;
            }
        }
        depthTouchEmission = touchEmission;
    }
    */
    
    inline float CorrectedLinearEyeDepth(float z, float B)
    {
        return 1.0 / (z / PM._34 + B);
    }
    
    void applyDepthColor(inout float4 finalColor, inout float3 depthTouchEmission, inout float3 finalEmission, in float4 worldDirection)
    {
        float3 touchEmission = 0;
        float fadeLength = float(20);
        fadeLength *= 0.01;
        
        float perspectiveDivide = 1.0f / poiCam.clipPos.w;
        float4 direction = worldDirection * perspectiveDivide;
        float2 screenPos = poiCam.grabPos.xy * perspectiveDivide;
        float z = SAMPLE_DEPTH_TEXTURE(_CameraDepthTexture, screenPos);
        
        #if UNITY_REVERSED_Z
            if (z == 0)
        #else
            if(z == 1)
        #endif
        return;
        
        float depth = CorrectedLinearEyeDepth(z, direction.w);
        float3 worldpos = direction * depth + _WorldSpaceCameraPos.xyz;
        /*
        finalColor.rgb = frac(worldpos);
        return;
        */
        
        float diff = distance(worldpos, poiMesh.worldPos);
        float intersect = 0;
        intersect = clamp(1 - smoothstep(0, fadeLength, diff), 0, 1);
        half3 depthMask = POI2D_SAMPLER_PAN(_DepthMask, _MainTex, poiMesh.uv[float(0)], float4(0,0,0,0));
        
        half4 depthGradient = 0;
        half3 depthColor = 0;
        
        
        if (float(0) == 0)
        {
            depthGradient = POI2D_SAMPLER_PAN(_DepthGradient, _MainTex, float2(intersect, intersect), float4(0,0,0,0));
            depthColor = depthGradient.rgb * float4(1,1,1,1).rgb;
        }
        else
        {
            depthGradient = POI2D_SAMPLER_PAN(_DepthGradient, _MainTex, poiMesh.uv[float(0)], float4(0,0,0,0));
            depthColor = depthGradient.rgb * float4(1,1,1,1).rgb * intersect;
        }
        
        
        if(float(0) == 0) // rpelace
        {
            finalColor.rgb = lerp(finalColor.rgb, depthColor, intersect * depthMask);
        }
        else if(float(0) == 1) // add
        {
            finalColor.rgb += depthColor * intersect * depthMask;
        }
        else if(float(0) == 2) // multiply
        {
            finalColor.rgb *= lerp(1, depthColor, intersect * depthMask);
        }
        finalColor.a *= lerp(float(1), float(1), intersect * depthMask);
        touchEmission = depthColor * float(3) * intersect * depthMask;
        
        depthTouchEmission = touchEmission;
    }
#endif
