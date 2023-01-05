// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Destiny2 Armor&Weapon shader 1.0.3"
{
	Properties
	{
		_Cutoff( "Mask Clip Value", Float ) = 0.5
		_InsertDiffuseTextureHere("Insert Diffuse Texture Here", 2D) = "gray" {}
		_InsertGstackTextureHere("Insert Gstack Texture Here", 2D) = "black" {}
		[Normal]_InsertNormalMapHere("Insert Normal Map Here", 2D) = "bump" {}
		_WearMaskBias("Wear Mask Bias", Range( 0 , 1)) = 0.5
		_WearMaskContrast("Wear Mask Contrast", Range( 0 , 1)) = 0.95
		_DyeColorA("Dye Color A", Color) = (0.5019608,0.5019608,0.5019608,0)
		_DyeColorB("Dye Color B", Color) = (0.5019608,0.5019608,0.5019608,0)
		_MetalnessA("Metalness A", Range( 0 , 1)) = 1
		_GlossinessA("Glossiness A", Range( 0 , 1)) = 0
		_GlossinessASmoother("Glossiness A Smoother", Range( 0 , 1)) = 1
		_MetalnessB("Metalness B", Range( 0 , 1)) = 1
		_GlossinessB("Glossiness B", Range( 0 , 1)) = 0
		_GlossinessBSmoother("Glossiness B Smoother", Range( 0 , 1)) = 0
		_EmissionColor("Emission Color", Color) = (1,1,1,1)
		_TransparencyBias("Transparency Bias", Range( 0 , 1)) = 0
		_TiledDiffuse("TiledDiffuse", 2D) = "gray" {}
		_TiledDiffuseBias("TiledDiffuse Bias", Range( 0 , 1)) = 1
		_TiledDiffuseGlossMapBias("TiledDiffuse Gloss Map Bias", Range( 0 , 1)) = 0
		_TiledNormalMap("TiledNormal Map", 2D) = "bump" {}
		_TiledNormalBias("TiledNormal Bias", Range( 0 , 1)) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "AlphaTest+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Off
		CGPROGRAM
		#include "UnityStandardUtils.cginc"
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float2 uv_texcoord;
			float4 vertexColor : COLOR;
		};

		uniform sampler2D _InsertNormalMapHere;
		uniform float4 _InsertNormalMapHere_ST;
		uniform sampler2D _TiledNormalMap;
		uniform float4 _TiledNormalMap_ST;
		uniform float _TiledNormalBias;
		uniform sampler2D _InsertGstackTextureHere;
		uniform float4 _InsertGstackTextureHere_ST;
		uniform float4 _DyeColorA;
		uniform float4 _DyeColorB;
		uniform float _WearMaskContrast;
		uniform float _WearMaskBias;
		uniform sampler2D _TiledDiffuse;
		uniform float4 _TiledDiffuse_ST;
		uniform float _TiledDiffuseBias;
		uniform sampler2D _InsertDiffuseTextureHere;
		uniform float4 _InsertDiffuseTextureHere_ST;
		uniform float4 _EmissionColor;
		uniform float _MetalnessA;
		uniform float _MetalnessB;
		uniform float _TiledDiffuseGlossMapBias;
		uniform float _GlossinessA;
		uniform float _GlossinessASmoother;
		uniform float _GlossinessB;
		uniform float _GlossinessBSmoother;
		uniform float _TransparencyBias;
		uniform float _Cutoff = 0.5;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_InsertNormalMapHere = i.uv_texcoord * _InsertNormalMapHere_ST.xy + _InsertNormalMapHere_ST.zw;
			float3 tex2DNode7 = UnpackNormal( tex2D( _InsertNormalMapHere, uv_InsertNormalMapHere ) );
			float4 appendResult149 = (float4(tex2DNode7.r , -tex2DNode7.g , tex2DNode7.b , 0.0));
			float4 color134 = IsGammaSpace() ? float4(0,0,1,0) : float4(0,0,1,0);
			float2 uv_TiledNormalMap = i.uv_texcoord * _TiledNormalMap_ST.xy + _TiledNormalMap_ST.zw;
			float3 tex2DNode127 = UnpackNormal( tex2D( _TiledNormalMap, uv_TiledNormalMap ) );
			float4 appendResult156 = (float4(tex2DNode127.r , -tex2DNode127.g , tex2DNode127.b , 0.0));
			float4 lerpResult133 = lerp( color134 , appendResult156 , _TiledNormalBias);
			float2 uv_InsertGstackTextureHere = i.uv_texcoord * _InsertGstackTextureHere_ST.xy + _InsertGstackTextureHere_ST.zw;
			float4 tex2DNode6 = tex2D( _InsertGstackTextureHere, uv_InsertGstackTextureHere );
			float ifLocalVar72 = 0;
			if( tex2DNode6.a > 0.157 )
				ifLocalVar72 = 1.0;
			float4 lerpResult157 = lerp( color134 , lerpResult133 , ifLocalVar72);
			o.Normal = BlendNormals( appendResult149.xyz , lerpResult157.xyz );
			float4 color76 = IsGammaSpace() ? float4(0.5019608,0.5019608,0.5019608,0) : float4(0.2158605,0.2158605,0.2158605,0);
			float temp_output_44_0 = ( ( _WearMaskContrast * 0.99999 ) / 2.0 );
			float temp_output_42_0 = ( 0.5 - _WearMaskBias );
			float clampResult48 = clamp( ( temp_output_44_0 + temp_output_42_0 ) , 0.0 , 1.0 );
			float clampResult47 = clamp( ( ( 1.0 - temp_output_44_0 ) + temp_output_42_0 ) , 0.0 , 1.0 );
			float clampResult58 = clamp( ( ( ( ( tex2DNode6.a * ( 1.0 / ( 1.0 - 0.156863 ) ) ) + ( 0.156863 / ( 0.156863 - 1.0 ) ) ) * ( 1.0 / ( clampResult48 - clampResult47 ) ) ) + ( clampResult47 / ( clampResult47 - clampResult48 ) ) ) , 0.0 , 1.0 );
			float4 lerpResult53 = lerp( _DyeColorA , _DyeColorB , clampResult58);
			float4 lerpResult75 = lerp( color76 , lerpResult53 , ifLocalVar72);
			float4 color140 = IsGammaSpace() ? float4(0.5019608,0.5019608,0.5019608,0) : float4(0.2158605,0.2158605,0.2158605,0);
			float2 uv_TiledDiffuse = i.uv_texcoord * _TiledDiffuse_ST.xy + _TiledDiffuse_ST.zw;
			float4 tex2DNode138 = tex2D( _TiledDiffuse, uv_TiledDiffuse );
			float4 lerpResult141 = lerp( color140 , tex2DNode138 , _TiledDiffuseBias);
			float2 uv_InsertDiffuseTextureHere = i.uv_texcoord * _InsertDiffuseTextureHere_ST.xy + _InsertDiffuseTextureHere_ST.zw;
			float4 blendOpSrc139 = lerpResult141;
			float4 blendOpDest139 = tex2D( _InsertDiffuseTextureHere, uv_InsertDiffuseTextureHere );
			float4 blendOpSrc51 = lerpResult75;
			float4 blendOpDest51 = ( saturate( (( blendOpDest139 > 0.5 ) ? ( 1.0 - ( 1.0 - 2.0 * ( blendOpDest139 - 0.5 ) ) * ( 1.0 - blendOpSrc139 ) ) : ( 2.0 * blendOpDest139 * blendOpSrc139 ) ) ));
			o.Albedo = ( saturate( (( blendOpDest51 > 0.5 ) ? ( 1.0 - ( 1.0 - 2.0 * ( blendOpDest51 - 0.5 ) ) * ( 1.0 - blendOpSrc51 ) ) : ( 2.0 * blendOpDest51 * blendOpSrc51 ) ) )).rgb;
			float clampResult121 = clamp( ( ( tex2DNode6.b * ( 1.0 / ( 1.0 - 0.157 ) ) ) + ( 0.157 / ( 0.157 - 1.0 ) ) ) , 0.0 , 1.0 );
			float4 lerpResult126 = lerp( float4( 0,0,0,0 ) , _EmissionColor , ( clampResult121 * 5.0 ));
			o.Emission = lerpResult126.rgb;
			float clampResult86 = clamp( ( ( tex2DNode6.a * ( 1.0 / ( 0.125 - 0.0 ) ) ) + ( 0.0 / ( 0.0 - 0.125 ) ) ) , 0.0 , 1.0 );
			float lerpResult109 = lerp( ( clampResult86 * _MetalnessA ) , ( clampResult86 * _MetalnessB ) , clampResult58);
			float lerpResult111 = lerp( clampResult86 , lerpResult109 , ifLocalVar72);
			o.Metallic = lerpResult111;
			float4 temp_cast_6 = (tex2DNode138.a).xxxx;
			float4 lerpResult151 = lerp( color140 , temp_cast_6 , _TiledDiffuseGlossMapBias);
			float4 lerpResult154 = lerp( color140 , lerpResult151 , ifLocalVar72);
			float4 temp_cast_7 = (tex2DNode6.g).xxxx;
			float4 blendOpSrc148 = lerpResult154;
			float4 blendOpDest148 = temp_cast_7;
			float4 temp_output_148_0 = ( saturate( (( blendOpDest148 > 0.5 ) ? ( 1.0 - ( 1.0 - 2.0 * ( blendOpDest148 - 0.5 ) ) * ( 1.0 - blendOpSrc148 ) ) : ( 2.0 * blendOpDest148 * blendOpSrc148 ) ) ));
			float4 temp_cast_8 = (_GlossinessA).xxxx;
			float4 lerpResult88 = lerp( temp_output_148_0 , float4( 0.5,0,0,0 ) , _GlossinessASmoother);
			float4 blendOpSrc96 = temp_cast_8;
			float4 blendOpDest96 = lerpResult88;
			float4 temp_cast_9 = (_GlossinessB).xxxx;
			float4 lerpResult92 = lerp( temp_output_148_0 , float4( 0.5,0,0,0 ) , _GlossinessBSmoother);
			float4 blendOpSrc100 = temp_cast_9;
			float4 blendOpDest100 = lerpResult92;
			float4 lerpResult101 = lerp( ( saturate( (( blendOpDest96 > 0.5 ) ? ( 1.0 - ( 1.0 - 2.0 * ( blendOpDest96 - 0.5 ) ) * ( 1.0 - blendOpSrc96 ) ) : ( 2.0 * blendOpDest96 * blendOpSrc96 ) ) )) , ( saturate( (( blendOpDest100 > 0.5 ) ? ( 1.0 - ( 1.0 - 2.0 * ( blendOpDest100 - 0.5 ) ) * ( 1.0 - blendOpSrc100 ) ) : ( 2.0 * blendOpDest100 * blendOpSrc100 ) ) )) , clampResult58);
			float4 lerpResult102 = lerp( temp_output_148_0 , lerpResult101 , ifLocalVar72);
			o.Smoothness = lerpResult102.r;
			o.Occlusion = tex2DNode6.r;
			o.Alpha = 1;
			float temp_output_29_0 = ( ( tex2DNode6.b * ( 1.0 / ( 0.157 - 0.0 ) ) ) + ( 0.0 / ( 0.0 - 0.157 ) ) );
			float ifLocalVar2 = 0;
			if( i.vertexColor.b > 0.25 )
				ifLocalVar2 = 1.0;
			float lerpResult67 = lerp( 1.0 , temp_output_29_0 , ifLocalVar2);
			float lerpResult70 = lerp( lerpResult67 , temp_output_29_0 , _TransparencyBias);
			clip( lerpResult70 - _Cutoff );
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16400
7;29;946;1014;1508.346;708.3936;2.806064;True;False
Node;AmplifyShaderEditor.CommentaryNode;50;-711.125,2300.626;Float;False;1457.387;641.2587;Wear Mask Controller;13;57;44;45;58;48;47;31;43;46;42;21;40;41;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;41;-701.2831,2685.885;Float;False;Property;_WearMaskContrast;Wear Mask Contrast;5;0;Create;True;0;0;False;0;0.95;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;57;-632.2021,2815.436;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0.99999;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;44;-476.0752,2805.994;Float;False;2;0;FLOAT;0;False;1;FLOAT;2;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;40;-703.4108,2610.521;Float;False;Property;_WearMaskBias;Wear Mask Bias;4;0;Create;True;0;0;False;0;0.5;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;21;-705.4244,2337.95;Float;False;628.6575;265.0187;Wear Mask;8;17;16;15;13;14;12;11;10;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;11;-670.9176,2457.533;Float;False;Constant;_WearMaskCRB;Wear Mask CR B;4;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;10;-672.4236,2384.594;Float;False;Constant;_WearMaskCRA;Wear Mask CR A;4;0;Create;True;0;0;False;0;0.156863;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;42;-420.88,2686.178;Float;False;2;0;FLOAT;0.5;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;45;-344.8749,2811.094;Float;False;2;0;FLOAT;1;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;12;-472.8721,2385.625;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;46;-209.175,2814.293;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;43;-213.175,2704.293;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;77;-711.878,2069.435;Float;False;703.679;226.2172;Metalness Map;9;78;79;84;85;86;83;81;82;80;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SamplerNode;6;-742.6573,-169.2249;Float;True;Property;_InsertGstackTextureHere;Insert Gstack Texture Here;2;0;Create;True;0;0;False;0;None;None;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleDivideOpNode;14;-339.872,2383.625;Float;False;2;0;FLOAT;1;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;13;-470.8721,2475.625;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;47;-84.17499,2811.293;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;48;-88.11729,2701.469;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;112;-723.621,1024.345;Float;False;1217.981;223.422;Emission Map;12;122;126;121;120;119;118;117;116;115;113;114;124;;0,0,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;74;-714.855,1855.596;Float;False;403.7729;200.9961;Dyemask Threshold;2;72;73;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;78;-703.3335,2111.837;Float;False;Constant;_MetalnessCRA;Metalness CR A;4;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;31;95.51795,2686.186;Float;False;602.7432;226.5863;Wear Mask Contrast;6;38;39;37;36;32;33;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;79;-705.1589,2192.642;Float;False;Constant;_MetalnessCRB;Metalness CR B;4;0;Create;True;0;0;False;0;0.125;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;140;-742.4259,-494.9138;Float;False;Constant;_TiledDiffuseDefault;TiledDiffuse Default;16;0;Create;True;0;0;False;0;0.5019608,0.5019608,0.5019608,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;73;-710.8551,1895.243;Float;False;Constant;_Greaterthan0157;Greater than: 0.157;9;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;16;-219.4112,2388.384;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;32;128.0269,2727.538;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;15;-339.4067,2469.947;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;113;-714.9019,1148.551;Float;False;Constant;_Float0;Float 0;4;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;22;-720.8453,1260.161;Float;False;982.8151;298.5839;Alpha Test;10;30;29;28;27;24;23;26;25;60;67;;0,0,1,1;0;0
Node;AmplifyShaderEditor.SamplerNode;138;-746.8707,-682.6871;Float;True;Property;_TiledDiffuse;TiledDiffuse;16;0;Create;True;0;0;False;0;None;None;True;0;False;gray;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;153;-748.4662,-246.5032;Float;False;Property;_TiledDiffuseGlossMapBias;TiledDiffuse Gloss Map Bias;18;0;Create;True;0;0;False;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;114;-709.0765,1066.746;Float;False;Constant;_Float52;Float 52;4;0;Create;True;0;0;False;0;0.157;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;80;-525.8101,2110.642;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;37;271.8875,2720.422;Float;False;2;0;FLOAT;1;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;25;-703.845,1376.805;Float;False;Constant;_AlphaTestCRA;Alpha Test CR A;4;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;82;-392.8095,2108.641;Float;False;2;0;FLOAT;1;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;33;127.3273,2810.143;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;17;-218.8369,2482.041;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;115;-537.5531,1065.551;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;151;-338.9522,-409.2219;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ConditionalIfNode;72;-482.2876,1892.994;Float;False;False;5;0;FLOAT;0;False;1;FLOAT;0.157;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;81;-523.8101,2200.642;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;26;-701.339,1449.746;Float;False;Constant;_AlphaTestCRB;Alpha Test CR B;4;0;Create;True;0;0;False;0;0.157;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;103;-724.5704,648.6902;Float;False;1015.295;364.2092;Glossiness Controls;10;102;101;100;96;92;88;94;99;90;89;;0,1,0,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;39;413.2417,2725.465;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;36;270.631,2809.743;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;84;-279.7665,2106.773;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;154;-127.4167,-417.6398;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;116;-535.5531,1155.551;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;117;-404.5525,1063.551;Float;False;2;0;FLOAT;1;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;23;-504.3387,1372.746;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;83;-392.3442,2194.964;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;127;-733.1523,214.4384;Float;True;Property;_TiledNormalMap;TiledNormal Map;19;0;Create;True;0;0;False;0;None;None;True;0;False;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleSubtractOpNode;24;-503.3387,1458.745;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;90;-700.5705,928.7535;Float;False;Property;_GlossinessBSmoother;Glossiness B Smoother;13;0;Create;True;0;0;False;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;28;-334.3388,1375.746;Float;False;2;0;FLOAT;1;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;71;-720.0484,1568.882;Float;False;385.506;272.0068;Vertex Paint (auto-transparency application);3;2;4;1;;0,0,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;87;-751.1762,-1417.205;Float;False;807.8767;531.5037;Color Dyes;6;51;75;53;76;52;54;;1,0,0,1;0;0
Node;AmplifyShaderEditor.SimpleAddOpNode;38;571.0589,2791.187;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;85;-277.6386,2194.988;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;89;-702.7945,769.8537;Float;False;Property;_GlossinessASmoother;Glossiness A Smoother;10;0;Create;True;0;0;False;0;1;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;119;-291.5094,1061.682;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.BlendOpsNode;148;53.73383,-413.7606;Float;False;Overlay;True;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.NegateNode;155;-398.0883,275.0255;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;118;-404.0872,1149.873;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;108;-2.032192,2069.367;Float;False;764.5273;235.444;Metalness Controller;6;109;107;106;105;104;111;;1,1,1,1;0;0
Node;AmplifyShaderEditor.VertexColorNode;1;-710.0484,1604.882;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ClampOpNode;86;-148.1754,2154.756;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;105;4.397607,2178.827;Float;False;Property;_MetalnessB;Metalness B;11;0;Create;True;0;0;False;0;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;120;-289.3815,1149.896;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;88;-418.333,711.5214;Float;False;3;0;COLOR;0.5,0,0,0;False;1;COLOR;0.5,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;142;-743.5742,-328.2048;Float;False;Property;_TiledDiffuseBias;TiledDiffuse Bias;17;0;Create;True;0;0;False;0;1;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;52;-740.267,-1378.206;Float;False;Property;_DyeColorA;Dye Color A;6;0;Create;True;0;0;False;0;0.5019608,0.5019608,0.5019608,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ClampOpNode;58;604.5122,2527.957;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;54;-738.2415,-1217.682;Float;False;Property;_DyeColorB;Dye Color B;7;0;Create;True;0;0;False;0;0.5019608,0.5019608,0.5019608,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;4;-707.2087,1764.2;Float;False;Constant;_GreaterThan025;Greater Than: 0.25;0;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;27;-334.8734,1466.067;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;94;-703.6441,694.6902;Float;False;Property;_GlossinessA;Glossiness A;9;0;Create;True;0;0;False;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;7;-739.5398,22.56567;Float;True;Property;_InsertNormalMapHere;Insert Normal Map Here;3;1;[Normal];Create;True;0;0;False;0;None;None;True;0;False;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;30;-207.0295,1369.162;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;99;-700.5416,849.3735;Float;False;Property;_GlossinessB;Glossiness B;12;0;Create;True;0;0;False;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;135;-732.342,406.4077;Float;False;Property;_TiledNormalBias;TiledNormal Bias;20;0;Create;True;0;0;False;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;104;3.967807,2105.367;Float;False;Property;_MetalnessA;Metalness A;8;0;Create;True;0;0;False;0;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;156;-205.8371,232.4437;Float;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.ColorNode;134;-725.9055,482.9502;Float;False;Constant;_FlatNormalMap;Flat Normal Map;16;0;Create;True;0;0;False;0;0,0,1,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;92;-412.6853,863.7225;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0.5,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;53;-513.4477,-1370.725;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;5;-746.5206,-882.6722;Float;True;Property;_InsertDiffuseTextureHere;Insert Diffuse Texture Here;1;0;Create;True;0;0;False;0;None;None;True;0;False;gray;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;141;-334.5742,-560.2048;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;76;-736.5632,-1057.808;Float;False;Constant;_DefaultDyeColor;Default Dye Color;7;0;Create;True;0;0;False;0;0.5019608,0.5019608,0.5019608,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;106;288.9242,2103.07;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;133;-103.6938,361.9453;Float;False;3;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0,0,0,0;False;2;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.BlendOpsNode;100;-254.0739,845.1645;Float;False;Overlay;True;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ClampOpNode;121;-159.9183,1109.665;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;107;285.602,2199.907;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.BlendOpsNode;96;-256.5447,742.6429;Float;False;Overlay;True;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;29;-186.3039,1464.162;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.NegateNode;150;-438.7256,79.97238;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ConditionalIfNode;2;-494.2083,1654.363;Float;False;False;5;0;FLOAT;0;False;1;FLOAT;0.25;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;75;-349.583,-1373.06;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;124;132.0268,1067.183;Float;False;Property;_EmissionColor;Emission Color;14;0;Create;True;0;0;False;0;1,1,1,1;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;157;175.8959,352.4656;Float;False;3;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0,0,0,0;False;2;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.LerpOp;101;-32.9468,784.1495;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.DynamicAppendNode;149;-300.4744,58.39053;Float;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;122;-11.58246,1135.053;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;67;78.7219,1408.534;Float;False;3;0;FLOAT;1;False;1;FLOAT;1;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;109;443.2174,2138.439;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;60;-707.364,1300.072;Float;False;Property;_TransparencyBias;Transparency Bias;15;0;Create;True;0;0;False;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.BlendOpsNode;139;-135.0935,-680.1185;Float;False;Overlay;True;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.BlendOpsNode;51;-163.3953,-1377.243;Float;False;Overlay;True;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.BlendNormalsNode;128;93.5865,114.6614;Float;False;0;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LerpOp;111;601.0704,2138.829;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;126;339.5686,1084.781;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;70;368.3486,1544.461;Float;False;3;0;FLOAT;1;False;1;FLOAT;1;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;102;142.5914,785.803;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;992.0448,733.4306;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;Destiny2 Armor&Weapon shader 1.0.3;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;False;Off;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;True;0;True;Opaque;;AlphaTest;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;136;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;57;0;41;0
WireConnection;44;0;57;0
WireConnection;42;1;40;0
WireConnection;45;1;44;0
WireConnection;12;0;11;0
WireConnection;12;1;10;0
WireConnection;46;0;45;0
WireConnection;46;1;42;0
WireConnection;43;0;44;0
WireConnection;43;1;42;0
WireConnection;14;1;12;0
WireConnection;13;0;10;0
WireConnection;13;1;11;0
WireConnection;47;0;46;0
WireConnection;48;0;43;0
WireConnection;16;0;6;4
WireConnection;16;1;14;0
WireConnection;32;0;48;0
WireConnection;32;1;47;0
WireConnection;15;0;10;0
WireConnection;15;1;13;0
WireConnection;80;0;79;0
WireConnection;80;1;78;0
WireConnection;37;1;32;0
WireConnection;82;1;80;0
WireConnection;33;0;47;0
WireConnection;33;1;48;0
WireConnection;17;0;16;0
WireConnection;17;1;15;0
WireConnection;115;0;113;0
WireConnection;115;1;114;0
WireConnection;151;0;140;0
WireConnection;151;1;138;4
WireConnection;151;2;153;0
WireConnection;72;0;6;4
WireConnection;72;2;73;0
WireConnection;81;0;78;0
WireConnection;81;1;79;0
WireConnection;39;0;17;0
WireConnection;39;1;37;0
WireConnection;36;0;47;0
WireConnection;36;1;33;0
WireConnection;84;0;6;4
WireConnection;84;1;82;0
WireConnection;154;0;140;0
WireConnection;154;1;151;0
WireConnection;154;2;72;0
WireConnection;116;0;114;0
WireConnection;116;1;113;0
WireConnection;117;1;115;0
WireConnection;23;0;26;0
WireConnection;23;1;25;0
WireConnection;83;0;78;0
WireConnection;83;1;81;0
WireConnection;24;0;25;0
WireConnection;24;1;26;0
WireConnection;28;1;23;0
WireConnection;38;0;39;0
WireConnection;38;1;36;0
WireConnection;85;0;84;0
WireConnection;85;1;83;0
WireConnection;119;0;6;3
WireConnection;119;1;117;0
WireConnection;148;0;154;0
WireConnection;148;1;6;2
WireConnection;155;0;127;2
WireConnection;118;0;114;0
WireConnection;118;1;116;0
WireConnection;86;0;85;0
WireConnection;120;0;119;0
WireConnection;120;1;118;0
WireConnection;88;0;148;0
WireConnection;88;2;89;0
WireConnection;58;0;38;0
WireConnection;27;0;25;0
WireConnection;27;1;24;0
WireConnection;30;0;6;3
WireConnection;30;1;28;0
WireConnection;156;0;127;1
WireConnection;156;1;155;0
WireConnection;156;2;127;3
WireConnection;92;0;148;0
WireConnection;92;2;90;0
WireConnection;53;0;52;0
WireConnection;53;1;54;0
WireConnection;53;2;58;0
WireConnection;141;0;140;0
WireConnection;141;1;138;0
WireConnection;141;2;142;0
WireConnection;106;0;86;0
WireConnection;106;1;104;0
WireConnection;133;0;134;0
WireConnection;133;1;156;0
WireConnection;133;2;135;0
WireConnection;100;0;99;0
WireConnection;100;1;92;0
WireConnection;121;0;120;0
WireConnection;107;0;86;0
WireConnection;107;1;105;0
WireConnection;96;0;94;0
WireConnection;96;1;88;0
WireConnection;29;0;30;0
WireConnection;29;1;27;0
WireConnection;150;0;7;2
WireConnection;2;0;1;3
WireConnection;2;2;4;0
WireConnection;75;0;76;0
WireConnection;75;1;53;0
WireConnection;75;2;72;0
WireConnection;157;0;134;0
WireConnection;157;1;133;0
WireConnection;157;2;72;0
WireConnection;101;0;96;0
WireConnection;101;1;100;0
WireConnection;101;2;58;0
WireConnection;149;0;7;1
WireConnection;149;1;150;0
WireConnection;149;2;7;3
WireConnection;122;0;121;0
WireConnection;67;1;29;0
WireConnection;67;2;2;0
WireConnection;109;0;106;0
WireConnection;109;1;107;0
WireConnection;109;2;58;0
WireConnection;139;0;141;0
WireConnection;139;1;5;0
WireConnection;51;0;75;0
WireConnection;51;1;139;0
WireConnection;128;0;149;0
WireConnection;128;1;157;0
WireConnection;111;0;86;0
WireConnection;111;1;109;0
WireConnection;111;2;72;0
WireConnection;126;1;124;0
WireConnection;126;2;122;0
WireConnection;70;0;67;0
WireConnection;70;1;29;0
WireConnection;70;2;60;0
WireConnection;102;0;148;0
WireConnection;102;1;101;0
WireConnection;102;2;72;0
WireConnection;0;0;51;0
WireConnection;0;1;128;0
WireConnection;0;2;126;0
WireConnection;0;3;111;0
WireConnection;0;4;102;0
WireConnection;0;5;6;1
WireConnection;0;10;70;0
ASEEND*/
//CHKSM=0E0264AFBA9D13319FB9ABA0CD0351C9F67BEA18