// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Halo 5/Visor Shader"
{
	Properties
	{
		_AlbedoMap("Albedo Map", 2D) = "white" {}
		_ControlMap("Control Map", 2D) = "white" {}
		[HDR]_PrimaryColor("Primary Color", Color) = (1,0.4800286,0,1)
		[HDR]_EdgeColor("Edge Color", Color) = (0,0.2278075,1,1)
		_EdgePowerIntensity("Edge Power/Intensity", Float) = 0.5
		_EdgeScale("Edge Scale", Float) = 0.5
		[Normal]_NormalMap("Normal Map", 2D) = "bump" {}
		[Toggle]_NormalYinvert("Normal Y invert", Float) = 1
		_NormalScale("Normal Scale", Float) = 1
		_Smoothness("Smoothness", Float) = 1
		_Specularity("Specularity", Float) = 1
		_ReflectionScale("Reflection Scale", Float) = 1
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Back
		CGINCLUDE
		#include "UnityStandardUtils.cginc"
		#include "UnityPBSLighting.cginc"
		#include "Lighting.cginc"
		#pragma target 3.0
		#ifdef UNITY_PASS_SHADOWCASTER
			#undef INTERNAL_DATA
			#undef WorldReflectionVector
			#undef WorldNormalVector
			#define INTERNAL_DATA half3 internalSurfaceTtoW0; half3 internalSurfaceTtoW1; half3 internalSurfaceTtoW2;
			#define WorldReflectionVector(data,normal) reflect (data.worldRefl, half3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal)))
			#define WorldNormalVector(data,normal) half3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal))
		#endif
		struct Input
		{
			float2 uv_texcoord;
			float3 worldPos;
			float3 worldNormal;
			INTERNAL_DATA
			float3 worldRefl;
		};

		uniform float _NormalYinvert;
		uniform float _NormalScale;
		uniform sampler2D _NormalMap;
		uniform float4 _NormalMap_ST;
		uniform sampler2D _AlbedoMap;
		uniform float4 _AlbedoMap_ST;
		uniform float4 _PrimaryColor;
		uniform float4 _EdgeColor;
		uniform float _EdgeScale;
		uniform float _EdgePowerIntensity;
		uniform sampler2D _ControlMap;
		uniform float4 _ControlMap_ST;
		uniform float _ReflectionScale;
		uniform float _Specularity;
		uniform float _Smoothness;


		float DecodeReflection37( float3 VR , float Mip )
		{
			float4 skyData = UNITY_SAMPLE_TEXCUBE_LOD(unity_SpecCube0, VR, Mip);
			return DecodeHDR (skyData, unity_SpecCube0_HDR);
		}


		void surf( Input i , inout SurfaceOutputStandardSpecular o )
		{
			float2 uv_NormalMap = i.uv_texcoord * _NormalMap_ST.xy + _NormalMap_ST.zw;
			float3 tex2DNode4 = UnpackScaleNormal( tex2D( _NormalMap, uv_NormalMap ) ,_NormalScale );
			float4 appendResult63 = (float4(tex2DNode4.r , -tex2DNode4.g , tex2DNode4.b , 0.0));
			o.Normal = lerp(float4( tex2DNode4 , 0.0 ),appendResult63,_NormalYinvert).xyz;
			float2 uv_AlbedoMap = i.uv_texcoord * _AlbedoMap_ST.xy + _AlbedoMap_ST.zw;
			float3 ase_worldPos = i.worldPos;
			float3 ase_worldViewDir = normalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float3 ase_worldNormal = WorldNormalVector( i, float3( 0, 0, 1 ) );
			float fresnelNdotV42 = dot( ase_worldNormal, ase_worldViewDir );
			float fresnelNode42 = ( 0.0 + _EdgeScale * pow( 1.0 - fresnelNdotV42, ( 1.0 - _EdgePowerIntensity ) ) );
			float4 lerpResult41 = lerp( _PrimaryColor , _EdgeColor , fresnelNode42);
			float2 uv_ControlMap = i.uv_texcoord * _ControlMap_ST.xy + _ControlMap_ST.zw;
			float4 tex2DNode1 = tex2D( _ControlMap, uv_ControlMap );
			float temp_output_96_0 = ( 1.0 - tex2DNode1.r );
			float4 temp_output_44_0 = ( tex2D( _AlbedoMap, uv_AlbedoMap ) * lerpResult41 * temp_output_96_0 );
			float3 VR37 = WorldReflectionVector( i , lerp(float4( tex2DNode4 , 0.0 ),appendResult63,_NormalYinvert).xyz );
			float Mip37 = 0.0;
			float localDecodeReflection37 = DecodeReflection37( VR37 , Mip37 );
			o.Albedo = ( temp_output_44_0 + ( localDecodeReflection37 * _ReflectionScale * lerpResult41 ) ).rgb;
			o.Specular = ( temp_output_96_0 * _Specularity * temp_output_44_0 ).rgb;
			o.Smoothness = ( tex2DNode1.a * _Smoothness );
			o.Alpha = 1;
		}

		ENDCG
		CGPROGRAM
		#pragma surface surf StandardSpecular keepalpha fullforwardshadows 

		ENDCG
		Pass
		{
			Name "ShadowCaster"
			Tags{ "LightMode" = "ShadowCaster" }
			ZWrite On
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 3.0
			#pragma multi_compile_shadowcaster
			#pragma multi_compile UNITY_PASS_SHADOWCASTER
			#pragma skip_variants FOG_LINEAR FOG_EXP FOG_EXP2
			#include "HLSLSupport.cginc"
			#if ( SHADER_API_D3D11 || SHADER_API_GLCORE || SHADER_API_GLES3 || SHADER_API_METAL || SHADER_API_VULKAN )
				#define CAN_SKIP_VPOS
			#endif
			#include "UnityCG.cginc"
			#include "Lighting.cginc"
			#include "UnityPBSLighting.cginc"
			struct v2f
			{
				V2F_SHADOW_CASTER;
				float2 customPack1 : TEXCOORD1;
				float4 tSpace0 : TEXCOORD2;
				float4 tSpace1 : TEXCOORD3;
				float4 tSpace2 : TEXCOORD4;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};
			v2f vert( appdata_full v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID( v );
				UNITY_INITIALIZE_OUTPUT( v2f, o );
				UNITY_TRANSFER_INSTANCE_ID( v, o );
				Input customInputData;
				float3 worldPos = mul( unity_ObjectToWorld, v.vertex ).xyz;
				half3 worldNormal = UnityObjectToWorldNormal( v.normal );
				half3 worldTangent = UnityObjectToWorldDir( v.tangent.xyz );
				half tangentSign = v.tangent.w * unity_WorldTransformParams.w;
				half3 worldBinormal = cross( worldNormal, worldTangent ) * tangentSign;
				o.tSpace0 = float4( worldTangent.x, worldBinormal.x, worldNormal.x, worldPos.x );
				o.tSpace1 = float4( worldTangent.y, worldBinormal.y, worldNormal.y, worldPos.y );
				o.tSpace2 = float4( worldTangent.z, worldBinormal.z, worldNormal.z, worldPos.z );
				o.customPack1.xy = customInputData.uv_texcoord;
				o.customPack1.xy = v.texcoord;
				TRANSFER_SHADOW_CASTER_NORMALOFFSET( o )
				return o;
			}
			half4 frag( v2f IN
			#if !defined( CAN_SKIP_VPOS )
			, UNITY_VPOS_TYPE vpos : VPOS
			#endif
			) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID( IN );
				Input surfIN;
				UNITY_INITIALIZE_OUTPUT( Input, surfIN );
				surfIN.uv_texcoord = IN.customPack1.xy;
				float3 worldPos = float3( IN.tSpace0.w, IN.tSpace1.w, IN.tSpace2.w );
				half3 worldViewDir = normalize( UnityWorldSpaceViewDir( worldPos ) );
				surfIN.worldPos = worldPos;
				surfIN.worldNormal = float3( IN.tSpace0.z, IN.tSpace1.z, IN.tSpace2.z );
				surfIN.worldRefl = -worldViewDir;
				surfIN.internalSurfaceTtoW0 = IN.tSpace0.xyz;
				surfIN.internalSurfaceTtoW1 = IN.tSpace1.xyz;
				surfIN.internalSurfaceTtoW2 = IN.tSpace2.xyz;
				SurfaceOutputStandardSpecular o;
				UNITY_INITIALIZE_OUTPUT( SurfaceOutputStandardSpecular, o )
				surf( surfIN, o );
				#if defined( CAN_SKIP_VPOS )
				float2 vpos = IN.pos;
				#endif
				SHADOW_CASTER_FRAGMENT( IN )
			}
			ENDCG
		}
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=15405
1927;34;1906;999;1831.248;1779.792;2.173716;True;False
Node;AmplifyShaderEditor.CommentaryNode;108;-832.6285,-685.4626;Float;False;1452.792;729.2565;Smoothness/Reflection;27;48;49;99;96;53;62;37;38;64;50;65;63;4;1;109;110;111;112;113;47;69;121;122;123;135;148;150;;0,1,0,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;50;-803.2156,-277.5134;Float;False;Property;_NormalScale;Normal Scale;8;0;Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;4;-517.2253,-277.9899;Float;True;Property;_NormalMap;Normal Map;6;1;[Normal];Create;True;0;0;False;0;None;None;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;152;-830.0287,-1362.778;Float;False;1448.732;612.0186;Colors;11;60;117;44;151;41;32;33;42;43;57;154;;1,0,0,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;53;-804.6538,-170.2762;Float;False;Property;_ReflectionScale;Reflection Scale;11;0;Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;109;-565.7938,-87.55149;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;43;-791.8052,-857.7559;Float;False;Property;_EdgePowerIntensity;Edge Power/Intensity;4;0;Create;True;0;0;False;0;0.5;0.5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.NegateNode;65;-205.2775,-155.3287;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;154;-540.8068,-852.3057;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;63;-46.6893,-218.4897;Float;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RangedFloatNode;57;-791.8052,-955.2458;Float;False;Property;_EdgeScale;Edge Scale;5;0;Create;True;0;0;False;0;0.5;0.5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;110;-515.3659,-80.97389;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ToggleSwitchNode;64;-50.61142,-324.0647;Float;False;Property;_NormalYinvert;Normal Y invert;7;0;Create;True;0;0;False;0;1;2;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.WireNode;113;357.262,-85.35896;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;33;-800,-1136;Float;False;Property;_EdgeColor;Edge Color;3;1;[HDR];Create;True;0;0;False;0;0,0.2278075,1,1;0,0.2278075,1,1;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FresnelNode;42;-388.3196,-952.0328;Float;False;Standard;WorldNormal;ViewDir;False;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;32;-800,-1312;Float;False;Property;_PrimaryColor;Primary Color;2;1;[HDR];Create;True;0;0;False;0;1,0.4800286,0,1;1,0.4800285,0,1;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;41;-497.561,-1305.756;Float;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;112;392.3422,-94.1291;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WorldReflectionVector;38;188.9026,-218.2804;Float;False;False;1;0;FLOAT3;0,0,0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.WireNode;116;361.6519,-712.4167;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.CustomExpressionNode;37;429.2007,-613.0181;Float;False;float4 skyData = UNITY_SAMPLE_TEXCUBE_LOD(unity_SpecCube0, VR, Mip)@$return DecodeHDR (skyData, unity_SpecCube0_HDR)@;1;False;2;True;VR;FLOAT3;0,0,0;In;;True;Mip;FLOAT;0;In;;Decode Reflection;True;False;0;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;111;394.5346,-135.7872;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;62;466.4375,-498.1661;Float;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;120;624.7556,-501.9339;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;1;-796.0488,-606.2576;Float;True;Property;_ControlMap;Control Map;1;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.WireNode;118;629.1408,-688.299;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;151;-182.2,-1301.896;Float;True;Property;_AlbedoMap;Albedo Map;0;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.OneMinusNode;96;-462.9608,-604.4134;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;119;589.6754,-721.187;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;44;218.7316,-1301.426;Float;True;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;115;164.2545,-730.7203;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;147;629.1847,-1257.919;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;114;151.0993,-754.838;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;146;637.1151,-1199.765;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;48;-800.8169,-376.3929;Float;False;Property;_Smoothness;Smoothness;9;0;Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;117;150.623,-971.9617;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;49;-442.334,-398.0238;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;149;631.8286,-171.5092;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;60;224.8465,-1065.672;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;125;642.2965,-357.2266;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;101;673.6993,-1015.406;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;124;631.3334,-295.8359;Float;False;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.WireNode;148;576.319,-147.7194;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;122;298.0685,-567.7098;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;150;462.6553,-147.7191;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;121;337.5341,-550.1696;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;126;683.954,-324.3387;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;102;700.4725,-972.4695;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;129;655.4512,-265.1404;Float;False;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.WireNode;136;716.7279,-174.5532;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;123;348.4969,-322.1461;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;47;-799.9312,-57.65657;Float;False;Property;_Specularity;Specularity;10;0;Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;131;687.1972,-26.24573;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;128;659.2653,-85.63837;Float;False;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.WireNode;135;426.9589,-126.1089;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;140;668.7202,-60.43384;Float;False;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.OneMinusNode;99;-463.2432,-496.9004;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;139;692.2614,3.994284;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;141;723.3334,-100.877;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;69;467.4909,-89.83929;Float;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;818.0268,-100.7767;Float;False;True;2;Float;ASEMaterialInspector;0;0;StandardSpecular;Halo 5/Visor Shader;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;4;5;50;0
WireConnection;109;0;53;0
WireConnection;65;0;4;2
WireConnection;154;0;43;0
WireConnection;63;0;4;1
WireConnection;63;1;65;0
WireConnection;63;2;4;3
WireConnection;110;0;109;0
WireConnection;64;0;4;0
WireConnection;64;1;63;0
WireConnection;113;0;110;0
WireConnection;42;2;57;0
WireConnection;42;3;154;0
WireConnection;41;0;32;0
WireConnection;41;1;33;0
WireConnection;41;2;42;0
WireConnection;112;0;113;0
WireConnection;38;0;64;0
WireConnection;116;0;41;0
WireConnection;37;0;38;0
WireConnection;111;0;112;0
WireConnection;62;0;37;0
WireConnection;62;1;111;0
WireConnection;62;2;116;0
WireConnection;120;0;62;0
WireConnection;118;0;120;0
WireConnection;96;0;1;1
WireConnection;119;0;118;0
WireConnection;44;0;151;0
WireConnection;44;1;41;0
WireConnection;44;2;96;0
WireConnection;115;0;119;0
WireConnection;147;0;44;0
WireConnection;114;0;115;0
WireConnection;146;0;147;0
WireConnection;117;0;114;0
WireConnection;49;0;1;4
WireConnection;49;1;48;0
WireConnection;149;0;146;0
WireConnection;60;0;44;0
WireConnection;60;1;117;0
WireConnection;125;0;49;0
WireConnection;101;0;60;0
WireConnection;124;0;64;0
WireConnection;148;0;149;0
WireConnection;122;0;96;0
WireConnection;150;0;148;0
WireConnection;121;0;122;0
WireConnection;126;0;125;0
WireConnection;102;0;101;0
WireConnection;129;0;124;0
WireConnection;136;0;102;0
WireConnection;123;0;121;0
WireConnection;131;0;126;0
WireConnection;128;0;129;0
WireConnection;135;0;150;0
WireConnection;140;0;128;0
WireConnection;99;0;1;3
WireConnection;139;0;131;0
WireConnection;141;0;136;0
WireConnection;69;0;123;0
WireConnection;69;1;47;0
WireConnection;69;2;135;0
WireConnection;0;0;141;0
WireConnection;0;1;140;0
WireConnection;0;3;69;0
WireConnection;0;4;139;0
ASEEND*/
//CHKSM=0429EB3625179D8B2B70DEECD9B08F0BA75454A7