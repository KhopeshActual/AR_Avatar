#ifndef POI_VIDEO
    #define POI_VIDEO
    
    UNITY_DECLARE_TEX2D_NOSAMPLER(_VideoPixelTexture); float4 _VideoPixelTexture_ST;
    UNITY_DECLARE_TEX2D_NOSAMPLER(_VideoMaskTexture); float4 _VideoMaskTexture_ST;
    
    float _VideoUVNumber;
    float _VideoType;
    float3 pixels;
    float2 _VideoResolution;
    sampler2D _VideoGameboyRamp;
    half _VideoBacklight;
    half _VideoCRTRefreshRate;
    half _VideoCRTPixelEnergizedTime;
    half _VideoEnableVideoPlayer;
    half _VideoRepeatVideoTexture;
    half _VideoPixelateToResolution;
    float2 _VideoMaskPanning;
    // Video Settings
    half _VideoSaturation;
    half _VideoContrast;
    float2 _VideoTiling;
    float2 _VideoOffset;
    float2 _VideoPanning;
    //Debug
    half _VideoEnableDebug;
    
    UNITY_DECLARE_TEX2D_NOSAMPLER(_VideoDebugTexture); float4 _VideoDebugTexture_ST;
    
    
    sampler2D _VRChat_VideoPlayer;
    float4 _VRChat_VideoPlayer_TexelSize;
    
    float4 globalVideoPlayerColor;
    float3 globalColorToDisplayOnScreen;
    float globalVideoOn;
    
    float3 applyBacklight(float3 albedo, half backlightStrength)
    {
        return max(backlightStrength, albedo.rgb);
    }
    
    float3 applyViewAngleTN(float3 albedo)
    {
        float3 reflectionVector = normalize(reflect(poiCam.viewDir.rgb, poiMesh.normals[1].rgb));
        float upwardShift = dot(reflectionVector, poiMesh.binormal);
        upwardShift = pow(upwardShift, 1);
        float sideShift = dot(reflectionVector, poiMesh.tangent);
        sideShift *= pow(sideShift, 3);
        #if !UNITY_COLORSPACE_GAMMA
            albedo = LinearToGammaSpace(albedo);
        #endif
        albedo = saturate(lerp(half3(0.5, 0.5, 0.5), albedo, upwardShift + 1));
        #if !UNITY_COLORSPACE_GAMMA
            albedo = GammaToLinearSpace(albedo);
        #endif
        albedo = (lerp(albedo, albedo.gbr, sideShift));
        return albedo;
    }
    
    float calculateCRTPixelBrightness()
    {
        float totalPixels = float4(1280,720,0,1).x * float4(1280,720,0,1).y;
        float2 uvPixel = float2((floor((1 - poiMesh.uv[float(0)].y) * float4(1280,720,0,1).y)) / float4(1280,720,0,1).y, (floor(poiMesh.uv[float(0)].x * float4(1280,720,0,1).x)) / float4(1280,720,0,1).x);
        float currentPixelNumber = float4(1280,720,0,1).x * (float4(1280,720,0,1).y * uvPixel.x) + float4(1280,720,0,1).y * uvPixel.y;
        float currentPixelAlpha = currentPixelNumber / totalPixels;
        half electronBeamAlpha = frac(_Time.y * float(24));
        float electronBeamPixelNumber = totalPixels * electronBeamAlpha;
        
        float DistanceInPixelsFromCurrentElectronBeamPixel = 0;
        if (electronBeamPixelNumber >= currentPixelNumber)
        {
            DistanceInPixelsFromCurrentElectronBeamPixel = electronBeamPixelNumber - currentPixelNumber;
        }
        else
        {
            DistanceInPixelsFromCurrentElectronBeamPixel = electronBeamPixelNumber + (totalPixels - currentPixelNumber);
        }
        float CRTFrameTime = 1 / float(24);
        float timeSincecurrentPixelWasHitByElectronBeam = (DistanceInPixelsFromCurrentElectronBeamPixel / totalPixels);
        
        return saturate(float(1.9) - timeSincecurrentPixelWasHitByElectronBeam);
    }
    
    void applyContrastSettings(inout float3 pixel)
    {
        #if !UNITY_COLORSPACE_GAMMA
            pixel = LinearToGammaSpace(pixel);
        #endif
        pixel = saturate(lerp(half3(0.5, 0.5, 0.5), pixel, float(0) + 1));
        #if !UNITY_COLORSPACE_GAMMA
            pixel = GammaToLinearSpace(pixel);
        #endif
    }
    
    void applySaturationSettings(inout float3 pixel)
    {
        pixel = lerp(pixel.rgb, dot(pixel.rgb, float3(0.3, 0.59, 0.11)), -float(0));
    }
    
    void applyVideoSettings(inout float3 pixel)
    {
        applySaturationSettings(pixel);
        applyContrastSettings(pixel);
    }
    
    void calculateLCD(inout float4 albedo)
    {
        
        if(float(0) == 0)
        {
            globalColorToDisplayOnScreen = albedo;
        }
        globalColorToDisplayOnScreen = applyBacklight(globalColorToDisplayOnScreen, float(1) * .01);
        applyVideoSettings(globalColorToDisplayOnScreen);
        albedo.rgb = globalColorToDisplayOnScreen * pixels * float(1);
    }
    void calculateTN(inout float4 albedo)
    {
        if(float(0) == 0)
        {
            globalColorToDisplayOnScreen = albedo;
        }
        globalColorToDisplayOnScreen = applyBacklight(globalColorToDisplayOnScreen, float(1) * .01);
        globalColorToDisplayOnScreen = applyViewAngleTN(globalColorToDisplayOnScreen);
        applyVideoSettings(globalColorToDisplayOnScreen);
        albedo.rgb = globalColorToDisplayOnScreen * pixels * float(1);
    }
    void calculateCRT(inout float4 albedo)
    {
        
        if(float(0) == 0)
        {
            globalColorToDisplayOnScreen = albedo;
        }
        float brightness = calculateCRTPixelBrightness();
        applyVideoSettings(globalColorToDisplayOnScreen);
        albedo.rgb = globalColorToDisplayOnScreen * pixels * brightness * float(1);
    }
    void calculateOLED(inout float4 albedo)
    {
        
        if(float(0) == 0)
        {
            globalColorToDisplayOnScreen = albedo;
        }
        applyVideoSettings(globalColorToDisplayOnScreen);
        albedo.rgb = globalColorToDisplayOnScreen * pixels * float(1);
    }
    void calculateGameboy(inout float4 albedo)
    {
        
        if(float(0) == 0)
        {
            globalColorToDisplayOnScreen = albedo;
        }
        applyVideoSettings(globalColorToDisplayOnScreen);
        half brightness = saturate((globalColorToDisplayOnScreen.r + globalColorToDisplayOnScreen.g + globalColorToDisplayOnScreen.b) * .3333333);
        albedo.rgb = tex2D(_VideoGameboyRamp, brightness);
    }
    void calculateProjector(inout float4 albedo)
    {
        
        if(float(0) == 0)
        {
            globalColorToDisplayOnScreen = albedo;
        }
        applyVideoSettings(globalColorToDisplayOnScreen);
        
        float3 projectorColor = albedo * globalColorToDisplayOnScreen * float(1);
        albedo.r = clamp(projectorColor.r, albedo.r, 1000);
        albedo.g = clamp(projectorColor.g, albedo.g, 1000);
        albedo.b = clamp(projectorColor.b, albedo.b, 1000);
    }
    
    void applyScreenEffect(inout float4 albedo, inout float3 videoEmission)
    {
        float4 albedoBeforeScreen = albedo;
        
        pixels = UNITY_SAMPLE_TEX2D_SAMPLER(_VideoPixelTexture, _MainTex, TRANSFORM_TEX(poiMesh.uv[float(0)], _VideoPixelTexture) * float4(1280,720,0,1));
        globalVideoOn = 0;
        
        if(float(0) == 1)
        {
            float4 videoTexture = 0;
            
            if(float(0))
            {
                
                if(float(0))
                {
                    videoTexture = UNITY_SAMPLE_TEX2D_SAMPLER(_VideoDebugTexture, _MainTex, round(TRANSFORM_TEX(poiMesh.uv[float(0)], _VideoDebugTexture) * float4(1280,720,0,1) + .5) / float4(1280,720,0,1));
                }
                else
                {
                    videoTexture = tex2D(_VRChat_VideoPlayer, round(poiMesh.uv[float(0)] * float4(1280,720,0,1) + .5) / float4(1280,720,0,1));
                }
            }
            else
            {
                
                if(float(0))
                {
                    videoTexture = UNITY_SAMPLE_TEX2D_SAMPLER(_VideoDebugTexture, _MainTex, TRANSFORM_TEX(poiMesh.uv[float(0)], _VideoDebugTexture) * float4(1,1,0,0) + float4(0,0,0,0));
                }
                else
                {
                    videoTexture = tex2D(_VRChat_VideoPlayer, ((poiMesh.uv[float(0)] + _Time.x * float4(0,0,0,0)) * float4(1,1,0,0)) + float4(0,0,0,0));
                }
            }
            if(videoTexture.a == 1)
            {
                globalColorToDisplayOnScreen = videoTexture.rgb;
                globalVideoOn = 1;
            }
        }
        
        
        if(float(0) == 1)
        {
            if(poiMesh.uv[float(0)].x > 1 || poiMesh.uv[float(0)].x < 0 || poiMesh.uv[float(0)].y > 1 || poiMesh.uv[float(0)].y < 0)
            {
                return;
            }
        }
        
        switch(float(3))
        {
            case 0: // LCD
            {
                calculateLCD(albedo);
                break;
            }
            case 1: // TN
            {
                calculateTN(albedo);
                break;
            }
            case 2: // CRT
            {
                calculateCRT(albedo);
                break;
            }
            case 3: // OLED
            {
                calculateOLED(albedo);
                break;
            }
            case 4: // Gameboy
            {
                calculateGameboy(albedo);
                break;
            }
            case 5: // Projector
            {
                calculateProjector(albedo);
                break;
            }
        }
        
        float screenMask = UNITY_SAMPLE_TEX2D_SAMPLER(_VideoMaskTexture, _MainTex, TRANSFORM_TEX(poiMesh.uv[float(0)], _VideoMaskTexture) + _Time.x * float4(0,0,0,0));
        albedo = lerp(albedoBeforeScreen, albedo, screenMask);
        videoEmission = max(albedo.rgb * screenMask - 1, 0);
    }
    
#endif
