Shader "Custom/HalfLamDiffuse" {
  Properties{
    _EmissiveColor("Emissive Color", Color) = (1,1,1,1)
    _AmbientColor("Ambient Color", Color) = (1,1,1,1)
    _MinLitValue("Brightness", Range(0,1)) = 1
  }
    SubShader{
    Tags{ "RenderType" = "Opaque" }
    LOD 200

    CGPROGRAM
    // Physically based Standard lighting model, and enable shadows on all light types
    //#pragma surface surf Lambert //Standard fullforwardshadows
#pragma surface surf HalfLamDiffuse 

    float _MinLitValue; 

    inline float4 LightingHalfLamDiffuse(SurfaceOutput s, fixed3 lightDir, fixed atten) {
      float difLight = max(0, dot(s.Normal, lightDir));
      // bright darker areas reference to half lambert shadering
      float hLambert = difLight * _MinLitValue + (1 - _MinLitValue);
      //float hLambert = difLight * 0.5 + 0.5;

      float4 col;
      col.rgb = s.Albedo * _LightColor0.rgb * (hLambert * atten * 2);
      col.a = s.Alpha;
      return col;
    }

  // Use shader model 3.0 target, to get nicer looking lighting
  //#pragma target 3.0

  float4 _EmissiveColor;
  float4 _AmbientColor;
  
  struct Input {
    float2 uv_MainTex;
  };

  void surf(Input IN, inout SurfaceOutput o) {
    // Albedo comes from a texture tinted by color
    float4 c;
    c = pow((_EmissiveColor + _AmbientColor), 2.5);

    o.Albedo = c.rgb;
    o.Alpha = c.a;
  }
  ENDCG
  }
    FallBack "Diffuse"
}
