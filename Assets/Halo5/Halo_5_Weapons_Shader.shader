// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Halo 5/Weapon Shader"
{
	Properties
	{
		_AlbedoMap("Albedo Map", 2D) = "white" {}
		_AlbedoTint("Albedo Tint", Color) = (1,1,1,1)
		_ControlMap("Control Map", 2D) = "gray" {}
		[HDR]_EmmisionColor("Emmision Color", Color) = (0,0,0,0)
		_NormalMap("Normal Map", 2D) = "bump" {}
		[Toggle]_InvertNormal("Invert Normal", Float) = 1
		_MetallicPower("Metallic Power", Range( 0 , 1)) = 0.5
		_Smoothness("Smoothness", Range( 0 , 1)) = 0.5
		_Occlusion("Occlusion", Range( 0 , 1)) = 0.5
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform float _InvertNormal;
		uniform sampler2D _NormalMap;
		uniform float4 _NormalMap_ST;
		uniform sampler2D _AlbedoMap;
		uniform float4 _AlbedoMap_ST;
		uniform float4 _AlbedoTint;
		uniform float4 _EmmisionColor;
		uniform sampler2D _ControlMap;
		uniform float4 _ControlMap_ST;
		uniform float _MetallicPower;
		uniform float _Smoothness;
		uniform float _Occlusion;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_NormalMap = i.uv_texcoord * _NormalMap_ST.xy + _NormalMap_ST.zw;
			float3 tex2DNode5 = UnpackNormal( tex2D( _NormalMap, uv_NormalMap ) );
			float4 appendResult81 = (float4(tex2DNode5.r , -tex2DNode5.g , tex2DNode5.b , 0.0));
			o.Normal = lerp(float4( tex2DNode5 , 0.0 ),appendResult81,_InvertNormal).xyz;
			float2 uv_AlbedoMap = i.uv_texcoord * _AlbedoMap_ST.xy + _AlbedoMap_ST.zw;
			float4 tex2DNode1 = tex2D( _AlbedoMap, uv_AlbedoMap );
			o.Albedo = ( tex2DNode1 * _AlbedoTint ).rgb;
			o.Emission = ( tex2DNode1.a * _EmmisionColor * tex2DNode1 ).rgb;
			float2 uv_ControlMap = i.uv_texcoord * _ControlMap_ST.xy + _ControlMap_ST.zw;
			float4 tex2DNode38 = tex2D( _ControlMap, uv_ControlMap );
			o.Metallic = ( tex2DNode38.b * _MetallicPower );
			o.Smoothness = ( tex2DNode38.r * _Smoothness );
			o.Occlusion = ( tex2DNode38.g * _Occlusion );
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=15405
7;34;1906;999;2010.696;730.8615;1.6;True;False
Node;AmplifyShaderEditor.CommentaryNode;52;-1128.809,-391.5857;Float;False;1011.018;590.1193;Diffuse;15;83;84;87;86;85;80;81;82;49;5;50;2;1;4;90;;1,0,0,1;0;0
Node;AmplifyShaderEditor.SamplerNode;5;-821.438,-134.9423;Float;True;Property;_NormalMap;Normal Map;4;0;Create;True;0;0;False;0;None;a25823fa647950a4d906b072388d7944;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.NegateNode;82;-494.5238,-83.33256;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;81;-304.3386,-105.8081;Float;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.WireNode;85;-167.6103,-50.42044;Float;False;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.WireNode;83;-168.9104,8.079508;Float;False;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.WireNode;84;-196.2106,32.77954;Float;False;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.CommentaryNode;59;-1020.274,221.9006;Float;False;872.0469;429.8667;Metalic Properties;7;25;20;19;24;12;38;13;;0.2426471,0.6239352,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;25;-645.6113,455.8681;Float;False;Property;_Occlusion;Occlusion;8;0;Create;True;0;0;False;0;0.5;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;20;-648.9023,363.3976;Float;False;Property;_Smoothness;Smoothness;7;0;Create;True;0;0;False;0;0.5;0.9;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;4;-713.6868,-335.5686;Float;False;Property;_AlbedoTint;Albedo Tint;1;0;Create;True;0;0;False;0;1,1,1,1;1,1,1,1;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.WireNode;86;-588.8101,39.27949;Float;False;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SamplerNode;38;-991.6473,270.7082;Float;True;Property;_ControlMap;Control Map;2;0;Create;True;0;0;False;0;None;35461fb552559dc4badc965fe389f2d0;True;0;False;gray;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;13;-651.8519,270.8511;Float;False;Property;_MetallicPower;Metallic Power;6;0;Create;True;0;0;False;0;0.5;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;50;-1049.125,-116.1396;Float;False;Property;_EmmisionColor;Emmision Color;3;1;[HDR];Create;True;0;0;False;0;0,0,0,0;0,0,0,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;1;-1052.688,-335.1573;Float;True;Property;_AlbedoMap;Albedo Map;0;0;Create;True;0;0;False;0;None;32a3bd30371cb9b40a13c2e9be47acea;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;12;-313.7704,271.8803;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;87;-596.6107,69.17951;Float;False;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;24;-305.5487,530.2546;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2;-458.8307,-333.4924;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;49;-1044.699,63.29347;Float;False;3;3;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;19;-307.748,393.1237;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ToggleSwitchNode;80;-526.9678,31.27911;Float;False;Property;_InvertNormal;Invert Normal;5;0;Create;True;0;0;False;0;1;2;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.WireNode;79;-114.077,563.1598;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;90;-170.2104,87.37954;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;68;-122.2401,424.649;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;64;-114.1154,-293.5388;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;69;-121.9179,303.1596;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;78;-41.90688,549.1027;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;70;-90.71794,292.7598;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;73;-69.20689,407.4031;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;92;-133.8104,83.47957;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;65;-88.11542,-268.839;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;89;-148.1104,49.6795;Float;False;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.WireNode;74;-76.41792,89.95964;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;66;-89.41543,-50.43867;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;91;-84.41042,36.67953;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;71;-94.61794,69.15959;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;88;-93.51046,8.079544;Float;False;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.WireNode;77;-51.71792,113.3598;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;76;-28.31784,95.15968;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;94;-44.11035,1.579529;Float;False;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.WireNode;72;-62.11792,43.15986;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;93;-40.21034,26.27957;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;75;-47.8179,69.15985;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;67;-60.81546,-21.83882;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;128,-48;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;Halo 5/Weapon Shader;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;82;0;5;2
WireConnection;81;0;5;1
WireConnection;81;1;82;0
WireConnection;81;2;5;3
WireConnection;85;0;81;0
WireConnection;83;0;85;0
WireConnection;84;0;83;0
WireConnection;86;0;84;0
WireConnection;12;0;38;3
WireConnection;12;1;13;0
WireConnection;87;0;86;0
WireConnection;24;0;38;2
WireConnection;24;1;25;0
WireConnection;2;0;1;0
WireConnection;2;1;4;0
WireConnection;49;0;1;4
WireConnection;49;1;50;0
WireConnection;49;2;1;0
WireConnection;19;0;38;1
WireConnection;19;1;20;0
WireConnection;80;0;5;0
WireConnection;80;1;87;0
WireConnection;79;0;24;0
WireConnection;90;0;49;0
WireConnection;68;0;19;0
WireConnection;64;0;2;0
WireConnection;69;0;12;0
WireConnection;78;0;79;0
WireConnection;70;0;69;0
WireConnection;73;0;68;0
WireConnection;92;0;90;0
WireConnection;65;0;64;0
WireConnection;89;0;80;0
WireConnection;74;0;73;0
WireConnection;66;0;65;0
WireConnection;91;0;92;0
WireConnection;71;0;70;0
WireConnection;88;0;89;0
WireConnection;77;0;78;0
WireConnection;76;0;77;0
WireConnection;94;0;88;0
WireConnection;72;0;71;0
WireConnection;93;0;91;0
WireConnection;75;0;74;0
WireConnection;67;0;66;0
WireConnection;0;0;67;0
WireConnection;0;1;94;0
WireConnection;0;2;93;0
WireConnection;0;3;72;0
WireConnection;0;4;75;0
WireConnection;0;5;76;0
ASEEND*/
//CHKSM=C33D131A8DEA3FC31435050F192FD087A08469D9