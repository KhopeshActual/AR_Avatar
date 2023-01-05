#ifndef POI_FUNCTIONS_ARTISTIC
    #define POI_FUNCTIONS_ARTISTIC
    
    // Based on unity shader graph code
    
    // * Adjustments * //
    
    /*
    * Channel Mixer
    *
    * Controls the amount each of the channels of input In contribute to each of the channels of output Out. The slider
    * parameters on the node control the contribution of each of the input channels. The toggle button parameters control
    * which of the output channels is currently being edited. Slider controls for editing the contribution of each input
    * channnel range between -2 and 2.
    */
    void poiChannelMixer(float3 In, float3 _ChannelMixer_Red, float3 _ChannelMixer_Green, float3 _ChannelMixer_Blue, out float3 Out)
    {
        Out = float3(dot(In, _ChannelMixer_Red), dot(In, _ChannelMixer_Green), dot(In, _ChannelMixer_Blue));
    }
    
    /*
    * Contrast
    *
    * Adjusts the contrast of input In by the amount of input Contrast. A Contrast value of 1 will return the input
    * unaltered. A Contrast value of 0 will return the midpoint of the input
    */
    void poiContrast(float3 In, float Contrast, out float3 Out)
    {
        float midpoint = pow(0.5, 2.2);
        Out = (In - midpoint) * Contrast + midpoint;
    }
    
    /*
    * Hue Shift
    *
    * Offsets the hue of input col by the amount of input hueAdjust.
    */
    float3 hueShift(float3 col, float hueAdjust)
    {
        hueAdjust *= 2 * pi;
        const float3 k = float3(0.57735, 0.57735, 0.57735);
        half cosAngle = cos(hueAdjust);
        return col * cosAngle + cross(k, col) * sin(hueAdjust) + k * dot(k, col) * (1.0 - cosAngle);
    }
    
    /*
    * Invert Colors
    *
    * Inverts the colors of input In on a per channel basis. This Node assumes all input values are in the range 0 - 1.
    */
    void poiInvertColors(float4 In, float4 InvertColors, out float4 Out)
    {
        Out = abs(InvertColors - In);
    }
    
    /*
    * Replace Color
    *
    * Replaces values in input In equal to input From to the value of input To. Input Range can be used to define a
    * wider range of values around input From to replace. Input Fuzziness can be used to soften the edges around the
    * selection similar to anti-aliasing.
    */
    void poiReplaceColor(float3 In, float3 From, float3 To, float Range, float Fuzziness, out float3 Out)
    {
        float Distance = distance(From, In);
        Out = lerp(To, In, saturate((Distance - Range) / max(Fuzziness, 0.00001)));
    }
    
    /*
    * Saturation
    *
    * Adjusts the saturation of input In by the amount of input Saturation. A Saturation value of 1 will return the input
    * unaltered. A Saturation value of 0 will return the input completely desaturated.
    */
    void poiSaturation(float3 In, float Saturation, out float3 Out)
    {
        float luma = dot(In, float3(0.2126729, 0.7151522, 0.0721750));
        Out = luma.xxx + Saturation.xxx * (In - luma.xxx);
    }
    
    /*
    * Dither Node
    *
    * Dither is an intentional form of noise used to randomize quantization error. It is used to prevent large-scale
    * patterns such as color banding in images. The Dither node applies dithering in screen-space to ensure a uniform
    * distribution of the pattern. This can be adjusted by connecting another node to input Screen Position.
    *
    * This Node is commonly used as an input to Alpha Clip Threshold on a Master Node to give the appearance of
    * transparency to an opaque object. This is useful for creating objects that appear to be transparent but have
    * the advantages of rendering as opaque, such as writing depth and/or being rendered in deferred.
    */
    void poiDither(float4 In, float4 ScreenPosition, out float4 Out)
    {
        float2 uv = ScreenPosition.xy * _ScreenParams.xy;
        float DITHER_THRESHOLDS[16] = {
            1.0 / 17.0, 9.0 / 17.0, 3.0 / 17.0, 11.0 / 17.0,
            13.0 / 17.0, 5.0 / 17.0, 15.0 / 17.0, 7.0 / 17.0,
            4.0 / 17.0, 12.0 / 17.0, 2.0 / 17.0, 10.0 / 17.0,
            16.0 / 17.0, 8.0 / 17.0, 14.0 / 17.0, 6.0 / 17.0
        };
        uint index = (uint(uv.x) % 4) * 4 + uint(uv.y) % 4;
        Out = In - DITHER_THRESHOLDS[index];
    }
    
    /*
    * Color Mask
    *
    * Creates a mask from values in input In equal to input Mask Color. Input Range can be used to define a wider
    * range of values around input Mask Color to create the mask. Colors within this range will return 1,
    * otherwise the node will return 0. Input Fuzziness can be used to soften the edges around the selection
    * similar to anti-aliasing.
    */
    void poiColorMask(float3 In, float3 MaskColor, float Range, float Fuzziness, out float4 Out)
    {
        float Distance = distance(MaskColor, In);
        Out = saturate(1 - (Distance - Range) / max(Fuzziness, 0.00001));
    }
#endif
