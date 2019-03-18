Shader "Yukatayu/Empty" {
	Properties {
	}

	SubShader {
		Tags { "RenderType"="Transparent"  "Queue"="3000" }
		ZTest Always	// 常に前面に表示
		Cull Off    	// 裏面が見えている場合も処理する

		Pass {
			CGPROGRAM
			#pragma target 3.0
			#include "UnityCG.cginc"

			#pragma vertex vert
			struct appdata {
				float4 vertex : POSITION;
			};
			struct v2f {
				float4 vertex : SV_POSITION;
				float4 pos : TEXCOORD0;
			};
			v2f vert (appdata v) {
				v2f o;
				o.vertex = float4 (v.vertex.xy, 1, 1);
				o.pos = ComputeScreenPos(o.vertex);
				return o;
			}

			#pragma fragment frag
			fixed4 frag (v2f i) : SV_Target {
				// r, g, b, alpha
				return float4(1., 0., 0., 1.);
			}

			ENDCG
		}
	}
}
