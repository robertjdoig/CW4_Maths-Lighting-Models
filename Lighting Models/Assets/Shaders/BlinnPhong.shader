Shader "Custom/BlinnPhong" {
  Properties{
    _MainTint("Diffuse Tint", Color) = (1,1,1,1)
    _MainTex("Base (RGB)", 2D) = "white" {}
    _SpecularColor("Specular Color", Color) = (1,1,1,1)
    _SpecPower("Specular Power", Range(0.1, 60)) = 3
    _SpecularMask("Specular Mask", 2D) = "white" {}
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200
		
		CGPROGRAM
		// Physically based Standard lighting model, and enable shadows on all light types
		#pragma surface surf CustomBlinnPhong

		// Use shader model 3.0 target, to get nicer looking lighting
		#pragma target 3.0

		sampler2D _MainTex;
    sampler2D _SpecularMask; 
    float4 _MainTint; 
    float4 _SpecularColor;
    float _SpecPower;


		struct Input {
			float2 uv_MainTex;
      float2 uv_SpecularMask;
		};

    struct Output {
      fixed3 Albedo;
      fixed3 Normal;
      fixed3 Emission;
      fixed3 SpecularColor;
      half Specular;
      fixed Gloss;
      fixed Alpha;
    };

    inline fixed4 LightingCustomBlinnPhong(Output s, fixed3 lightDir, half3 viewDir, fixed3 atten)
    {
      fixed3 halfVector = normalize(lightDir * viewDir);

      float diff = max(0, dot(s.Normal, lightDir));

      float ab = max(0, dot(s.Normal, halfVector));
      float spec = pow(ab, _SpecPower) * _SpecularColor;

      fixed4 c;
      c.rgb = (s.Albedo * _LightColor0.rgb * diff) * (_LightColor0.rgb * _SpecularColor.rgb * spec) * (atten * 2);
      c.a = s.Alpha;
      return c;
    }



		void surf (Input IN, inout Output o) {
      half4 c = tex2D(_MainTex, IN.uv_MainTex) * _MainTint;
      float4 specMask = tex2D(_SpecularMask, IN.uv_SpecularMask) * _SpecularColor;


      o.Albedo = c.rgb;
      o.Specular = specMask.r;
      o.SpecularColor = specMask.rgb;
      //o.Gloss = 1.0;
      o.Alpha = c.a;
		}
		ENDCG
	}
	FallBack "Diffuse"
}
