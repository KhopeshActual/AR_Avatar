#ifndef POI_PATHING
#define POI_PATHING

// Fill, 0, Path, 1, Loop, 2
half _PathTypeR;
half _PathTypeG;
half _PathTypeB;
half3 _PathWidth;
float3 _PathTime;
float3 _PathOffset;
float3 _PathSpeed;
float4 _PathColorR;
float4 _PathColorG;
float4 _PathColorB;
float3 _PathEmissionStrength;
float3 _PathSoftness;
float3 _PathSegments;
float3 _PathAlpha;

#ifdef POI_AUDIOLINK
	// Time Offset
	half _AudioLinkPathTimeOffsetBandR;
	half2 _AudioLinkPathTimeOffsetR;
	half _AudioLinkPathTimeOffsetBandG;
	half2 _AudioLinkPathTimeOffsetG;
	half _AudioLinkPathTimeOffsetBandB;
	half2 _AudioLinkPathTimeOffsetB;

	// Emission Offset
	half _AudioLinkPathEmissionAddBandR;
	half2 _AudioLinkPathEmissionAddR;
	half _AudioLinkPathEmissionAddBandG;
	half2 _AudioLinkPathEmissionAddG;
	half _AudioLinkPathEmissionAddBandB;
	half2 _AudioLinkPathEmissionAddB;

	// Length Offset
	half _AudioLinkPathWidthOffsetBandR;
	half2 _AudioLinkPathWidthOffsetR;
	half _AudioLinkPathWidthOffsetBandG;
	half2 _AudioLinkPathWidthOffsetG;
	half _AudioLinkPathWidthOffsetBandB;
	half2 _AudioLinkPathWidthOffsetB;
#endif

#if defined(PROP_PATHINGMAP) || !defined(OPTIMIZER_ENABLED)
	POI_TEXTURE_NOSAMPLER(_PathingMap);
#endif
#if defined(PROP_PATHINGCOLORMAP) || !defined(OPTIMIZER_ENABLED)
	POI_TEXTURE_NOSAMPLER(_PathingColorMap);
#endif

