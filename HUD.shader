Shader "Yukatayu/Empty" {
	Properties {
	}

	SubShader {
		Tags { "RenderType"="Opaque" }

		Pass {
			CGPROGRAM
			#pragma target 3.0
			#include "UnityCG.cginc"

			#pragma vertex vert
			struct appdata {
				float4 vertex : POSITION;
			};
			v2f vert (appdata v) {
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.pos = ComputeScreenPos(o.vertex);
				return o;
			}

			#pragma fragment frag
			struct v2f {
				float4 vertex : SV_POSITION;
				float4 pos : TEXCOORD0;
			};
			fixed4 frag (v2f i) : SV_Target {
				// r, g, b, alpha
				return float4(1., 0., 0., 1.);
			}

			ENDCG
		}
	}
}
