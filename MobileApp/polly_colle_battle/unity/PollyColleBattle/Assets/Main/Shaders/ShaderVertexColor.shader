Shader "Universal Render Pipeline/Custom/ShaderVertexColor"
{
    Properties {
        // プロパティ定義
    }

    SubShader {
        Tags {
            "RenderType"="Opaque"
        }

        Pass {
            Tags {
                "LightMode"="UniversalForward"
            }

            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"

            struct appdata_t {
                float4 vertex : POSITION;
                float4 color : COLOR;
            };

            struct v2f {
                float4 pos : SV_POSITION;
                float4 color : COLOR;
            };

            v2f vert (appdata_t v) {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.color = v.color;
                return o;
            }

            half4 frag (v2f i) : SV_Target {
                return i.color;
            }
            ENDCG
        }
    }

    FallBack "Universal Render Pipeline/Lit"
}