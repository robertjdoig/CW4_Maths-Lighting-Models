﻿Shader "Custom/FresnelReflections" {
	Properties {
		_MainTint ("Diffuse Tint", Color) = (1,1,1,1)
    _MainTex ("Base (RGB)", 2D) = "white" {}
    _CubeMap ("CubeMap", CUBE) = ""{}
    _ReflectionAmount ("Reflection Amount", Range(0,1)) = 1
    _RimPower("Fresnel Falloff", Range(0.1, 3)) = 2
    _SpecColor("Specular Color", Color) = (1,1,1,1)
    _SpecPower("Specular Power", Range(0,1)) = 0.5
  }
    SubShader{
      Tags { "RenderType" = "Opaque" }
      LOD 200

      CGPROGRAM
      // Physically based Standard lighting model, and enable shadows on all light types
      #pragma surface surf BlinnPhong

      // Use shader model 3.0 target, to get nicer looking lighting
      #pragma target 3.0

      samplerCUBE _CubeMap;
      sampler2D _MainTex;
      float4 _MainTint;
      float _ReflectionAmount;
      float _RimPower;
      float _SpecPower;

		struct Input {
			float2 uv_MainTex;
      float3 worldRefl;
      float3 viewDir;

		};

		
		void surf (Input IN, inout SurfaceOutput o) {
      half4 c = tex2D(_MainTex, IN.uv_MainTex);

      float rim = 1.0 - saturate(dot(o.Normal, normalize(IN.viewDir)));
      rim = pow(rim, _RimPower);

      o.Albedo = c.rgb * _MainTint;
      o.Emission = (texCUBE(_CubeMap, IN.worldRefl).rgb * _ReflectionAmount) * rim;
      o.Specular = _SpecPower;
      o.Gloss = 1.0;
      o.Alpha = c.a;
		}
		ENDCG
	}
	FallBack "Diffuse"
}