void applyPathing(inout float4 albedo, inout float3 pathEmission)
{
	#if defined(PROP_PATHINGMAP) || !defined(OPTIMIZER_ENABLED)
		float4 path = POI2D_SAMPLER_PAN(_PathingMap, _MainTex, poiMesh.uv[float(0)], float4(0,0,0,0));
	#else
		float4 path = float4(0,0,0,0);
		return;
	#endif
	
	#if defined(PROP_PATHINGCOLORMAP) || !defined(OPTIMIZER_ENABLED)
		float4 pathColorMap = POI2D_SAMPLER_PAN(_PathingColorMap, _MainTex, poiMesh.uv[float(0)], float4(0,0,0,0));
	#else
		float4 pathColorMap = float4(1, 1, 1, 1);
	#endif
	
	float3 pathAudioLinkEmission = 0;
	float3 pathTime = 0;
	float3 pathAlpha[3] = {
		float3(0.0, 0.0, 0.0), float3(0.0, 0.0, 0.0), float3(0.0, 0.0, 0.0)
	};


	#ifdef POI_AUDIOLINK
		half pathAudioLinkPathTimeOffsetBand[3] = {float(0), float(0), float(0)};
		half2 pathAudioLinkTimeOffset[3] = {float4(0,0,0,1).xy, float4(0,0,0,1).xy, float4(0,0,0,1).xy};
		half pathAudioLinkPathWidthOffsetBand[3] = {float(0), float(0), float(0)};
		half2 pathAudioLinkWidthOffset[3] = {float4(0,0,0,0).xy, float4(0,0,0,0).xy, float4(0,0,0,0).xy};

		
		if (poiMods.audioLinkTextureExists)
		{
			// Emission
			pathAudioLinkEmission.r = lerp(float4(0,0,0,0).x, float4(0,0,0,0).y, poiMods.audioLink[float(0)]);
			pathAudioLinkEmission.g = lerp(float4(0,0,0,0).x, float4(0,0,0,0).y, poiMods.audioLink[float(0)]);
			pathAudioLinkEmission.b = lerp(float4(0,0,0,0).x, float4(0,0,0,0).y, poiMods.audioLink[float(0)]);
		}
	#endif

	[unroll]
	for (int index = 0; index < 3; index++)
	{
		pathTime[index] = float4(-999,-999,-999,1)[index] != -999.0f ? frac(float4(-999,-999,-999,1)[index] + float4(0,0,0,1)[index]): frac(_Time.x * float4(1,1,1,1)[index] + float4(0,0,0,1)[index]);

		#ifdef POI_AUDIOLINK
			
			if (poiMods.audioLinkTextureExists)
			{
				pathTime[index] += lerp(pathAudioLinkTimeOffset[index].x, pathAudioLinkTimeOffset[index].y, poiMods.audioLink[pathAudioLinkPathTimeOffsetBand[index]]);
			}
		#endif

		if (float4(0,0,0,1)[index])
		{
			float pathSegments = abs(float4(0,0,0,1)[index]);
			pathTime = (ceil(pathTime * pathSegments) - .5) / pathSegments;
		}

		if (path[index])
		{
			// Cutting it in half because it goes out in both directions for now
			half pathWidth = float4(0.03,0.03,0.03,1)[index] * .5;
			#ifdef POI_AUDIOLINK
				
				if (poiMods.audioLinkTextureExists)
				{
					pathWidth += lerp(pathAudioLinkWidthOffset[index].x, pathAudioLinkWidthOffset[index].y, poiMods.audioLink[pathAudioLinkPathWidthOffsetBand[index]]);
				}
			#endif


			//fill
			pathAlpha[index].x = pathTime[index] > path[index];
			//path
			pathAlpha[index].y = saturate((1 - abs(lerp(-pathWidth, 1 + pathWidth, pathTime[index]) - path[index])) - (1 - pathWidth)) * (1 / pathWidth);
			//loop
			pathAlpha[index].z = saturate((1 - distance(pathTime[index], path[index])) - (1 - pathWidth)) * (1 / pathWidth);
			pathAlpha[index].z += saturate(distance(pathTime[index], path[index]) - (1 - pathWidth)) * (1 / pathWidth);
			pathAlpha[index] = smoothstep(0, float4(1,1,1,1)[index] + .00001, pathAlpha[index]);
		}
	}

	// Emission
	pathEmission = 0;
	pathEmission += pathAlpha[0][float(0)] * float4(1,1,1,1).rgb * (float4(0,0,0,1)[0] + pathAudioLinkEmission.r);
	pathEmission += pathAlpha[1][float(0)] * float4(1,1,1,1).rgb * (float4(0,0,0,1)[1] + pathAudioLinkEmission.g);
	pathEmission += pathAlpha[2][float(0)] * float4(1,1,1,1).rgb * (float4(0,0,0,1)[2] + pathAudioLinkEmission.b);
	pathEmission *= pathColorMap.rgb * pathColorMap.a * path.a;

	float3 colorReplace = 0;
	colorReplace = pathAlpha[0][float(0)] * float4(1,1,1,1).rgb * pathColorMap.rgb;
	albedo.rgb = lerp(albedo.rgb, colorReplace + albedo.rgb * 0.00001, pathColorMap.a * path.a * float4(1,1,1,1).a * pathAlpha[0][float(0)]);
	colorReplace = pathAlpha[1][float(0)] * float4(1,1,1,1).rgb * pathColorMap.rgb;
	albedo.rgb = lerp(albedo.rgb, colorReplace + albedo.rgb * 0.00001, pathColorMap.a * path.a * float4(1,1,1,1).a * pathAlpha[1][float(0)]);
	colorReplace = pathAlpha[2][float(0)] * float4(1,1,1,1).rgb * pathColorMap.rgb;
	albedo.rgb = lerp(albedo.rgb, colorReplace + albedo.rgb * 0.00001, pathColorMap.a * path.a * float4(1,1,1,1).a * pathAlpha[2][float(0)]);
}

#endif
