// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Halo 5/Armor Shader"
{
	Properties
	{
		_AlbedoMap("Albedo Map", 2D) = "white" {}
		_AlbedoTint("Albedo Tint", Color) = (1,1,1,0)
		_ControlMap("Control Map", 2D) = "gray" {}
		_PrimaryColor("Primary Color", Color) = (1,0,0,0)
		_SecondaryColor("Secondary Color", Color) = (0,1,0,0)
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
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
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
		uniform float4 _PrimaryColor;
		uniform sampler2D _ControlMap;
		uniform float4 _ControlMap_ST;
		uniform float4 _SecondaryColor;
		uniform float _MetallicPower;
		uniform float _Smoothness;
		uniform float _Occlusion;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_NormalMap = i.uv_texcoord * _NormalMap_ST.xy + _NormalMap_ST.zw;
			float3 tex2DNode5 = UnpackNormal( tex2D( _NormalMap, uv_NormalMap ) );
			float4 appendResult158 = (float4(tex2DNode5.r , -tex2DNode5.g , tex2DNode5.b , 0.0));
			o.Normal = lerp(float4( tex2DNode5 , 0.0 ),appendResult158,_InvertNormal).xyz;
			float2 uv_AlbedoMap = i.uv_texcoord * _AlbedoMap_ST.xy + _AlbedoMap_ST.zw;
			float4 temp_output_2_0 = ( tex2D( _AlbedoMap, uv_AlbedoMap ) * _AlbedoTint );
			float2 uv_ControlMap = i.uv_texcoord * _ControlMap_ST.xy + _ControlMap_ST.zw;
			float4 tex2DNode38 = tex2D( _ControlMap, uv_ControlMap );
			float4 lerpResult83 = lerp( temp_output_2_0 , _PrimaryColor , tex2DNode38.r);
			float4 lerpResult101 = lerp( lerpResult83 , _SecondaryColor , tex2DNode38.g);
			float4 temp_cast_2 = (( tex2DNode38.r + tex2DNode38.g )).xxxx;
			float4 blendOpSrc118 = ( lerpResult101 * temp_output_2_0 );
			float4 blendOpDest118 = ( temp_output_2_0 - temp_cast_2 );
			o.Albedo = 	max( blendOpSrc118, blendOpDest118 ).rgb;
			o.Metallic = ( tex2DNode38.b * _MetallicPower );
			o.Smoothness = ( tex2DNode38.a * _Smoothness );
			o.Occlusion = ( float4(1,1,1,0) * _Occlusion ).r;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=15405
1927;34;1906;999;2166.347;1694.666;2.705091;True;False
Node;AmplifyShaderEditor.CommentaryNode;52;-989.7102,-427.9856;Float;False;881.0179;447.1193;Diffuse;7;155;158;157;2;1;4;5;;0,0.2965517,1,1;0;0
Node;AmplifyShaderEditor.ColorNode;4;-574.5871,-371.9685;Float;False;Property;_AlbedoTint;Albedo Tint;1;0;Create;True;0;0;False;0;1,1,1,0;1,1,1,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;1;-966.9099,-376.6352;Float;True;Property;_AlbedoMap;Albedo Map;0;0;Create;True;0;0;False;0;None;e6eec85e4027df44c8b13c72ee3df2d3;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2;-319.7305,-394.8923;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;124;-103.0383,-363.821;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;92;-988.228,-1163.59;Float;False;1244.948;606.2745;Colors;19;118;154;151;117;101;102;113;83;131;139;99;128;93;97;98;94;95;96;38;;1,0,0,1;0;0
Node;AmplifyShaderEditor.WireNode;137;-80.3243,-396.4726;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;125;-83.16353,-461.7755;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;38;-967.7552,-1115.585;Float;True;Property;_ControlMap;Control Map;2;0;Create;True;0;0;False;0;None;875d070b2c20c19478ae4e9a87f585be;True;0;False;gray;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.WireNode;138;-107.2972,-487.3286;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;140;-66.12794,-362.4013;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;96;-696.8259,-975.3715;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;95;-668.8801,-983.9704;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;123;-44.83352,-396.4724;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;94;-671.0297,-902.2835;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;98;-698.9754,-925.9297;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;130;-416.7764,-497.2663;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;136;-51.93162,-481.65;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;97;-726.921,-900.1339;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;93;-701.1253,-876.4874;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;129;-446.589,-528.498;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;128;-452.2671,-819.5214;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;59;-994.2744,223.2006;Float;False;902.2717;477.093;Metalic Properties;11;19;12;13;25;24;20;80;81;82;84;85;;0.2413793,1,0,1;0;0
Node;AmplifyShaderEditor.WireNode;91;-1024.994,-899.2862;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;89;-1014.246,-873.3691;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;126;-87.42242,-508.6227;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;88;-1046.492,-861.6484;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;90;-1062.998,-886.0655;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;139;-453.6868,-846.494;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;152;-29.58203,-361.6804;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;80;-880.7228,479.0594;Float;False;Constant;_ambient_occlusion;ambient_occlusion;8;0;Create;True;0;0;False;0;1,1,1,0;0,0,0,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.WireNode;135;-200.9929,-524.239;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;99;-619.2209,-1108.769;Float;False;Property;_PrimaryColor;Primary Color;3;0;Create;True;0;0;False;0;1,0,0,0;0.2403762,0.2541328,0.2867646,1;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.WireNode;132;-213.7695,-549.7922;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;81;-367.624,515.059;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;86;-1055.86,367.0792;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;83;-381.1682,-921.9781;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;87;-1030.064,274.6436;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;153;-8.582031,-396.6804;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;102;-383.7407,-1105.895;Float;False;Property;_SecondaryColor;Secondary Color;4;0;Create;True;0;0;False;0;0,1,0,0;0.5073529,0,0,1;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.WireNode;84;-993.52,293.9906;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;131;-220.8676,-627.8719;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;113;-644.3064,-781.6418;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;25;-625.5828,546.8979;Float;False;Property;_Occlusion;Occlusion;9;0;Create;True;0;0;False;0;0.5;0.5;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;85;-1015.017,392.875;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;154;-10.58203,-1031.68;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;101;-180.9572,-947.1469;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;82;-354.624,543.6591;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;20;-867.9637,371.1466;Float;False;Property;_Smoothness;Smoothness;8;0;Create;True;0;0;False;0;0.5;0.5;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;13;-877.3624,272.1511;Float;False;Property;_MetallicPower;Metallic Power;7;0;Create;True;0;0;False;0;0.5;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;12;-287.7706,273.1803;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;19;-281.7482,394.4237;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;117;-224.6019,-794.1088;Float;True;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;151;26.41797,-1123.68;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;24;-279.5489,531.5546;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;69;-121.9179,303.1596;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;79;-72.51784,563.1598;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.BlendOpsNode;118;-5.05127,-795.9058;Float;True;Lighten;False;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;5;-966.9933,-179.48;Float;True;Property;_NormalMap;Normal Map;5;0;Create;True;0;0;False;0;None;3aa006d78f232824085c25c9ec175a36;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.WireNode;68;-92.01527,422.76;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;78;-40.01783,556.6589;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;148;255.354,-729.6668;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;70;-90.71794,292.7598;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;73;-67.31783,414.9593;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.NegateNode;157;-668.7787,-109.7008;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;149;260.4877,-63.1841;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;71;-94.61794,69.15959;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;77;-51.71792,113.3598;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.DynamicAppendNode;158;-526.694,-134.7764;Float;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.WireNode;74;-76.41792,89.95964;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;72;-62.11792,43.15986;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;150;283.2017,-37.63076;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;75;-47.8179,69.15985;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;76;-28.31784,95.15968;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ToggleSwitchNode;155;-355.4239,-167.9892;Float;False;Property;_InvertNormal;Invert Normal;6;0;Create;True;0;0;False;0;1;2;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;494.4787,-50.30413;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;Halo 5/Armor Shader;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;2;0;1;0
WireConnection;2;1;4;0
WireConnection;124;0;2;0
WireConnection;137;0;124;0
WireConnection;125;0;137;0
WireConnection;138;0;125;0
WireConnection;140;0;2;0
WireConnection;96;0;38;4
WireConnection;95;0;38;3
WireConnection;123;0;140;0
WireConnection;94;0;95;0
WireConnection;98;0;96;0
WireConnection;130;0;138;0
WireConnection;136;0;123;0
WireConnection;97;0;98;0
WireConnection;93;0;94;0
WireConnection;129;0;130;0
WireConnection;128;0;129;0
WireConnection;91;0;97;0
WireConnection;89;0;93;0
WireConnection;126;0;136;0
WireConnection;88;0;89;0
WireConnection;90;0;91;0
WireConnection;139;0;128;0
WireConnection;152;0;2;0
WireConnection;135;0;126;0
WireConnection;132;0;135;0
WireConnection;81;0;80;0
WireConnection;86;0;90;0
WireConnection;83;0;139;0
WireConnection;83;1;99;0
WireConnection;83;2;38;1
WireConnection;87;0;88;0
WireConnection;153;0;152;0
WireConnection;84;0;87;0
WireConnection;131;0;132;0
WireConnection;113;0;38;1
WireConnection;113;1;38;2
WireConnection;85;0;86;0
WireConnection;154;0;153;0
WireConnection;101;0;83;0
WireConnection;101;1;102;0
WireConnection;101;2;38;2
WireConnection;82;0;81;0
WireConnection;12;0;84;0
WireConnection;12;1;13;0
WireConnection;19;0;85;0
WireConnection;19;1;20;0
WireConnection;117;0;131;0
WireConnection;117;1;113;0
WireConnection;151;0;101;0
WireConnection;151;1;154;0
WireConnection;24;0;82;0
WireConnection;24;1;25;0
WireConnection;69;0;12;0
WireConnection;79;0;24;0
WireConnection;118;0;151;0
WireConnection;118;1;117;0
WireConnection;68;0;19;0
WireConnection;78;0;79;0
WireConnection;148;0;118;0
WireConnection;70;0;69;0
WireConnection;73;0;68;0
WireConnection;157;0;5;2
WireConnection;149;0;148;0
WireConnection;71;0;70;0
WireConnection;77;0;78;0
WireConnection;158;0;5;1
WireConnection;158;1;157;0
WireConnection;158;2;5;3
WireConnection;74;0;73;0
WireConnection;72;0;71;0
WireConnection;150;0;149;0
WireConnection;75;0;74;0
WireConnection;76;0;77;0
WireConnection;155;0;5;0
WireConnection;155;1;158;0
WireConnection;0;0;150;0
WireConnection;0;1;155;0
WireConnection;0;3;72;0
WireConnection;0;4;75;0
WireConnection;0;5;76;0
ASEEND*/
//CHKSM=3C65C3FA5BCB3FC9B41A5563F713428C84122AF9