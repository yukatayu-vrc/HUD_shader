Shader "Yukatayu/HUD" {
	Properties {
		_MainTex ("Texture", 2D) = "white" {}
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
			sampler2D _MainTex;

			// Vertex
			#pragma vertex vert
			v2f vert (appdata v) {
				v2f o;
				o.vertex = float4 (v.vertex.xy, 1, 1);
				o.pos = ComputeScreenPos(o.vertex);
				return o;
			}

			// Fragment
			#pragma fragment frag
			fixed4 frag (v2f i) : SV_Target {
				half2 uv = i.pos.xy / i.pos.w;
				return tex2D(_MainTex, uv);
			}

			ENDCG
		}
	}
}
