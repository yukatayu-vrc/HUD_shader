Shader "Yukatayu/HUD" {
	Properties {
		_MainTex ("Texture", 2D) = "white" {}
		_SwitchTex ("Switch", 2D) = "white" {}
		_Zoom ("HUD Zoom", Range (0.5, 4)) = 1
		_Pos ("HUD Pos", Range (-2, 2)) = 0
	}

	SubShader {
		Tags { "RenderType"="Transparent"  "Queue"="3000" }
		ZTest Always	// 常に前面に表示
		Cull Off    	// 裏面が見えている場合も処理する

		Pass {
			// Meta
			CGPROGRAM
			#pragma target 3.0
			#include "UnityCG.cginc"

			// Struct
			struct appdata {
				float4 vertex : POSITION;
			};
			struct v2f {
				float4 vertex : SV_POSITION;
				float4 pos : TEXCOORD0;
			};

			// Param
			sampler2D _MainTex, _SwitchTex;
			Float _Zoom, _Pos;

			// Vertex
			#pragma vertex vert
			v2f vert (appdata v) {
				v2f o;
				// float4(u, v, w=0, LOD(0-7))
				half4 showBoolTex = tex2Dlod(_SwitchTex, float4(0, 0, 0, 0));
				bool showFlag = showBoolTex.rgb.r != 0;
				o.vertex = float4 (v.vertex.xy + float2(_Pos, _Pos), _Zoom, _Zoom) * showFlag;
				o.pos = ComputeScreenPos(o.vertex);
				return o;
			}

			// Fragment
			#pragma fragment frag
			fixed4 frag (v2f i) : SV_Target {
				half2 uv = i.pos.xy / i.pos.w;
				uv = uv * 2 - 1;
				uv = uv * _Zoom + half2(-_Pos, _Pos);
				// 0.5を掛ける必要は無い
				uv = uv + 0.5;
				return tex2D(_MainTex, uv);
			}

			ENDCG
		}
	}
}
