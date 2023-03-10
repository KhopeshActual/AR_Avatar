#ifndef POI_CLEARCOAT
    #define POI_CLEARCOAT
    
    samplerCUBE _ClearCoatCubeMap;
    float _ClearCoatSampleWorld;
    POI_TEXTURE_NOSAMPLER(_ClearCoatMask);
    POI_TEXTURE_NOSAMPLER(_ClearCoatSmoothnessMap);
    float _ClearCoatInvertSmoothness;
    float _ClearCoat;
    float _ClearCoatSmoothness;
    float3 _ClearCoatTint;
    float _ClearCoatNormalToUse;
    float _ClearCoatForceLighting;
    float lighty_clear_boy_uwu_var;
    
    
    float3 CalculateClearCoatEnvironmentalReflections()
    {
        float3 reflectionColor;
        
        float smoothnessMap = (POI2D_SAMPLER_PAN(_ClearCoatSmoothnessMap, _MainTex, poiMesh.uv[float(0)], float4(0,0,0,0)));
        if (float(0) == 1)
        {
            smoothnessMap = 1 - smoothnessMap;
        }
        smoothnessMap *= float(0);
        float roughness = 1 - smoothnessMap;
        
        lighty_clear_boy_uwu_var = 0;
        
        float3 reflectedDir = float(0) == 0 ? poiCam.vertexReflectionDir: poiCam.reflectionDir;
        
        float4 envSample = UNITY_SAMPLE_TEXCUBE_LOD(unity_SpecCube0, reflectedDir, roughness * UNITY_SPECCUBE_LOD_STEPS);
        bool no_probe = unity_SpecCube0_HDR.a == 0 && envSample.a == 0;
        
        
        if(float(0) == 0 && no_probe == 0)
        {
            
            Unity_GlossyEnvironmentData envData;
            envData.roughness = roughness;
            envData.reflUVW = BoxProjection(
                reflectedDir, poiMesh.worldPos.xyz,
                unity_SpecCube0_ProbePosition,
                unity_SpecCube0_BoxMin, unity_SpecCube0_BoxMax
            );
            float3 probe0 = Unity_GlossyEnvironment(
                UNITY_PASS_TEXCUBE(unity_SpecCube0), unity_SpecCube0_HDR, envData
            );
            envData.reflUVW = BoxProjection(
                reflectedDir, poiMesh.worldPos.xyz,
                unity_SpecCube1_ProbePosition,
                unity_SpecCube1_BoxMin, unity_SpecCube1_BoxMax
            );
            
            float interpolator = unity_SpecCube0_BoxMin.w;
            
            if(interpolator < 0.99999)
            {
                float3 probe1 = Unity_GlossyEnvironment(
                    UNITY_PASS_TEXCUBE_SAMPLER(unity_SpecCube1, unity_SpecCube0),
                    unity_SpecCube0_HDR, envData
                );
                reflectionColor = lerp(probe1, probe0, interpolator);
            }
            else
            {
                reflectionColor = probe0;
            }
        }
        else
        {
            lighty_clear_boy_uwu_var = 1;
            reflectionColor = texCUBElod(_ClearCoatCubeMap, float4(reflectedDir, roughness * UNITY_SPECCUBE_LOD_STEPS));
        }
        
        if(float(0))
        {
            lighty_clear_boy_uwu_var = 1;
        }
        
        return reflectionColor * float4(1,1,1,1);
    }
    
    void calculateAndApplyClearCoat(inout float4 finalColor)
    {
        half clearCoatMap = POI2D_SAMPLER_PAN(_ClearCoatMask, _MainTex, poiMesh.uv[float(0)], float4(0,0,0,0));
        
        #ifdef POI_BLACKLIGHT
            if(float(4) != 4)
            {
                clearCoatMap *= blackLightMask[float(4)];
            }
        #endif
        
        half3 reflectionColor = CalculateClearCoatEnvironmentalReflections();
        
        float NormalDotView = abs(dot(float(1), float(0) == 0 ? poiLight.N0DotV: poiLight.nDotV).r);
        #ifdef POI_LIGHTING
            finalColor.rgb = lerp(finalColor.rgb, reflectionColor * lerp(1, poiLight.finalLighting, lighty_clear_boy_uwu_var), clearCoatMap * float(1) * clamp(FresnelTerm(float(1), NormalDotView), 0, 1));
            //finalColor.rgb += reflectionColor;
            //finalColor.rgb = finalColor.rgb * (1- (reflectionColor.r + reflectionColor.g + reflectionColor.b)/3) + reflectionColor * clearCoatMap * lerp(1, poiLight.finalLighting, lighty_clear_boy_uwu_var);
        #else
            finalColor.rgb = lerp(finalColor.rgb, reflectionColor, clearCoatMap * float(1) * clamp(FresnelTerm(float(1), NormalDotView), 0, 1));
        #endif
    }
    
#endif
