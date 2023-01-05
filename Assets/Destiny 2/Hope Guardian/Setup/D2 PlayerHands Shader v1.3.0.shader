// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Destiny2 PlayerHands Shader 1.0.3"
{
	Properties
	{
		_Diffuse("Diffuse", 2D) = "gray" {}
		_MRC("MRC", 2D) = "gray" {}
		_NormalMap("Normal Map", 2D) = "bump" {}
		_TiledDiffuse("TiledDiffuse", 2D) = "gray" {}
		_TiledNormal("TiledNormal", 2D) = "bump" {}
		_TiledNormalBias("TiledNormal Bias", Range( 0 , 1)) = 0
		_TiledDiffuseBias("TiledDiffuse Bias", Range( 0 , 1)) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Off
		CGPROGRAM
		#include "UnityStandardUtils.cginc"
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform sampler2D _NormalMap;
		uniform float4 _NormalMap_ST;
		uniform sampler2D _TiledNormal;
		uniform float4 _TiledNormal_ST;
		uniform float _TiledNormalBias;
		uniform sampler2D _TiledDiffuse;
		uniform float4 _TiledDiffuse_ST;
		uniform float _TiledDiffuseBias;
		uniform sampler2D _Diffuse;
		uniform float4 _Diffuse_ST;
		uniform sampler2D _MRC;
		uniform float4 _MRC_ST;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_NormalMap = i.uv_texcoord * _NormalMap_ST.xy + _NormalMap_ST.zw;
			float3 tex2DNode3 = UnpackNormal( tex2D( _NormalMap, uv_NormalMap ) );
			float3 appendResult6 = (float3(tex2DNode3.r , -tex2DNode3.g , tex2DNode3.b));
			float4 color11 = IsGammaSpace() ? float4(0,0,1,0) : float4(0,0,1,0);
			float2 uv_TiledNormal = i.uv_texcoord * _TiledNormal_ST.xy + _TiledNormal_ST.zw;
			float3 tex2DNode5 = UnpackNormal( tex2D( _TiledNormal, uv_TiledNormal ) );
			float3 appendResult9 = (float3(tex2DNode5.r , -tex2DNode5.g , tex2DNode5.b));
			float4 lerpResult12 = lerp( color11 , float4( appendResult9 , 0.0 ) , _TiledNormalBias);
			o.Normal = BlendNormals( appendResult6 , lerpResult12.rgb );
			float4 color18 = IsGammaSpace() ? float4(0.5019608,0.5019608,0.5019608,0) : float4(0.2158605,0.2158605,0.2158605,0);
			float2 uv_TiledDiffuse = i.uv_texcoord * _TiledDiffuse_ST.xy + _TiledDiffuse_ST.zw;
			float4 lerpResult17 = lerp( color18 , tex2D( _TiledDiffuse, uv_TiledDiffuse ) , _TiledDiffuseBias);
			float2 uv_Diffuse = i.uv_texcoord * _Diffuse_ST.xy + _Diffuse_ST.zw;
			float4 blendOpSrc14 = lerpResult17;
			float4 blendOpDest14 = tex2D( _Diffuse, uv_Diffuse );
			o.Albedo = ( saturate( (( blendOpDest14 > 0.5 ) ? ( 1.0 - ( 1.0 - 2.0 * ( blendOpDest14 - 0.5 ) ) * ( 1.0 - blendOpSrc14 ) ) : ( 2.0 * blendOpDest14 * blendOpSrc14 ) ) )).rgb;
			float2 uv_MRC = i.uv_texcoord * _MRC_ST.xy + _MRC_ST.zw;
			float4 tex2DNode2 = tex2D( _MRC, uv_MRC );
			o.Metallic = tex2DNode2.r;
			o.Smoothness = tex2DNode2.g;
			o.Occlusion = tex2DNode2.b;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16400
7;29;946;1014;1292.929;786.4143;1.933905;True;False
Node;AmplifyShaderEditor.SamplerNode;5;-749.7897,566.9348;Float;True;Property;_TiledNormal;TiledNormal;4;0;Create;True;0;0;False;0;None;None;True;0;False;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;3;-746.3911,353.0347;Float;True;Property;_NormalMap;Normal Map;2;0;Create;True;0;0;False;0;None;None;True;0;False;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.NegateNode;10;-413.4586,597.0402;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;15;-406.7172,-592.6237;Float;False;Property;_TiledDiffuseBias;TiledDiffuse Bias;6;0;Create;True;0;0;False;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;13;-576.2289,976.4695;Float;False;Property;_TiledNormalBias;TiledNormal Bias;5;0;Create;True;0;0;False;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;18;-384.0454,-453.7488;Float;False;Constant;_Color1;Color 1;5;0;Create;True;0;0;False;0;0.5019608,0.5019608,0.5019608,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;4;-517.891,-278.365;Float;True;Property;_TiledDiffuse;TiledDiffuse;3;0;Create;True;0;0;False;0;None;None;True;0;False;gray;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;11;-666.5568,773.356;Float;False;Constant;_Color0;Color 0;5;0;Create;True;0;0;False;0;0,0,1,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.NegateNode;7;-441.4016,414.0293;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;9;-228.5353,577.1552;Float;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LerpOp;17;70.77582,-293.8572;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;12;-265.5568,774.4695;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.DynamicAppendNode;6;-227.4016,388.0293;Float;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SamplerNode;1;-396.3316,-79.45308;Float;True;Property;_Diffuse;Diffuse;0;0;Create;True;0;0;False;0;None;None;True;0;False;gray;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.BlendOpsNode;14;14.33222,-129.8303;Float;False;Overlay;True;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.BlendNormalsNode;8;-46.96522,508.0104;Float;False;0;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SamplerNode;2;-387.3911,147.0347;Float;True;Property;_MRC;MRC;1;0;Create;True;0;0;False;0;None;None;True;0;False;gray;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;225.7292,54.175;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;Destiny2 PlayerHands Shader 1.0.3;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Off;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;10;0;5;2
WireConnection;7;0;3;2
WireConnection;9;0;5;1
WireConnection;9;1;10;0
WireConnection;9;2;5;3
WireConnection;17;0;18;0
WireConnection;17;1;4;0
WireConnection;17;2;15;0
WireConnection;12;0;11;0
WireConnection;12;1;9;0
WireConnection;12;2;13;0
WireConnection;6;0;3;1
WireConnection;6;1;7;0
WireConnection;6;2;3;3
WireConnection;14;0;17;0
WireConnection;14;1;1;0
WireConnection;8;0;6;0
WireConnection;8;1;12;0
WireConnection;0;0;14;0
WireConnection;0;1;8;0
WireConnection;0;3;2;1
WireConnection;0;4;2;2
WireConnection;0;5;2;3
ASEEND*/
//CHKSM=FD36CC49F47CE3C348E01A6A5CB35D98933BF0C5