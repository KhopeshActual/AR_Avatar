Shader "PosterPanner"
{
	Properties
	{
		_Texture0("Texture 0", 2D) = "white" {}
		_trans_time("Transition Time", Range(0 , 10)) = 1
		_hold_time("Hold Time", Range(0 , 30)) = 1

		_xtiles("xtiles", Float) = 4
		_ytiles("ytiles", Float) = 4

		_tlimit("Tile limit", Range(1 , 15)) = 1

		[HideInInspector] _texcoord("", 2D) = "white" {}
		[HideInInspector] __dirty("", Int) = 1
	}


		SubShader
		{
			Tags{ "RenderType" = "TransparentCutout"  "Queue" = "AlphaTest+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
			Cull Back
			CGPROGRAM
			#include "UnityShaderVariables.cginc"
			#pragma target 5.0
			#pragma surface surf Standard keepalpha addshadow fullforwardshadows 
			struct Input
			{
				float2 uv_texcoord;
			};

			uniform sampler2D _Texture0;
			float _trans_time;
			float _hold_time;
			float _tpick;
			float _tlimit;

			float _xtiles;
			float _ytiles;

			// EDIT THESE VALUES TO CHANGE THE TILE ATLAS GRIDSIZE X/Y
			// static const int gsize[2] = { 4, 4 };

			// CONVERT NORMAL UV TO IT'S CORRESPONDING TILE-UV, SPECIFIED BY INDEX 
			float2 uv_2_tileuv(float2 uv, int index)
			{
				int2 tsize = max(int2(_xtiles, _ytiles), 1);

				float2 tpart = float2(1. / tsize[0], 1. / tsize.y);
				float2 base = float2((index % tsize.x) * tpart.x , floor(index / float(tsize.x)) * tpart.y);
				return base + uv * tpart;
			}

			void surf(Input i , inout SurfaceOutputStandard o)
			{
				// SETUP TIMING VARIABLES
				float total = _trans_time + _hold_time;
				float s_time = frac(_Time[1] / total) * total;

				// SETUP THE ATLAS PICK VALUES
				int base_pick = floor(_Time[1] / total);
				base_pick = base_pick % int(_tlimit + 1);
				int next_pick = (base_pick >= int(_tlimit)) ? 0 : base_pick + 1;

				// CALCULATE UV VALUES FOR ATLAS
				float trans_y = 1 - saturate(s_time / _trans_time);
				float scroll_y = frac(i.uv_texcoord.y - trans_y);
				float2 final_uv = (trans_y < i.uv_texcoord.y) ?
					uv_2_tileuv(float2(i.uv_texcoord.x, scroll_y), next_pick) :
					uv_2_tileuv(i.uv_texcoord, base_pick);

				// GET THE PIXEL
				o.Emission = tex2D(_Texture0, final_uv);

				return;
			}

			ENDCG
		}
			Fallback "Diffuse"
				CustomEditor "ASEMaterialInspector"
}