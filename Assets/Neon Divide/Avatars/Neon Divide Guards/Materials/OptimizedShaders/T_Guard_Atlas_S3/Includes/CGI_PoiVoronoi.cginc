#ifndef POI_VORONOI
    #define POI_VORONOI
    
    float _VoronoiSpace;
    float _VoronoiBlend;
    float _VoronoiType;
    float4 _VoronoiColor0;
    float _VoronoiEmission0;
    float4 _VoronoiColor1;
    float _VoronoiEmission1;
    float2 _VoronoiGradient;
    float _VoronoiScale;
    float3 _VoronoiSpeed;
    float _VoronoiEnableRandomCellColor;
    float2 _VoronoiRandomMinMaxSaturation;
    float2 _VoronoiRandomMinMaxBrightness;
    float3 randomPoint;
    float _VoronoiEffectsMaterialAlpha;
    
    #if defined(PROP_VORONOIMASK) || !defined(OPTIMIZER_ENABLED)
        POI_TEXTURE_NOSAMPLER(_VoronoiMask);
    #endif
    #if defined(PROP_VORONOINOISE) || !defined(OPTIMIZER_ENABLED)
        POI_TEXTURE_NOSAMPLER(_VoronoiNoise);
    #endif
    float _VoronoiNoiseIntensity;
    
    float2 inoise(float3 P, float jitter)
    {
        float3 Pi = mod(floor(P), 289.0);
        float3 Pf = frac(P);
        float3 oi = float3(-1.0, 0.0, 1.0);
        float3 of = float3(-0.5, 0.5, 1.5);
        float3 px = Permutation(Pi.x + oi);
        float3 py = Permutation(Pi.y + oi);
        
        float3 p, ox, oy, oz, dx, dy, dz;
        float2 F = 1e6;
        
        for (int i = 0; i < 3; i ++)
        {
            for (int j = 0; j < 3; j ++)
            {
                p = Permutation(px[i] + py[j] + Pi.z + oi); // pij1, pij2, pij3
                
                ox = frac(p * K) - Ko;
                oy = mod(floor(p * K), 7.0) * K - Ko;
                
                p = Permutation(p);
                
                oz = frac(p * K) - Ko;
                
                dx = Pf.x - of[i] + jitter * ox;
                dy = Pf.y - of[j] + jitter * oy;
                dz = Pf.z - of + jitter * oz;
                
                float3 d = dx * dx + dy * dy + dz * dz; // dij1, dij2 and dij3, squared
                
                //Find lowest and second lowest distances
                for (int n = 0; n < 3; n ++)
                {
                    if (d[n] < F[0])
                    {
                        F[1] = F[0];
                        F[0] = d[n];
                        randomPoint = p;
                    }
                    else if(d[n] < F[1])
                    {
                        F[1] = d[n];
                    }
                }
            }
        }
        
        return F;
    }
    
    float voronoi2D(in float2 x, float scale, float2 speed)
    {
        x *= scale;
        x += speed * _Time.x;
        float2 n = floor(x);
        float2 f = frac(x);
        
        // first pass: regular voronoi
        float2 mg, mr;
        float md = 8.0;
        for (int j = -1; j <= 1; j ++)
        {
            for (int i = -1; i <= 1; i ++)
            {
                float2 g = float2(float(i), float(j));
                float2 o = random2(n + g);
                float2 currentPoint = o;
                
                float2 r = g + o - f;
                float d = dot(r, r);
                
                if (d < md)
                {
                    md = d;
                    mr = r;
                    mg = g;
                    randomPoint.xy = currentPoint;
                }
            }
        }
        
        // second pass: distance to borders
        md = 8.0;
        for (int r = -2; r <= 2; r ++)
        {
            for (int q = -2; q <= 2; q ++)
            {
                float2 g = mg + float2(float(q), float(r));
                float2 o = random2(n + g);
                
                float2 r = g + o - f;
                
                if (dot(mr - r, mr - r) > 0.00001)
                {
                    md = min(md, dot(0.5 * (mr + r), normalize(r - mr)));
                }
            }
        }
        return md;
    }
    
    float voronoi3D(in float3 x, float scale, float3 speed)
    {
        x *= scale;
        x += speed * _Time.x;
        float3 n = floor(x);
        float3 f = frac(x);
        
        // first pass: regular voronoi
        float3 mg, mr;
        float md = 8.0;
        for (int j = -1; j <= 1; j ++)
        {
            for (int i = -1; i <= 1; i ++)
            {
                for (int h = -1; h <= 1; h ++)
                {
                    float3 g = float3(float(h), float(i), float(j));
                    float3 o = random3(n + g);
                    float3 currentPoint = o;
                    
                    float3 r = g + o - f;
                    float d = dot(r, r);
                    
                    if (d < md)
                    {
                        md = d;
                        mr = r;
                        mg = g;
                        randomPoint = currentPoint;
                    }
                }
            }
        }
        
        // second pass: distance to borders
        md = 8.0;
        for (int r = -2; r <= 2; r ++)
        {
            for (int q = -2; q <= 2; q ++)
            {
                for (int p = -2; p <= 2; p ++)
                {
                    float3 g = mg + float3(float(p), float(q), float(r));
                    float3 o = random3(n + g);
                    
                    float3 r = g + o - f;
                    
                    if (dot(mr - r, mr - r) > 0.00001)
                    {
                        md = min(md, dot(0.5 * (mr + r), normalize(r - mr)));
                    }
                }
            }
        }
        return md;
    }
    
    
    
    // fracal sum, range -1.0 - 1.0
    float VoronoiNoise_Octaves(float3 p, float scale, float3 speed, int octaveNumber, float octaveScale, float octaveAttenuation, float jitter, float time)
    {
        float freq = scale;
        float weight = 1.0f;
        float sum = 0;
        for (int i = 0; i < octaveNumber; i ++)
        {
            float2 F = inoise(p * freq + time * speed, jitter) * weight;
            
            sum += sqrt(F[0]);
            
            freq *= octaveScale;
            weight *= 1.0f - octaveAttenuation;
        }
        return sum;
    }
    
    float VoronoiNoiseDiff_Octaves(float3 p, float scale, float3 speed, int octaveNumber, float octaveScale, float octaveAttenuation, float jitter, float time)
    {
        float freq = scale;
        float weight = 1.0f;
        float sum = 0;
        for (int i = 0; i < octaveNumber; i ++)
        {
            float2 F = inoise(p * freq + time * speed, jitter) * weight;
            
            sum += sqrt(F[1]) - sqrt(F[0]);
            
            freq *= octaveScale;
            weight *= 1.0f - octaveAttenuation;
        }
        return sum;
    }
    
    void applyVoronoi(inout float4 finalColor, inout float3 VoronoiEmission)
    {
        float voronoiOctaveNumber = 1;
        float voronoiOctaveScale = 1;
        float voronoiOctaveAttenuation = 1;
        randomPoint = 0;
        float4 voronoiColor1 = float4(1,1,1,1);
        
        float voronoi = 0;
        
        float3 position = 0;
        
        
        if (float(0) == 0)
        {
            position = poiMesh.localPos;
        }
        
        if(float(0) == 1)
        {
            position = poiMesh.worldPos;
        }
        
        if(float(0) == 2)
        {
            position = float3(poiMesh.uv[0].x, poiMesh.uv[0].y, 0);
        }
        #if defined(PROP_VORONOIMASK) || !defined(OPTIMIZER_ENABLED)
            float mask = POI2D_SAMPLER_PAN(_VoronoiMask, _MainTex, poiMesh.uv[float(0)], float4(0,0,0,0)).r;
        #else
            float mask = 1;
        #endif
        #if defined(PROP_VORONOINOISE) || !defined(OPTIMIZER_ENABLED)
            float edgeNoise = POI2D_SAMPLER_PAN(_VoronoiNoise, _MainTex, poiMesh.uv[float(0)], float4(0,0,0,0)).r * float(0.1);
        #else
            float edgeNoise = 0;
        #endif
        
        if(float(1) == 0) // Basic
        {
            voronoi = voronoi2D(position.xy, float(5), float4(3,3,3,1));
        }
        
        if (float(1) == 1) // Diff
        {
            voronoi = VoronoiNoiseDiff_Octaves(position, float(5), float4(3,3,3,1), voronoiOctaveNumber, voronoiOctaveScale, voronoiOctaveAttenuation, 1, _Time.x);
        }
        
        if (float(1) == 2) // Fixed Border
        {
            voronoi = voronoi3D(position, float(5), float4(3,3,3,1));
            // isolines
            //color = c.x * (0.5 + 0.5 * sin(64.0 * c.x)) * 1.0;
        }
        
        if (float(0) == 1)
        {
            float3 rando = random3(randomPoint);
            fixed hue = rando.x;
            fixed saturation = lerp(float4(0.8,1,0,1).x, float4(0.8,1,0,1).y, rando.y);
            fixed value = lerp(float4(0.8,1,0,1).x, float4(0.8,1,0,1).y, rando.z);
            float3 hsv = float3(hue, saturation, value);
            
            voronoiColor1.rgb = HSVtoRGB(hsv);
        }
        
        float2 voronoiGradient = float4(0.04,0.05,0,0);
        voronoiGradient.xy += edgeNoise;
        float ramp = smoothstep(voronoiGradient.x, voronoiGradient.y, voronoi);
        
        
        if(float(0) == 0)
        {
            float4 voronoiColor = lerp(float4(0,0,0,1), voronoiColor1, ramp);
            
            if(float(0))
            {
                finalColor.rgba = lerp(finalColor, voronoiColor, min(mask, 0.99999));
            }
            else
            {
                finalColor.rgb = lerp(finalColor.rgb, voronoiColor.rgb, min(mask * voronoiColor.a, 0.99999));
            }
        }
        float4 voronoiEmissionColor = lerp(float4(0,0,0,1) * float(0), voronoiColor1 * float(0), ramp);
        VoronoiEmission = voronoiEmissionColor.rgb * mask * voronoiEmissionColor.a;
    }
    
#endif
