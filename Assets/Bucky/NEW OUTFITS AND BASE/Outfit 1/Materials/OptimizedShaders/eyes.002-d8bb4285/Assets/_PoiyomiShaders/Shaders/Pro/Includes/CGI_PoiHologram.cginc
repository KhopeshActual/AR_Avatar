#ifndef POI_HOLOGRAM
    #define POI_HOLOGRAM
    
    UNITY_DECLARE_TEX2D_NOSAMPLER(_HoloAlphaMap); float4 _HoloAlphaMap_ST;
    float _HoloCoordinateSpace; // 0 World, 1 Local, 2 UV
    float3 _HoloDirection;
    float _HoloScrollSpeed;
    float _HoloLineDensity;

    fixed _HoloFresnelAlpha;
    fixed _HoloRimSharpness;
    fixed _HoloRimWidth;
    void ApplyHoloAlpha(inout float4 color)
    {
        float uv = 0;
        
        if (float(0) == 0)
        {
            uv = dot(normalize(float4(0,1,0,1)), poiMesh.worldPos * float(10)) + _Time.x * float(1);
        }
        
        if(float(0) == 1)
        {
            uv = dot(normalize(float4(0,1,0,1)), poiMesh.localPos * float(10)) + _Time.x * float(1);
        }
        
        if(float(0) == 2)
        {
            uv = dot(float4(0,1,0,1), poiMesh.uv[0] * float(10)) + _Time.x * float(1);
        }
        float holoRim = saturate(1 - smoothstep(min(float(0.5), float(0.5)), float(0.5), poiCam.viewDotNormal));
        holoRim = abs(lerp(1, holoRim, float(0)));
        color.a *= UNITY_SAMPLE_TEX2D_SAMPLER(_HoloAlphaMap, _MainTex, uv).r * holoRim;
    }
    
#endif
