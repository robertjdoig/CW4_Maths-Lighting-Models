﻿Shader "Custom/MaskReflection" {
	Properties {
    _MainTint("Diffuse Tint", Color) = (1,1,1,1)
    _MainTex("Base (RGB)", 2D) = "white" {}
    _ReflAmount("Reflection Amount", Range(0,1)) = 1
    _CubeMap("Cubemap", CUBE) = "" {}
    _ReflMask("Reflection Mask", 2D) = "" {}
  }

    SubShader{
      Tags { "RenderType" = "Opaque" }
      LOD 200

      CGPROGRAM
    // Physically based Standard lighting model, and enable shadows on all light types
    #pragma surface surf BlinnPhong

    // Use shader model 3.0 target, to get nicer looking lighting
    #pragma target 3.0

    sampler2D _MainTex;
    sampler2D _ReflMask;
    samplerCUBE _CubeMap;
    float4 _MainTint;
    float _ReflAmount;


		struct Input {
      float2 uv_MainTex;
      float3 worldRefl;
		};

		

		void surf (Input IN, inout SurfaceOutput o) {
      half4 c = tex2D(_MainTex, IN.uv_MainTex);
      float3 reflection = texCUBE(_CubeMap, IN.worldRefl).rgb;
      float4 reflMask = tex2D(_ReflMask, IN.uv_MainTex);

      o.Albedo = c.rgb * _MainTint;
      o.Emission = (reflection * reflMask.r)* _ReflAmount;
      o.Alpha = c.a;
		}
		ENDCG
	}
	FallBack "Diffuse"
}
