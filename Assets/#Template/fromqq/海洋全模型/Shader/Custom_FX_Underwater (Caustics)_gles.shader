Shader "Custom/FX/Underwater (Caustics)" {
Properties {
_MainTex ("Texture", 2D) = "white" { }
_WaterColor ("Water Tint", Color) = (1,1,1,1)
_CausticTex ("Caustic Texture", 2D) = "black" { }
_CausticIntensity ("Caustic Intensity", Range(0, 2)) = 1
_Speed ("Speed", Float) = 1
[Toggle(TINT)] _UnderwaterTint ("Underwater Tint", Float) = 0
[Toggle(BLEND)] _ColorBlend ("Luminosity Blend", Float) = 0
}
SubShader {
 LOD 200
 Tags { "RenderType" = "Opaque" }
 Pass {
  Name "FORWARD"
  LOD 200
  Tags { "LIGHTMODE" = "ForwardBase" "RenderType" = "Opaque" "SHADOWSUPPORT" = "true" }
  ZClip Off
  GpuProgramID 12203
Program "vp" {
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _CausticTex_ST;
uniform highp float _Speed;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying lowp vec3 xlv_COLOR0;
void main ()
{
  highp vec3 shlight_1;
  highp vec2 cUv_2;
  highp vec2 tmpvar_3;
  lowp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  highp vec3 tmpvar_6;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = unity_WorldToObject[0].xyz;
  tmpvar_7[1] = unity_WorldToObject[1].xyz;
  tmpvar_7[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize((_glesNormal * tmpvar_7));
  highp vec2 tmpvar_9;
  tmpvar_9.x = ((tmpvar_6.x * 0.866) + (tmpvar_6.y * 0.5));
  tmpvar_9.y = ((tmpvar_6.z * 0.866) + (tmpvar_6.y * 0.5));
  cUv_2 = ((tmpvar_9 * _CausticTex_ST.xy) + _CausticTex_ST.zw);
  mediump vec2 uv_10;
  uv_10 = cUv_2;
  mediump vec2 distortOffset_11;
  highp float tmpvar_12;
  tmpvar_12 = ((_Time * 20.0) * _Speed).x;
  highp vec2 tmpvar_13;
  tmpvar_13.x = sin((tmpvar_12 + (uv_10.y * 6.28)));
  tmpvar_13.y = sin((tmpvar_12 + (uv_10.x * 6.28)));
  highp vec2 tmpvar_14;
  tmpvar_14 = (tmpvar_13 * vec2(0.025, 0.01));
  distortOffset_11 = tmpvar_14;
  uv_10 = (uv_10 + distortOffset_11);
  uv_10.x = (uv_10.x + (_Time.x * 0.3));
  tmpvar_3 = uv_10;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = tmpvar_8;
  mediump vec4 normal_16;
  normal_16 = tmpvar_15;
  mediump vec3 res_17;
  mediump vec3 x_18;
  x_18.x = dot (unity_SHAr, normal_16);
  x_18.y = dot (unity_SHAg, normal_16);
  x_18.z = dot (unity_SHAb, normal_16);
  mediump vec3 x1_19;
  mediump vec4 tmpvar_20;
  tmpvar_20 = (normal_16.xyzz * normal_16.yzzx);
  x1_19.x = dot (unity_SHBr, tmpvar_20);
  x1_19.y = dot (unity_SHBg, tmpvar_20);
  x1_19.z = dot (unity_SHBb, tmpvar_20);
  res_17 = (x_18 + (x1_19 + (unity_SHC.xyz * 
    ((normal_16.x * normal_16.x) - (normal_16.y * normal_16.y))
  )));
  mediump vec3 tmpvar_21;
  tmpvar_21 = max (((1.055 * 
    pow (max (res_17, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_17 = tmpvar_21;
  shlight_1 = tmpvar_21;
  tmpvar_4 = shlight_1;
  gl_Position = (glstate_matrix_mvp * tmpvar_5);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_8;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_COLOR0 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _CausticTex;
uniform lowp float _CausticIntensity;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_COLOR0;
void main ()
{
  lowp vec4 caustic_1;
  lowp float diff_2;
  lowp vec3 lightDir_3;
  lowp vec4 col_4;
  mediump vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_4 = tmpvar_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_3 = tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = max (0.0, dot (xlv_TEXCOORD2, lightDir_3));
  diff_2 = tmpvar_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = ((col_4.xyz * _LightColor0.xyz) * diff_2);
  col_4.xyz = (col_4.xyz * xlv_COLOR0);
  col_4.xyz = (col_4.xyz + tmpvar_8);
  mediump vec4 tmpvar_9;
  tmpvar_9 = (_CausticIntensity * texture2D (_CausticTex, xlv_TEXCOORD1));
  caustic_1 = tmpvar_9;
  col_4 = (col_4 + (caustic_1 * diff_2));
  gl_FragData[0] = col_4;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _CausticTex_ST;
uniform highp float _Speed;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying lowp vec3 xlv_COLOR0;
void main ()
{
  highp vec3 shlight_1;
  highp vec2 cUv_2;
  highp vec2 tmpvar_3;
  lowp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  highp vec3 tmpvar_6;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = unity_WorldToObject[0].xyz;
  tmpvar_7[1] = unity_WorldToObject[1].xyz;
  tmpvar_7[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize((_glesNormal * tmpvar_7));
  highp vec2 tmpvar_9;
  tmpvar_9.x = ((tmpvar_6.x * 0.866) + (tmpvar_6.y * 0.5));
  tmpvar_9.y = ((tmpvar_6.z * 0.866) + (tmpvar_6.y * 0.5));
  cUv_2 = ((tmpvar_9 * _CausticTex_ST.xy) + _CausticTex_ST.zw);
  mediump vec2 uv_10;
  uv_10 = cUv_2;
  mediump vec2 distortOffset_11;
  highp float tmpvar_12;
  tmpvar_12 = ((_Time * 20.0) * _Speed).x;
  highp vec2 tmpvar_13;
  tmpvar_13.x = sin((tmpvar_12 + (uv_10.y * 6.28)));
  tmpvar_13.y = sin((tmpvar_12 + (uv_10.x * 6.28)));
  highp vec2 tmpvar_14;
  tmpvar_14 = (tmpvar_13 * vec2(0.025, 0.01));
  distortOffset_11 = tmpvar_14;
  uv_10 = (uv_10 + distortOffset_11);
  uv_10.x = (uv_10.x + (_Time.x * 0.3));
  tmpvar_3 = uv_10;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = tmpvar_8;
  mediump vec4 normal_16;
  normal_16 = tmpvar_15;
  mediump vec3 res_17;
  mediump vec3 x_18;
  x_18.x = dot (unity_SHAr, normal_16);
  x_18.y = dot (unity_SHAg, normal_16);
  x_18.z = dot (unity_SHAb, normal_16);
  mediump vec3 x1_19;
  mediump vec4 tmpvar_20;
  tmpvar_20 = (normal_16.xyzz * normal_16.yzzx);
  x1_19.x = dot (unity_SHBr, tmpvar_20);
  x1_19.y = dot (unity_SHBg, tmpvar_20);
  x1_19.z = dot (unity_SHBb, tmpvar_20);
  res_17 = (x_18 + (x1_19 + (unity_SHC.xyz * 
    ((normal_16.x * normal_16.x) - (normal_16.y * normal_16.y))
  )));
  mediump vec3 tmpvar_21;
  tmpvar_21 = max (((1.055 * 
    pow (max (res_17, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_17 = tmpvar_21;
  shlight_1 = tmpvar_21;
  tmpvar_4 = shlight_1;
  gl_Position = (glstate_matrix_mvp * tmpvar_5);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_8;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_COLOR0 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _CausticTex;
uniform lowp float _CausticIntensity;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_COLOR0;
void main ()
{
  lowp vec4 caustic_1;
  lowp float diff_2;
  lowp vec3 lightDir_3;
  lowp vec4 col_4;
  mediump vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_4 = tmpvar_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_3 = tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = max (0.0, dot (xlv_TEXCOORD2, lightDir_3));
  diff_2 = tmpvar_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = ((col_4.xyz * _LightColor0.xyz) * diff_2);
  col_4.xyz = (col_4.xyz * xlv_COLOR0);
  col_4.xyz = (col_4.xyz + tmpvar_8);
  mediump vec4 tmpvar_9;
  tmpvar_9 = (_CausticIntensity * texture2D (_CausticTex, xlv_TEXCOORD1));
  caustic_1 = tmpvar_9;
  col_4 = (col_4 + (caustic_1 * diff_2));
  gl_FragData[0] = col_4;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _CausticTex_ST;
uniform highp float _Speed;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying lowp vec3 xlv_COLOR0;
void main ()
{
  highp vec3 shlight_1;
  highp vec2 cUv_2;
  highp vec2 tmpvar_3;
  lowp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  highp vec3 tmpvar_6;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = unity_WorldToObject[0].xyz;
  tmpvar_7[1] = unity_WorldToObject[1].xyz;
  tmpvar_7[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize((_glesNormal * tmpvar_7));
  highp vec2 tmpvar_9;
  tmpvar_9.x = ((tmpvar_6.x * 0.866) + (tmpvar_6.y * 0.5));
  tmpvar_9.y = ((tmpvar_6.z * 0.866) + (tmpvar_6.y * 0.5));
  cUv_2 = ((tmpvar_9 * _CausticTex_ST.xy) + _CausticTex_ST.zw);
  mediump vec2 uv_10;
  uv_10 = cUv_2;
  mediump vec2 distortOffset_11;
  highp float tmpvar_12;
  tmpvar_12 = ((_Time * 20.0) * _Speed).x;
  highp vec2 tmpvar_13;
  tmpvar_13.x = sin((tmpvar_12 + (uv_10.y * 6.28)));
  tmpvar_13.y = sin((tmpvar_12 + (uv_10.x * 6.28)));
  highp vec2 tmpvar_14;
  tmpvar_14 = (tmpvar_13 * vec2(0.025, 0.01));
  distortOffset_11 = tmpvar_14;
  uv_10 = (uv_10 + distortOffset_11);
  uv_10.x = (uv_10.x + (_Time.x * 0.3));
  tmpvar_3 = uv_10;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = tmpvar_8;
  mediump vec4 normal_16;
  normal_16 = tmpvar_15;
  mediump vec3 res_17;
  mediump vec3 x_18;
  x_18.x = dot (unity_SHAr, normal_16);
  x_18.y = dot (unity_SHAg, normal_16);
  x_18.z = dot (unity_SHAb, normal_16);
  mediump vec3 x1_19;
  mediump vec4 tmpvar_20;
  tmpvar_20 = (normal_16.xyzz * normal_16.yzzx);
  x1_19.x = dot (unity_SHBr, tmpvar_20);
  x1_19.y = dot (unity_SHBg, tmpvar_20);
  x1_19.z = dot (unity_SHBb, tmpvar_20);
  res_17 = (x_18 + (x1_19 + (unity_SHC.xyz * 
    ((normal_16.x * normal_16.x) - (normal_16.y * normal_16.y))
  )));
  mediump vec3 tmpvar_21;
  tmpvar_21 = max (((1.055 * 
    pow (max (res_17, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_17 = tmpvar_21;
  shlight_1 = tmpvar_21;
  tmpvar_4 = shlight_1;
  gl_Position = (glstate_matrix_mvp * tmpvar_5);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_8;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_COLOR0 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _CausticTex;
uniform lowp float _CausticIntensity;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_COLOR0;
void main ()
{
  lowp vec4 caustic_1;
  lowp float diff_2;
  lowp vec3 lightDir_3;
  lowp vec4 col_4;
  mediump vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_4 = tmpvar_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_3 = tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = max (0.0, dot (xlv_TEXCOORD2, lightDir_3));
  diff_2 = tmpvar_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = ((col_4.xyz * _LightColor0.xyz) * diff_2);
  col_4.xyz = (col_4.xyz * xlv_COLOR0);
  col_4.xyz = (col_4.xyz + tmpvar_8);
  mediump vec4 tmpvar_9;
  tmpvar_9 = (_CausticIntensity * texture2D (_CausticTex, xlv_TEXCOORD1));
  caustic_1 = tmpvar_9;
  col_4 = (col_4 + (caustic_1 * diff_2));
  gl_FragData[0] = col_4;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_WorldToShadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _CausticTex_ST;
uniform highp float _Speed;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying lowp vec3 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  highp vec3 shlight_1;
  highp vec2 cUv_2;
  highp vec2 tmpvar_3;
  lowp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  highp vec4 tmpvar_6;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_7;
  tmpvar_7[0] = unity_WorldToObject[0].xyz;
  tmpvar_7[1] = unity_WorldToObject[1].xyz;
  tmpvar_7[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize((_glesNormal * tmpvar_7));
  highp vec2 tmpvar_9;
  tmpvar_9.x = ((tmpvar_6.x * 0.866) + (tmpvar_6.y * 0.5));
  tmpvar_9.y = ((tmpvar_6.z * 0.866) + (tmpvar_6.y * 0.5));
  cUv_2 = ((tmpvar_9 * _CausticTex_ST.xy) + _CausticTex_ST.zw);
  mediump vec2 uv_10;
  uv_10 = cUv_2;
  mediump vec2 distortOffset_11;
  highp float tmpvar_12;
  tmpvar_12 = ((_Time * 20.0) * _Speed).x;
  highp vec2 tmpvar_13;
  tmpvar_13.x = sin((tmpvar_12 + (uv_10.y * 6.28)));
  tmpvar_13.y = sin((tmpvar_12 + (uv_10.x * 6.28)));
  highp vec2 tmpvar_14;
  tmpvar_14 = (tmpvar_13 * vec2(0.025, 0.01));
  distortOffset_11 = tmpvar_14;
  uv_10 = (uv_10 + distortOffset_11);
  uv_10.x = (uv_10.x + (_Time.x * 0.3));
  tmpvar_3 = uv_10;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = tmpvar_8;
  mediump vec4 normal_16;
  normal_16 = tmpvar_15;
  mediump vec3 res_17;
  mediump vec3 x_18;
  x_18.x = dot (unity_SHAr, normal_16);
  x_18.y = dot (unity_SHAg, normal_16);
  x_18.z = dot (unity_SHAb, normal_16);
  mediump vec3 x1_19;
  mediump vec4 tmpvar_20;
  tmpvar_20 = (normal_16.xyzz * normal_16.yzzx);
  x1_19.x = dot (unity_SHBr, tmpvar_20);
  x1_19.y = dot (unity_SHBg, tmpvar_20);
  x1_19.z = dot (unity_SHBb, tmpvar_20);
  res_17 = (x_18 + (x1_19 + (unity_SHC.xyz * 
    ((normal_16.x * normal_16.x) - (normal_16.y * normal_16.y))
  )));
  mediump vec3 tmpvar_21;
  tmpvar_21 = max (((1.055 * 
    pow (max (res_17, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_17 = tmpvar_21;
  shlight_1 = tmpvar_21;
  tmpvar_4 = shlight_1;
  gl_Position = (glstate_matrix_mvp * tmpvar_5);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_8;
  xlv_TEXCOORD3 = tmpvar_6.xyz;
  xlv_COLOR0 = tmpvar_4;
  xlv_TEXCOORD4 = (unity_WorldToShadow[0] * tmpvar_6);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform mediump vec4 _LightShadowData;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _ShadowMapTexture;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _CausticTex;
uniform lowp float _CausticIntensity;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 caustic_1;
  lowp float diff_2;
  lowp vec3 lightDir_3;
  lowp vec4 col_4;
  mediump vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_4 = tmpvar_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_3 = tmpvar_6;
  highp float lightShadowDataX_7;
  lowp vec2 outsideOfShadowmap_8;
  lowp vec2 coordCheck_9;
  highp vec2 tmpvar_10;
  tmpvar_10 = abs(((xlv_TEXCOORD4.xy * 2.0) - 1.0));
  coordCheck_9 = tmpvar_10;
  bvec2 tmpvar_11;
  tmpvar_11 = greaterThan (coordCheck_9, vec2(1.0, 1.0));
  lowp float tmpvar_12;
  if (tmpvar_11.x) {
    tmpvar_12 = 1.0;
  } else {
    tmpvar_12 = 0.0;
  };
  lowp float tmpvar_13;
  if (tmpvar_11.y) {
    tmpvar_13 = 1.0;
  } else {
    tmpvar_13 = 0.0;
  };
  lowp vec2 tmpvar_14;
  tmpvar_14.x = tmpvar_12;
  tmpvar_14.y = tmpvar_13;
  outsideOfShadowmap_8.y = tmpvar_14.y;
  outsideOfShadowmap_8.x = (tmpvar_12 + tmpvar_13);
  highp float tmpvar_15;
  if ((xlv_TEXCOORD4.z > 1.0)) {
    tmpvar_15 = 1.0;
  } else {
    tmpvar_15 = 0.0;
  };
  outsideOfShadowmap_8.x = (outsideOfShadowmap_8.x + tmpvar_15);
  mediump float tmpvar_16;
  tmpvar_16 = _LightShadowData.x;
  lightShadowDataX_7 = tmpvar_16;
  lowp float tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = clamp ((max (
    float((texture2D (_ShadowMapTexture, xlv_TEXCOORD4.xy).x > xlv_TEXCOORD4.z))
  , lightShadowDataX_7) + outsideOfShadowmap_8.x), 0.0, 1.0);
  tmpvar_17 = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = max (0.0, dot (xlv_TEXCOORD2, lightDir_3));
  diff_2 = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = ((col_4.xyz * _LightColor0.xyz) * (diff_2 * tmpvar_17));
  col_4.xyz = (col_4.xyz * xlv_COLOR0);
  col_4.xyz = (col_4.xyz + tmpvar_20);
  mediump vec4 tmpvar_21;
  tmpvar_21 = (_CausticIntensity * texture2D (_CausticTex, xlv_TEXCOORD1));
  caustic_1 = tmpvar_21;
  col_4 = (col_4 + ((caustic_1 * diff_2) * (
    (tmpvar_17 * 0.5)
   + 0.5)));
  gl_FragData[0] = col_4;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_WorldToShadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _CausticTex_ST;
uniform highp float _Speed;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying lowp vec3 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  highp vec3 shlight_1;
  highp vec2 cUv_2;
  highp vec2 tmpvar_3;
  lowp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  highp vec4 tmpvar_6;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_7;
  tmpvar_7[0] = unity_WorldToObject[0].xyz;
  tmpvar_7[1] = unity_WorldToObject[1].xyz;
  tmpvar_7[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize((_glesNormal * tmpvar_7));
  highp vec2 tmpvar_9;
  tmpvar_9.x = ((tmpvar_6.x * 0.866) + (tmpvar_6.y * 0.5));
  tmpvar_9.y = ((tmpvar_6.z * 0.866) + (tmpvar_6.y * 0.5));
  cUv_2 = ((tmpvar_9 * _CausticTex_ST.xy) + _CausticTex_ST.zw);
  mediump vec2 uv_10;
  uv_10 = cUv_2;
  mediump vec2 distortOffset_11;
  highp float tmpvar_12;
  tmpvar_12 = ((_Time * 20.0) * _Speed).x;
  highp vec2 tmpvar_13;
  tmpvar_13.x = sin((tmpvar_12 + (uv_10.y * 6.28)));
  tmpvar_13.y = sin((tmpvar_12 + (uv_10.x * 6.28)));
  highp vec2 tmpvar_14;
  tmpvar_14 = (tmpvar_13 * vec2(0.025, 0.01));
  distortOffset_11 = tmpvar_14;
  uv_10 = (uv_10 + distortOffset_11);
  uv_10.x = (uv_10.x + (_Time.x * 0.3));
  tmpvar_3 = uv_10;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = tmpvar_8;
  mediump vec4 normal_16;
  normal_16 = tmpvar_15;
  mediump vec3 res_17;
  mediump vec3 x_18;
  x_18.x = dot (unity_SHAr, normal_16);
  x_18.y = dot (unity_SHAg, normal_16);
  x_18.z = dot (unity_SHAb, normal_16);
  mediump vec3 x1_19;
  mediump vec4 tmpvar_20;
  tmpvar_20 = (normal_16.xyzz * normal_16.yzzx);
  x1_19.x = dot (unity_SHBr, tmpvar_20);
  x1_19.y = dot (unity_SHBg, tmpvar_20);
  x1_19.z = dot (unity_SHBb, tmpvar_20);
  res_17 = (x_18 + (x1_19 + (unity_SHC.xyz * 
    ((normal_16.x * normal_16.x) - (normal_16.y * normal_16.y))
  )));
  mediump vec3 tmpvar_21;
  tmpvar_21 = max (((1.055 * 
    pow (max (res_17, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_17 = tmpvar_21;
  shlight_1 = tmpvar_21;
  tmpvar_4 = shlight_1;
  gl_Position = (glstate_matrix_mvp * tmpvar_5);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_8;
  xlv_TEXCOORD3 = tmpvar_6.xyz;
  xlv_COLOR0 = tmpvar_4;
  xlv_TEXCOORD4 = (unity_WorldToShadow[0] * tmpvar_6);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform mediump vec4 _LightShadowData;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _ShadowMapTexture;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _CausticTex;
uniform lowp float _CausticIntensity;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 caustic_1;
  lowp float diff_2;
  lowp vec3 lightDir_3;
  lowp vec4 col_4;
  mediump vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_4 = tmpvar_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_3 = tmpvar_6;
  highp float lightShadowDataX_7;
  lowp vec2 outsideOfShadowmap_8;
  lowp vec2 coordCheck_9;
  highp vec2 tmpvar_10;
  tmpvar_10 = abs(((xlv_TEXCOORD4.xy * 2.0) - 1.0));
  coordCheck_9 = tmpvar_10;
  bvec2 tmpvar_11;
  tmpvar_11 = greaterThan (coordCheck_9, vec2(1.0, 1.0));
  lowp float tmpvar_12;
  if (tmpvar_11.x) {
    tmpvar_12 = 1.0;
  } else {
    tmpvar_12 = 0.0;
  };
  lowp float tmpvar_13;
  if (tmpvar_11.y) {
    tmpvar_13 = 1.0;
  } else {
    tmpvar_13 = 0.0;
  };
  lowp vec2 tmpvar_14;
  tmpvar_14.x = tmpvar_12;
  tmpvar_14.y = tmpvar_13;
  outsideOfShadowmap_8.y = tmpvar_14.y;
  outsideOfShadowmap_8.x = (tmpvar_12 + tmpvar_13);
  highp float tmpvar_15;
  if ((xlv_TEXCOORD4.z > 1.0)) {
    tmpvar_15 = 1.0;
  } else {
    tmpvar_15 = 0.0;
  };
  outsideOfShadowmap_8.x = (outsideOfShadowmap_8.x + tmpvar_15);
  mediump float tmpvar_16;
  tmpvar_16 = _LightShadowData.x;
  lightShadowDataX_7 = tmpvar_16;
  lowp float tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = clamp ((max (
    float((texture2D (_ShadowMapTexture, xlv_TEXCOORD4.xy).x > xlv_TEXCOORD4.z))
  , lightShadowDataX_7) + outsideOfShadowmap_8.x), 0.0, 1.0);
  tmpvar_17 = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = max (0.0, dot (xlv_TEXCOORD2, lightDir_3));
  diff_2 = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = ((col_4.xyz * _LightColor0.xyz) * (diff_2 * tmpvar_17));
  col_4.xyz = (col_4.xyz * xlv_COLOR0);
  col_4.xyz = (col_4.xyz + tmpvar_20);
  mediump vec4 tmpvar_21;
  tmpvar_21 = (_CausticIntensity * texture2D (_CausticTex, xlv_TEXCOORD1));
  caustic_1 = tmpvar_21;
  col_4 = (col_4 + ((caustic_1 * diff_2) * (
    (tmpvar_17 * 0.5)
   + 0.5)));
  gl_FragData[0] = col_4;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_WorldToShadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _CausticTex_ST;
uniform highp float _Speed;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying lowp vec3 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  highp vec3 shlight_1;
  highp vec2 cUv_2;
  highp vec2 tmpvar_3;
  lowp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  highp vec4 tmpvar_6;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_7;
  tmpvar_7[0] = unity_WorldToObject[0].xyz;
  tmpvar_7[1] = unity_WorldToObject[1].xyz;
  tmpvar_7[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize((_glesNormal * tmpvar_7));
  highp vec2 tmpvar_9;
  tmpvar_9.x = ((tmpvar_6.x * 0.866) + (tmpvar_6.y * 0.5));
  tmpvar_9.y = ((tmpvar_6.z * 0.866) + (tmpvar_6.y * 0.5));
  cUv_2 = ((tmpvar_9 * _CausticTex_ST.xy) + _CausticTex_ST.zw);
  mediump vec2 uv_10;
  uv_10 = cUv_2;
  mediump vec2 distortOffset_11;
  highp float tmpvar_12;
  tmpvar_12 = ((_Time * 20.0) * _Speed).x;
  highp vec2 tmpvar_13;
  tmpvar_13.x = sin((tmpvar_12 + (uv_10.y * 6.28)));
  tmpvar_13.y = sin((tmpvar_12 + (uv_10.x * 6.28)));
  highp vec2 tmpvar_14;
  tmpvar_14 = (tmpvar_13 * vec2(0.025, 0.01));
  distortOffset_11 = tmpvar_14;
  uv_10 = (uv_10 + distortOffset_11);
  uv_10.x = (uv_10.x + (_Time.x * 0.3));
  tmpvar_3 = uv_10;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = tmpvar_8;
  mediump vec4 normal_16;
  normal_16 = tmpvar_15;
  mediump vec3 res_17;
  mediump vec3 x_18;
  x_18.x = dot (unity_SHAr, normal_16);
  x_18.y = dot (unity_SHAg, normal_16);
  x_18.z = dot (unity_SHAb, normal_16);
  mediump vec3 x1_19;
  mediump vec4 tmpvar_20;
  tmpvar_20 = (normal_16.xyzz * normal_16.yzzx);
  x1_19.x = dot (unity_SHBr, tmpvar_20);
  x1_19.y = dot (unity_SHBg, tmpvar_20);
  x1_19.z = dot (unity_SHBb, tmpvar_20);
  res_17 = (x_18 + (x1_19 + (unity_SHC.xyz * 
    ((normal_16.x * normal_16.x) - (normal_16.y * normal_16.y))
  )));
  mediump vec3 tmpvar_21;
  tmpvar_21 = max (((1.055 * 
    pow (max (res_17, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_17 = tmpvar_21;
  shlight_1 = tmpvar_21;
  tmpvar_4 = shlight_1;
  gl_Position = (glstate_matrix_mvp * tmpvar_5);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_8;
  xlv_TEXCOORD3 = tmpvar_6.xyz;
  xlv_COLOR0 = tmpvar_4;
  xlv_TEXCOORD4 = (unity_WorldToShadow[0] * tmpvar_6);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform mediump vec4 _LightShadowData;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _ShadowMapTexture;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _CausticTex;
uniform lowp float _CausticIntensity;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 caustic_1;
  lowp float diff_2;
  lowp vec3 lightDir_3;
  lowp vec4 col_4;
  mediump vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_4 = tmpvar_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_3 = tmpvar_6;
  highp float lightShadowDataX_7;
  lowp vec2 outsideOfShadowmap_8;
  lowp vec2 coordCheck_9;
  highp vec2 tmpvar_10;
  tmpvar_10 = abs(((xlv_TEXCOORD4.xy * 2.0) - 1.0));
  coordCheck_9 = tmpvar_10;
  bvec2 tmpvar_11;
  tmpvar_11 = greaterThan (coordCheck_9, vec2(1.0, 1.0));
  lowp float tmpvar_12;
  if (tmpvar_11.x) {
    tmpvar_12 = 1.0;
  } else {
    tmpvar_12 = 0.0;
  };
  lowp float tmpvar_13;
  if (tmpvar_11.y) {
    tmpvar_13 = 1.0;
  } else {
    tmpvar_13 = 0.0;
  };
  lowp vec2 tmpvar_14;
  tmpvar_14.x = tmpvar_12;
  tmpvar_14.y = tmpvar_13;
  outsideOfShadowmap_8.y = tmpvar_14.y;
  outsideOfShadowmap_8.x = (tmpvar_12 + tmpvar_13);
  highp float tmpvar_15;
  if ((xlv_TEXCOORD4.z > 1.0)) {
    tmpvar_15 = 1.0;
  } else {
    tmpvar_15 = 0.0;
  };
  outsideOfShadowmap_8.x = (outsideOfShadowmap_8.x + tmpvar_15);
  mediump float tmpvar_16;
  tmpvar_16 = _LightShadowData.x;
  lightShadowDataX_7 = tmpvar_16;
  lowp float tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = clamp ((max (
    float((texture2D (_ShadowMapTexture, xlv_TEXCOORD4.xy).x > xlv_TEXCOORD4.z))
  , lightShadowDataX_7) + outsideOfShadowmap_8.x), 0.0, 1.0);
  tmpvar_17 = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = max (0.0, dot (xlv_TEXCOORD2, lightDir_3));
  diff_2 = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = ((col_4.xyz * _LightColor0.xyz) * (diff_2 * tmpvar_17));
  col_4.xyz = (col_4.xyz * xlv_COLOR0);
  col_4.xyz = (col_4.xyz + tmpvar_20);
  mediump vec4 tmpvar_21;
  tmpvar_21 = (_CausticIntensity * texture2D (_CausticTex, xlv_TEXCOORD1));
  caustic_1 = tmpvar_21;
  col_4 = (col_4 + ((caustic_1 * diff_2) * (
    (tmpvar_17 * 0.5)
   + 0.5)));
  gl_FragData[0] = col_4;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _CausticTex_ST;
uniform highp float _Speed;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying lowp vec3 xlv_COLOR0;
void main ()
{
  highp vec3 shlight_1;
  highp vec2 cUv_2;
  highp vec2 tmpvar_3;
  lowp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  highp vec3 tmpvar_6;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = unity_WorldToObject[0].xyz;
  tmpvar_7[1] = unity_WorldToObject[1].xyz;
  tmpvar_7[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize((_glesNormal * tmpvar_7));
  highp vec2 tmpvar_9;
  tmpvar_9.x = ((tmpvar_6.x * 0.866) + (tmpvar_6.y * 0.5));
  tmpvar_9.y = ((tmpvar_6.z * 0.866) + (tmpvar_6.y * 0.5));
  cUv_2 = ((tmpvar_9 * _CausticTex_ST.xy) + _CausticTex_ST.zw);
  mediump vec2 uv_10;
  uv_10 = cUv_2;
  mediump vec2 distortOffset_11;
  highp float tmpvar_12;
  tmpvar_12 = ((_Time * 20.0) * _Speed).x;
  highp vec2 tmpvar_13;
  tmpvar_13.x = sin((tmpvar_12 + (uv_10.y * 6.28)));
  tmpvar_13.y = sin((tmpvar_12 + (uv_10.x * 6.28)));
  highp vec2 tmpvar_14;
  tmpvar_14 = (tmpvar_13 * vec2(0.025, 0.01));
  distortOffset_11 = tmpvar_14;
  uv_10 = (uv_10 + distortOffset_11);
  uv_10.x = (uv_10.x + (_Time.x * 0.3));
  tmpvar_3 = uv_10;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = tmpvar_8;
  mediump vec4 normal_16;
  normal_16 = tmpvar_15;
  mediump vec3 res_17;
  mediump vec3 x_18;
  x_18.x = dot (unity_SHAr, normal_16);
  x_18.y = dot (unity_SHAg, normal_16);
  x_18.z = dot (unity_SHAb, normal_16);
  mediump vec3 x1_19;
  mediump vec4 tmpvar_20;
  tmpvar_20 = (normal_16.xyzz * normal_16.yzzx);
  x1_19.x = dot (unity_SHBr, tmpvar_20);
  x1_19.y = dot (unity_SHBg, tmpvar_20);
  x1_19.z = dot (unity_SHBb, tmpvar_20);
  res_17 = (x_18 + (x1_19 + (unity_SHC.xyz * 
    ((normal_16.x * normal_16.x) - (normal_16.y * normal_16.y))
  )));
  mediump vec3 tmpvar_21;
  tmpvar_21 = max (((1.055 * 
    pow (max (res_17, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_17 = tmpvar_21;
  shlight_1 = tmpvar_21;
  tmpvar_4 = shlight_1;
  gl_Position = (glstate_matrix_mvp * tmpvar_5);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_8;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_COLOR0 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _CausticTex;
uniform lowp float _CausticIntensity;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_COLOR0;
void main ()
{
  lowp vec4 caustic_1;
  lowp float diff_2;
  lowp vec3 lightDir_3;
  lowp vec4 col_4;
  mediump vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_4 = tmpvar_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_3 = tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = max (0.0, dot (xlv_TEXCOORD2, lightDir_3));
  diff_2 = tmpvar_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = ((col_4.xyz * _LightColor0.xyz) * diff_2);
  col_4.xyz = (col_4.xyz * xlv_COLOR0);
  col_4.xyz = (col_4.xyz + tmpvar_8);
  mediump vec4 tmpvar_9;
  tmpvar_9 = (_CausticIntensity * texture2D (_CausticTex, xlv_TEXCOORD1));
  caustic_1 = tmpvar_9;
  col_4 = (col_4 + (caustic_1 * diff_2));
  gl_FragData[0] = col_4;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _CausticTex_ST;
uniform highp float _Speed;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying lowp vec3 xlv_COLOR0;
void main ()
{
  highp vec3 shlight_1;
  highp vec2 cUv_2;
  highp vec2 tmpvar_3;
  lowp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  highp vec3 tmpvar_6;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = unity_WorldToObject[0].xyz;
  tmpvar_7[1] = unity_WorldToObject[1].xyz;
  tmpvar_7[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize((_glesNormal * tmpvar_7));
  highp vec2 tmpvar_9;
  tmpvar_9.x = ((tmpvar_6.x * 0.866) + (tmpvar_6.y * 0.5));
  tmpvar_9.y = ((tmpvar_6.z * 0.866) + (tmpvar_6.y * 0.5));
  cUv_2 = ((tmpvar_9 * _CausticTex_ST.xy) + _CausticTex_ST.zw);
  mediump vec2 uv_10;
  uv_10 = cUv_2;
  mediump vec2 distortOffset_11;
  highp float tmpvar_12;
  tmpvar_12 = ((_Time * 20.0) * _Speed).x;
  highp vec2 tmpvar_13;
  tmpvar_13.x = sin((tmpvar_12 + (uv_10.y * 6.28)));
  tmpvar_13.y = sin((tmpvar_12 + (uv_10.x * 6.28)));
  highp vec2 tmpvar_14;
  tmpvar_14 = (tmpvar_13 * vec2(0.025, 0.01));
  distortOffset_11 = tmpvar_14;
  uv_10 = (uv_10 + distortOffset_11);
  uv_10.x = (uv_10.x + (_Time.x * 0.3));
  tmpvar_3 = uv_10;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = tmpvar_8;
  mediump vec4 normal_16;
  normal_16 = tmpvar_15;
  mediump vec3 res_17;
  mediump vec3 x_18;
  x_18.x = dot (unity_SHAr, normal_16);
  x_18.y = dot (unity_SHAg, normal_16);
  x_18.z = dot (unity_SHAb, normal_16);
  mediump vec3 x1_19;
  mediump vec4 tmpvar_20;
  tmpvar_20 = (normal_16.xyzz * normal_16.yzzx);
  x1_19.x = dot (unity_SHBr, tmpvar_20);
  x1_19.y = dot (unity_SHBg, tmpvar_20);
  x1_19.z = dot (unity_SHBb, tmpvar_20);
  res_17 = (x_18 + (x1_19 + (unity_SHC.xyz * 
    ((normal_16.x * normal_16.x) - (normal_16.y * normal_16.y))
  )));
  mediump vec3 tmpvar_21;
  tmpvar_21 = max (((1.055 * 
    pow (max (res_17, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_17 = tmpvar_21;
  shlight_1 = tmpvar_21;
  tmpvar_4 = shlight_1;
  gl_Position = (glstate_matrix_mvp * tmpvar_5);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_8;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_COLOR0 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _CausticTex;
uniform lowp float _CausticIntensity;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_COLOR0;
void main ()
{
  lowp vec4 caustic_1;
  lowp float diff_2;
  lowp vec3 lightDir_3;
  lowp vec4 col_4;
  mediump vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_4 = tmpvar_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_3 = tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = max (0.0, dot (xlv_TEXCOORD2, lightDir_3));
  diff_2 = tmpvar_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = ((col_4.xyz * _LightColor0.xyz) * diff_2);
  col_4.xyz = (col_4.xyz * xlv_COLOR0);
  col_4.xyz = (col_4.xyz + tmpvar_8);
  mediump vec4 tmpvar_9;
  tmpvar_9 = (_CausticIntensity * texture2D (_CausticTex, xlv_TEXCOORD1));
  caustic_1 = tmpvar_9;
  col_4 = (col_4 + (caustic_1 * diff_2));
  gl_FragData[0] = col_4;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _CausticTex_ST;
uniform highp float _Speed;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying lowp vec3 xlv_COLOR0;
void main ()
{
  highp vec3 shlight_1;
  highp vec2 cUv_2;
  highp vec2 tmpvar_3;
  lowp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  highp vec3 tmpvar_6;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = unity_WorldToObject[0].xyz;
  tmpvar_7[1] = unity_WorldToObject[1].xyz;
  tmpvar_7[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize((_glesNormal * tmpvar_7));
  highp vec2 tmpvar_9;
  tmpvar_9.x = ((tmpvar_6.x * 0.866) + (tmpvar_6.y * 0.5));
  tmpvar_9.y = ((tmpvar_6.z * 0.866) + (tmpvar_6.y * 0.5));
  cUv_2 = ((tmpvar_9 * _CausticTex_ST.xy) + _CausticTex_ST.zw);
  mediump vec2 uv_10;
  uv_10 = cUv_2;
  mediump vec2 distortOffset_11;
  highp float tmpvar_12;
  tmpvar_12 = ((_Time * 20.0) * _Speed).x;
  highp vec2 tmpvar_13;
  tmpvar_13.x = sin((tmpvar_12 + (uv_10.y * 6.28)));
  tmpvar_13.y = sin((tmpvar_12 + (uv_10.x * 6.28)));
  highp vec2 tmpvar_14;
  tmpvar_14 = (tmpvar_13 * vec2(0.025, 0.01));
  distortOffset_11 = tmpvar_14;
  uv_10 = (uv_10 + distortOffset_11);
  uv_10.x = (uv_10.x + (_Time.x * 0.3));
  tmpvar_3 = uv_10;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = tmpvar_8;
  mediump vec4 normal_16;
  normal_16 = tmpvar_15;
  mediump vec3 res_17;
  mediump vec3 x_18;
  x_18.x = dot (unity_SHAr, normal_16);
  x_18.y = dot (unity_SHAg, normal_16);
  x_18.z = dot (unity_SHAb, normal_16);
  mediump vec3 x1_19;
  mediump vec4 tmpvar_20;
  tmpvar_20 = (normal_16.xyzz * normal_16.yzzx);
  x1_19.x = dot (unity_SHBr, tmpvar_20);
  x1_19.y = dot (unity_SHBg, tmpvar_20);
  x1_19.z = dot (unity_SHBb, tmpvar_20);
  res_17 = (x_18 + (x1_19 + (unity_SHC.xyz * 
    ((normal_16.x * normal_16.x) - (normal_16.y * normal_16.y))
  )));
  mediump vec3 tmpvar_21;
  tmpvar_21 = max (((1.055 * 
    pow (max (res_17, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_17 = tmpvar_21;
  shlight_1 = tmpvar_21;
  tmpvar_4 = shlight_1;
  gl_Position = (glstate_matrix_mvp * tmpvar_5);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_8;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_COLOR0 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _CausticTex;
uniform lowp float _CausticIntensity;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_COLOR0;
void main ()
{
  lowp vec4 caustic_1;
  lowp float diff_2;
  lowp vec3 lightDir_3;
  lowp vec4 col_4;
  mediump vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_4 = tmpvar_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_3 = tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = max (0.0, dot (xlv_TEXCOORD2, lightDir_3));
  diff_2 = tmpvar_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = ((col_4.xyz * _LightColor0.xyz) * diff_2);
  col_4.xyz = (col_4.xyz * xlv_COLOR0);
  col_4.xyz = (col_4.xyz + tmpvar_8);
  mediump vec4 tmpvar_9;
  tmpvar_9 = (_CausticIntensity * texture2D (_CausticTex, xlv_TEXCOORD1));
  caustic_1 = tmpvar_9;
  col_4 = (col_4 + (caustic_1 * diff_2));
  gl_FragData[0] = col_4;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_WorldToShadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _CausticTex_ST;
uniform highp float _Speed;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying lowp vec3 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  highp vec3 shlight_1;
  highp vec2 cUv_2;
  highp vec2 tmpvar_3;
  lowp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  highp vec4 tmpvar_6;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_7;
  tmpvar_7[0] = unity_WorldToObject[0].xyz;
  tmpvar_7[1] = unity_WorldToObject[1].xyz;
  tmpvar_7[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize((_glesNormal * tmpvar_7));
  highp vec2 tmpvar_9;
  tmpvar_9.x = ((tmpvar_6.x * 0.866) + (tmpvar_6.y * 0.5));
  tmpvar_9.y = ((tmpvar_6.z * 0.866) + (tmpvar_6.y * 0.5));
  cUv_2 = ((tmpvar_9 * _CausticTex_ST.xy) + _CausticTex_ST.zw);
  mediump vec2 uv_10;
  uv_10 = cUv_2;
  mediump vec2 distortOffset_11;
  highp float tmpvar_12;
  tmpvar_12 = ((_Time * 20.0) * _Speed).x;
  highp vec2 tmpvar_13;
  tmpvar_13.x = sin((tmpvar_12 + (uv_10.y * 6.28)));
  tmpvar_13.y = sin((tmpvar_12 + (uv_10.x * 6.28)));
  highp vec2 tmpvar_14;
  tmpvar_14 = (tmpvar_13 * vec2(0.025, 0.01));
  distortOffset_11 = tmpvar_14;
  uv_10 = (uv_10 + distortOffset_11);
  uv_10.x = (uv_10.x + (_Time.x * 0.3));
  tmpvar_3 = uv_10;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = tmpvar_8;
  mediump vec4 normal_16;
  normal_16 = tmpvar_15;
  mediump vec3 res_17;
  mediump vec3 x_18;
  x_18.x = dot (unity_SHAr, normal_16);
  x_18.y = dot (unity_SHAg, normal_16);
  x_18.z = dot (unity_SHAb, normal_16);
  mediump vec3 x1_19;
  mediump vec4 tmpvar_20;
  tmpvar_20 = (normal_16.xyzz * normal_16.yzzx);
  x1_19.x = dot (unity_SHBr, tmpvar_20);
  x1_19.y = dot (unity_SHBg, tmpvar_20);
  x1_19.z = dot (unity_SHBb, tmpvar_20);
  res_17 = (x_18 + (x1_19 + (unity_SHC.xyz * 
    ((normal_16.x * normal_16.x) - (normal_16.y * normal_16.y))
  )));
  mediump vec3 tmpvar_21;
  tmpvar_21 = max (((1.055 * 
    pow (max (res_17, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_17 = tmpvar_21;
  shlight_1 = tmpvar_21;
  tmpvar_4 = shlight_1;
  gl_Position = (glstate_matrix_mvp * tmpvar_5);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_8;
  xlv_TEXCOORD3 = tmpvar_6.xyz;
  xlv_COLOR0 = tmpvar_4;
  xlv_TEXCOORD4 = (unity_WorldToShadow[0] * tmpvar_6);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform mediump vec4 _LightShadowData;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _ShadowMapTexture;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _CausticTex;
uniform lowp float _CausticIntensity;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 caustic_1;
  lowp float diff_2;
  lowp vec3 lightDir_3;
  lowp vec4 col_4;
  mediump vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_4 = tmpvar_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_3 = tmpvar_6;
  highp float lightShadowDataX_7;
  lowp vec2 outsideOfShadowmap_8;
  lowp vec2 coordCheck_9;
  highp vec2 tmpvar_10;
  tmpvar_10 = abs(((xlv_TEXCOORD4.xy * 2.0) - 1.0));
  coordCheck_9 = tmpvar_10;
  bvec2 tmpvar_11;
  tmpvar_11 = greaterThan (coordCheck_9, vec2(1.0, 1.0));
  lowp float tmpvar_12;
  if (tmpvar_11.x) {
    tmpvar_12 = 1.0;
  } else {
    tmpvar_12 = 0.0;
  };
  lowp float tmpvar_13;
  if (tmpvar_11.y) {
    tmpvar_13 = 1.0;
  } else {
    tmpvar_13 = 0.0;
  };
  lowp vec2 tmpvar_14;
  tmpvar_14.x = tmpvar_12;
  tmpvar_14.y = tmpvar_13;
  outsideOfShadowmap_8.y = tmpvar_14.y;
  outsideOfShadowmap_8.x = (tmpvar_12 + tmpvar_13);
  highp float tmpvar_15;
  if ((xlv_TEXCOORD4.z > 1.0)) {
    tmpvar_15 = 1.0;
  } else {
    tmpvar_15 = 0.0;
  };
  outsideOfShadowmap_8.x = (outsideOfShadowmap_8.x + tmpvar_15);
  mediump float tmpvar_16;
  tmpvar_16 = _LightShadowData.x;
  lightShadowDataX_7 = tmpvar_16;
  lowp float tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = clamp ((max (
    float((texture2D (_ShadowMapTexture, xlv_TEXCOORD4.xy).x > xlv_TEXCOORD4.z))
  , lightShadowDataX_7) + outsideOfShadowmap_8.x), 0.0, 1.0);
  tmpvar_17 = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = max (0.0, dot (xlv_TEXCOORD2, lightDir_3));
  diff_2 = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = ((col_4.xyz * _LightColor0.xyz) * (diff_2 * tmpvar_17));
  col_4.xyz = (col_4.xyz * xlv_COLOR0);
  col_4.xyz = (col_4.xyz + tmpvar_20);
  mediump vec4 tmpvar_21;
  tmpvar_21 = (_CausticIntensity * texture2D (_CausticTex, xlv_TEXCOORD1));
  caustic_1 = tmpvar_21;
  col_4 = (col_4 + ((caustic_1 * diff_2) * (
    (tmpvar_17 * 0.5)
   + 0.5)));
  gl_FragData[0] = col_4;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_WorldToShadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _CausticTex_ST;
uniform highp float _Speed;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying lowp vec3 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  highp vec3 shlight_1;
  highp vec2 cUv_2;
  highp vec2 tmpvar_3;
  lowp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  highp vec4 tmpvar_6;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_7;
  tmpvar_7[0] = unity_WorldToObject[0].xyz;
  tmpvar_7[1] = unity_WorldToObject[1].xyz;
  tmpvar_7[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize((_glesNormal * tmpvar_7));
  highp vec2 tmpvar_9;
  tmpvar_9.x = ((tmpvar_6.x * 0.866) + (tmpvar_6.y * 0.5));
  tmpvar_9.y = ((tmpvar_6.z * 0.866) + (tmpvar_6.y * 0.5));
  cUv_2 = ((tmpvar_9 * _CausticTex_ST.xy) + _CausticTex_ST.zw);
  mediump vec2 uv_10;
  uv_10 = cUv_2;
  mediump vec2 distortOffset_11;
  highp float tmpvar_12;
  tmpvar_12 = ((_Time * 20.0) * _Speed).x;
  highp vec2 tmpvar_13;
  tmpvar_13.x = sin((tmpvar_12 + (uv_10.y * 6.28)));
  tmpvar_13.y = sin((tmpvar_12 + (uv_10.x * 6.28)));
  highp vec2 tmpvar_14;
  tmpvar_14 = (tmpvar_13 * vec2(0.025, 0.01));
  distortOffset_11 = tmpvar_14;
  uv_10 = (uv_10 + distortOffset_11);
  uv_10.x = (uv_10.x + (_Time.x * 0.3));
  tmpvar_3 = uv_10;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = tmpvar_8;
  mediump vec4 normal_16;
  normal_16 = tmpvar_15;
  mediump vec3 res_17;
  mediump vec3 x_18;
  x_18.x = dot (unity_SHAr, normal_16);
  x_18.y = dot (unity_SHAg, normal_16);
  x_18.z = dot (unity_SHAb, normal_16);
  mediump vec3 x1_19;
  mediump vec4 tmpvar_20;
  tmpvar_20 = (normal_16.xyzz * normal_16.yzzx);
  x1_19.x = dot (unity_SHBr, tmpvar_20);
  x1_19.y = dot (unity_SHBg, tmpvar_20);
  x1_19.z = dot (unity_SHBb, tmpvar_20);
  res_17 = (x_18 + (x1_19 + (unity_SHC.xyz * 
    ((normal_16.x * normal_16.x) - (normal_16.y * normal_16.y))
  )));
  mediump vec3 tmpvar_21;
  tmpvar_21 = max (((1.055 * 
    pow (max (res_17, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_17 = tmpvar_21;
  shlight_1 = tmpvar_21;
  tmpvar_4 = shlight_1;
  gl_Position = (glstate_matrix_mvp * tmpvar_5);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_8;
  xlv_TEXCOORD3 = tmpvar_6.xyz;
  xlv_COLOR0 = tmpvar_4;
  xlv_TEXCOORD4 = (unity_WorldToShadow[0] * tmpvar_6);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform mediump vec4 _LightShadowData;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _ShadowMapTexture;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _CausticTex;
uniform lowp float _CausticIntensity;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 caustic_1;
  lowp float diff_2;
  lowp vec3 lightDir_3;
  lowp vec4 col_4;
  mediump vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_4 = tmpvar_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_3 = tmpvar_6;
  highp float lightShadowDataX_7;
  lowp vec2 outsideOfShadowmap_8;
  lowp vec2 coordCheck_9;
  highp vec2 tmpvar_10;
  tmpvar_10 = abs(((xlv_TEXCOORD4.xy * 2.0) - 1.0));
  coordCheck_9 = tmpvar_10;
  bvec2 tmpvar_11;
  tmpvar_11 = greaterThan (coordCheck_9, vec2(1.0, 1.0));
  lowp float tmpvar_12;
  if (tmpvar_11.x) {
    tmpvar_12 = 1.0;
  } else {
    tmpvar_12 = 0.0;
  };
  lowp float tmpvar_13;
  if (tmpvar_11.y) {
    tmpvar_13 = 1.0;
  } else {
    tmpvar_13 = 0.0;
  };
  lowp vec2 tmpvar_14;
  tmpvar_14.x = tmpvar_12;
  tmpvar_14.y = tmpvar_13;
  outsideOfShadowmap_8.y = tmpvar_14.y;
  outsideOfShadowmap_8.x = (tmpvar_12 + tmpvar_13);
  highp float tmpvar_15;
  if ((xlv_TEXCOORD4.z > 1.0)) {
    tmpvar_15 = 1.0;
  } else {
    tmpvar_15 = 0.0;
  };
  outsideOfShadowmap_8.x = (outsideOfShadowmap_8.x + tmpvar_15);
  mediump float tmpvar_16;
  tmpvar_16 = _LightShadowData.x;
  lightShadowDataX_7 = tmpvar_16;
  lowp float tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = clamp ((max (
    float((texture2D (_ShadowMapTexture, xlv_TEXCOORD4.xy).x > xlv_TEXCOORD4.z))
  , lightShadowDataX_7) + outsideOfShadowmap_8.x), 0.0, 1.0);
  tmpvar_17 = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = max (0.0, dot (xlv_TEXCOORD2, lightDir_3));
  diff_2 = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = ((col_4.xyz * _LightColor0.xyz) * (diff_2 * tmpvar_17));
  col_4.xyz = (col_4.xyz * xlv_COLOR0);
  col_4.xyz = (col_4.xyz + tmpvar_20);
  mediump vec4 tmpvar_21;
  tmpvar_21 = (_CausticIntensity * texture2D (_CausticTex, xlv_TEXCOORD1));
  caustic_1 = tmpvar_21;
  col_4 = (col_4 + ((caustic_1 * diff_2) * (
    (tmpvar_17 * 0.5)
   + 0.5)));
  gl_FragData[0] = col_4;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_WorldToShadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _CausticTex_ST;
uniform highp float _Speed;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying lowp vec3 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  highp vec3 shlight_1;
  highp vec2 cUv_2;
  highp vec2 tmpvar_3;
  lowp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  highp vec4 tmpvar_6;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_7;
  tmpvar_7[0] = unity_WorldToObject[0].xyz;
  tmpvar_7[1] = unity_WorldToObject[1].xyz;
  tmpvar_7[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize((_glesNormal * tmpvar_7));
  highp vec2 tmpvar_9;
  tmpvar_9.x = ((tmpvar_6.x * 0.866) + (tmpvar_6.y * 0.5));
  tmpvar_9.y = ((tmpvar_6.z * 0.866) + (tmpvar_6.y * 0.5));
  cUv_2 = ((tmpvar_9 * _CausticTex_ST.xy) + _CausticTex_ST.zw);
  mediump vec2 uv_10;
  uv_10 = cUv_2;
  mediump vec2 distortOffset_11;
  highp float tmpvar_12;
  tmpvar_12 = ((_Time * 20.0) * _Speed).x;
  highp vec2 tmpvar_13;
  tmpvar_13.x = sin((tmpvar_12 + (uv_10.y * 6.28)));
  tmpvar_13.y = sin((tmpvar_12 + (uv_10.x * 6.28)));
  highp vec2 tmpvar_14;
  tmpvar_14 = (tmpvar_13 * vec2(0.025, 0.01));
  distortOffset_11 = tmpvar_14;
  uv_10 = (uv_10 + distortOffset_11);
  uv_10.x = (uv_10.x + (_Time.x * 0.3));
  tmpvar_3 = uv_10;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = tmpvar_8;
  mediump vec4 normal_16;
  normal_16 = tmpvar_15;
  mediump vec3 res_17;
  mediump vec3 x_18;
  x_18.x = dot (unity_SHAr, normal_16);
  x_18.y = dot (unity_SHAg, normal_16);
  x_18.z = dot (unity_SHAb, normal_16);
  mediump vec3 x1_19;
  mediump vec4 tmpvar_20;
  tmpvar_20 = (normal_16.xyzz * normal_16.yzzx);
  x1_19.x = dot (unity_SHBr, tmpvar_20);
  x1_19.y = dot (unity_SHBg, tmpvar_20);
  x1_19.z = dot (unity_SHBb, tmpvar_20);
  res_17 = (x_18 + (x1_19 + (unity_SHC.xyz * 
    ((normal_16.x * normal_16.x) - (normal_16.y * normal_16.y))
  )));
  mediump vec3 tmpvar_21;
  tmpvar_21 = max (((1.055 * 
    pow (max (res_17, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_17 = tmpvar_21;
  shlight_1 = tmpvar_21;
  tmpvar_4 = shlight_1;
  gl_Position = (glstate_matrix_mvp * tmpvar_5);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_8;
  xlv_TEXCOORD3 = tmpvar_6.xyz;
  xlv_COLOR0 = tmpvar_4;
  xlv_TEXCOORD4 = (unity_WorldToShadow[0] * tmpvar_6);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform mediump vec4 _LightShadowData;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _ShadowMapTexture;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _CausticTex;
uniform lowp float _CausticIntensity;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 caustic_1;
  lowp float diff_2;
  lowp vec3 lightDir_3;
  lowp vec4 col_4;
  mediump vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_4 = tmpvar_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_3 = tmpvar_6;
  highp float lightShadowDataX_7;
  lowp vec2 outsideOfShadowmap_8;
  lowp vec2 coordCheck_9;
  highp vec2 tmpvar_10;
  tmpvar_10 = abs(((xlv_TEXCOORD4.xy * 2.0) - 1.0));
  coordCheck_9 = tmpvar_10;
  bvec2 tmpvar_11;
  tmpvar_11 = greaterThan (coordCheck_9, vec2(1.0, 1.0));
  lowp float tmpvar_12;
  if (tmpvar_11.x) {
    tmpvar_12 = 1.0;
  } else {
    tmpvar_12 = 0.0;
  };
  lowp float tmpvar_13;
  if (tmpvar_11.y) {
    tmpvar_13 = 1.0;
  } else {
    tmpvar_13 = 0.0;
  };
  lowp vec2 tmpvar_14;
  tmpvar_14.x = tmpvar_12;
  tmpvar_14.y = tmpvar_13;
  outsideOfShadowmap_8.y = tmpvar_14.y;
  outsideOfShadowmap_8.x = (tmpvar_12 + tmpvar_13);
  highp float tmpvar_15;
  if ((xlv_TEXCOORD4.z > 1.0)) {
    tmpvar_15 = 1.0;
  } else {
    tmpvar_15 = 0.0;
  };
  outsideOfShadowmap_8.x = (outsideOfShadowmap_8.x + tmpvar_15);
  mediump float tmpvar_16;
  tmpvar_16 = _LightShadowData.x;
  lightShadowDataX_7 = tmpvar_16;
  lowp float tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = clamp ((max (
    float((texture2D (_ShadowMapTexture, xlv_TEXCOORD4.xy).x > xlv_TEXCOORD4.z))
  , lightShadowDataX_7) + outsideOfShadowmap_8.x), 0.0, 1.0);
  tmpvar_17 = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = max (0.0, dot (xlv_TEXCOORD2, lightDir_3));
  diff_2 = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = ((col_4.xyz * _LightColor0.xyz) * (diff_2 * tmpvar_17));
  col_4.xyz = (col_4.xyz * xlv_COLOR0);
  col_4.xyz = (col_4.xyz + tmpvar_20);
  mediump vec4 tmpvar_21;
  tmpvar_21 = (_CausticIntensity * texture2D (_CausticTex, xlv_TEXCOORD1));
  caustic_1 = tmpvar_21;
  col_4 = (col_4 + ((caustic_1 * diff_2) * (
    (tmpvar_17 * 0.5)
   + 0.5)));
  gl_FragData[0] = col_4;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_FogParams;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _CausticTex_ST;
uniform highp float _Speed;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying lowp vec3 xlv_COLOR0;
varying highp float xlv_TEXCOORD5;
void main ()
{
  highp vec3 shlight_1;
  highp vec2 cUv_2;
  highp vec2 tmpvar_3;
  lowp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (glstate_matrix_mvp * tmpvar_6);
  highp vec3 tmpvar_7;
  tmpvar_7 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((_glesNormal * tmpvar_8));
  highp vec2 tmpvar_10;
  tmpvar_10.x = ((tmpvar_7.x * 0.866) + (tmpvar_7.y * 0.5));
  tmpvar_10.y = ((tmpvar_7.z * 0.866) + (tmpvar_7.y * 0.5));
  cUv_2 = ((tmpvar_10 * _CausticTex_ST.xy) + _CausticTex_ST.zw);
  mediump vec2 uv_11;
  uv_11 = cUv_2;
  mediump vec2 distortOffset_12;
  highp float tmpvar_13;
  tmpvar_13 = ((_Time * 20.0) * _Speed).x;
  highp vec2 tmpvar_14;
  tmpvar_14.x = sin((tmpvar_13 + (uv_11.y * 6.28)));
  tmpvar_14.y = sin((tmpvar_13 + (uv_11.x * 6.28)));
  highp vec2 tmpvar_15;
  tmpvar_15 = (tmpvar_14 * vec2(0.025, 0.01));
  distortOffset_12 = tmpvar_15;
  uv_11 = (uv_11 + distortOffset_12);
  uv_11.x = (uv_11.x + (_Time.x * 0.3));
  tmpvar_3 = uv_11;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = tmpvar_9;
  mediump vec4 normal_17;
  normal_17 = tmpvar_16;
  mediump vec3 res_18;
  mediump vec3 x_19;
  x_19.x = dot (unity_SHAr, normal_17);
  x_19.y = dot (unity_SHAg, normal_17);
  x_19.z = dot (unity_SHAb, normal_17);
  mediump vec3 x1_20;
  mediump vec4 tmpvar_21;
  tmpvar_21 = (normal_17.xyzz * normal_17.yzzx);
  x1_20.x = dot (unity_SHBr, tmpvar_21);
  x1_20.y = dot (unity_SHBg, tmpvar_21);
  x1_20.z = dot (unity_SHBb, tmpvar_21);
  res_18 = (x_19 + (x1_20 + (unity_SHC.xyz * 
    ((normal_17.x * normal_17.x) - (normal_17.y * normal_17.y))
  )));
  mediump vec3 tmpvar_22;
  tmpvar_22 = max (((1.055 * 
    pow (max (res_18, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_18 = tmpvar_22;
  shlight_1 = tmpvar_22;
  tmpvar_4 = shlight_1;
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_9;
  xlv_TEXCOORD3 = tmpvar_7;
  xlv_COLOR0 = tmpvar_4;
  xlv_TEXCOORD5 = ((tmpvar_5.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 unity_FogColor;
uniform lowp vec4 _LightColor0;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _CausticTex;
uniform lowp float _CausticIntensity;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_COLOR0;
varying highp float xlv_TEXCOORD5;
void main ()
{
  lowp vec4 caustic_1;
  lowp float diff_2;
  lowp vec3 lightDir_3;
  lowp vec4 col_4;
  mediump vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_4 = tmpvar_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_3 = tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = max (0.0, dot (xlv_TEXCOORD2, lightDir_3));
  diff_2 = tmpvar_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = ((col_4.xyz * _LightColor0.xyz) * diff_2);
  col_4.xyz = (col_4.xyz * xlv_COLOR0);
  col_4.xyz = (col_4.xyz + tmpvar_8);
  mediump vec4 tmpvar_9;
  tmpvar_9 = (_CausticIntensity * texture2D (_CausticTex, xlv_TEXCOORD1));
  caustic_1 = tmpvar_9;
  col_4 = (col_4 + (caustic_1 * diff_2));
  highp float tmpvar_10;
  tmpvar_10 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  col_4.xyz = mix (unity_FogColor.xyz, col_4.xyz, vec3(tmpvar_10));
  gl_FragData[0] = col_4;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_FogParams;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _CausticTex_ST;
uniform highp float _Speed;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying lowp vec3 xlv_COLOR0;
varying highp float xlv_TEXCOORD5;
void main ()
{
  highp vec3 shlight_1;
  highp vec2 cUv_2;
  highp vec2 tmpvar_3;
  lowp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (glstate_matrix_mvp * tmpvar_6);
  highp vec3 tmpvar_7;
  tmpvar_7 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((_glesNormal * tmpvar_8));
  highp vec2 tmpvar_10;
  tmpvar_10.x = ((tmpvar_7.x * 0.866) + (tmpvar_7.y * 0.5));
  tmpvar_10.y = ((tmpvar_7.z * 0.866) + (tmpvar_7.y * 0.5));
  cUv_2 = ((tmpvar_10 * _CausticTex_ST.xy) + _CausticTex_ST.zw);
  mediump vec2 uv_11;
  uv_11 = cUv_2;
  mediump vec2 distortOffset_12;
  highp float tmpvar_13;
  tmpvar_13 = ((_Time * 20.0) * _Speed).x;
  highp vec2 tmpvar_14;
  tmpvar_14.x = sin((tmpvar_13 + (uv_11.y * 6.28)));
  tmpvar_14.y = sin((tmpvar_13 + (uv_11.x * 6.28)));
  highp vec2 tmpvar_15;
  tmpvar_15 = (tmpvar_14 * vec2(0.025, 0.01));
  distortOffset_12 = tmpvar_15;
  uv_11 = (uv_11 + distortOffset_12);
  uv_11.x = (uv_11.x + (_Time.x * 0.3));
  tmpvar_3 = uv_11;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = tmpvar_9;
  mediump vec4 normal_17;
  normal_17 = tmpvar_16;
  mediump vec3 res_18;
  mediump vec3 x_19;
  x_19.x = dot (unity_SHAr, normal_17);
  x_19.y = dot (unity_SHAg, normal_17);
  x_19.z = dot (unity_SHAb, normal_17);
  mediump vec3 x1_20;
  mediump vec4 tmpvar_21;
  tmpvar_21 = (normal_17.xyzz * normal_17.yzzx);
  x1_20.x = dot (unity_SHBr, tmpvar_21);
  x1_20.y = dot (unity_SHBg, tmpvar_21);
  x1_20.z = dot (unity_SHBb, tmpvar_21);
  res_18 = (x_19 + (x1_20 + (unity_SHC.xyz * 
    ((normal_17.x * normal_17.x) - (normal_17.y * normal_17.y))
  )));
  mediump vec3 tmpvar_22;
  tmpvar_22 = max (((1.055 * 
    pow (max (res_18, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_18 = tmpvar_22;
  shlight_1 = tmpvar_22;
  tmpvar_4 = shlight_1;
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_9;
  xlv_TEXCOORD3 = tmpvar_7;
  xlv_COLOR0 = tmpvar_4;
  xlv_TEXCOORD5 = ((tmpvar_5.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 unity_FogColor;
uniform lowp vec4 _LightColor0;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _CausticTex;
uniform lowp float _CausticIntensity;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_COLOR0;
varying highp float xlv_TEXCOORD5;
void main ()
{
  lowp vec4 caustic_1;
  lowp float diff_2;
  lowp vec3 lightDir_3;
  lowp vec4 col_4;
  mediump vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_4 = tmpvar_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_3 = tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = max (0.0, dot (xlv_TEXCOORD2, lightDir_3));
  diff_2 = tmpvar_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = ((col_4.xyz * _LightColor0.xyz) * diff_2);
  col_4.xyz = (col_4.xyz * xlv_COLOR0);
  col_4.xyz = (col_4.xyz + tmpvar_8);
  mediump vec4 tmpvar_9;
  tmpvar_9 = (_CausticIntensity * texture2D (_CausticTex, xlv_TEXCOORD1));
  caustic_1 = tmpvar_9;
  col_4 = (col_4 + (caustic_1 * diff_2));
  highp float tmpvar_10;
  tmpvar_10 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  col_4.xyz = mix (unity_FogColor.xyz, col_4.xyz, vec3(tmpvar_10));
  gl_FragData[0] = col_4;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_FogParams;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _CausticTex_ST;
uniform highp float _Speed;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying lowp vec3 xlv_COLOR0;
varying highp float xlv_TEXCOORD5;
void main ()
{
  highp vec3 shlight_1;
  highp vec2 cUv_2;
  highp vec2 tmpvar_3;
  lowp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (glstate_matrix_mvp * tmpvar_6);
  highp vec3 tmpvar_7;
  tmpvar_7 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((_glesNormal * tmpvar_8));
  highp vec2 tmpvar_10;
  tmpvar_10.x = ((tmpvar_7.x * 0.866) + (tmpvar_7.y * 0.5));
  tmpvar_10.y = ((tmpvar_7.z * 0.866) + (tmpvar_7.y * 0.5));
  cUv_2 = ((tmpvar_10 * _CausticTex_ST.xy) + _CausticTex_ST.zw);
  mediump vec2 uv_11;
  uv_11 = cUv_2;
  mediump vec2 distortOffset_12;
  highp float tmpvar_13;
  tmpvar_13 = ((_Time * 20.0) * _Speed).x;
  highp vec2 tmpvar_14;
  tmpvar_14.x = sin((tmpvar_13 + (uv_11.y * 6.28)));
  tmpvar_14.y = sin((tmpvar_13 + (uv_11.x * 6.28)));
  highp vec2 tmpvar_15;
  tmpvar_15 = (tmpvar_14 * vec2(0.025, 0.01));
  distortOffset_12 = tmpvar_15;
  uv_11 = (uv_11 + distortOffset_12);
  uv_11.x = (uv_11.x + (_Time.x * 0.3));
  tmpvar_3 = uv_11;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = tmpvar_9;
  mediump vec4 normal_17;
  normal_17 = tmpvar_16;
  mediump vec3 res_18;
  mediump vec3 x_19;
  x_19.x = dot (unity_SHAr, normal_17);
  x_19.y = dot (unity_SHAg, normal_17);
  x_19.z = dot (unity_SHAb, normal_17);
  mediump vec3 x1_20;
  mediump vec4 tmpvar_21;
  tmpvar_21 = (normal_17.xyzz * normal_17.yzzx);
  x1_20.x = dot (unity_SHBr, tmpvar_21);
  x1_20.y = dot (unity_SHBg, tmpvar_21);
  x1_20.z = dot (unity_SHBb, tmpvar_21);
  res_18 = (x_19 + (x1_20 + (unity_SHC.xyz * 
    ((normal_17.x * normal_17.x) - (normal_17.y * normal_17.y))
  )));
  mediump vec3 tmpvar_22;
  tmpvar_22 = max (((1.055 * 
    pow (max (res_18, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_18 = tmpvar_22;
  shlight_1 = tmpvar_22;
  tmpvar_4 = shlight_1;
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_9;
  xlv_TEXCOORD3 = tmpvar_7;
  xlv_COLOR0 = tmpvar_4;
  xlv_TEXCOORD5 = ((tmpvar_5.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 unity_FogColor;
uniform lowp vec4 _LightColor0;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _CausticTex;
uniform lowp float _CausticIntensity;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_COLOR0;
varying highp float xlv_TEXCOORD5;
void main ()
{
  lowp vec4 caustic_1;
  lowp float diff_2;
  lowp vec3 lightDir_3;
  lowp vec4 col_4;
  mediump vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_4 = tmpvar_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_3 = tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = max (0.0, dot (xlv_TEXCOORD2, lightDir_3));
  diff_2 = tmpvar_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = ((col_4.xyz * _LightColor0.xyz) * diff_2);
  col_4.xyz = (col_4.xyz * xlv_COLOR0);
  col_4.xyz = (col_4.xyz + tmpvar_8);
  mediump vec4 tmpvar_9;
  tmpvar_9 = (_CausticIntensity * texture2D (_CausticTex, xlv_TEXCOORD1));
  caustic_1 = tmpvar_9;
  col_4 = (col_4 + (caustic_1 * diff_2));
  highp float tmpvar_10;
  tmpvar_10 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  col_4.xyz = mix (unity_FogColor.xyz, col_4.xyz, vec3(tmpvar_10));
  gl_FragData[0] = col_4;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_WorldToShadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_FogParams;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _CausticTex_ST;
uniform highp float _Speed;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying lowp vec3 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
void main ()
{
  highp vec3 shlight_1;
  highp vec2 cUv_2;
  highp vec2 tmpvar_3;
  lowp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (glstate_matrix_mvp * tmpvar_6);
  highp vec4 tmpvar_7;
  tmpvar_7 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((_glesNormal * tmpvar_8));
  highp vec2 tmpvar_10;
  tmpvar_10.x = ((tmpvar_7.x * 0.866) + (tmpvar_7.y * 0.5));
  tmpvar_10.y = ((tmpvar_7.z * 0.866) + (tmpvar_7.y * 0.5));
  cUv_2 = ((tmpvar_10 * _CausticTex_ST.xy) + _CausticTex_ST.zw);
  mediump vec2 uv_11;
  uv_11 = cUv_2;
  mediump vec2 distortOffset_12;
  highp float tmpvar_13;
  tmpvar_13 = ((_Time * 20.0) * _Speed).x;
  highp vec2 tmpvar_14;
  tmpvar_14.x = sin((tmpvar_13 + (uv_11.y * 6.28)));
  tmpvar_14.y = sin((tmpvar_13 + (uv_11.x * 6.28)));
  highp vec2 tmpvar_15;
  tmpvar_15 = (tmpvar_14 * vec2(0.025, 0.01));
  distortOffset_12 = tmpvar_15;
  uv_11 = (uv_11 + distortOffset_12);
  uv_11.x = (uv_11.x + (_Time.x * 0.3));
  tmpvar_3 = uv_11;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = tmpvar_9;
  mediump vec4 normal_17;
  normal_17 = tmpvar_16;
  mediump vec3 res_18;
  mediump vec3 x_19;
  x_19.x = dot (unity_SHAr, normal_17);
  x_19.y = dot (unity_SHAg, normal_17);
  x_19.z = dot (unity_SHAb, normal_17);
  mediump vec3 x1_20;
  mediump vec4 tmpvar_21;
  tmpvar_21 = (normal_17.xyzz * normal_17.yzzx);
  x1_20.x = dot (unity_SHBr, tmpvar_21);
  x1_20.y = dot (unity_SHBg, tmpvar_21);
  x1_20.z = dot (unity_SHBb, tmpvar_21);
  res_18 = (x_19 + (x1_20 + (unity_SHC.xyz * 
    ((normal_17.x * normal_17.x) - (normal_17.y * normal_17.y))
  )));
  mediump vec3 tmpvar_22;
  tmpvar_22 = max (((1.055 * 
    pow (max (res_18, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_18 = tmpvar_22;
  shlight_1 = tmpvar_22;
  tmpvar_4 = shlight_1;
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_9;
  xlv_TEXCOORD3 = tmpvar_7.xyz;
  xlv_COLOR0 = tmpvar_4;
  xlv_TEXCOORD4 = (unity_WorldToShadow[0] * tmpvar_7);
  xlv_TEXCOORD5 = ((tmpvar_5.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform mediump vec4 _LightShadowData;
uniform lowp vec4 unity_FogColor;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _ShadowMapTexture;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _CausticTex;
uniform lowp float _CausticIntensity;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
void main ()
{
  lowp vec4 caustic_1;
  lowp float diff_2;
  lowp vec3 lightDir_3;
  lowp vec4 col_4;
  mediump vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_4 = tmpvar_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_3 = tmpvar_6;
  highp float lightShadowDataX_7;
  lowp vec2 outsideOfShadowmap_8;
  lowp vec2 coordCheck_9;
  highp vec2 tmpvar_10;
  tmpvar_10 = abs(((xlv_TEXCOORD4.xy * 2.0) - 1.0));
  coordCheck_9 = tmpvar_10;
  bvec2 tmpvar_11;
  tmpvar_11 = greaterThan (coordCheck_9, vec2(1.0, 1.0));
  lowp float tmpvar_12;
  if (tmpvar_11.x) {
    tmpvar_12 = 1.0;
  } else {
    tmpvar_12 = 0.0;
  };
  lowp float tmpvar_13;
  if (tmpvar_11.y) {
    tmpvar_13 = 1.0;
  } else {
    tmpvar_13 = 0.0;
  };
  lowp vec2 tmpvar_14;
  tmpvar_14.x = tmpvar_12;
  tmpvar_14.y = tmpvar_13;
  outsideOfShadowmap_8.y = tmpvar_14.y;
  outsideOfShadowmap_8.x = (tmpvar_12 + tmpvar_13);
  highp float tmpvar_15;
  if ((xlv_TEXCOORD4.z > 1.0)) {
    tmpvar_15 = 1.0;
  } else {
    tmpvar_15 = 0.0;
  };
  outsideOfShadowmap_8.x = (outsideOfShadowmap_8.x + tmpvar_15);
  mediump float tmpvar_16;
  tmpvar_16 = _LightShadowData.x;
  lightShadowDataX_7 = tmpvar_16;
  lowp float tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = clamp ((max (
    float((texture2D (_ShadowMapTexture, xlv_TEXCOORD4.xy).x > xlv_TEXCOORD4.z))
  , lightShadowDataX_7) + outsideOfShadowmap_8.x), 0.0, 1.0);
  tmpvar_17 = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = max (0.0, dot (xlv_TEXCOORD2, lightDir_3));
  diff_2 = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = ((col_4.xyz * _LightColor0.xyz) * (diff_2 * tmpvar_17));
  col_4.xyz = (col_4.xyz * xlv_COLOR0);
  col_4.xyz = (col_4.xyz + tmpvar_20);
  mediump vec4 tmpvar_21;
  tmpvar_21 = (_CausticIntensity * texture2D (_CausticTex, xlv_TEXCOORD1));
  caustic_1 = tmpvar_21;
  col_4 = (col_4 + ((caustic_1 * diff_2) * (
    (tmpvar_17 * 0.5)
   + 0.5)));
  highp float tmpvar_22;
  tmpvar_22 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  col_4.xyz = mix (unity_FogColor.xyz, col_4.xyz, vec3(tmpvar_22));
  gl_FragData[0] = col_4;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_WorldToShadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_FogParams;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _CausticTex_ST;
uniform highp float _Speed;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying lowp vec3 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
void main ()
{
  highp vec3 shlight_1;
  highp vec2 cUv_2;
  highp vec2 tmpvar_3;
  lowp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (glstate_matrix_mvp * tmpvar_6);
  highp vec4 tmpvar_7;
  tmpvar_7 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((_glesNormal * tmpvar_8));
  highp vec2 tmpvar_10;
  tmpvar_10.x = ((tmpvar_7.x * 0.866) + (tmpvar_7.y * 0.5));
  tmpvar_10.y = ((tmpvar_7.z * 0.866) + (tmpvar_7.y * 0.5));
  cUv_2 = ((tmpvar_10 * _CausticTex_ST.xy) + _CausticTex_ST.zw);
  mediump vec2 uv_11;
  uv_11 = cUv_2;
  mediump vec2 distortOffset_12;
  highp float tmpvar_13;
  tmpvar_13 = ((_Time * 20.0) * _Speed).x;
  highp vec2 tmpvar_14;
  tmpvar_14.x = sin((tmpvar_13 + (uv_11.y * 6.28)));
  tmpvar_14.y = sin((tmpvar_13 + (uv_11.x * 6.28)));
  highp vec2 tmpvar_15;
  tmpvar_15 = (tmpvar_14 * vec2(0.025, 0.01));
  distortOffset_12 = tmpvar_15;
  uv_11 = (uv_11 + distortOffset_12);
  uv_11.x = (uv_11.x + (_Time.x * 0.3));
  tmpvar_3 = uv_11;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = tmpvar_9;
  mediump vec4 normal_17;
  normal_17 = tmpvar_16;
  mediump vec3 res_18;
  mediump vec3 x_19;
  x_19.x = dot (unity_SHAr, normal_17);
  x_19.y = dot (unity_SHAg, normal_17);
  x_19.z = dot (unity_SHAb, normal_17);
  mediump vec3 x1_20;
  mediump vec4 tmpvar_21;
  tmpvar_21 = (normal_17.xyzz * normal_17.yzzx);
  x1_20.x = dot (unity_SHBr, tmpvar_21);
  x1_20.y = dot (unity_SHBg, tmpvar_21);
  x1_20.z = dot (unity_SHBb, tmpvar_21);
  res_18 = (x_19 + (x1_20 + (unity_SHC.xyz * 
    ((normal_17.x * normal_17.x) - (normal_17.y * normal_17.y))
  )));
  mediump vec3 tmpvar_22;
  tmpvar_22 = max (((1.055 * 
    pow (max (res_18, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_18 = tmpvar_22;
  shlight_1 = tmpvar_22;
  tmpvar_4 = shlight_1;
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_9;
  xlv_TEXCOORD3 = tmpvar_7.xyz;
  xlv_COLOR0 = tmpvar_4;
  xlv_TEXCOORD4 = (unity_WorldToShadow[0] * tmpvar_7);
  xlv_TEXCOORD5 = ((tmpvar_5.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform mediump vec4 _LightShadowData;
uniform lowp vec4 unity_FogColor;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _ShadowMapTexture;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _CausticTex;
uniform lowp float _CausticIntensity;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
void main ()
{
  lowp vec4 caustic_1;
  lowp float diff_2;
  lowp vec3 lightDir_3;
  lowp vec4 col_4;
  mediump vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_4 = tmpvar_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_3 = tmpvar_6;
  highp float lightShadowDataX_7;
  lowp vec2 outsideOfShadowmap_8;
  lowp vec2 coordCheck_9;
  highp vec2 tmpvar_10;
  tmpvar_10 = abs(((xlv_TEXCOORD4.xy * 2.0) - 1.0));
  coordCheck_9 = tmpvar_10;
  bvec2 tmpvar_11;
  tmpvar_11 = greaterThan (coordCheck_9, vec2(1.0, 1.0));
  lowp float tmpvar_12;
  if (tmpvar_11.x) {
    tmpvar_12 = 1.0;
  } else {
    tmpvar_12 = 0.0;
  };
  lowp float tmpvar_13;
  if (tmpvar_11.y) {
    tmpvar_13 = 1.0;
  } else {
    tmpvar_13 = 0.0;
  };
  lowp vec2 tmpvar_14;
  tmpvar_14.x = tmpvar_12;
  tmpvar_14.y = tmpvar_13;
  outsideOfShadowmap_8.y = tmpvar_14.y;
  outsideOfShadowmap_8.x = (tmpvar_12 + tmpvar_13);
  highp float tmpvar_15;
  if ((xlv_TEXCOORD4.z > 1.0)) {
    tmpvar_15 = 1.0;
  } else {
    tmpvar_15 = 0.0;
  };
  outsideOfShadowmap_8.x = (outsideOfShadowmap_8.x + tmpvar_15);
  mediump float tmpvar_16;
  tmpvar_16 = _LightShadowData.x;
  lightShadowDataX_7 = tmpvar_16;
  lowp float tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = clamp ((max (
    float((texture2D (_ShadowMapTexture, xlv_TEXCOORD4.xy).x > xlv_TEXCOORD4.z))
  , lightShadowDataX_7) + outsideOfShadowmap_8.x), 0.0, 1.0);
  tmpvar_17 = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = max (0.0, dot (xlv_TEXCOORD2, lightDir_3));
  diff_2 = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = ((col_4.xyz * _LightColor0.xyz) * (diff_2 * tmpvar_17));
  col_4.xyz = (col_4.xyz * xlv_COLOR0);
  col_4.xyz = (col_4.xyz + tmpvar_20);
  mediump vec4 tmpvar_21;
  tmpvar_21 = (_CausticIntensity * texture2D (_CausticTex, xlv_TEXCOORD1));
  caustic_1 = tmpvar_21;
  col_4 = (col_4 + ((caustic_1 * diff_2) * (
    (tmpvar_17 * 0.5)
   + 0.5)));
  highp float tmpvar_22;
  tmpvar_22 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  col_4.xyz = mix (unity_FogColor.xyz, col_4.xyz, vec3(tmpvar_22));
  gl_FragData[0] = col_4;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_WorldToShadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_FogParams;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _CausticTex_ST;
uniform highp float _Speed;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying lowp vec3 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
void main ()
{
  highp vec3 shlight_1;
  highp vec2 cUv_2;
  highp vec2 tmpvar_3;
  lowp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (glstate_matrix_mvp * tmpvar_6);
  highp vec4 tmpvar_7;
  tmpvar_7 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((_glesNormal * tmpvar_8));
  highp vec2 tmpvar_10;
  tmpvar_10.x = ((tmpvar_7.x * 0.866) + (tmpvar_7.y * 0.5));
  tmpvar_10.y = ((tmpvar_7.z * 0.866) + (tmpvar_7.y * 0.5));
  cUv_2 = ((tmpvar_10 * _CausticTex_ST.xy) + _CausticTex_ST.zw);
  mediump vec2 uv_11;
  uv_11 = cUv_2;
  mediump vec2 distortOffset_12;
  highp float tmpvar_13;
  tmpvar_13 = ((_Time * 20.0) * _Speed).x;
  highp vec2 tmpvar_14;
  tmpvar_14.x = sin((tmpvar_13 + (uv_11.y * 6.28)));
  tmpvar_14.y = sin((tmpvar_13 + (uv_11.x * 6.28)));
  highp vec2 tmpvar_15;
  tmpvar_15 = (tmpvar_14 * vec2(0.025, 0.01));
  distortOffset_12 = tmpvar_15;
  uv_11 = (uv_11 + distortOffset_12);
  uv_11.x = (uv_11.x + (_Time.x * 0.3));
  tmpvar_3 = uv_11;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = tmpvar_9;
  mediump vec4 normal_17;
  normal_17 = tmpvar_16;
  mediump vec3 res_18;
  mediump vec3 x_19;
  x_19.x = dot (unity_SHAr, normal_17);
  x_19.y = dot (unity_SHAg, normal_17);
  x_19.z = dot (unity_SHAb, normal_17);
  mediump vec3 x1_20;
  mediump vec4 tmpvar_21;
  tmpvar_21 = (normal_17.xyzz * normal_17.yzzx);
  x1_20.x = dot (unity_SHBr, tmpvar_21);
  x1_20.y = dot (unity_SHBg, tmpvar_21);
  x1_20.z = dot (unity_SHBb, tmpvar_21);
  res_18 = (x_19 + (x1_20 + (unity_SHC.xyz * 
    ((normal_17.x * normal_17.x) - (normal_17.y * normal_17.y))
  )));
  mediump vec3 tmpvar_22;
  tmpvar_22 = max (((1.055 * 
    pow (max (res_18, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_18 = tmpvar_22;
  shlight_1 = tmpvar_22;
  tmpvar_4 = shlight_1;
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_9;
  xlv_TEXCOORD3 = tmpvar_7.xyz;
  xlv_COLOR0 = tmpvar_4;
  xlv_TEXCOORD4 = (unity_WorldToShadow[0] * tmpvar_7);
  xlv_TEXCOORD5 = ((tmpvar_5.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform mediump vec4 _LightShadowData;
uniform lowp vec4 unity_FogColor;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _ShadowMapTexture;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _CausticTex;
uniform lowp float _CausticIntensity;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
void main ()
{
  lowp vec4 caustic_1;
  lowp float diff_2;
  lowp vec3 lightDir_3;
  lowp vec4 col_4;
  mediump vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_4 = tmpvar_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_3 = tmpvar_6;
  highp float lightShadowDataX_7;
  lowp vec2 outsideOfShadowmap_8;
  lowp vec2 coordCheck_9;
  highp vec2 tmpvar_10;
  tmpvar_10 = abs(((xlv_TEXCOORD4.xy * 2.0) - 1.0));
  coordCheck_9 = tmpvar_10;
  bvec2 tmpvar_11;
  tmpvar_11 = greaterThan (coordCheck_9, vec2(1.0, 1.0));
  lowp float tmpvar_12;
  if (tmpvar_11.x) {
    tmpvar_12 = 1.0;
  } else {
    tmpvar_12 = 0.0;
  };
  lowp float tmpvar_13;
  if (tmpvar_11.y) {
    tmpvar_13 = 1.0;
  } else {
    tmpvar_13 = 0.0;
  };
  lowp vec2 tmpvar_14;
  tmpvar_14.x = tmpvar_12;
  tmpvar_14.y = tmpvar_13;
  outsideOfShadowmap_8.y = tmpvar_14.y;
  outsideOfShadowmap_8.x = (tmpvar_12 + tmpvar_13);
  highp float tmpvar_15;
  if ((xlv_TEXCOORD4.z > 1.0)) {
    tmpvar_15 = 1.0;
  } else {
    tmpvar_15 = 0.0;
  };
  outsideOfShadowmap_8.x = (outsideOfShadowmap_8.x + tmpvar_15);
  mediump float tmpvar_16;
  tmpvar_16 = _LightShadowData.x;
  lightShadowDataX_7 = tmpvar_16;
  lowp float tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = clamp ((max (
    float((texture2D (_ShadowMapTexture, xlv_TEXCOORD4.xy).x > xlv_TEXCOORD4.z))
  , lightShadowDataX_7) + outsideOfShadowmap_8.x), 0.0, 1.0);
  tmpvar_17 = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = max (0.0, dot (xlv_TEXCOORD2, lightDir_3));
  diff_2 = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = ((col_4.xyz * _LightColor0.xyz) * (diff_2 * tmpvar_17));
  col_4.xyz = (col_4.xyz * xlv_COLOR0);
  col_4.xyz = (col_4.xyz + tmpvar_20);
  mediump vec4 tmpvar_21;
  tmpvar_21 = (_CausticIntensity * texture2D (_CausticTex, xlv_TEXCOORD1));
  caustic_1 = tmpvar_21;
  col_4 = (col_4 + ((caustic_1 * diff_2) * (
    (tmpvar_17 * 0.5)
   + 0.5)));
  highp float tmpvar_22;
  tmpvar_22 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  col_4.xyz = mix (unity_FogColor.xyz, col_4.xyz, vec3(tmpvar_22));
  gl_FragData[0] = col_4;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_FogParams;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _CausticTex_ST;
uniform highp float _Speed;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying lowp vec3 xlv_COLOR0;
varying highp float xlv_TEXCOORD5;
void main ()
{
  highp vec3 shlight_1;
  highp vec2 cUv_2;
  highp vec2 tmpvar_3;
  lowp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (glstate_matrix_mvp * tmpvar_6);
  highp vec3 tmpvar_7;
  tmpvar_7 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((_glesNormal * tmpvar_8));
  highp vec2 tmpvar_10;
  tmpvar_10.x = ((tmpvar_7.x * 0.866) + (tmpvar_7.y * 0.5));
  tmpvar_10.y = ((tmpvar_7.z * 0.866) + (tmpvar_7.y * 0.5));
  cUv_2 = ((tmpvar_10 * _CausticTex_ST.xy) + _CausticTex_ST.zw);
  mediump vec2 uv_11;
  uv_11 = cUv_2;
  mediump vec2 distortOffset_12;
  highp float tmpvar_13;
  tmpvar_13 = ((_Time * 20.0) * _Speed).x;
  highp vec2 tmpvar_14;
  tmpvar_14.x = sin((tmpvar_13 + (uv_11.y * 6.28)));
  tmpvar_14.y = sin((tmpvar_13 + (uv_11.x * 6.28)));
  highp vec2 tmpvar_15;
  tmpvar_15 = (tmpvar_14 * vec2(0.025, 0.01));
  distortOffset_12 = tmpvar_15;
  uv_11 = (uv_11 + distortOffset_12);
  uv_11.x = (uv_11.x + (_Time.x * 0.3));
  tmpvar_3 = uv_11;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = tmpvar_9;
  mediump vec4 normal_17;
  normal_17 = tmpvar_16;
  mediump vec3 res_18;
  mediump vec3 x_19;
  x_19.x = dot (unity_SHAr, normal_17);
  x_19.y = dot (unity_SHAg, normal_17);
  x_19.z = dot (unity_SHAb, normal_17);
  mediump vec3 x1_20;
  mediump vec4 tmpvar_21;
  tmpvar_21 = (normal_17.xyzz * normal_17.yzzx);
  x1_20.x = dot (unity_SHBr, tmpvar_21);
  x1_20.y = dot (unity_SHBg, tmpvar_21);
  x1_20.z = dot (unity_SHBb, tmpvar_21);
  res_18 = (x_19 + (x1_20 + (unity_SHC.xyz * 
    ((normal_17.x * normal_17.x) - (normal_17.y * normal_17.y))
  )));
  mediump vec3 tmpvar_22;
  tmpvar_22 = max (((1.055 * 
    pow (max (res_18, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_18 = tmpvar_22;
  shlight_1 = tmpvar_22;
  tmpvar_4 = shlight_1;
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_9;
  xlv_TEXCOORD3 = tmpvar_7;
  xlv_COLOR0 = tmpvar_4;
  xlv_TEXCOORD5 = ((tmpvar_5.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 unity_FogColor;
uniform lowp vec4 _LightColor0;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _CausticTex;
uniform lowp float _CausticIntensity;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_COLOR0;
varying highp float xlv_TEXCOORD5;
void main ()
{
  lowp vec4 caustic_1;
  lowp float diff_2;
  lowp vec3 lightDir_3;
  lowp vec4 col_4;
  mediump vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_4 = tmpvar_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_3 = tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = max (0.0, dot (xlv_TEXCOORD2, lightDir_3));
  diff_2 = tmpvar_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = ((col_4.xyz * _LightColor0.xyz) * diff_2);
  col_4.xyz = (col_4.xyz * xlv_COLOR0);
  col_4.xyz = (col_4.xyz + tmpvar_8);
  mediump vec4 tmpvar_9;
  tmpvar_9 = (_CausticIntensity * texture2D (_CausticTex, xlv_TEXCOORD1));
  caustic_1 = tmpvar_9;
  col_4 = (col_4 + (caustic_1 * diff_2));
  highp float tmpvar_10;
  tmpvar_10 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  col_4.xyz = mix (unity_FogColor.xyz, col_4.xyz, vec3(tmpvar_10));
  gl_FragData[0] = col_4;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_FogParams;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _CausticTex_ST;
uniform highp float _Speed;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying lowp vec3 xlv_COLOR0;
varying highp float xlv_TEXCOORD5;
void main ()
{
  highp vec3 shlight_1;
  highp vec2 cUv_2;
  highp vec2 tmpvar_3;
  lowp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (glstate_matrix_mvp * tmpvar_6);
  highp vec3 tmpvar_7;
  tmpvar_7 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((_glesNormal * tmpvar_8));
  highp vec2 tmpvar_10;
  tmpvar_10.x = ((tmpvar_7.x * 0.866) + (tmpvar_7.y * 0.5));
  tmpvar_10.y = ((tmpvar_7.z * 0.866) + (tmpvar_7.y * 0.5));
  cUv_2 = ((tmpvar_10 * _CausticTex_ST.xy) + _CausticTex_ST.zw);
  mediump vec2 uv_11;
  uv_11 = cUv_2;
  mediump vec2 distortOffset_12;
  highp float tmpvar_13;
  tmpvar_13 = ((_Time * 20.0) * _Speed).x;
  highp vec2 tmpvar_14;
  tmpvar_14.x = sin((tmpvar_13 + (uv_11.y * 6.28)));
  tmpvar_14.y = sin((tmpvar_13 + (uv_11.x * 6.28)));
  highp vec2 tmpvar_15;
  tmpvar_15 = (tmpvar_14 * vec2(0.025, 0.01));
  distortOffset_12 = tmpvar_15;
  uv_11 = (uv_11 + distortOffset_12);
  uv_11.x = (uv_11.x + (_Time.x * 0.3));
  tmpvar_3 = uv_11;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = tmpvar_9;
  mediump vec4 normal_17;
  normal_17 = tmpvar_16;
  mediump vec3 res_18;
  mediump vec3 x_19;
  x_19.x = dot (unity_SHAr, normal_17);
  x_19.y = dot (unity_SHAg, normal_17);
  x_19.z = dot (unity_SHAb, normal_17);
  mediump vec3 x1_20;
  mediump vec4 tmpvar_21;
  tmpvar_21 = (normal_17.xyzz * normal_17.yzzx);
  x1_20.x = dot (unity_SHBr, tmpvar_21);
  x1_20.y = dot (unity_SHBg, tmpvar_21);
  x1_20.z = dot (unity_SHBb, tmpvar_21);
  res_18 = (x_19 + (x1_20 + (unity_SHC.xyz * 
    ((normal_17.x * normal_17.x) - (normal_17.y * normal_17.y))
  )));
  mediump vec3 tmpvar_22;
  tmpvar_22 = max (((1.055 * 
    pow (max (res_18, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_18 = tmpvar_22;
  shlight_1 = tmpvar_22;
  tmpvar_4 = shlight_1;
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_9;
  xlv_TEXCOORD3 = tmpvar_7;
  xlv_COLOR0 = tmpvar_4;
  xlv_TEXCOORD5 = ((tmpvar_5.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 unity_FogColor;
uniform lowp vec4 _LightColor0;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _CausticTex;
uniform lowp float _CausticIntensity;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_COLOR0;
varying highp float xlv_TEXCOORD5;
void main ()
{
  lowp vec4 caustic_1;
  lowp float diff_2;
  lowp vec3 lightDir_3;
  lowp vec4 col_4;
  mediump vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_4 = tmpvar_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_3 = tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = max (0.0, dot (xlv_TEXCOORD2, lightDir_3));
  diff_2 = tmpvar_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = ((col_4.xyz * _LightColor0.xyz) * diff_2);
  col_4.xyz = (col_4.xyz * xlv_COLOR0);
  col_4.xyz = (col_4.xyz + tmpvar_8);
  mediump vec4 tmpvar_9;
  tmpvar_9 = (_CausticIntensity * texture2D (_CausticTex, xlv_TEXCOORD1));
  caustic_1 = tmpvar_9;
  col_4 = (col_4 + (caustic_1 * diff_2));
  highp float tmpvar_10;
  tmpvar_10 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  col_4.xyz = mix (unity_FogColor.xyz, col_4.xyz, vec3(tmpvar_10));
  gl_FragData[0] = col_4;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_FogParams;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _CausticTex_ST;
uniform highp float _Speed;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying lowp vec3 xlv_COLOR0;
varying highp float xlv_TEXCOORD5;
void main ()
{
  highp vec3 shlight_1;
  highp vec2 cUv_2;
  highp vec2 tmpvar_3;
  lowp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (glstate_matrix_mvp * tmpvar_6);
  highp vec3 tmpvar_7;
  tmpvar_7 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((_glesNormal * tmpvar_8));
  highp vec2 tmpvar_10;
  tmpvar_10.x = ((tmpvar_7.x * 0.866) + (tmpvar_7.y * 0.5));
  tmpvar_10.y = ((tmpvar_7.z * 0.866) + (tmpvar_7.y * 0.5));
  cUv_2 = ((tmpvar_10 * _CausticTex_ST.xy) + _CausticTex_ST.zw);
  mediump vec2 uv_11;
  uv_11 = cUv_2;
  mediump vec2 distortOffset_12;
  highp float tmpvar_13;
  tmpvar_13 = ((_Time * 20.0) * _Speed).x;
  highp vec2 tmpvar_14;
  tmpvar_14.x = sin((tmpvar_13 + (uv_11.y * 6.28)));
  tmpvar_14.y = sin((tmpvar_13 + (uv_11.x * 6.28)));
  highp vec2 tmpvar_15;
  tmpvar_15 = (tmpvar_14 * vec2(0.025, 0.01));
  distortOffset_12 = tmpvar_15;
  uv_11 = (uv_11 + distortOffset_12);
  uv_11.x = (uv_11.x + (_Time.x * 0.3));
  tmpvar_3 = uv_11;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = tmpvar_9;
  mediump vec4 normal_17;
  normal_17 = tmpvar_16;
  mediump vec3 res_18;
  mediump vec3 x_19;
  x_19.x = dot (unity_SHAr, normal_17);
  x_19.y = dot (unity_SHAg, normal_17);
  x_19.z = dot (unity_SHAb, normal_17);
  mediump vec3 x1_20;
  mediump vec4 tmpvar_21;
  tmpvar_21 = (normal_17.xyzz * normal_17.yzzx);
  x1_20.x = dot (unity_SHBr, tmpvar_21);
  x1_20.y = dot (unity_SHBg, tmpvar_21);
  x1_20.z = dot (unity_SHBb, tmpvar_21);
  res_18 = (x_19 + (x1_20 + (unity_SHC.xyz * 
    ((normal_17.x * normal_17.x) - (normal_17.y * normal_17.y))
  )));
  mediump vec3 tmpvar_22;
  tmpvar_22 = max (((1.055 * 
    pow (max (res_18, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_18 = tmpvar_22;
  shlight_1 = tmpvar_22;
  tmpvar_4 = shlight_1;
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_9;
  xlv_TEXCOORD3 = tmpvar_7;
  xlv_COLOR0 = tmpvar_4;
  xlv_TEXCOORD5 = ((tmpvar_5.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 unity_FogColor;
uniform lowp vec4 _LightColor0;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _CausticTex;
uniform lowp float _CausticIntensity;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_COLOR0;
varying highp float xlv_TEXCOORD5;
void main ()
{
  lowp vec4 caustic_1;
  lowp float diff_2;
  lowp vec3 lightDir_3;
  lowp vec4 col_4;
  mediump vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_4 = tmpvar_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_3 = tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = max (0.0, dot (xlv_TEXCOORD2, lightDir_3));
  diff_2 = tmpvar_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = ((col_4.xyz * _LightColor0.xyz) * diff_2);
  col_4.xyz = (col_4.xyz * xlv_COLOR0);
  col_4.xyz = (col_4.xyz + tmpvar_8);
  mediump vec4 tmpvar_9;
  tmpvar_9 = (_CausticIntensity * texture2D (_CausticTex, xlv_TEXCOORD1));
  caustic_1 = tmpvar_9;
  col_4 = (col_4 + (caustic_1 * diff_2));
  highp float tmpvar_10;
  tmpvar_10 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  col_4.xyz = mix (unity_FogColor.xyz, col_4.xyz, vec3(tmpvar_10));
  gl_FragData[0] = col_4;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "FOG_LINEAR" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_WorldToShadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_FogParams;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _CausticTex_ST;
uniform highp float _Speed;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying lowp vec3 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
void main ()
{
  highp vec3 shlight_1;
  highp vec2 cUv_2;
  highp vec2 tmpvar_3;
  lowp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (glstate_matrix_mvp * tmpvar_6);
  highp vec4 tmpvar_7;
  tmpvar_7 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((_glesNormal * tmpvar_8));
  highp vec2 tmpvar_10;
  tmpvar_10.x = ((tmpvar_7.x * 0.866) + (tmpvar_7.y * 0.5));
  tmpvar_10.y = ((tmpvar_7.z * 0.866) + (tmpvar_7.y * 0.5));
  cUv_2 = ((tmpvar_10 * _CausticTex_ST.xy) + _CausticTex_ST.zw);
  mediump vec2 uv_11;
  uv_11 = cUv_2;
  mediump vec2 distortOffset_12;
  highp float tmpvar_13;
  tmpvar_13 = ((_Time * 20.0) * _Speed).x;
  highp vec2 tmpvar_14;
  tmpvar_14.x = sin((tmpvar_13 + (uv_11.y * 6.28)));
  tmpvar_14.y = sin((tmpvar_13 + (uv_11.x * 6.28)));
  highp vec2 tmpvar_15;
  tmpvar_15 = (tmpvar_14 * vec2(0.025, 0.01));
  distortOffset_12 = tmpvar_15;
  uv_11 = (uv_11 + distortOffset_12);
  uv_11.x = (uv_11.x + (_Time.x * 0.3));
  tmpvar_3 = uv_11;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = tmpvar_9;
  mediump vec4 normal_17;
  normal_17 = tmpvar_16;
  mediump vec3 res_18;
  mediump vec3 x_19;
  x_19.x = dot (unity_SHAr, normal_17);
  x_19.y = dot (unity_SHAg, normal_17);
  x_19.z = dot (unity_SHAb, normal_17);
  mediump vec3 x1_20;
  mediump vec4 tmpvar_21;
  tmpvar_21 = (normal_17.xyzz * normal_17.yzzx);
  x1_20.x = dot (unity_SHBr, tmpvar_21);
  x1_20.y = dot (unity_SHBg, tmpvar_21);
  x1_20.z = dot (unity_SHBb, tmpvar_21);
  res_18 = (x_19 + (x1_20 + (unity_SHC.xyz * 
    ((normal_17.x * normal_17.x) - (normal_17.y * normal_17.y))
  )));
  mediump vec3 tmpvar_22;
  tmpvar_22 = max (((1.055 * 
    pow (max (res_18, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_18 = tmpvar_22;
  shlight_1 = tmpvar_22;
  tmpvar_4 = shlight_1;
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_9;
  xlv_TEXCOORD3 = tmpvar_7.xyz;
  xlv_COLOR0 = tmpvar_4;
  xlv_TEXCOORD4 = (unity_WorldToShadow[0] * tmpvar_7);
  xlv_TEXCOORD5 = ((tmpvar_5.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform mediump vec4 _LightShadowData;
uniform lowp vec4 unity_FogColor;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _ShadowMapTexture;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _CausticTex;
uniform lowp float _CausticIntensity;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
void main ()
{
  lowp vec4 caustic_1;
  lowp float diff_2;
  lowp vec3 lightDir_3;
  lowp vec4 col_4;
  mediump vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_4 = tmpvar_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_3 = tmpvar_6;
  highp float lightShadowDataX_7;
  lowp vec2 outsideOfShadowmap_8;
  lowp vec2 coordCheck_9;
  highp vec2 tmpvar_10;
  tmpvar_10 = abs(((xlv_TEXCOORD4.xy * 2.0) - 1.0));
  coordCheck_9 = tmpvar_10;
  bvec2 tmpvar_11;
  tmpvar_11 = greaterThan (coordCheck_9, vec2(1.0, 1.0));
  lowp float tmpvar_12;
  if (tmpvar_11.x) {
    tmpvar_12 = 1.0;
  } else {
    tmpvar_12 = 0.0;
  };
  lowp float tmpvar_13;
  if (tmpvar_11.y) {
    tmpvar_13 = 1.0;
  } else {
    tmpvar_13 = 0.0;
  };
  lowp vec2 tmpvar_14;
  tmpvar_14.x = tmpvar_12;
  tmpvar_14.y = tmpvar_13;
  outsideOfShadowmap_8.y = tmpvar_14.y;
  outsideOfShadowmap_8.x = (tmpvar_12 + tmpvar_13);
  highp float tmpvar_15;
  if ((xlv_TEXCOORD4.z > 1.0)) {
    tmpvar_15 = 1.0;
  } else {
    tmpvar_15 = 0.0;
  };
  outsideOfShadowmap_8.x = (outsideOfShadowmap_8.x + tmpvar_15);
  mediump float tmpvar_16;
  tmpvar_16 = _LightShadowData.x;
  lightShadowDataX_7 = tmpvar_16;
  lowp float tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = clamp ((max (
    float((texture2D (_ShadowMapTexture, xlv_TEXCOORD4.xy).x > xlv_TEXCOORD4.z))
  , lightShadowDataX_7) + outsideOfShadowmap_8.x), 0.0, 1.0);
  tmpvar_17 = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = max (0.0, dot (xlv_TEXCOORD2, lightDir_3));
  diff_2 = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = ((col_4.xyz * _LightColor0.xyz) * (diff_2 * tmpvar_17));
  col_4.xyz = (col_4.xyz * xlv_COLOR0);
  col_4.xyz = (col_4.xyz + tmpvar_20);
  mediump vec4 tmpvar_21;
  tmpvar_21 = (_CausticIntensity * texture2D (_CausticTex, xlv_TEXCOORD1));
  caustic_1 = tmpvar_21;
  col_4 = (col_4 + ((caustic_1 * diff_2) * (
    (tmpvar_17 * 0.5)
   + 0.5)));
  highp float tmpvar_22;
  tmpvar_22 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  col_4.xyz = mix (unity_FogColor.xyz, col_4.xyz, vec3(tmpvar_22));
  gl_FragData[0] = col_4;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "FOG_LINEAR" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_WorldToShadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_FogParams;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _CausticTex_ST;
uniform highp float _Speed;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying lowp vec3 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
void main ()
{
  highp vec3 shlight_1;
  highp vec2 cUv_2;
  highp vec2 tmpvar_3;
  lowp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (glstate_matrix_mvp * tmpvar_6);
  highp vec4 tmpvar_7;
  tmpvar_7 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((_glesNormal * tmpvar_8));
  highp vec2 tmpvar_10;
  tmpvar_10.x = ((tmpvar_7.x * 0.866) + (tmpvar_7.y * 0.5));
  tmpvar_10.y = ((tmpvar_7.z * 0.866) + (tmpvar_7.y * 0.5));
  cUv_2 = ((tmpvar_10 * _CausticTex_ST.xy) + _CausticTex_ST.zw);
  mediump vec2 uv_11;
  uv_11 = cUv_2;
  mediump vec2 distortOffset_12;
  highp float tmpvar_13;
  tmpvar_13 = ((_Time * 20.0) * _Speed).x;
  highp vec2 tmpvar_14;
  tmpvar_14.x = sin((tmpvar_13 + (uv_11.y * 6.28)));
  tmpvar_14.y = sin((tmpvar_13 + (uv_11.x * 6.28)));
  highp vec2 tmpvar_15;
  tmpvar_15 = (tmpvar_14 * vec2(0.025, 0.01));
  distortOffset_12 = tmpvar_15;
  uv_11 = (uv_11 + distortOffset_12);
  uv_11.x = (uv_11.x + (_Time.x * 0.3));
  tmpvar_3 = uv_11;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = tmpvar_9;
  mediump vec4 normal_17;
  normal_17 = tmpvar_16;
  mediump vec3 res_18;
  mediump vec3 x_19;
  x_19.x = dot (unity_SHAr, normal_17);
  x_19.y = dot (unity_SHAg, normal_17);
  x_19.z = dot (unity_SHAb, normal_17);
  mediump vec3 x1_20;
  mediump vec4 tmpvar_21;
  tmpvar_21 = (normal_17.xyzz * normal_17.yzzx);
  x1_20.x = dot (unity_SHBr, tmpvar_21);
  x1_20.y = dot (unity_SHBg, tmpvar_21);
  x1_20.z = dot (unity_SHBb, tmpvar_21);
  res_18 = (x_19 + (x1_20 + (unity_SHC.xyz * 
    ((normal_17.x * normal_17.x) - (normal_17.y * normal_17.y))
  )));
  mediump vec3 tmpvar_22;
  tmpvar_22 = max (((1.055 * 
    pow (max (res_18, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_18 = tmpvar_22;
  shlight_1 = tmpvar_22;
  tmpvar_4 = shlight_1;
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_9;
  xlv_TEXCOORD3 = tmpvar_7.xyz;
  xlv_COLOR0 = tmpvar_4;
  xlv_TEXCOORD4 = (unity_WorldToShadow[0] * tmpvar_7);
  xlv_TEXCOORD5 = ((tmpvar_5.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform mediump vec4 _LightShadowData;
uniform lowp vec4 unity_FogColor;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _ShadowMapTexture;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _CausticTex;
uniform lowp float _CausticIntensity;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
void main ()
{
  lowp vec4 caustic_1;
  lowp float diff_2;
  lowp vec3 lightDir_3;
  lowp vec4 col_4;
  mediump vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_4 = tmpvar_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_3 = tmpvar_6;
  highp float lightShadowDataX_7;
  lowp vec2 outsideOfShadowmap_8;
  lowp vec2 coordCheck_9;
  highp vec2 tmpvar_10;
  tmpvar_10 = abs(((xlv_TEXCOORD4.xy * 2.0) - 1.0));
  coordCheck_9 = tmpvar_10;
  bvec2 tmpvar_11;
  tmpvar_11 = greaterThan (coordCheck_9, vec2(1.0, 1.0));
  lowp float tmpvar_12;
  if (tmpvar_11.x) {
    tmpvar_12 = 1.0;
  } else {
    tmpvar_12 = 0.0;
  };
  lowp float tmpvar_13;
  if (tmpvar_11.y) {
    tmpvar_13 = 1.0;
  } else {
    tmpvar_13 = 0.0;
  };
  lowp vec2 tmpvar_14;
  tmpvar_14.x = tmpvar_12;
  tmpvar_14.y = tmpvar_13;
  outsideOfShadowmap_8.y = tmpvar_14.y;
  outsideOfShadowmap_8.x = (tmpvar_12 + tmpvar_13);
  highp float tmpvar_15;
  if ((xlv_TEXCOORD4.z > 1.0)) {
    tmpvar_15 = 1.0;
  } else {
    tmpvar_15 = 0.0;
  };
  outsideOfShadowmap_8.x = (outsideOfShadowmap_8.x + tmpvar_15);
  mediump float tmpvar_16;
  tmpvar_16 = _LightShadowData.x;
  lightShadowDataX_7 = tmpvar_16;
  lowp float tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = clamp ((max (
    float((texture2D (_ShadowMapTexture, xlv_TEXCOORD4.xy).x > xlv_TEXCOORD4.z))
  , lightShadowDataX_7) + outsideOfShadowmap_8.x), 0.0, 1.0);
  tmpvar_17 = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = max (0.0, dot (xlv_TEXCOORD2, lightDir_3));
  diff_2 = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = ((col_4.xyz * _LightColor0.xyz) * (diff_2 * tmpvar_17));
  col_4.xyz = (col_4.xyz * xlv_COLOR0);
  col_4.xyz = (col_4.xyz + tmpvar_20);
  mediump vec4 tmpvar_21;
  tmpvar_21 = (_CausticIntensity * texture2D (_CausticTex, xlv_TEXCOORD1));
  caustic_1 = tmpvar_21;
  col_4 = (col_4 + ((caustic_1 * diff_2) * (
    (tmpvar_17 * 0.5)
   + 0.5)));
  highp float tmpvar_22;
  tmpvar_22 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  col_4.xyz = mix (unity_FogColor.xyz, col_4.xyz, vec3(tmpvar_22));
  gl_FragData[0] = col_4;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "FOG_LINEAR" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_WorldToShadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_FogParams;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _CausticTex_ST;
uniform highp float _Speed;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying lowp vec3 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
void main ()
{
  highp vec3 shlight_1;
  highp vec2 cUv_2;
  highp vec2 tmpvar_3;
  lowp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (glstate_matrix_mvp * tmpvar_6);
  highp vec4 tmpvar_7;
  tmpvar_7 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((_glesNormal * tmpvar_8));
  highp vec2 tmpvar_10;
  tmpvar_10.x = ((tmpvar_7.x * 0.866) + (tmpvar_7.y * 0.5));
  tmpvar_10.y = ((tmpvar_7.z * 0.866) + (tmpvar_7.y * 0.5));
  cUv_2 = ((tmpvar_10 * _CausticTex_ST.xy) + _CausticTex_ST.zw);
  mediump vec2 uv_11;
  uv_11 = cUv_2;
  mediump vec2 distortOffset_12;
  highp float tmpvar_13;
  tmpvar_13 = ((_Time * 20.0) * _Speed).x;
  highp vec2 tmpvar_14;
  tmpvar_14.x = sin((tmpvar_13 + (uv_11.y * 6.28)));
  tmpvar_14.y = sin((tmpvar_13 + (uv_11.x * 6.28)));
  highp vec2 tmpvar_15;
  tmpvar_15 = (tmpvar_14 * vec2(0.025, 0.01));
  distortOffset_12 = tmpvar_15;
  uv_11 = (uv_11 + distortOffset_12);
  uv_11.x = (uv_11.x + (_Time.x * 0.3));
  tmpvar_3 = uv_11;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = tmpvar_9;
  mediump vec4 normal_17;
  normal_17 = tmpvar_16;
  mediump vec3 res_18;
  mediump vec3 x_19;
  x_19.x = dot (unity_SHAr, normal_17);
  x_19.y = dot (unity_SHAg, normal_17);
  x_19.z = dot (unity_SHAb, normal_17);
  mediump vec3 x1_20;
  mediump vec4 tmpvar_21;
  tmpvar_21 = (normal_17.xyzz * normal_17.yzzx);
  x1_20.x = dot (unity_SHBr, tmpvar_21);
  x1_20.y = dot (unity_SHBg, tmpvar_21);
  x1_20.z = dot (unity_SHBb, tmpvar_21);
  res_18 = (x_19 + (x1_20 + (unity_SHC.xyz * 
    ((normal_17.x * normal_17.x) - (normal_17.y * normal_17.y))
  )));
  mediump vec3 tmpvar_22;
  tmpvar_22 = max (((1.055 * 
    pow (max (res_18, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_18 = tmpvar_22;
  shlight_1 = tmpvar_22;
  tmpvar_4 = shlight_1;
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_9;
  xlv_TEXCOORD3 = tmpvar_7.xyz;
  xlv_COLOR0 = tmpvar_4;
  xlv_TEXCOORD4 = (unity_WorldToShadow[0] * tmpvar_7);
  xlv_TEXCOORD5 = ((tmpvar_5.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform mediump vec4 _LightShadowData;
uniform lowp vec4 unity_FogColor;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _ShadowMapTexture;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _CausticTex;
uniform lowp float _CausticIntensity;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
void main ()
{
  lowp vec4 caustic_1;
  lowp float diff_2;
  lowp vec3 lightDir_3;
  lowp vec4 col_4;
  mediump vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_4 = tmpvar_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_3 = tmpvar_6;
  highp float lightShadowDataX_7;
  lowp vec2 outsideOfShadowmap_8;
  lowp vec2 coordCheck_9;
  highp vec2 tmpvar_10;
  tmpvar_10 = abs(((xlv_TEXCOORD4.xy * 2.0) - 1.0));
  coordCheck_9 = tmpvar_10;
  bvec2 tmpvar_11;
  tmpvar_11 = greaterThan (coordCheck_9, vec2(1.0, 1.0));
  lowp float tmpvar_12;
  if (tmpvar_11.x) {
    tmpvar_12 = 1.0;
  } else {
    tmpvar_12 = 0.0;
  };
  lowp float tmpvar_13;
  if (tmpvar_11.y) {
    tmpvar_13 = 1.0;
  } else {
    tmpvar_13 = 0.0;
  };
  lowp vec2 tmpvar_14;
  tmpvar_14.x = tmpvar_12;
  tmpvar_14.y = tmpvar_13;
  outsideOfShadowmap_8.y = tmpvar_14.y;
  outsideOfShadowmap_8.x = (tmpvar_12 + tmpvar_13);
  highp float tmpvar_15;
  if ((xlv_TEXCOORD4.z > 1.0)) {
    tmpvar_15 = 1.0;
  } else {
    tmpvar_15 = 0.0;
  };
  outsideOfShadowmap_8.x = (outsideOfShadowmap_8.x + tmpvar_15);
  mediump float tmpvar_16;
  tmpvar_16 = _LightShadowData.x;
  lightShadowDataX_7 = tmpvar_16;
  lowp float tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = clamp ((max (
    float((texture2D (_ShadowMapTexture, xlv_TEXCOORD4.xy).x > xlv_TEXCOORD4.z))
  , lightShadowDataX_7) + outsideOfShadowmap_8.x), 0.0, 1.0);
  tmpvar_17 = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = max (0.0, dot (xlv_TEXCOORD2, lightDir_3));
  diff_2 = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = ((col_4.xyz * _LightColor0.xyz) * (diff_2 * tmpvar_17));
  col_4.xyz = (col_4.xyz * xlv_COLOR0);
  col_4.xyz = (col_4.xyz + tmpvar_20);
  mediump vec4 tmpvar_21;
  tmpvar_21 = (_CausticIntensity * texture2D (_CausticTex, xlv_TEXCOORD1));
  caustic_1 = tmpvar_21;
  col_4 = (col_4 + ((caustic_1 * diff_2) * (
    (tmpvar_17 * 0.5)
   + 0.5)));
  highp float tmpvar_22;
  tmpvar_22 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  col_4.xyz = mix (unity_FogColor.xyz, col_4.xyz, vec3(tmpvar_22));
  gl_FragData[0] = col_4;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "TINT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _CausticTex_ST;
uniform highp float _Speed;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying lowp vec3 xlv_COLOR0;
void main ()
{
  highp vec3 shlight_1;
  highp vec2 cUv_2;
  highp vec2 tmpvar_3;
  lowp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  highp vec3 tmpvar_6;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = unity_WorldToObject[0].xyz;
  tmpvar_7[1] = unity_WorldToObject[1].xyz;
  tmpvar_7[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize((_glesNormal * tmpvar_7));
  highp vec2 tmpvar_9;
  tmpvar_9.x = ((tmpvar_6.x * 0.866) + (tmpvar_6.y * 0.5));
  tmpvar_9.y = ((tmpvar_6.z * 0.866) + (tmpvar_6.y * 0.5));
  cUv_2 = ((tmpvar_9 * _CausticTex_ST.xy) + _CausticTex_ST.zw);
  mediump vec2 uv_10;
  uv_10 = cUv_2;
  mediump vec2 distortOffset_11;
  highp float tmpvar_12;
  tmpvar_12 = ((_Time * 20.0) * _Speed).x;
  highp vec2 tmpvar_13;
  tmpvar_13.x = sin((tmpvar_12 + (uv_10.y * 6.28)));
  tmpvar_13.y = sin((tmpvar_12 + (uv_10.x * 6.28)));
  highp vec2 tmpvar_14;
  tmpvar_14 = (tmpvar_13 * vec2(0.025, 0.01));
  distortOffset_11 = tmpvar_14;
  uv_10 = (uv_10 + distortOffset_11);
  uv_10.x = (uv_10.x + (_Time.x * 0.3));
  tmpvar_3 = uv_10;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = tmpvar_8;
  mediump vec4 normal_16;
  normal_16 = tmpvar_15;
  mediump vec3 res_17;
  mediump vec3 x_18;
  x_18.x = dot (unity_SHAr, normal_16);
  x_18.y = dot (unity_SHAg, normal_16);
  x_18.z = dot (unity_SHAb, normal_16);
  mediump vec3 x1_19;
  mediump vec4 tmpvar_20;
  tmpvar_20 = (normal_16.xyzz * normal_16.yzzx);
  x1_19.x = dot (unity_SHBr, tmpvar_20);
  x1_19.y = dot (unity_SHBg, tmpvar_20);
  x1_19.z = dot (unity_SHBb, tmpvar_20);
  res_17 = (x_18 + (x1_19 + (unity_SHC.xyz * 
    ((normal_16.x * normal_16.x) - (normal_16.y * normal_16.y))
  )));
  mediump vec3 tmpvar_21;
  tmpvar_21 = max (((1.055 * 
    pow (max (res_17, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_17 = tmpvar_21;
  shlight_1 = tmpvar_21;
  tmpvar_4 = shlight_1;
  gl_Position = (glstate_matrix_mvp * tmpvar_5);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_8;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_COLOR0 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _CausticTex;
uniform lowp vec4 _WaterColor;
uniform lowp float _CausticIntensity;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_COLOR0;
void main ()
{
  lowp vec4 caustic_1;
  lowp float diff_2;
  lowp vec3 lightDir_3;
  lowp vec4 col_4;
  mediump vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_4 = tmpvar_5;
  col_4.xyz = mix (col_4.xyz, (col_4.xyz * _WaterColor.xyz), _WaterColor.www);
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_3 = tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = max (0.0, dot (xlv_TEXCOORD2, lightDir_3));
  diff_2 = tmpvar_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = ((col_4.xyz * _LightColor0.xyz) * diff_2);
  col_4.xyz = (col_4.xyz * xlv_COLOR0);
  col_4.xyz = (col_4.xyz + tmpvar_8);
  mediump vec4 tmpvar_9;
  tmpvar_9 = (_CausticIntensity * texture2D (_CausticTex, xlv_TEXCOORD1));
  caustic_1 = tmpvar_9;
  caustic_1.xyz = mix (caustic_1.xyz, (caustic_1.xyz * _WaterColor.xyz), _WaterColor.www);
  col_4 = (col_4 + (caustic_1 * diff_2));
  gl_FragData[0] = col_4;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "TINT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _CausticTex_ST;
uniform highp float _Speed;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying lowp vec3 xlv_COLOR0;
void main ()
{
  highp vec3 shlight_1;
  highp vec2 cUv_2;
  highp vec2 tmpvar_3;
  lowp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  highp vec3 tmpvar_6;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = unity_WorldToObject[0].xyz;
  tmpvar_7[1] = unity_WorldToObject[1].xyz;
  tmpvar_7[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize((_glesNormal * tmpvar_7));
  highp vec2 tmpvar_9;
  tmpvar_9.x = ((tmpvar_6.x * 0.866) + (tmpvar_6.y * 0.5));
  tmpvar_9.y = ((tmpvar_6.z * 0.866) + (tmpvar_6.y * 0.5));
  cUv_2 = ((tmpvar_9 * _CausticTex_ST.xy) + _CausticTex_ST.zw);
  mediump vec2 uv_10;
  uv_10 = cUv_2;
  mediump vec2 distortOffset_11;
  highp float tmpvar_12;
  tmpvar_12 = ((_Time * 20.0) * _Speed).x;
  highp vec2 tmpvar_13;
  tmpvar_13.x = sin((tmpvar_12 + (uv_10.y * 6.28)));
  tmpvar_13.y = sin((tmpvar_12 + (uv_10.x * 6.28)));
  highp vec2 tmpvar_14;
  tmpvar_14 = (tmpvar_13 * vec2(0.025, 0.01));
  distortOffset_11 = tmpvar_14;
  uv_10 = (uv_10 + distortOffset_11);
  uv_10.x = (uv_10.x + (_Time.x * 0.3));
  tmpvar_3 = uv_10;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = tmpvar_8;
  mediump vec4 normal_16;
  normal_16 = tmpvar_15;
  mediump vec3 res_17;
  mediump vec3 x_18;
  x_18.x = dot (unity_SHAr, normal_16);
  x_18.y = dot (unity_SHAg, normal_16);
  x_18.z = dot (unity_SHAb, normal_16);
  mediump vec3 x1_19;
  mediump vec4 tmpvar_20;
  tmpvar_20 = (normal_16.xyzz * normal_16.yzzx);
  x1_19.x = dot (unity_SHBr, tmpvar_20);
  x1_19.y = dot (unity_SHBg, tmpvar_20);
  x1_19.z = dot (unity_SHBb, tmpvar_20);
  res_17 = (x_18 + (x1_19 + (unity_SHC.xyz * 
    ((normal_16.x * normal_16.x) - (normal_16.y * normal_16.y))
  )));
  mediump vec3 tmpvar_21;
  tmpvar_21 = max (((1.055 * 
    pow (max (res_17, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_17 = tmpvar_21;
  shlight_1 = tmpvar_21;
  tmpvar_4 = shlight_1;
  gl_Position = (glstate_matrix_mvp * tmpvar_5);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_8;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_COLOR0 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _CausticTex;
uniform lowp vec4 _WaterColor;
uniform lowp float _CausticIntensity;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_COLOR0;
void main ()
{
  lowp vec4 caustic_1;
  lowp float diff_2;
  lowp vec3 lightDir_3;
  lowp vec4 col_4;
  mediump vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_4 = tmpvar_5;
  col_4.xyz = mix (col_4.xyz, (col_4.xyz * _WaterColor.xyz), _WaterColor.www);
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_3 = tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = max (0.0, dot (xlv_TEXCOORD2, lightDir_3));
  diff_2 = tmpvar_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = ((col_4.xyz * _LightColor0.xyz) * diff_2);
  col_4.xyz = (col_4.xyz * xlv_COLOR0);
  col_4.xyz = (col_4.xyz + tmpvar_8);
  mediump vec4 tmpvar_9;
  tmpvar_9 = (_CausticIntensity * texture2D (_CausticTex, xlv_TEXCOORD1));
  caustic_1 = tmpvar_9;
  caustic_1.xyz = mix (caustic_1.xyz, (caustic_1.xyz * _WaterColor.xyz), _WaterColor.www);
  col_4 = (col_4 + (caustic_1 * diff_2));
  gl_FragData[0] = col_4;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "TINT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _CausticTex_ST;
uniform highp float _Speed;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying lowp vec3 xlv_COLOR0;
void main ()
{
  highp vec3 shlight_1;
  highp vec2 cUv_2;
  highp vec2 tmpvar_3;
  lowp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  highp vec3 tmpvar_6;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = unity_WorldToObject[0].xyz;
  tmpvar_7[1] = unity_WorldToObject[1].xyz;
  tmpvar_7[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize((_glesNormal * tmpvar_7));
  highp vec2 tmpvar_9;
  tmpvar_9.x = ((tmpvar_6.x * 0.866) + (tmpvar_6.y * 0.5));
  tmpvar_9.y = ((tmpvar_6.z * 0.866) + (tmpvar_6.y * 0.5));
  cUv_2 = ((tmpvar_9 * _CausticTex_ST.xy) + _CausticTex_ST.zw);
  mediump vec2 uv_10;
  uv_10 = cUv_2;
  mediump vec2 distortOffset_11;
  highp float tmpvar_12;
  tmpvar_12 = ((_Time * 20.0) * _Speed).x;
  highp vec2 tmpvar_13;
  tmpvar_13.x = sin((tmpvar_12 + (uv_10.y * 6.28)));
  tmpvar_13.y = sin((tmpvar_12 + (uv_10.x * 6.28)));
  highp vec2 tmpvar_14;
  tmpvar_14 = (tmpvar_13 * vec2(0.025, 0.01));
  distortOffset_11 = tmpvar_14;
  uv_10 = (uv_10 + distortOffset_11);
  uv_10.x = (uv_10.x + (_Time.x * 0.3));
  tmpvar_3 = uv_10;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = tmpvar_8;
  mediump vec4 normal_16;
  normal_16 = tmpvar_15;
  mediump vec3 res_17;
  mediump vec3 x_18;
  x_18.x = dot (unity_SHAr, normal_16);
  x_18.y = dot (unity_SHAg, normal_16);
  x_18.z = dot (unity_SHAb, normal_16);
  mediump vec3 x1_19;
  mediump vec4 tmpvar_20;
  tmpvar_20 = (normal_16.xyzz * normal_16.yzzx);
  x1_19.x = dot (unity_SHBr, tmpvar_20);
  x1_19.y = dot (unity_SHBg, tmpvar_20);
  x1_19.z = dot (unity_SHBb, tmpvar_20);
  res_17 = (x_18 + (x1_19 + (unity_SHC.xyz * 
    ((normal_16.x * normal_16.x) - (normal_16.y * normal_16.y))
  )));
  mediump vec3 tmpvar_21;
  tmpvar_21 = max (((1.055 * 
    pow (max (res_17, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_17 = tmpvar_21;
  shlight_1 = tmpvar_21;
  tmpvar_4 = shlight_1;
  gl_Position = (glstate_matrix_mvp * tmpvar_5);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_8;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_COLOR0 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _CausticTex;
uniform lowp vec4 _WaterColor;
uniform lowp float _CausticIntensity;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_COLOR0;
void main ()
{
  lowp vec4 caustic_1;
  lowp float diff_2;
  lowp vec3 lightDir_3;
  lowp vec4 col_4;
  mediump vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_4 = tmpvar_5;
  col_4.xyz = mix (col_4.xyz, (col_4.xyz * _WaterColor.xyz), _WaterColor.www);
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_3 = tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = max (0.0, dot (xlv_TEXCOORD2, lightDir_3));
  diff_2 = tmpvar_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = ((col_4.xyz * _LightColor0.xyz) * diff_2);
  col_4.xyz = (col_4.xyz * xlv_COLOR0);
  col_4.xyz = (col_4.xyz + tmpvar_8);
  mediump vec4 tmpvar_9;
  tmpvar_9 = (_CausticIntensity * texture2D (_CausticTex, xlv_TEXCOORD1));
  caustic_1 = tmpvar_9;
  caustic_1.xyz = mix (caustic_1.xyz, (caustic_1.xyz * _WaterColor.xyz), _WaterColor.www);
  col_4 = (col_4 + (caustic_1 * diff_2));
  gl_FragData[0] = col_4;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "TINT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_WorldToShadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _CausticTex_ST;
uniform highp float _Speed;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying lowp vec3 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  highp vec3 shlight_1;
  highp vec2 cUv_2;
  highp vec2 tmpvar_3;
  lowp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  highp vec4 tmpvar_6;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_7;
  tmpvar_7[0] = unity_WorldToObject[0].xyz;
  tmpvar_7[1] = unity_WorldToObject[1].xyz;
  tmpvar_7[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize((_glesNormal * tmpvar_7));
  highp vec2 tmpvar_9;
  tmpvar_9.x = ((tmpvar_6.x * 0.866) + (tmpvar_6.y * 0.5));
  tmpvar_9.y = ((tmpvar_6.z * 0.866) + (tmpvar_6.y * 0.5));
  cUv_2 = ((tmpvar_9 * _CausticTex_ST.xy) + _CausticTex_ST.zw);
  mediump vec2 uv_10;
  uv_10 = cUv_2;
  mediump vec2 distortOffset_11;
  highp float tmpvar_12;
  tmpvar_12 = ((_Time * 20.0) * _Speed).x;
  highp vec2 tmpvar_13;
  tmpvar_13.x = sin((tmpvar_12 + (uv_10.y * 6.28)));
  tmpvar_13.y = sin((tmpvar_12 + (uv_10.x * 6.28)));
  highp vec2 tmpvar_14;
  tmpvar_14 = (tmpvar_13 * vec2(0.025, 0.01));
  distortOffset_11 = tmpvar_14;
  uv_10 = (uv_10 + distortOffset_11);
  uv_10.x = (uv_10.x + (_Time.x * 0.3));
  tmpvar_3 = uv_10;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = tmpvar_8;
  mediump vec4 normal_16;
  normal_16 = tmpvar_15;
  mediump vec3 res_17;
  mediump vec3 x_18;
  x_18.x = dot (unity_SHAr, normal_16);
  x_18.y = dot (unity_SHAg, normal_16);
  x_18.z = dot (unity_SHAb, normal_16);
  mediump vec3 x1_19;
  mediump vec4 tmpvar_20;
  tmpvar_20 = (normal_16.xyzz * normal_16.yzzx);
  x1_19.x = dot (unity_SHBr, tmpvar_20);
  x1_19.y = dot (unity_SHBg, tmpvar_20);
  x1_19.z = dot (unity_SHBb, tmpvar_20);
  res_17 = (x_18 + (x1_19 + (unity_SHC.xyz * 
    ((normal_16.x * normal_16.x) - (normal_16.y * normal_16.y))
  )));
  mediump vec3 tmpvar_21;
  tmpvar_21 = max (((1.055 * 
    pow (max (res_17, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_17 = tmpvar_21;
  shlight_1 = tmpvar_21;
  tmpvar_4 = shlight_1;
  gl_Position = (glstate_matrix_mvp * tmpvar_5);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_8;
  xlv_TEXCOORD3 = tmpvar_6.xyz;
  xlv_COLOR0 = tmpvar_4;
  xlv_TEXCOORD4 = (unity_WorldToShadow[0] * tmpvar_6);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform mediump vec4 _LightShadowData;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _ShadowMapTexture;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _CausticTex;
uniform lowp vec4 _WaterColor;
uniform lowp float _CausticIntensity;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 caustic_1;
  lowp float diff_2;
  lowp vec3 lightDir_3;
  lowp vec4 col_4;
  mediump vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_4 = tmpvar_5;
  col_4.xyz = mix (col_4.xyz, (col_4.xyz * _WaterColor.xyz), _WaterColor.www);
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_3 = tmpvar_6;
  highp float lightShadowDataX_7;
  lowp vec2 outsideOfShadowmap_8;
  lowp vec2 coordCheck_9;
  highp vec2 tmpvar_10;
  tmpvar_10 = abs(((xlv_TEXCOORD4.xy * 2.0) - 1.0));
  coordCheck_9 = tmpvar_10;
  bvec2 tmpvar_11;
  tmpvar_11 = greaterThan (coordCheck_9, vec2(1.0, 1.0));
  lowp float tmpvar_12;
  if (tmpvar_11.x) {
    tmpvar_12 = 1.0;
  } else {
    tmpvar_12 = 0.0;
  };
  lowp float tmpvar_13;
  if (tmpvar_11.y) {
    tmpvar_13 = 1.0;
  } else {
    tmpvar_13 = 0.0;
  };
  lowp vec2 tmpvar_14;
  tmpvar_14.x = tmpvar_12;
  tmpvar_14.y = tmpvar_13;
  outsideOfShadowmap_8.y = tmpvar_14.y;
  outsideOfShadowmap_8.x = (tmpvar_12 + tmpvar_13);
  highp float tmpvar_15;
  if ((xlv_TEXCOORD4.z > 1.0)) {
    tmpvar_15 = 1.0;
  } else {
    tmpvar_15 = 0.0;
  };
  outsideOfShadowmap_8.x = (outsideOfShadowmap_8.x + tmpvar_15);
  mediump float tmpvar_16;
  tmpvar_16 = _LightShadowData.x;
  lightShadowDataX_7 = tmpvar_16;
  lowp float tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = clamp ((max (
    float((texture2D (_ShadowMapTexture, xlv_TEXCOORD4.xy).x > xlv_TEXCOORD4.z))
  , lightShadowDataX_7) + outsideOfShadowmap_8.x), 0.0, 1.0);
  tmpvar_17 = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = max (0.0, dot (xlv_TEXCOORD2, lightDir_3));
  diff_2 = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = ((col_4.xyz * _LightColor0.xyz) * (diff_2 * tmpvar_17));
  col_4.xyz = (col_4.xyz * xlv_COLOR0);
  col_4.xyz = (col_4.xyz + tmpvar_20);
  mediump vec4 tmpvar_21;
  tmpvar_21 = (_CausticIntensity * texture2D (_CausticTex, xlv_TEXCOORD1));
  caustic_1 = tmpvar_21;
  caustic_1.xyz = mix (caustic_1.xyz, (caustic_1.xyz * _WaterColor.xyz), _WaterColor.www);
  col_4 = (col_4 + ((caustic_1 * diff_2) * (
    (tmpvar_17 * 0.5)
   + 0.5)));
  gl_FragData[0] = col_4;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "TINT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_WorldToShadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _CausticTex_ST;
uniform highp float _Speed;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying lowp vec3 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  highp vec3 shlight_1;
  highp vec2 cUv_2;
  highp vec2 tmpvar_3;
  lowp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  highp vec4 tmpvar_6;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_7;
  tmpvar_7[0] = unity_WorldToObject[0].xyz;
  tmpvar_7[1] = unity_WorldToObject[1].xyz;
  tmpvar_7[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize((_glesNormal * tmpvar_7));
  highp vec2 tmpvar_9;
  tmpvar_9.x = ((tmpvar_6.x * 0.866) + (tmpvar_6.y * 0.5));
  tmpvar_9.y = ((tmpvar_6.z * 0.866) + (tmpvar_6.y * 0.5));
  cUv_2 = ((tmpvar_9 * _CausticTex_ST.xy) + _CausticTex_ST.zw);
  mediump vec2 uv_10;
  uv_10 = cUv_2;
  mediump vec2 distortOffset_11;
  highp float tmpvar_12;
  tmpvar_12 = ((_Time * 20.0) * _Speed).x;
  highp vec2 tmpvar_13;
  tmpvar_13.x = sin((tmpvar_12 + (uv_10.y * 6.28)));
  tmpvar_13.y = sin((tmpvar_12 + (uv_10.x * 6.28)));
  highp vec2 tmpvar_14;
  tmpvar_14 = (tmpvar_13 * vec2(0.025, 0.01));
  distortOffset_11 = tmpvar_14;
  uv_10 = (uv_10 + distortOffset_11);
  uv_10.x = (uv_10.x + (_Time.x * 0.3));
  tmpvar_3 = uv_10;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = tmpvar_8;
  mediump vec4 normal_16;
  normal_16 = tmpvar_15;
  mediump vec3 res_17;
  mediump vec3 x_18;
  x_18.x = dot (unity_SHAr, normal_16);
  x_18.y = dot (unity_SHAg, normal_16);
  x_18.z = dot (unity_SHAb, normal_16);
  mediump vec3 x1_19;
  mediump vec4 tmpvar_20;
  tmpvar_20 = (normal_16.xyzz * normal_16.yzzx);
  x1_19.x = dot (unity_SHBr, tmpvar_20);
  x1_19.y = dot (unity_SHBg, tmpvar_20);
  x1_19.z = dot (unity_SHBb, tmpvar_20);
  res_17 = (x_18 + (x1_19 + (unity_SHC.xyz * 
    ((normal_16.x * normal_16.x) - (normal_16.y * normal_16.y))
  )));
  mediump vec3 tmpvar_21;
  tmpvar_21 = max (((1.055 * 
    pow (max (res_17, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_17 = tmpvar_21;
  shlight_1 = tmpvar_21;
  tmpvar_4 = shlight_1;
  gl_Position = (glstate_matrix_mvp * tmpvar_5);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_8;
  xlv_TEXCOORD3 = tmpvar_6.xyz;
  xlv_COLOR0 = tmpvar_4;
  xlv_TEXCOORD4 = (unity_WorldToShadow[0] * tmpvar_6);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform mediump vec4 _LightShadowData;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _ShadowMapTexture;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _CausticTex;
uniform lowp vec4 _WaterColor;
uniform lowp float _CausticIntensity;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 caustic_1;
  lowp float diff_2;
  lowp vec3 lightDir_3;
  lowp vec4 col_4;
  mediump vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_4 = tmpvar_5;
  col_4.xyz = mix (col_4.xyz, (col_4.xyz * _WaterColor.xyz), _WaterColor.www);
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_3 = tmpvar_6;
  highp float lightShadowDataX_7;
  lowp vec2 outsideOfShadowmap_8;
  lowp vec2 coordCheck_9;
  highp vec2 tmpvar_10;
  tmpvar_10 = abs(((xlv_TEXCOORD4.xy * 2.0) - 1.0));
  coordCheck_9 = tmpvar_10;
  bvec2 tmpvar_11;
  tmpvar_11 = greaterThan (coordCheck_9, vec2(1.0, 1.0));
  lowp float tmpvar_12;
  if (tmpvar_11.x) {
    tmpvar_12 = 1.0;
  } else {
    tmpvar_12 = 0.0;
  };
  lowp float tmpvar_13;
  if (tmpvar_11.y) {
    tmpvar_13 = 1.0;
  } else {
    tmpvar_13 = 0.0;
  };
  lowp vec2 tmpvar_14;
  tmpvar_14.x = tmpvar_12;
  tmpvar_14.y = tmpvar_13;
  outsideOfShadowmap_8.y = tmpvar_14.y;
  outsideOfShadowmap_8.x = (tmpvar_12 + tmpvar_13);
  highp float tmpvar_15;
  if ((xlv_TEXCOORD4.z > 1.0)) {
    tmpvar_15 = 1.0;
  } else {
    tmpvar_15 = 0.0;
  };
  outsideOfShadowmap_8.x = (outsideOfShadowmap_8.x + tmpvar_15);
  mediump float tmpvar_16;
  tmpvar_16 = _LightShadowData.x;
  lightShadowDataX_7 = tmpvar_16;
  lowp float tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = clamp ((max (
    float((texture2D (_ShadowMapTexture, xlv_TEXCOORD4.xy).x > xlv_TEXCOORD4.z))
  , lightShadowDataX_7) + outsideOfShadowmap_8.x), 0.0, 1.0);
  tmpvar_17 = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = max (0.0, dot (xlv_TEXCOORD2, lightDir_3));
  diff_2 = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = ((col_4.xyz * _LightColor0.xyz) * (diff_2 * tmpvar_17));
  col_4.xyz = (col_4.xyz * xlv_COLOR0);
  col_4.xyz = (col_4.xyz + tmpvar_20);
  mediump vec4 tmpvar_21;
  tmpvar_21 = (_CausticIntensity * texture2D (_CausticTex, xlv_TEXCOORD1));
  caustic_1 = tmpvar_21;
  caustic_1.xyz = mix (caustic_1.xyz, (caustic_1.xyz * _WaterColor.xyz), _WaterColor.www);
  col_4 = (col_4 + ((caustic_1 * diff_2) * (
    (tmpvar_17 * 0.5)
   + 0.5)));
  gl_FragData[0] = col_4;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "TINT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_WorldToShadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _CausticTex_ST;
uniform highp float _Speed;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying lowp vec3 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  highp vec3 shlight_1;
  highp vec2 cUv_2;
  highp vec2 tmpvar_3;
  lowp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  highp vec4 tmpvar_6;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_7;
  tmpvar_7[0] = unity_WorldToObject[0].xyz;
  tmpvar_7[1] = unity_WorldToObject[1].xyz;
  tmpvar_7[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize((_glesNormal * tmpvar_7));
  highp vec2 tmpvar_9;
  tmpvar_9.x = ((tmpvar_6.x * 0.866) + (tmpvar_6.y * 0.5));
  tmpvar_9.y = ((tmpvar_6.z * 0.866) + (tmpvar_6.y * 0.5));
  cUv_2 = ((tmpvar_9 * _CausticTex_ST.xy) + _CausticTex_ST.zw);
  mediump vec2 uv_10;
  uv_10 = cUv_2;
  mediump vec2 distortOffset_11;
  highp float tmpvar_12;
  tmpvar_12 = ((_Time * 20.0) * _Speed).x;
  highp vec2 tmpvar_13;
  tmpvar_13.x = sin((tmpvar_12 + (uv_10.y * 6.28)));
  tmpvar_13.y = sin((tmpvar_12 + (uv_10.x * 6.28)));
  highp vec2 tmpvar_14;
  tmpvar_14 = (tmpvar_13 * vec2(0.025, 0.01));
  distortOffset_11 = tmpvar_14;
  uv_10 = (uv_10 + distortOffset_11);
  uv_10.x = (uv_10.x + (_Time.x * 0.3));
  tmpvar_3 = uv_10;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = tmpvar_8;
  mediump vec4 normal_16;
  normal_16 = tmpvar_15;
  mediump vec3 res_17;
  mediump vec3 x_18;
  x_18.x = dot (unity_SHAr, normal_16);
  x_18.y = dot (unity_SHAg, normal_16);
  x_18.z = dot (unity_SHAb, normal_16);
  mediump vec3 x1_19;
  mediump vec4 tmpvar_20;
  tmpvar_20 = (normal_16.xyzz * normal_16.yzzx);
  x1_19.x = dot (unity_SHBr, tmpvar_20);
  x1_19.y = dot (unity_SHBg, tmpvar_20);
  x1_19.z = dot (unity_SHBb, tmpvar_20);
  res_17 = (x_18 + (x1_19 + (unity_SHC.xyz * 
    ((normal_16.x * normal_16.x) - (normal_16.y * normal_16.y))
  )));
  mediump vec3 tmpvar_21;
  tmpvar_21 = max (((1.055 * 
    pow (max (res_17, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_17 = tmpvar_21;
  shlight_1 = tmpvar_21;
  tmpvar_4 = shlight_1;
  gl_Position = (glstate_matrix_mvp * tmpvar_5);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_8;
  xlv_TEXCOORD3 = tmpvar_6.xyz;
  xlv_COLOR0 = tmpvar_4;
  xlv_TEXCOORD4 = (unity_WorldToShadow[0] * tmpvar_6);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform mediump vec4 _LightShadowData;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _ShadowMapTexture;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _CausticTex;
uniform lowp vec4 _WaterColor;
uniform lowp float _CausticIntensity;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 caustic_1;
  lowp float diff_2;
  lowp vec3 lightDir_3;
  lowp vec4 col_4;
  mediump vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_4 = tmpvar_5;
  col_4.xyz = mix (col_4.xyz, (col_4.xyz * _WaterColor.xyz), _WaterColor.www);
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_3 = tmpvar_6;
  highp float lightShadowDataX_7;
  lowp vec2 outsideOfShadowmap_8;
  lowp vec2 coordCheck_9;
  highp vec2 tmpvar_10;
  tmpvar_10 = abs(((xlv_TEXCOORD4.xy * 2.0) - 1.0));
  coordCheck_9 = tmpvar_10;
  bvec2 tmpvar_11;
  tmpvar_11 = greaterThan (coordCheck_9, vec2(1.0, 1.0));
  lowp float tmpvar_12;
  if (tmpvar_11.x) {
    tmpvar_12 = 1.0;
  } else {
    tmpvar_12 = 0.0;
  };
  lowp float tmpvar_13;
  if (tmpvar_11.y) {
    tmpvar_13 = 1.0;
  } else {
    tmpvar_13 = 0.0;
  };
  lowp vec2 tmpvar_14;
  tmpvar_14.x = tmpvar_12;
  tmpvar_14.y = tmpvar_13;
  outsideOfShadowmap_8.y = tmpvar_14.y;
  outsideOfShadowmap_8.x = (tmpvar_12 + tmpvar_13);
  highp float tmpvar_15;
  if ((xlv_TEXCOORD4.z > 1.0)) {
    tmpvar_15 = 1.0;
  } else {
    tmpvar_15 = 0.0;
  };
  outsideOfShadowmap_8.x = (outsideOfShadowmap_8.x + tmpvar_15);
  mediump float tmpvar_16;
  tmpvar_16 = _LightShadowData.x;
  lightShadowDataX_7 = tmpvar_16;
  lowp float tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = clamp ((max (
    float((texture2D (_ShadowMapTexture, xlv_TEXCOORD4.xy).x > xlv_TEXCOORD4.z))
  , lightShadowDataX_7) + outsideOfShadowmap_8.x), 0.0, 1.0);
  tmpvar_17 = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = max (0.0, dot (xlv_TEXCOORD2, lightDir_3));
  diff_2 = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = ((col_4.xyz * _LightColor0.xyz) * (diff_2 * tmpvar_17));
  col_4.xyz = (col_4.xyz * xlv_COLOR0);
  col_4.xyz = (col_4.xyz + tmpvar_20);
  mediump vec4 tmpvar_21;
  tmpvar_21 = (_CausticIntensity * texture2D (_CausticTex, xlv_TEXCOORD1));
  caustic_1 = tmpvar_21;
  caustic_1.xyz = mix (caustic_1.xyz, (caustic_1.xyz * _WaterColor.xyz), _WaterColor.www);
  col_4 = (col_4 + ((caustic_1 * diff_2) * (
    (tmpvar_17 * 0.5)
   + 0.5)));
  gl_FragData[0] = col_4;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "VERTEXLIGHT_ON" "TINT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _CausticTex_ST;
uniform highp float _Speed;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying lowp vec3 xlv_COLOR0;
void main ()
{
  highp vec3 shlight_1;
  highp vec2 cUv_2;
  highp vec2 tmpvar_3;
  lowp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  highp vec3 tmpvar_6;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = unity_WorldToObject[0].xyz;
  tmpvar_7[1] = unity_WorldToObject[1].xyz;
  tmpvar_7[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize((_glesNormal * tmpvar_7));
  highp vec2 tmpvar_9;
  tmpvar_9.x = ((tmpvar_6.x * 0.866) + (tmpvar_6.y * 0.5));
  tmpvar_9.y = ((tmpvar_6.z * 0.866) + (tmpvar_6.y * 0.5));
  cUv_2 = ((tmpvar_9 * _CausticTex_ST.xy) + _CausticTex_ST.zw);
  mediump vec2 uv_10;
  uv_10 = cUv_2;
  mediump vec2 distortOffset_11;
  highp float tmpvar_12;
  tmpvar_12 = ((_Time * 20.0) * _Speed).x;
  highp vec2 tmpvar_13;
  tmpvar_13.x = sin((tmpvar_12 + (uv_10.y * 6.28)));
  tmpvar_13.y = sin((tmpvar_12 + (uv_10.x * 6.28)));
  highp vec2 tmpvar_14;
  tmpvar_14 = (tmpvar_13 * vec2(0.025, 0.01));
  distortOffset_11 = tmpvar_14;
  uv_10 = (uv_10 + distortOffset_11);
  uv_10.x = (uv_10.x + (_Time.x * 0.3));
  tmpvar_3 = uv_10;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = tmpvar_8;
  mediump vec4 normal_16;
  normal_16 = tmpvar_15;
  mediump vec3 res_17;
  mediump vec3 x_18;
  x_18.x = dot (unity_SHAr, normal_16);
  x_18.y = dot (unity_SHAg, normal_16);
  x_18.z = dot (unity_SHAb, normal_16);
  mediump vec3 x1_19;
  mediump vec4 tmpvar_20;
  tmpvar_20 = (normal_16.xyzz * normal_16.yzzx);
  x1_19.x = dot (unity_SHBr, tmpvar_20);
  x1_19.y = dot (unity_SHBg, tmpvar_20);
  x1_19.z = dot (unity_SHBb, tmpvar_20);
  res_17 = (x_18 + (x1_19 + (unity_SHC.xyz * 
    ((normal_16.x * normal_16.x) - (normal_16.y * normal_16.y))
  )));
  mediump vec3 tmpvar_21;
  tmpvar_21 = max (((1.055 * 
    pow (max (res_17, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_17 = tmpvar_21;
  shlight_1 = tmpvar_21;
  tmpvar_4 = shlight_1;
  gl_Position = (glstate_matrix_mvp * tmpvar_5);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_8;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_COLOR0 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _CausticTex;
uniform lowp vec4 _WaterColor;
uniform lowp float _CausticIntensity;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_COLOR0;
void main ()
{
  lowp vec4 caustic_1;
  lowp float diff_2;
  lowp vec3 lightDir_3;
  lowp vec4 col_4;
  mediump vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_4 = tmpvar_5;
  col_4.xyz = mix (col_4.xyz, (col_4.xyz * _WaterColor.xyz), _WaterColor.www);
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_3 = tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = max (0.0, dot (xlv_TEXCOORD2, lightDir_3));
  diff_2 = tmpvar_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = ((col_4.xyz * _LightColor0.xyz) * diff_2);
  col_4.xyz = (col_4.xyz * xlv_COLOR0);
  col_4.xyz = (col_4.xyz + tmpvar_8);
  mediump vec4 tmpvar_9;
  tmpvar_9 = (_CausticIntensity * texture2D (_CausticTex, xlv_TEXCOORD1));
  caustic_1 = tmpvar_9;
  caustic_1.xyz = mix (caustic_1.xyz, (caustic_1.xyz * _WaterColor.xyz), _WaterColor.www);
  col_4 = (col_4 + (caustic_1 * diff_2));
  gl_FragData[0] = col_4;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "VERTEXLIGHT_ON" "TINT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _CausticTex_ST;
uniform highp float _Speed;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying lowp vec3 xlv_COLOR0;
void main ()
{
  highp vec3 shlight_1;
  highp vec2 cUv_2;
  highp vec2 tmpvar_3;
  lowp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  highp vec3 tmpvar_6;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = unity_WorldToObject[0].xyz;
  tmpvar_7[1] = unity_WorldToObject[1].xyz;
  tmpvar_7[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize((_glesNormal * tmpvar_7));
  highp vec2 tmpvar_9;
  tmpvar_9.x = ((tmpvar_6.x * 0.866) + (tmpvar_6.y * 0.5));
  tmpvar_9.y = ((tmpvar_6.z * 0.866) + (tmpvar_6.y * 0.5));
  cUv_2 = ((tmpvar_9 * _CausticTex_ST.xy) + _CausticTex_ST.zw);
  mediump vec2 uv_10;
  uv_10 = cUv_2;
  mediump vec2 distortOffset_11;
  highp float tmpvar_12;
  tmpvar_12 = ((_Time * 20.0) * _Speed).x;
  highp vec2 tmpvar_13;
  tmpvar_13.x = sin((tmpvar_12 + (uv_10.y * 6.28)));
  tmpvar_13.y = sin((tmpvar_12 + (uv_10.x * 6.28)));
  highp vec2 tmpvar_14;
  tmpvar_14 = (tmpvar_13 * vec2(0.025, 0.01));
  distortOffset_11 = tmpvar_14;
  uv_10 = (uv_10 + distortOffset_11);
  uv_10.x = (uv_10.x + (_Time.x * 0.3));
  tmpvar_3 = uv_10;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = tmpvar_8;
  mediump vec4 normal_16;
  normal_16 = tmpvar_15;
  mediump vec3 res_17;
  mediump vec3 x_18;
  x_18.x = dot (unity_SHAr, normal_16);
  x_18.y = dot (unity_SHAg, normal_16);
  x_18.z = dot (unity_SHAb, normal_16);
  mediump vec3 x1_19;
  mediump vec4 tmpvar_20;
  tmpvar_20 = (normal_16.xyzz * normal_16.yzzx);
  x1_19.x = dot (unity_SHBr, tmpvar_20);
  x1_19.y = dot (unity_SHBg, tmpvar_20);
  x1_19.z = dot (unity_SHBb, tmpvar_20);
  res_17 = (x_18 + (x1_19 + (unity_SHC.xyz * 
    ((normal_16.x * normal_16.x) - (normal_16.y * normal_16.y))
  )));
  mediump vec3 tmpvar_21;
  tmpvar_21 = max (((1.055 * 
    pow (max (res_17, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_17 = tmpvar_21;
  shlight_1 = tmpvar_21;
  tmpvar_4 = shlight_1;
  gl_Position = (glstate_matrix_mvp * tmpvar_5);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_8;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_COLOR0 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _CausticTex;
uniform lowp vec4 _WaterColor;
uniform lowp float _CausticIntensity;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_COLOR0;
void main ()
{
  lowp vec4 caustic_1;
  lowp float diff_2;
  lowp vec3 lightDir_3;
  lowp vec4 col_4;
  mediump vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_4 = tmpvar_5;
  col_4.xyz = mix (col_4.xyz, (col_4.xyz * _WaterColor.xyz), _WaterColor.www);
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_3 = tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = max (0.0, dot (xlv_TEXCOORD2, lightDir_3));
  diff_2 = tmpvar_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = ((col_4.xyz * _LightColor0.xyz) * diff_2);
  col_4.xyz = (col_4.xyz * xlv_COLOR0);
  col_4.xyz = (col_4.xyz + tmpvar_8);
  mediump vec4 tmpvar_9;
  tmpvar_9 = (_CausticIntensity * texture2D (_CausticTex, xlv_TEXCOORD1));
  caustic_1 = tmpvar_9;
  caustic_1.xyz = mix (caustic_1.xyz, (caustic_1.xyz * _WaterColor.xyz), _WaterColor.www);
  col_4 = (col_4 + (caustic_1 * diff_2));
  gl_FragData[0] = col_4;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "VERTEXLIGHT_ON" "TINT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _CausticTex_ST;
uniform highp float _Speed;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying lowp vec3 xlv_COLOR0;
void main ()
{
  highp vec3 shlight_1;
  highp vec2 cUv_2;
  highp vec2 tmpvar_3;
  lowp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  highp vec3 tmpvar_6;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = unity_WorldToObject[0].xyz;
  tmpvar_7[1] = unity_WorldToObject[1].xyz;
  tmpvar_7[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize((_glesNormal * tmpvar_7));
  highp vec2 tmpvar_9;
  tmpvar_9.x = ((tmpvar_6.x * 0.866) + (tmpvar_6.y * 0.5));
  tmpvar_9.y = ((tmpvar_6.z * 0.866) + (tmpvar_6.y * 0.5));
  cUv_2 = ((tmpvar_9 * _CausticTex_ST.xy) + _CausticTex_ST.zw);
  mediump vec2 uv_10;
  uv_10 = cUv_2;
  mediump vec2 distortOffset_11;
  highp float tmpvar_12;
  tmpvar_12 = ((_Time * 20.0) * _Speed).x;
  highp vec2 tmpvar_13;
  tmpvar_13.x = sin((tmpvar_12 + (uv_10.y * 6.28)));
  tmpvar_13.y = sin((tmpvar_12 + (uv_10.x * 6.28)));
  highp vec2 tmpvar_14;
  tmpvar_14 = (tmpvar_13 * vec2(0.025, 0.01));
  distortOffset_11 = tmpvar_14;
  uv_10 = (uv_10 + distortOffset_11);
  uv_10.x = (uv_10.x + (_Time.x * 0.3));
  tmpvar_3 = uv_10;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = tmpvar_8;
  mediump vec4 normal_16;
  normal_16 = tmpvar_15;
  mediump vec3 res_17;
  mediump vec3 x_18;
  x_18.x = dot (unity_SHAr, normal_16);
  x_18.y = dot (unity_SHAg, normal_16);
  x_18.z = dot (unity_SHAb, normal_16);
  mediump vec3 x1_19;
  mediump vec4 tmpvar_20;
  tmpvar_20 = (normal_16.xyzz * normal_16.yzzx);
  x1_19.x = dot (unity_SHBr, tmpvar_20);
  x1_19.y = dot (unity_SHBg, tmpvar_20);
  x1_19.z = dot (unity_SHBb, tmpvar_20);
  res_17 = (x_18 + (x1_19 + (unity_SHC.xyz * 
    ((normal_16.x * normal_16.x) - (normal_16.y * normal_16.y))
  )));
  mediump vec3 tmpvar_21;
  tmpvar_21 = max (((1.055 * 
    pow (max (res_17, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_17 = tmpvar_21;
  shlight_1 = tmpvar_21;
  tmpvar_4 = shlight_1;
  gl_Position = (glstate_matrix_mvp * tmpvar_5);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_8;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_COLOR0 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _CausticTex;
uniform lowp vec4 _WaterColor;
uniform lowp float _CausticIntensity;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_COLOR0;
void main ()
{
  lowp vec4 caustic_1;
  lowp float diff_2;
  lowp vec3 lightDir_3;
  lowp vec4 col_4;
  mediump vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_4 = tmpvar_5;
  col_4.xyz = mix (col_4.xyz, (col_4.xyz * _WaterColor.xyz), _WaterColor.www);
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_3 = tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = max (0.0, dot (xlv_TEXCOORD2, lightDir_3));
  diff_2 = tmpvar_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = ((col_4.xyz * _LightColor0.xyz) * diff_2);
  col_4.xyz = (col_4.xyz * xlv_COLOR0);
  col_4.xyz = (col_4.xyz + tmpvar_8);
  mediump vec4 tmpvar_9;
  tmpvar_9 = (_CausticIntensity * texture2D (_CausticTex, xlv_TEXCOORD1));
  caustic_1 = tmpvar_9;
  caustic_1.xyz = mix (caustic_1.xyz, (caustic_1.xyz * _WaterColor.xyz), _WaterColor.www);
  col_4 = (col_4 + (caustic_1 * diff_2));
  gl_FragData[0] = col_4;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" "TINT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_WorldToShadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _CausticTex_ST;
uniform highp float _Speed;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying lowp vec3 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  highp vec3 shlight_1;
  highp vec2 cUv_2;
  highp vec2 tmpvar_3;
  lowp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  highp vec4 tmpvar_6;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_7;
  tmpvar_7[0] = unity_WorldToObject[0].xyz;
  tmpvar_7[1] = unity_WorldToObject[1].xyz;
  tmpvar_7[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize((_glesNormal * tmpvar_7));
  highp vec2 tmpvar_9;
  tmpvar_9.x = ((tmpvar_6.x * 0.866) + (tmpvar_6.y * 0.5));
  tmpvar_9.y = ((tmpvar_6.z * 0.866) + (tmpvar_6.y * 0.5));
  cUv_2 = ((tmpvar_9 * _CausticTex_ST.xy) + _CausticTex_ST.zw);
  mediump vec2 uv_10;
  uv_10 = cUv_2;
  mediump vec2 distortOffset_11;
  highp float tmpvar_12;
  tmpvar_12 = ((_Time * 20.0) * _Speed).x;
  highp vec2 tmpvar_13;
  tmpvar_13.x = sin((tmpvar_12 + (uv_10.y * 6.28)));
  tmpvar_13.y = sin((tmpvar_12 + (uv_10.x * 6.28)));
  highp vec2 tmpvar_14;
  tmpvar_14 = (tmpvar_13 * vec2(0.025, 0.01));
  distortOffset_11 = tmpvar_14;
  uv_10 = (uv_10 + distortOffset_11);
  uv_10.x = (uv_10.x + (_Time.x * 0.3));
  tmpvar_3 = uv_10;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = tmpvar_8;
  mediump vec4 normal_16;
  normal_16 = tmpvar_15;
  mediump vec3 res_17;
  mediump vec3 x_18;
  x_18.x = dot (unity_SHAr, normal_16);
  x_18.y = dot (unity_SHAg, normal_16);
  x_18.z = dot (unity_SHAb, normal_16);
  mediump vec3 x1_19;
  mediump vec4 tmpvar_20;
  tmpvar_20 = (normal_16.xyzz * normal_16.yzzx);
  x1_19.x = dot (unity_SHBr, tmpvar_20);
  x1_19.y = dot (unity_SHBg, tmpvar_20);
  x1_19.z = dot (unity_SHBb, tmpvar_20);
  res_17 = (x_18 + (x1_19 + (unity_SHC.xyz * 
    ((normal_16.x * normal_16.x) - (normal_16.y * normal_16.y))
  )));
  mediump vec3 tmpvar_21;
  tmpvar_21 = max (((1.055 * 
    pow (max (res_17, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_17 = tmpvar_21;
  shlight_1 = tmpvar_21;
  tmpvar_4 = shlight_1;
  gl_Position = (glstate_matrix_mvp * tmpvar_5);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_8;
  xlv_TEXCOORD3 = tmpvar_6.xyz;
  xlv_COLOR0 = tmpvar_4;
  xlv_TEXCOORD4 = (unity_WorldToShadow[0] * tmpvar_6);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform mediump vec4 _LightShadowData;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _ShadowMapTexture;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _CausticTex;
uniform lowp vec4 _WaterColor;
uniform lowp float _CausticIntensity;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 caustic_1;
  lowp float diff_2;
  lowp vec3 lightDir_3;
  lowp vec4 col_4;
  mediump vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_4 = tmpvar_5;
  col_4.xyz = mix (col_4.xyz, (col_4.xyz * _WaterColor.xyz), _WaterColor.www);
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_3 = tmpvar_6;
  highp float lightShadowDataX_7;
  lowp vec2 outsideOfShadowmap_8;
  lowp vec2 coordCheck_9;
  highp vec2 tmpvar_10;
  tmpvar_10 = abs(((xlv_TEXCOORD4.xy * 2.0) - 1.0));
  coordCheck_9 = tmpvar_10;
  bvec2 tmpvar_11;
  tmpvar_11 = greaterThan (coordCheck_9, vec2(1.0, 1.0));
  lowp float tmpvar_12;
  if (tmpvar_11.x) {
    tmpvar_12 = 1.0;
  } else {
    tmpvar_12 = 0.0;
  };
  lowp float tmpvar_13;
  if (tmpvar_11.y) {
    tmpvar_13 = 1.0;
  } else {
    tmpvar_13 = 0.0;
  };
  lowp vec2 tmpvar_14;
  tmpvar_14.x = tmpvar_12;
  tmpvar_14.y = tmpvar_13;
  outsideOfShadowmap_8.y = tmpvar_14.y;
  outsideOfShadowmap_8.x = (tmpvar_12 + tmpvar_13);
  highp float tmpvar_15;
  if ((xlv_TEXCOORD4.z > 1.0)) {
    tmpvar_15 = 1.0;
  } else {
    tmpvar_15 = 0.0;
  };
  outsideOfShadowmap_8.x = (outsideOfShadowmap_8.x + tmpvar_15);
  mediump float tmpvar_16;
  tmpvar_16 = _LightShadowData.x;
  lightShadowDataX_7 = tmpvar_16;
  lowp float tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = clamp ((max (
    float((texture2D (_ShadowMapTexture, xlv_TEXCOORD4.xy).x > xlv_TEXCOORD4.z))
  , lightShadowDataX_7) + outsideOfShadowmap_8.x), 0.0, 1.0);
  tmpvar_17 = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = max (0.0, dot (xlv_TEXCOORD2, lightDir_3));
  diff_2 = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = ((col_4.xyz * _LightColor0.xyz) * (diff_2 * tmpvar_17));
  col_4.xyz = (col_4.xyz * xlv_COLOR0);
  col_4.xyz = (col_4.xyz + tmpvar_20);
  mediump vec4 tmpvar_21;
  tmpvar_21 = (_CausticIntensity * texture2D (_CausticTex, xlv_TEXCOORD1));
  caustic_1 = tmpvar_21;
  caustic_1.xyz = mix (caustic_1.xyz, (caustic_1.xyz * _WaterColor.xyz), _WaterColor.www);
  col_4 = (col_4 + ((caustic_1 * diff_2) * (
    (tmpvar_17 * 0.5)
   + 0.5)));
  gl_FragData[0] = col_4;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" "TINT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_WorldToShadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _CausticTex_ST;
uniform highp float _Speed;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying lowp vec3 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  highp vec3 shlight_1;
  highp vec2 cUv_2;
  highp vec2 tmpvar_3;
  lowp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  highp vec4 tmpvar_6;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_7;
  tmpvar_7[0] = unity_WorldToObject[0].xyz;
  tmpvar_7[1] = unity_WorldToObject[1].xyz;
  tmpvar_7[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize((_glesNormal * tmpvar_7));
  highp vec2 tmpvar_9;
  tmpvar_9.x = ((tmpvar_6.x * 0.866) + (tmpvar_6.y * 0.5));
  tmpvar_9.y = ((tmpvar_6.z * 0.866) + (tmpvar_6.y * 0.5));
  cUv_2 = ((tmpvar_9 * _CausticTex_ST.xy) + _CausticTex_ST.zw);
  mediump vec2 uv_10;
  uv_10 = cUv_2;
  mediump vec2 distortOffset_11;
  highp float tmpvar_12;
  tmpvar_12 = ((_Time * 20.0) * _Speed).x;
  highp vec2 tmpvar_13;
  tmpvar_13.x = sin((tmpvar_12 + (uv_10.y * 6.28)));
  tmpvar_13.y = sin((tmpvar_12 + (uv_10.x * 6.28)));
  highp vec2 tmpvar_14;
  tmpvar_14 = (tmpvar_13 * vec2(0.025, 0.01));
  distortOffset_11 = tmpvar_14;
  uv_10 = (uv_10 + distortOffset_11);
  uv_10.x = (uv_10.x + (_Time.x * 0.3));
  tmpvar_3 = uv_10;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = tmpvar_8;
  mediump vec4 normal_16;
  normal_16 = tmpvar_15;
  mediump vec3 res_17;
  mediump vec3 x_18;
  x_18.x = dot (unity_SHAr, normal_16);
  x_18.y = dot (unity_SHAg, normal_16);
  x_18.z = dot (unity_SHAb, normal_16);
  mediump vec3 x1_19;
  mediump vec4 tmpvar_20;
  tmpvar_20 = (normal_16.xyzz * normal_16.yzzx);
  x1_19.x = dot (unity_SHBr, tmpvar_20);
  x1_19.y = dot (unity_SHBg, tmpvar_20);
  x1_19.z = dot (unity_SHBb, tmpvar_20);
  res_17 = (x_18 + (x1_19 + (unity_SHC.xyz * 
    ((normal_16.x * normal_16.x) - (normal_16.y * normal_16.y))
  )));
  mediump vec3 tmpvar_21;
  tmpvar_21 = max (((1.055 * 
    pow (max (res_17, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_17 = tmpvar_21;
  shlight_1 = tmpvar_21;
  tmpvar_4 = shlight_1;
  gl_Position = (glstate_matrix_mvp * tmpvar_5);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_8;
  xlv_TEXCOORD3 = tmpvar_6.xyz;
  xlv_COLOR0 = tmpvar_4;
  xlv_TEXCOORD4 = (unity_WorldToShadow[0] * tmpvar_6);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform mediump vec4 _LightShadowData;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _ShadowMapTexture;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _CausticTex;
uniform lowp vec4 _WaterColor;
uniform lowp float _CausticIntensity;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 caustic_1;
  lowp float diff_2;
  lowp vec3 lightDir_3;
  lowp vec4 col_4;
  mediump vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_4 = tmpvar_5;
  col_4.xyz = mix (col_4.xyz, (col_4.xyz * _WaterColor.xyz), _WaterColor.www);
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_3 = tmpvar_6;
  highp float lightShadowDataX_7;
  lowp vec2 outsideOfShadowmap_8;
  lowp vec2 coordCheck_9;
  highp vec2 tmpvar_10;
  tmpvar_10 = abs(((xlv_TEXCOORD4.xy * 2.0) - 1.0));
  coordCheck_9 = tmpvar_10;
  bvec2 tmpvar_11;
  tmpvar_11 = greaterThan (coordCheck_9, vec2(1.0, 1.0));
  lowp float tmpvar_12;
  if (tmpvar_11.x) {
    tmpvar_12 = 1.0;
  } else {
    tmpvar_12 = 0.0;
  };
  lowp float tmpvar_13;
  if (tmpvar_11.y) {
    tmpvar_13 = 1.0;
  } else {
    tmpvar_13 = 0.0;
  };
  lowp vec2 tmpvar_14;
  tmpvar_14.x = tmpvar_12;
  tmpvar_14.y = tmpvar_13;
  outsideOfShadowmap_8.y = tmpvar_14.y;
  outsideOfShadowmap_8.x = (tmpvar_12 + tmpvar_13);
  highp float tmpvar_15;
  if ((xlv_TEXCOORD4.z > 1.0)) {
    tmpvar_15 = 1.0;
  } else {
    tmpvar_15 = 0.0;
  };
  outsideOfShadowmap_8.x = (outsideOfShadowmap_8.x + tmpvar_15);
  mediump float tmpvar_16;
  tmpvar_16 = _LightShadowData.x;
  lightShadowDataX_7 = tmpvar_16;
  lowp float tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = clamp ((max (
    float((texture2D (_ShadowMapTexture, xlv_TEXCOORD4.xy).x > xlv_TEXCOORD4.z))
  , lightShadowDataX_7) + outsideOfShadowmap_8.x), 0.0, 1.0);
  tmpvar_17 = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = max (0.0, dot (xlv_TEXCOORD2, lightDir_3));
  diff_2 = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = ((col_4.xyz * _LightColor0.xyz) * (diff_2 * tmpvar_17));
  col_4.xyz = (col_4.xyz * xlv_COLOR0);
  col_4.xyz = (col_4.xyz + tmpvar_20);
  mediump vec4 tmpvar_21;
  tmpvar_21 = (_CausticIntensity * texture2D (_CausticTex, xlv_TEXCOORD1));
  caustic_1 = tmpvar_21;
  caustic_1.xyz = mix (caustic_1.xyz, (caustic_1.xyz * _WaterColor.xyz), _WaterColor.www);
  col_4 = (col_4 + ((caustic_1 * diff_2) * (
    (tmpvar_17 * 0.5)
   + 0.5)));
  gl_FragData[0] = col_4;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" "TINT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_WorldToShadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _CausticTex_ST;
uniform highp float _Speed;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying lowp vec3 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  highp vec3 shlight_1;
  highp vec2 cUv_2;
  highp vec2 tmpvar_3;
  lowp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  highp vec4 tmpvar_6;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_7;
  tmpvar_7[0] = unity_WorldToObject[0].xyz;
  tmpvar_7[1] = unity_WorldToObject[1].xyz;
  tmpvar_7[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize((_glesNormal * tmpvar_7));
  highp vec2 tmpvar_9;
  tmpvar_9.x = ((tmpvar_6.x * 0.866) + (tmpvar_6.y * 0.5));
  tmpvar_9.y = ((tmpvar_6.z * 0.866) + (tmpvar_6.y * 0.5));
  cUv_2 = ((tmpvar_9 * _CausticTex_ST.xy) + _CausticTex_ST.zw);
  mediump vec2 uv_10;
  uv_10 = cUv_2;
  mediump vec2 distortOffset_11;
  highp float tmpvar_12;
  tmpvar_12 = ((_Time * 20.0) * _Speed).x;
  highp vec2 tmpvar_13;
  tmpvar_13.x = sin((tmpvar_12 + (uv_10.y * 6.28)));
  tmpvar_13.y = sin((tmpvar_12 + (uv_10.x * 6.28)));
  highp vec2 tmpvar_14;
  tmpvar_14 = (tmpvar_13 * vec2(0.025, 0.01));
  distortOffset_11 = tmpvar_14;
  uv_10 = (uv_10 + distortOffset_11);
  uv_10.x = (uv_10.x + (_Time.x * 0.3));
  tmpvar_3 = uv_10;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = tmpvar_8;
  mediump vec4 normal_16;
  normal_16 = tmpvar_15;
  mediump vec3 res_17;
  mediump vec3 x_18;
  x_18.x = dot (unity_SHAr, normal_16);
  x_18.y = dot (unity_SHAg, normal_16);
  x_18.z = dot (unity_SHAb, normal_16);
  mediump vec3 x1_19;
  mediump vec4 tmpvar_20;
  tmpvar_20 = (normal_16.xyzz * normal_16.yzzx);
  x1_19.x = dot (unity_SHBr, tmpvar_20);
  x1_19.y = dot (unity_SHBg, tmpvar_20);
  x1_19.z = dot (unity_SHBb, tmpvar_20);
  res_17 = (x_18 + (x1_19 + (unity_SHC.xyz * 
    ((normal_16.x * normal_16.x) - (normal_16.y * normal_16.y))
  )));
  mediump vec3 tmpvar_21;
  tmpvar_21 = max (((1.055 * 
    pow (max (res_17, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_17 = tmpvar_21;
  shlight_1 = tmpvar_21;
  tmpvar_4 = shlight_1;
  gl_Position = (glstate_matrix_mvp * tmpvar_5);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_8;
  xlv_TEXCOORD3 = tmpvar_6.xyz;
  xlv_COLOR0 = tmpvar_4;
  xlv_TEXCOORD4 = (unity_WorldToShadow[0] * tmpvar_6);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform mediump vec4 _LightShadowData;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _ShadowMapTexture;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _CausticTex;
uniform lowp vec4 _WaterColor;
uniform lowp float _CausticIntensity;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 caustic_1;
  lowp float diff_2;
  lowp vec3 lightDir_3;
  lowp vec4 col_4;
  mediump vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_4 = tmpvar_5;
  col_4.xyz = mix (col_4.xyz, (col_4.xyz * _WaterColor.xyz), _WaterColor.www);
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_3 = tmpvar_6;
  highp float lightShadowDataX_7;
  lowp vec2 outsideOfShadowmap_8;
  lowp vec2 coordCheck_9;
  highp vec2 tmpvar_10;
  tmpvar_10 = abs(((xlv_TEXCOORD4.xy * 2.0) - 1.0));
  coordCheck_9 = tmpvar_10;
  bvec2 tmpvar_11;
  tmpvar_11 = greaterThan (coordCheck_9, vec2(1.0, 1.0));
  lowp float tmpvar_12;
  if (tmpvar_11.x) {
    tmpvar_12 = 1.0;
  } else {
    tmpvar_12 = 0.0;
  };
  lowp float tmpvar_13;
  if (tmpvar_11.y) {
    tmpvar_13 = 1.0;
  } else {
    tmpvar_13 = 0.0;
  };
  lowp vec2 tmpvar_14;
  tmpvar_14.x = tmpvar_12;
  tmpvar_14.y = tmpvar_13;
  outsideOfShadowmap_8.y = tmpvar_14.y;
  outsideOfShadowmap_8.x = (tmpvar_12 + tmpvar_13);
  highp float tmpvar_15;
  if ((xlv_TEXCOORD4.z > 1.0)) {
    tmpvar_15 = 1.0;
  } else {
    tmpvar_15 = 0.0;
  };
  outsideOfShadowmap_8.x = (outsideOfShadowmap_8.x + tmpvar_15);
  mediump float tmpvar_16;
  tmpvar_16 = _LightShadowData.x;
  lightShadowDataX_7 = tmpvar_16;
  lowp float tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = clamp ((max (
    float((texture2D (_ShadowMapTexture, xlv_TEXCOORD4.xy).x > xlv_TEXCOORD4.z))
  , lightShadowDataX_7) + outsideOfShadowmap_8.x), 0.0, 1.0);
  tmpvar_17 = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = max (0.0, dot (xlv_TEXCOORD2, lightDir_3));
  diff_2 = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = ((col_4.xyz * _LightColor0.xyz) * (diff_2 * tmpvar_17));
  col_4.xyz = (col_4.xyz * xlv_COLOR0);
  col_4.xyz = (col_4.xyz + tmpvar_20);
  mediump vec4 tmpvar_21;
  tmpvar_21 = (_CausticIntensity * texture2D (_CausticTex, xlv_TEXCOORD1));
  caustic_1 = tmpvar_21;
  caustic_1.xyz = mix (caustic_1.xyz, (caustic_1.xyz * _WaterColor.xyz), _WaterColor.www);
  col_4 = (col_4 + ((caustic_1 * diff_2) * (
    (tmpvar_17 * 0.5)
   + 0.5)));
  gl_FragData[0] = col_4;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "TINT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_FogParams;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _CausticTex_ST;
uniform highp float _Speed;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying lowp vec3 xlv_COLOR0;
varying highp float xlv_TEXCOORD5;
void main ()
{
  highp vec3 shlight_1;
  highp vec2 cUv_2;
  highp vec2 tmpvar_3;
  lowp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (glstate_matrix_mvp * tmpvar_6);
  highp vec3 tmpvar_7;
  tmpvar_7 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((_glesNormal * tmpvar_8));
  highp vec2 tmpvar_10;
  tmpvar_10.x = ((tmpvar_7.x * 0.866) + (tmpvar_7.y * 0.5));
  tmpvar_10.y = ((tmpvar_7.z * 0.866) + (tmpvar_7.y * 0.5));
  cUv_2 = ((tmpvar_10 * _CausticTex_ST.xy) + _CausticTex_ST.zw);
  mediump vec2 uv_11;
  uv_11 = cUv_2;
  mediump vec2 distortOffset_12;
  highp float tmpvar_13;
  tmpvar_13 = ((_Time * 20.0) * _Speed).x;
  highp vec2 tmpvar_14;
  tmpvar_14.x = sin((tmpvar_13 + (uv_11.y * 6.28)));
  tmpvar_14.y = sin((tmpvar_13 + (uv_11.x * 6.28)));
  highp vec2 tmpvar_15;
  tmpvar_15 = (tmpvar_14 * vec2(0.025, 0.01));
  distortOffset_12 = tmpvar_15;
  uv_11 = (uv_11 + distortOffset_12);
  uv_11.x = (uv_11.x + (_Time.x * 0.3));
  tmpvar_3 = uv_11;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = tmpvar_9;
  mediump vec4 normal_17;
  normal_17 = tmpvar_16;
  mediump vec3 res_18;
  mediump vec3 x_19;
  x_19.x = dot (unity_SHAr, normal_17);
  x_19.y = dot (unity_SHAg, normal_17);
  x_19.z = dot (unity_SHAb, normal_17);
  mediump vec3 x1_20;
  mediump vec4 tmpvar_21;
  tmpvar_21 = (normal_17.xyzz * normal_17.yzzx);
  x1_20.x = dot (unity_SHBr, tmpvar_21);
  x1_20.y = dot (unity_SHBg, tmpvar_21);
  x1_20.z = dot (unity_SHBb, tmpvar_21);
  res_18 = (x_19 + (x1_20 + (unity_SHC.xyz * 
    ((normal_17.x * normal_17.x) - (normal_17.y * normal_17.y))
  )));
  mediump vec3 tmpvar_22;
  tmpvar_22 = max (((1.055 * 
    pow (max (res_18, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_18 = tmpvar_22;
  shlight_1 = tmpvar_22;
  tmpvar_4 = shlight_1;
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_9;
  xlv_TEXCOORD3 = tmpvar_7;
  xlv_COLOR0 = tmpvar_4;
  xlv_TEXCOORD5 = ((tmpvar_5.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 unity_FogColor;
uniform lowp vec4 _LightColor0;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _CausticTex;
uniform lowp vec4 _WaterColor;
uniform lowp float _CausticIntensity;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_COLOR0;
varying highp float xlv_TEXCOORD5;
void main ()
{
  lowp vec4 caustic_1;
  lowp float diff_2;
  lowp vec3 lightDir_3;
  lowp vec4 col_4;
  mediump vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_4 = tmpvar_5;
  col_4.xyz = mix (col_4.xyz, (col_4.xyz * _WaterColor.xyz), _WaterColor.www);
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_3 = tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = max (0.0, dot (xlv_TEXCOORD2, lightDir_3));
  diff_2 = tmpvar_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = ((col_4.xyz * _LightColor0.xyz) * diff_2);
  col_4.xyz = (col_4.xyz * xlv_COLOR0);
  col_4.xyz = (col_4.xyz + tmpvar_8);
  mediump vec4 tmpvar_9;
  tmpvar_9 = (_CausticIntensity * texture2D (_CausticTex, xlv_TEXCOORD1));
  caustic_1 = tmpvar_9;
  caustic_1.xyz = mix (caustic_1.xyz, (caustic_1.xyz * _WaterColor.xyz), _WaterColor.www);
  col_4 = (col_4 + (caustic_1 * diff_2));
  highp float tmpvar_10;
  tmpvar_10 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  col_4.xyz = mix (unity_FogColor.xyz, col_4.xyz, vec3(tmpvar_10));
  gl_FragData[0] = col_4;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "TINT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_FogParams;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _CausticTex_ST;
uniform highp float _Speed;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying lowp vec3 xlv_COLOR0;
varying highp float xlv_TEXCOORD5;
void main ()
{
  highp vec3 shlight_1;
  highp vec2 cUv_2;
  highp vec2 tmpvar_3;
  lowp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (glstate_matrix_mvp * tmpvar_6);
  highp vec3 tmpvar_7;
  tmpvar_7 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((_glesNormal * tmpvar_8));
  highp vec2 tmpvar_10;
  tmpvar_10.x = ((tmpvar_7.x * 0.866) + (tmpvar_7.y * 0.5));
  tmpvar_10.y = ((tmpvar_7.z * 0.866) + (tmpvar_7.y * 0.5));
  cUv_2 = ((tmpvar_10 * _CausticTex_ST.xy) + _CausticTex_ST.zw);
  mediump vec2 uv_11;
  uv_11 = cUv_2;
  mediump vec2 distortOffset_12;
  highp float tmpvar_13;
  tmpvar_13 = ((_Time * 20.0) * _Speed).x;
  highp vec2 tmpvar_14;
  tmpvar_14.x = sin((tmpvar_13 + (uv_11.y * 6.28)));
  tmpvar_14.y = sin((tmpvar_13 + (uv_11.x * 6.28)));
  highp vec2 tmpvar_15;
  tmpvar_15 = (tmpvar_14 * vec2(0.025, 0.01));
  distortOffset_12 = tmpvar_15;
  uv_11 = (uv_11 + distortOffset_12);
  uv_11.x = (uv_11.x + (_Time.x * 0.3));
  tmpvar_3 = uv_11;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = tmpvar_9;
  mediump vec4 normal_17;
  normal_17 = tmpvar_16;
  mediump vec3 res_18;
  mediump vec3 x_19;
  x_19.x = dot (unity_SHAr, normal_17);
  x_19.y = dot (unity_SHAg, normal_17);
  x_19.z = dot (unity_SHAb, normal_17);
  mediump vec3 x1_20;
  mediump vec4 tmpvar_21;
  tmpvar_21 = (normal_17.xyzz * normal_17.yzzx);
  x1_20.x = dot (unity_SHBr, tmpvar_21);
  x1_20.y = dot (unity_SHBg, tmpvar_21);
  x1_20.z = dot (unity_SHBb, tmpvar_21);
  res_18 = (x_19 + (x1_20 + (unity_SHC.xyz * 
    ((normal_17.x * normal_17.x) - (normal_17.y * normal_17.y))
  )));
  mediump vec3 tmpvar_22;
  tmpvar_22 = max (((1.055 * 
    pow (max (res_18, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_18 = tmpvar_22;
  shlight_1 = tmpvar_22;
  tmpvar_4 = shlight_1;
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_9;
  xlv_TEXCOORD3 = tmpvar_7;
  xlv_COLOR0 = tmpvar_4;
  xlv_TEXCOORD5 = ((tmpvar_5.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 unity_FogColor;
uniform lowp vec4 _LightColor0;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _CausticTex;
uniform lowp vec4 _WaterColor;
uniform lowp float _CausticIntensity;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_COLOR0;
varying highp float xlv_TEXCOORD5;
void main ()
{
  lowp vec4 caustic_1;
  lowp float diff_2;
  lowp vec3 lightDir_3;
  lowp vec4 col_4;
  mediump vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_4 = tmpvar_5;
  col_4.xyz = mix (col_4.xyz, (col_4.xyz * _WaterColor.xyz), _WaterColor.www);
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_3 = tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = max (0.0, dot (xlv_TEXCOORD2, lightDir_3));
  diff_2 = tmpvar_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = ((col_4.xyz * _LightColor0.xyz) * diff_2);
  col_4.xyz = (col_4.xyz * xlv_COLOR0);
  col_4.xyz = (col_4.xyz + tmpvar_8);
  mediump vec4 tmpvar_9;
  tmpvar_9 = (_CausticIntensity * texture2D (_CausticTex, xlv_TEXCOORD1));
  caustic_1 = tmpvar_9;
  caustic_1.xyz = mix (caustic_1.xyz, (caustic_1.xyz * _WaterColor.xyz), _WaterColor.www);
  col_4 = (col_4 + (caustic_1 * diff_2));
  highp float tmpvar_10;
  tmpvar_10 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  col_4.xyz = mix (unity_FogColor.xyz, col_4.xyz, vec3(tmpvar_10));
  gl_FragData[0] = col_4;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "TINT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_FogParams;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _CausticTex_ST;
uniform highp float _Speed;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying lowp vec3 xlv_COLOR0;
varying highp float xlv_TEXCOORD5;
void main ()
{
  highp vec3 shlight_1;
  highp vec2 cUv_2;
  highp vec2 tmpvar_3;
  lowp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (glstate_matrix_mvp * tmpvar_6);
  highp vec3 tmpvar_7;
  tmpvar_7 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((_glesNormal * tmpvar_8));
  highp vec2 tmpvar_10;
  tmpvar_10.x = ((tmpvar_7.x * 0.866) + (tmpvar_7.y * 0.5));
  tmpvar_10.y = ((tmpvar_7.z * 0.866) + (tmpvar_7.y * 0.5));
  cUv_2 = ((tmpvar_10 * _CausticTex_ST.xy) + _CausticTex_ST.zw);
  mediump vec2 uv_11;
  uv_11 = cUv_2;
  mediump vec2 distortOffset_12;
  highp float tmpvar_13;
  tmpvar_13 = ((_Time * 20.0) * _Speed).x;
  highp vec2 tmpvar_14;
  tmpvar_14.x = sin((tmpvar_13 + (uv_11.y * 6.28)));
  tmpvar_14.y = sin((tmpvar_13 + (uv_11.x * 6.28)));
  highp vec2 tmpvar_15;
  tmpvar_15 = (tmpvar_14 * vec2(0.025, 0.01));
  distortOffset_12 = tmpvar_15;
  uv_11 = (uv_11 + distortOffset_12);
  uv_11.x = (uv_11.x + (_Time.x * 0.3));
  tmpvar_3 = uv_11;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = tmpvar_9;
  mediump vec4 normal_17;
  normal_17 = tmpvar_16;
  mediump vec3 res_18;
  mediump vec3 x_19;
  x_19.x = dot (unity_SHAr, normal_17);
  x_19.y = dot (unity_SHAg, normal_17);
  x_19.z = dot (unity_SHAb, normal_17);
  mediump vec3 x1_20;
  mediump vec4 tmpvar_21;
  tmpvar_21 = (normal_17.xyzz * normal_17.yzzx);
  x1_20.x = dot (unity_SHBr, tmpvar_21);
  x1_20.y = dot (unity_SHBg, tmpvar_21);
  x1_20.z = dot (unity_SHBb, tmpvar_21);
  res_18 = (x_19 + (x1_20 + (unity_SHC.xyz * 
    ((normal_17.x * normal_17.x) - (normal_17.y * normal_17.y))
  )));
  mediump vec3 tmpvar_22;
  tmpvar_22 = max (((1.055 * 
    pow (max (res_18, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_18 = tmpvar_22;
  shlight_1 = tmpvar_22;
  tmpvar_4 = shlight_1;
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_9;
  xlv_TEXCOORD3 = tmpvar_7;
  xlv_COLOR0 = tmpvar_4;
  xlv_TEXCOORD5 = ((tmpvar_5.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 unity_FogColor;
uniform lowp vec4 _LightColor0;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _CausticTex;
uniform lowp vec4 _WaterColor;
uniform lowp float _CausticIntensity;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_COLOR0;
varying highp float xlv_TEXCOORD5;
void main ()
{
  lowp vec4 caustic_1;
  lowp float diff_2;
  lowp vec3 lightDir_3;
  lowp vec4 col_4;
  mediump vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_4 = tmpvar_5;
  col_4.xyz = mix (col_4.xyz, (col_4.xyz * _WaterColor.xyz), _WaterColor.www);
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_3 = tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = max (0.0, dot (xlv_TEXCOORD2, lightDir_3));
  diff_2 = tmpvar_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = ((col_4.xyz * _LightColor0.xyz) * diff_2);
  col_4.xyz = (col_4.xyz * xlv_COLOR0);
  col_4.xyz = (col_4.xyz + tmpvar_8);
  mediump vec4 tmpvar_9;
  tmpvar_9 = (_CausticIntensity * texture2D (_CausticTex, xlv_TEXCOORD1));
  caustic_1 = tmpvar_9;
  caustic_1.xyz = mix (caustic_1.xyz, (caustic_1.xyz * _WaterColor.xyz), _WaterColor.www);
  col_4 = (col_4 + (caustic_1 * diff_2));
  highp float tmpvar_10;
  tmpvar_10 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  col_4.xyz = mix (unity_FogColor.xyz, col_4.xyz, vec3(tmpvar_10));
  gl_FragData[0] = col_4;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "FOG_LINEAR" "TINT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_WorldToShadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_FogParams;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _CausticTex_ST;
uniform highp float _Speed;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying lowp vec3 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
void main ()
{
  highp vec3 shlight_1;
  highp vec2 cUv_2;
  highp vec2 tmpvar_3;
  lowp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (glstate_matrix_mvp * tmpvar_6);
  highp vec4 tmpvar_7;
  tmpvar_7 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((_glesNormal * tmpvar_8));
  highp vec2 tmpvar_10;
  tmpvar_10.x = ((tmpvar_7.x * 0.866) + (tmpvar_7.y * 0.5));
  tmpvar_10.y = ((tmpvar_7.z * 0.866) + (tmpvar_7.y * 0.5));
  cUv_2 = ((tmpvar_10 * _CausticTex_ST.xy) + _CausticTex_ST.zw);
  mediump vec2 uv_11;
  uv_11 = cUv_2;
  mediump vec2 distortOffset_12;
  highp float tmpvar_13;
  tmpvar_13 = ((_Time * 20.0) * _Speed).x;
  highp vec2 tmpvar_14;
  tmpvar_14.x = sin((tmpvar_13 + (uv_11.y * 6.28)));
  tmpvar_14.y = sin((tmpvar_13 + (uv_11.x * 6.28)));
  highp vec2 tmpvar_15;
  tmpvar_15 = (tmpvar_14 * vec2(0.025, 0.01));
  distortOffset_12 = tmpvar_15;
  uv_11 = (uv_11 + distortOffset_12);
  uv_11.x = (uv_11.x + (_Time.x * 0.3));
  tmpvar_3 = uv_11;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = tmpvar_9;
  mediump vec4 normal_17;
  normal_17 = tmpvar_16;
  mediump vec3 res_18;
  mediump vec3 x_19;
  x_19.x = dot (unity_SHAr, normal_17);
  x_19.y = dot (unity_SHAg, normal_17);
  x_19.z = dot (unity_SHAb, normal_17);
  mediump vec3 x1_20;
  mediump vec4 tmpvar_21;
  tmpvar_21 = (normal_17.xyzz * normal_17.yzzx);
  x1_20.x = dot (unity_SHBr, tmpvar_21);
  x1_20.y = dot (unity_SHBg, tmpvar_21);
  x1_20.z = dot (unity_SHBb, tmpvar_21);
  res_18 = (x_19 + (x1_20 + (unity_SHC.xyz * 
    ((normal_17.x * normal_17.x) - (normal_17.y * normal_17.y))
  )));
  mediump vec3 tmpvar_22;
  tmpvar_22 = max (((1.055 * 
    pow (max (res_18, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_18 = tmpvar_22;
  shlight_1 = tmpvar_22;
  tmpvar_4 = shlight_1;
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_9;
  xlv_TEXCOORD3 = tmpvar_7.xyz;
  xlv_COLOR0 = tmpvar_4;
  xlv_TEXCOORD4 = (unity_WorldToShadow[0] * tmpvar_7);
  xlv_TEXCOORD5 = ((tmpvar_5.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform mediump vec4 _LightShadowData;
uniform lowp vec4 unity_FogColor;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _ShadowMapTexture;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _CausticTex;
uniform lowp vec4 _WaterColor;
uniform lowp float _CausticIntensity;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
void main ()
{
  lowp vec4 caustic_1;
  lowp float diff_2;
  lowp vec3 lightDir_3;
  lowp vec4 col_4;
  mediump vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_4 = tmpvar_5;
  col_4.xyz = mix (col_4.xyz, (col_4.xyz * _WaterColor.xyz), _WaterColor.www);
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_3 = tmpvar_6;
  highp float lightShadowDataX_7;
  lowp vec2 outsideOfShadowmap_8;
  lowp vec2 coordCheck_9;
  highp vec2 tmpvar_10;
  tmpvar_10 = abs(((xlv_TEXCOORD4.xy * 2.0) - 1.0));
  coordCheck_9 = tmpvar_10;
  bvec2 tmpvar_11;
  tmpvar_11 = greaterThan (coordCheck_9, vec2(1.0, 1.0));
  lowp float tmpvar_12;
  if (tmpvar_11.x) {
    tmpvar_12 = 1.0;
  } else {
    tmpvar_12 = 0.0;
  };
  lowp float tmpvar_13;
  if (tmpvar_11.y) {
    tmpvar_13 = 1.0;
  } else {
    tmpvar_13 = 0.0;
  };
  lowp vec2 tmpvar_14;
  tmpvar_14.x = tmpvar_12;
  tmpvar_14.y = tmpvar_13;
  outsideOfShadowmap_8.y = tmpvar_14.y;
  outsideOfShadowmap_8.x = (tmpvar_12 + tmpvar_13);
  highp float tmpvar_15;
  if ((xlv_TEXCOORD4.z > 1.0)) {
    tmpvar_15 = 1.0;
  } else {
    tmpvar_15 = 0.0;
  };
  outsideOfShadowmap_8.x = (outsideOfShadowmap_8.x + tmpvar_15);
  mediump float tmpvar_16;
  tmpvar_16 = _LightShadowData.x;
  lightShadowDataX_7 = tmpvar_16;
  lowp float tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = clamp ((max (
    float((texture2D (_ShadowMapTexture, xlv_TEXCOORD4.xy).x > xlv_TEXCOORD4.z))
  , lightShadowDataX_7) + outsideOfShadowmap_8.x), 0.0, 1.0);
  tmpvar_17 = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = max (0.0, dot (xlv_TEXCOORD2, lightDir_3));
  diff_2 = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = ((col_4.xyz * _LightColor0.xyz) * (diff_2 * tmpvar_17));
  col_4.xyz = (col_4.xyz * xlv_COLOR0);
  col_4.xyz = (col_4.xyz + tmpvar_20);
  mediump vec4 tmpvar_21;
  tmpvar_21 = (_CausticIntensity * texture2D (_CausticTex, xlv_TEXCOORD1));
  caustic_1 = tmpvar_21;
  caustic_1.xyz = mix (caustic_1.xyz, (caustic_1.xyz * _WaterColor.xyz), _WaterColor.www);
  col_4 = (col_4 + ((caustic_1 * diff_2) * (
    (tmpvar_17 * 0.5)
   + 0.5)));
  highp float tmpvar_22;
  tmpvar_22 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  col_4.xyz = mix (unity_FogColor.xyz, col_4.xyz, vec3(tmpvar_22));
  gl_FragData[0] = col_4;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "FOG_LINEAR" "TINT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_WorldToShadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_FogParams;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _CausticTex_ST;
uniform highp float _Speed;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying lowp vec3 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
void main ()
{
  highp vec3 shlight_1;
  highp vec2 cUv_2;
  highp vec2 tmpvar_3;
  lowp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (glstate_matrix_mvp * tmpvar_6);
  highp vec4 tmpvar_7;
  tmpvar_7 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((_glesNormal * tmpvar_8));
  highp vec2 tmpvar_10;
  tmpvar_10.x = ((tmpvar_7.x * 0.866) + (tmpvar_7.y * 0.5));
  tmpvar_10.y = ((tmpvar_7.z * 0.866) + (tmpvar_7.y * 0.5));
  cUv_2 = ((tmpvar_10 * _CausticTex_ST.xy) + _CausticTex_ST.zw);
  mediump vec2 uv_11;
  uv_11 = cUv_2;
  mediump vec2 distortOffset_12;
  highp float tmpvar_13;
  tmpvar_13 = ((_Time * 20.0) * _Speed).x;
  highp vec2 tmpvar_14;
  tmpvar_14.x = sin((tmpvar_13 + (uv_11.y * 6.28)));
  tmpvar_14.y = sin((tmpvar_13 + (uv_11.x * 6.28)));
  highp vec2 tmpvar_15;
  tmpvar_15 = (tmpvar_14 * vec2(0.025, 0.01));
  distortOffset_12 = tmpvar_15;
  uv_11 = (uv_11 + distortOffset_12);
  uv_11.x = (uv_11.x + (_Time.x * 0.3));
  tmpvar_3 = uv_11;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = tmpvar_9;
  mediump vec4 normal_17;
  normal_17 = tmpvar_16;
  mediump vec3 res_18;
  mediump vec3 x_19;
  x_19.x = dot (unity_SHAr, normal_17);
  x_19.y = dot (unity_SHAg, normal_17);
  x_19.z = dot (unity_SHAb, normal_17);
  mediump vec3 x1_20;
  mediump vec4 tmpvar_21;
  tmpvar_21 = (normal_17.xyzz * normal_17.yzzx);
  x1_20.x = dot (unity_SHBr, tmpvar_21);
  x1_20.y = dot (unity_SHBg, tmpvar_21);
  x1_20.z = dot (unity_SHBb, tmpvar_21);
  res_18 = (x_19 + (x1_20 + (unity_SHC.xyz * 
    ((normal_17.x * normal_17.x) - (normal_17.y * normal_17.y))
  )));
  mediump vec3 tmpvar_22;
  tmpvar_22 = max (((1.055 * 
    pow (max (res_18, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_18 = tmpvar_22;
  shlight_1 = tmpvar_22;
  tmpvar_4 = shlight_1;
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_9;
  xlv_TEXCOORD3 = tmpvar_7.xyz;
  xlv_COLOR0 = tmpvar_4;
  xlv_TEXCOORD4 = (unity_WorldToShadow[0] * tmpvar_7);
  xlv_TEXCOORD5 = ((tmpvar_5.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform mediump vec4 _LightShadowData;
uniform lowp vec4 unity_FogColor;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _ShadowMapTexture;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _CausticTex;
uniform lowp vec4 _WaterColor;
uniform lowp float _CausticIntensity;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
void main ()
{
  lowp vec4 caustic_1;
  lowp float diff_2;
  lowp vec3 lightDir_3;
  lowp vec4 col_4;
  mediump vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_4 = tmpvar_5;
  col_4.xyz = mix (col_4.xyz, (col_4.xyz * _WaterColor.xyz), _WaterColor.www);
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_3 = tmpvar_6;
  highp float lightShadowDataX_7;
  lowp vec2 outsideOfShadowmap_8;
  lowp vec2 coordCheck_9;
  highp vec2 tmpvar_10;
  tmpvar_10 = abs(((xlv_TEXCOORD4.xy * 2.0) - 1.0));
  coordCheck_9 = tmpvar_10;
  bvec2 tmpvar_11;
  tmpvar_11 = greaterThan (coordCheck_9, vec2(1.0, 1.0));
  lowp float tmpvar_12;
  if (tmpvar_11.x) {
    tmpvar_12 = 1.0;
  } else {
    tmpvar_12 = 0.0;
  };
  lowp float tmpvar_13;
  if (tmpvar_11.y) {
    tmpvar_13 = 1.0;
  } else {
    tmpvar_13 = 0.0;
  };
  lowp vec2 tmpvar_14;
  tmpvar_14.x = tmpvar_12;
  tmpvar_14.y = tmpvar_13;
  outsideOfShadowmap_8.y = tmpvar_14.y;
  outsideOfShadowmap_8.x = (tmpvar_12 + tmpvar_13);
  highp float tmpvar_15;
  if ((xlv_TEXCOORD4.z > 1.0)) {
    tmpvar_15 = 1.0;
  } else {
    tmpvar_15 = 0.0;
  };
  outsideOfShadowmap_8.x = (outsideOfShadowmap_8.x + tmpvar_15);
  mediump float tmpvar_16;
  tmpvar_16 = _LightShadowData.x;
  lightShadowDataX_7 = tmpvar_16;
  lowp float tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = clamp ((max (
    float((texture2D (_ShadowMapTexture, xlv_TEXCOORD4.xy).x > xlv_TEXCOORD4.z))
  , lightShadowDataX_7) + outsideOfShadowmap_8.x), 0.0, 1.0);
  tmpvar_17 = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = max (0.0, dot (xlv_TEXCOORD2, lightDir_3));
  diff_2 = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = ((col_4.xyz * _LightColor0.xyz) * (diff_2 * tmpvar_17));
  col_4.xyz = (col_4.xyz * xlv_COLOR0);
  col_4.xyz = (col_4.xyz + tmpvar_20);
  mediump vec4 tmpvar_21;
  tmpvar_21 = (_CausticIntensity * texture2D (_CausticTex, xlv_TEXCOORD1));
  caustic_1 = tmpvar_21;
  caustic_1.xyz = mix (caustic_1.xyz, (caustic_1.xyz * _WaterColor.xyz), _WaterColor.www);
  col_4 = (col_4 + ((caustic_1 * diff_2) * (
    (tmpvar_17 * 0.5)
   + 0.5)));
  highp float tmpvar_22;
  tmpvar_22 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  col_4.xyz = mix (unity_FogColor.xyz, col_4.xyz, vec3(tmpvar_22));
  gl_FragData[0] = col_4;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "FOG_LINEAR" "TINT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_WorldToShadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_FogParams;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _CausticTex_ST;
uniform highp float _Speed;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying lowp vec3 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
void main ()
{
  highp vec3 shlight_1;
  highp vec2 cUv_2;
  highp vec2 tmpvar_3;
  lowp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (glstate_matrix_mvp * tmpvar_6);
  highp vec4 tmpvar_7;
  tmpvar_7 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((_glesNormal * tmpvar_8));
  highp vec2 tmpvar_10;
  tmpvar_10.x = ((tmpvar_7.x * 0.866) + (tmpvar_7.y * 0.5));
  tmpvar_10.y = ((tmpvar_7.z * 0.866) + (tmpvar_7.y * 0.5));
  cUv_2 = ((tmpvar_10 * _CausticTex_ST.xy) + _CausticTex_ST.zw);
  mediump vec2 uv_11;
  uv_11 = cUv_2;
  mediump vec2 distortOffset_12;
  highp float tmpvar_13;
  tmpvar_13 = ((_Time * 20.0) * _Speed).x;
  highp vec2 tmpvar_14;
  tmpvar_14.x = sin((tmpvar_13 + (uv_11.y * 6.28)));
  tmpvar_14.y = sin((tmpvar_13 + (uv_11.x * 6.28)));
  highp vec2 tmpvar_15;
  tmpvar_15 = (tmpvar_14 * vec2(0.025, 0.01));
  distortOffset_12 = tmpvar_15;
  uv_11 = (uv_11 + distortOffset_12);
  uv_11.x = (uv_11.x + (_Time.x * 0.3));
  tmpvar_3 = uv_11;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = tmpvar_9;
  mediump vec4 normal_17;
  normal_17 = tmpvar_16;
  mediump vec3 res_18;
  mediump vec3 x_19;
  x_19.x = dot (unity_SHAr, normal_17);
  x_19.y = dot (unity_SHAg, normal_17);
  x_19.z = dot (unity_SHAb, normal_17);
  mediump vec3 x1_20;
  mediump vec4 tmpvar_21;
  tmpvar_21 = (normal_17.xyzz * normal_17.yzzx);
  x1_20.x = dot (unity_SHBr, tmpvar_21);
  x1_20.y = dot (unity_SHBg, tmpvar_21);
  x1_20.z = dot (unity_SHBb, tmpvar_21);
  res_18 = (x_19 + (x1_20 + (unity_SHC.xyz * 
    ((normal_17.x * normal_17.x) - (normal_17.y * normal_17.y))
  )));
  mediump vec3 tmpvar_22;
  tmpvar_22 = max (((1.055 * 
    pow (max (res_18, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_18 = tmpvar_22;
  shlight_1 = tmpvar_22;
  tmpvar_4 = shlight_1;
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_9;
  xlv_TEXCOORD3 = tmpvar_7.xyz;
  xlv_COLOR0 = tmpvar_4;
  xlv_TEXCOORD4 = (unity_WorldToShadow[0] * tmpvar_7);
  xlv_TEXCOORD5 = ((tmpvar_5.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform mediump vec4 _LightShadowData;
uniform lowp vec4 unity_FogColor;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _ShadowMapTexture;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _CausticTex;
uniform lowp vec4 _WaterColor;
uniform lowp float _CausticIntensity;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
void main ()
{
  lowp vec4 caustic_1;
  lowp float diff_2;
  lowp vec3 lightDir_3;
  lowp vec4 col_4;
  mediump vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_4 = tmpvar_5;
  col_4.xyz = mix (col_4.xyz, (col_4.xyz * _WaterColor.xyz), _WaterColor.www);
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_3 = tmpvar_6;
  highp float lightShadowDataX_7;
  lowp vec2 outsideOfShadowmap_8;
  lowp vec2 coordCheck_9;
  highp vec2 tmpvar_10;
  tmpvar_10 = abs(((xlv_TEXCOORD4.xy * 2.0) - 1.0));
  coordCheck_9 = tmpvar_10;
  bvec2 tmpvar_11;
  tmpvar_11 = greaterThan (coordCheck_9, vec2(1.0, 1.0));
  lowp float tmpvar_12;
  if (tmpvar_11.x) {
    tmpvar_12 = 1.0;
  } else {
    tmpvar_12 = 0.0;
  };
  lowp float tmpvar_13;
  if (tmpvar_11.y) {
    tmpvar_13 = 1.0;
  } else {
    tmpvar_13 = 0.0;
  };
  lowp vec2 tmpvar_14;
  tmpvar_14.x = tmpvar_12;
  tmpvar_14.y = tmpvar_13;
  outsideOfShadowmap_8.y = tmpvar_14.y;
  outsideOfShadowmap_8.x = (tmpvar_12 + tmpvar_13);
  highp float tmpvar_15;
  if ((xlv_TEXCOORD4.z > 1.0)) {
    tmpvar_15 = 1.0;
  } else {
    tmpvar_15 = 0.0;
  };
  outsideOfShadowmap_8.x = (outsideOfShadowmap_8.x + tmpvar_15);
  mediump float tmpvar_16;
  tmpvar_16 = _LightShadowData.x;
  lightShadowDataX_7 = tmpvar_16;
  lowp float tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = clamp ((max (
    float((texture2D (_ShadowMapTexture, xlv_TEXCOORD4.xy).x > xlv_TEXCOORD4.z))
  , lightShadowDataX_7) + outsideOfShadowmap_8.x), 0.0, 1.0);
  tmpvar_17 = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = max (0.0, dot (xlv_TEXCOORD2, lightDir_3));
  diff_2 = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = ((col_4.xyz * _LightColor0.xyz) * (diff_2 * tmpvar_17));
  col_4.xyz = (col_4.xyz * xlv_COLOR0);
  col_4.xyz = (col_4.xyz + tmpvar_20);
  mediump vec4 tmpvar_21;
  tmpvar_21 = (_CausticIntensity * texture2D (_CausticTex, xlv_TEXCOORD1));
  caustic_1 = tmpvar_21;
  caustic_1.xyz = mix (caustic_1.xyz, (caustic_1.xyz * _WaterColor.xyz), _WaterColor.www);
  col_4 = (col_4 + ((caustic_1 * diff_2) * (
    (tmpvar_17 * 0.5)
   + 0.5)));
  highp float tmpvar_22;
  tmpvar_22 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  col_4.xyz = mix (unity_FogColor.xyz, col_4.xyz, vec3(tmpvar_22));
  gl_FragData[0] = col_4;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "VERTEXLIGHT_ON" "TINT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_FogParams;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _CausticTex_ST;
uniform highp float _Speed;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying lowp vec3 xlv_COLOR0;
varying highp float xlv_TEXCOORD5;
void main ()
{
  highp vec3 shlight_1;
  highp vec2 cUv_2;
  highp vec2 tmpvar_3;
  lowp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (glstate_matrix_mvp * tmpvar_6);
  highp vec3 tmpvar_7;
  tmpvar_7 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((_glesNormal * tmpvar_8));
  highp vec2 tmpvar_10;
  tmpvar_10.x = ((tmpvar_7.x * 0.866) + (tmpvar_7.y * 0.5));
  tmpvar_10.y = ((tmpvar_7.z * 0.866) + (tmpvar_7.y * 0.5));
  cUv_2 = ((tmpvar_10 * _CausticTex_ST.xy) + _CausticTex_ST.zw);
  mediump vec2 uv_11;
  uv_11 = cUv_2;
  mediump vec2 distortOffset_12;
  highp float tmpvar_13;
  tmpvar_13 = ((_Time * 20.0) * _Speed).x;
  highp vec2 tmpvar_14;
  tmpvar_14.x = sin((tmpvar_13 + (uv_11.y * 6.28)));
  tmpvar_14.y = sin((tmpvar_13 + (uv_11.x * 6.28)));
  highp vec2 tmpvar_15;
  tmpvar_15 = (tmpvar_14 * vec2(0.025, 0.01));
  distortOffset_12 = tmpvar_15;
  uv_11 = (uv_11 + distortOffset_12);
  uv_11.x = (uv_11.x + (_Time.x * 0.3));
  tmpvar_3 = uv_11;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = tmpvar_9;
  mediump vec4 normal_17;
  normal_17 = tmpvar_16;
  mediump vec3 res_18;
  mediump vec3 x_19;
  x_19.x = dot (unity_SHAr, normal_17);
  x_19.y = dot (unity_SHAg, normal_17);
  x_19.z = dot (unity_SHAb, normal_17);
  mediump vec3 x1_20;
  mediump vec4 tmpvar_21;
  tmpvar_21 = (normal_17.xyzz * normal_17.yzzx);
  x1_20.x = dot (unity_SHBr, tmpvar_21);
  x1_20.y = dot (unity_SHBg, tmpvar_21);
  x1_20.z = dot (unity_SHBb, tmpvar_21);
  res_18 = (x_19 + (x1_20 + (unity_SHC.xyz * 
    ((normal_17.x * normal_17.x) - (normal_17.y * normal_17.y))
  )));
  mediump vec3 tmpvar_22;
  tmpvar_22 = max (((1.055 * 
    pow (max (res_18, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_18 = tmpvar_22;
  shlight_1 = tmpvar_22;
  tmpvar_4 = shlight_1;
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_9;
  xlv_TEXCOORD3 = tmpvar_7;
  xlv_COLOR0 = tmpvar_4;
  xlv_TEXCOORD5 = ((tmpvar_5.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 unity_FogColor;
uniform lowp vec4 _LightColor0;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _CausticTex;
uniform lowp vec4 _WaterColor;
uniform lowp float _CausticIntensity;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_COLOR0;
varying highp float xlv_TEXCOORD5;
void main ()
{
  lowp vec4 caustic_1;
  lowp float diff_2;
  lowp vec3 lightDir_3;
  lowp vec4 col_4;
  mediump vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_4 = tmpvar_5;
  col_4.xyz = mix (col_4.xyz, (col_4.xyz * _WaterColor.xyz), _WaterColor.www);
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_3 = tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = max (0.0, dot (xlv_TEXCOORD2, lightDir_3));
  diff_2 = tmpvar_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = ((col_4.xyz * _LightColor0.xyz) * diff_2);
  col_4.xyz = (col_4.xyz * xlv_COLOR0);
  col_4.xyz = (col_4.xyz + tmpvar_8);
  mediump vec4 tmpvar_9;
  tmpvar_9 = (_CausticIntensity * texture2D (_CausticTex, xlv_TEXCOORD1));
  caustic_1 = tmpvar_9;
  caustic_1.xyz = mix (caustic_1.xyz, (caustic_1.xyz * _WaterColor.xyz), _WaterColor.www);
  col_4 = (col_4 + (caustic_1 * diff_2));
  highp float tmpvar_10;
  tmpvar_10 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  col_4.xyz = mix (unity_FogColor.xyz, col_4.xyz, vec3(tmpvar_10));
  gl_FragData[0] = col_4;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "VERTEXLIGHT_ON" "TINT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_FogParams;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _CausticTex_ST;
uniform highp float _Speed;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying lowp vec3 xlv_COLOR0;
varying highp float xlv_TEXCOORD5;
void main ()
{
  highp vec3 shlight_1;
  highp vec2 cUv_2;
  highp vec2 tmpvar_3;
  lowp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (glstate_matrix_mvp * tmpvar_6);
  highp vec3 tmpvar_7;
  tmpvar_7 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((_glesNormal * tmpvar_8));
  highp vec2 tmpvar_10;
  tmpvar_10.x = ((tmpvar_7.x * 0.866) + (tmpvar_7.y * 0.5));
  tmpvar_10.y = ((tmpvar_7.z * 0.866) + (tmpvar_7.y * 0.5));
  cUv_2 = ((tmpvar_10 * _CausticTex_ST.xy) + _CausticTex_ST.zw);
  mediump vec2 uv_11;
  uv_11 = cUv_2;
  mediump vec2 distortOffset_12;
  highp float tmpvar_13;
  tmpvar_13 = ((_Time * 20.0) * _Speed).x;
  highp vec2 tmpvar_14;
  tmpvar_14.x = sin((tmpvar_13 + (uv_11.y * 6.28)));
  tmpvar_14.y = sin((tmpvar_13 + (uv_11.x * 6.28)));
  highp vec2 tmpvar_15;
  tmpvar_15 = (tmpvar_14 * vec2(0.025, 0.01));
  distortOffset_12 = tmpvar_15;
  uv_11 = (uv_11 + distortOffset_12);
  uv_11.x = (uv_11.x + (_Time.x * 0.3));
  tmpvar_3 = uv_11;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = tmpvar_9;
  mediump vec4 normal_17;
  normal_17 = tmpvar_16;
  mediump vec3 res_18;
  mediump vec3 x_19;
  x_19.x = dot (unity_SHAr, normal_17);
  x_19.y = dot (unity_SHAg, normal_17);
  x_19.z = dot (unity_SHAb, normal_17);
  mediump vec3 x1_20;
  mediump vec4 tmpvar_21;
  tmpvar_21 = (normal_17.xyzz * normal_17.yzzx);
  x1_20.x = dot (unity_SHBr, tmpvar_21);
  x1_20.y = dot (unity_SHBg, tmpvar_21);
  x1_20.z = dot (unity_SHBb, tmpvar_21);
  res_18 = (x_19 + (x1_20 + (unity_SHC.xyz * 
    ((normal_17.x * normal_17.x) - (normal_17.y * normal_17.y))
  )));
  mediump vec3 tmpvar_22;
  tmpvar_22 = max (((1.055 * 
    pow (max (res_18, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_18 = tmpvar_22;
  shlight_1 = tmpvar_22;
  tmpvar_4 = shlight_1;
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_9;
  xlv_TEXCOORD3 = tmpvar_7;
  xlv_COLOR0 = tmpvar_4;
  xlv_TEXCOORD5 = ((tmpvar_5.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 unity_FogColor;
uniform lowp vec4 _LightColor0;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _CausticTex;
uniform lowp vec4 _WaterColor;
uniform lowp float _CausticIntensity;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_COLOR0;
varying highp float xlv_TEXCOORD5;
void main ()
{
  lowp vec4 caustic_1;
  lowp float diff_2;
  lowp vec3 lightDir_3;
  lowp vec4 col_4;
  mediump vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_4 = tmpvar_5;
  col_4.xyz = mix (col_4.xyz, (col_4.xyz * _WaterColor.xyz), _WaterColor.www);
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_3 = tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = max (0.0, dot (xlv_TEXCOORD2, lightDir_3));
  diff_2 = tmpvar_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = ((col_4.xyz * _LightColor0.xyz) * diff_2);
  col_4.xyz = (col_4.xyz * xlv_COLOR0);
  col_4.xyz = (col_4.xyz + tmpvar_8);
  mediump vec4 tmpvar_9;
  tmpvar_9 = (_CausticIntensity * texture2D (_CausticTex, xlv_TEXCOORD1));
  caustic_1 = tmpvar_9;
  caustic_1.xyz = mix (caustic_1.xyz, (caustic_1.xyz * _WaterColor.xyz), _WaterColor.www);
  col_4 = (col_4 + (caustic_1 * diff_2));
  highp float tmpvar_10;
  tmpvar_10 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  col_4.xyz = mix (unity_FogColor.xyz, col_4.xyz, vec3(tmpvar_10));
  gl_FragData[0] = col_4;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "VERTEXLIGHT_ON" "TINT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_FogParams;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _CausticTex_ST;
uniform highp float _Speed;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying lowp vec3 xlv_COLOR0;
varying highp float xlv_TEXCOORD5;
void main ()
{
  highp vec3 shlight_1;
  highp vec2 cUv_2;
  highp vec2 tmpvar_3;
  lowp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (glstate_matrix_mvp * tmpvar_6);
  highp vec3 tmpvar_7;
  tmpvar_7 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((_glesNormal * tmpvar_8));
  highp vec2 tmpvar_10;
  tmpvar_10.x = ((tmpvar_7.x * 0.866) + (tmpvar_7.y * 0.5));
  tmpvar_10.y = ((tmpvar_7.z * 0.866) + (tmpvar_7.y * 0.5));
  cUv_2 = ((tmpvar_10 * _CausticTex_ST.xy) + _CausticTex_ST.zw);
  mediump vec2 uv_11;
  uv_11 = cUv_2;
  mediump vec2 distortOffset_12;
  highp float tmpvar_13;
  tmpvar_13 = ((_Time * 20.0) * _Speed).x;
  highp vec2 tmpvar_14;
  tmpvar_14.x = sin((tmpvar_13 + (uv_11.y * 6.28)));
  tmpvar_14.y = sin((tmpvar_13 + (uv_11.x * 6.28)));
  highp vec2 tmpvar_15;
  tmpvar_15 = (tmpvar_14 * vec2(0.025, 0.01));
  distortOffset_12 = tmpvar_15;
  uv_11 = (uv_11 + distortOffset_12);
  uv_11.x = (uv_11.x + (_Time.x * 0.3));
  tmpvar_3 = uv_11;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = tmpvar_9;
  mediump vec4 normal_17;
  normal_17 = tmpvar_16;
  mediump vec3 res_18;
  mediump vec3 x_19;
  x_19.x = dot (unity_SHAr, normal_17);
  x_19.y = dot (unity_SHAg, normal_17);
  x_19.z = dot (unity_SHAb, normal_17);
  mediump vec3 x1_20;
  mediump vec4 tmpvar_21;
  tmpvar_21 = (normal_17.xyzz * normal_17.yzzx);
  x1_20.x = dot (unity_SHBr, tmpvar_21);
  x1_20.y = dot (unity_SHBg, tmpvar_21);
  x1_20.z = dot (unity_SHBb, tmpvar_21);
  res_18 = (x_19 + (x1_20 + (unity_SHC.xyz * 
    ((normal_17.x * normal_17.x) - (normal_17.y * normal_17.y))
  )));
  mediump vec3 tmpvar_22;
  tmpvar_22 = max (((1.055 * 
    pow (max (res_18, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_18 = tmpvar_22;
  shlight_1 = tmpvar_22;
  tmpvar_4 = shlight_1;
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_9;
  xlv_TEXCOORD3 = tmpvar_7;
  xlv_COLOR0 = tmpvar_4;
  xlv_TEXCOORD5 = ((tmpvar_5.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 unity_FogColor;
uniform lowp vec4 _LightColor0;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _CausticTex;
uniform lowp vec4 _WaterColor;
uniform lowp float _CausticIntensity;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_COLOR0;
varying highp float xlv_TEXCOORD5;
void main ()
{
  lowp vec4 caustic_1;
  lowp float diff_2;
  lowp vec3 lightDir_3;
  lowp vec4 col_4;
  mediump vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_4 = tmpvar_5;
  col_4.xyz = mix (col_4.xyz, (col_4.xyz * _WaterColor.xyz), _WaterColor.www);
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_3 = tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = max (0.0, dot (xlv_TEXCOORD2, lightDir_3));
  diff_2 = tmpvar_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = ((col_4.xyz * _LightColor0.xyz) * diff_2);
  col_4.xyz = (col_4.xyz * xlv_COLOR0);
  col_4.xyz = (col_4.xyz + tmpvar_8);
  mediump vec4 tmpvar_9;
  tmpvar_9 = (_CausticIntensity * texture2D (_CausticTex, xlv_TEXCOORD1));
  caustic_1 = tmpvar_9;
  caustic_1.xyz = mix (caustic_1.xyz, (caustic_1.xyz * _WaterColor.xyz), _WaterColor.www);
  col_4 = (col_4 + (caustic_1 * diff_2));
  highp float tmpvar_10;
  tmpvar_10 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  col_4.xyz = mix (unity_FogColor.xyz, col_4.xyz, vec3(tmpvar_10));
  gl_FragData[0] = col_4;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "FOG_LINEAR" "VERTEXLIGHT_ON" "TINT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_WorldToShadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_FogParams;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _CausticTex_ST;
uniform highp float _Speed;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying lowp vec3 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
void main ()
{
  highp vec3 shlight_1;
  highp vec2 cUv_2;
  highp vec2 tmpvar_3;
  lowp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (glstate_matrix_mvp * tmpvar_6);
  highp vec4 tmpvar_7;
  tmpvar_7 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((_glesNormal * tmpvar_8));
  highp vec2 tmpvar_10;
  tmpvar_10.x = ((tmpvar_7.x * 0.866) + (tmpvar_7.y * 0.5));
  tmpvar_10.y = ((tmpvar_7.z * 0.866) + (tmpvar_7.y * 0.5));
  cUv_2 = ((tmpvar_10 * _CausticTex_ST.xy) + _CausticTex_ST.zw);
  mediump vec2 uv_11;
  uv_11 = cUv_2;
  mediump vec2 distortOffset_12;
  highp float tmpvar_13;
  tmpvar_13 = ((_Time * 20.0) * _Speed).x;
  highp vec2 tmpvar_14;
  tmpvar_14.x = sin((tmpvar_13 + (uv_11.y * 6.28)));
  tmpvar_14.y = sin((tmpvar_13 + (uv_11.x * 6.28)));
  highp vec2 tmpvar_15;
  tmpvar_15 = (tmpvar_14 * vec2(0.025, 0.01));
  distortOffset_12 = tmpvar_15;
  uv_11 = (uv_11 + distortOffset_12);
  uv_11.x = (uv_11.x + (_Time.x * 0.3));
  tmpvar_3 = uv_11;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = tmpvar_9;
  mediump vec4 normal_17;
  normal_17 = tmpvar_16;
  mediump vec3 res_18;
  mediump vec3 x_19;
  x_19.x = dot (unity_SHAr, normal_17);
  x_19.y = dot (unity_SHAg, normal_17);
  x_19.z = dot (unity_SHAb, normal_17);
  mediump vec3 x1_20;
  mediump vec4 tmpvar_21;
  tmpvar_21 = (normal_17.xyzz * normal_17.yzzx);
  x1_20.x = dot (unity_SHBr, tmpvar_21);
  x1_20.y = dot (unity_SHBg, tmpvar_21);
  x1_20.z = dot (unity_SHBb, tmpvar_21);
  res_18 = (x_19 + (x1_20 + (unity_SHC.xyz * 
    ((normal_17.x * normal_17.x) - (normal_17.y * normal_17.y))
  )));
  mediump vec3 tmpvar_22;
  tmpvar_22 = max (((1.055 * 
    pow (max (res_18, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_18 = tmpvar_22;
  shlight_1 = tmpvar_22;
  tmpvar_4 = shlight_1;
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_9;
  xlv_TEXCOORD3 = tmpvar_7.xyz;
  xlv_COLOR0 = tmpvar_4;
  xlv_TEXCOORD4 = (unity_WorldToShadow[0] * tmpvar_7);
  xlv_TEXCOORD5 = ((tmpvar_5.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform mediump vec4 _LightShadowData;
uniform lowp vec4 unity_FogColor;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _ShadowMapTexture;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _CausticTex;
uniform lowp vec4 _WaterColor;
uniform lowp float _CausticIntensity;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
void main ()
{
  lowp vec4 caustic_1;
  lowp float diff_2;
  lowp vec3 lightDir_3;
  lowp vec4 col_4;
  mediump vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_4 = tmpvar_5;
  col_4.xyz = mix (col_4.xyz, (col_4.xyz * _WaterColor.xyz), _WaterColor.www);
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_3 = tmpvar_6;
  highp float lightShadowDataX_7;
  lowp vec2 outsideOfShadowmap_8;
  lowp vec2 coordCheck_9;
  highp vec2 tmpvar_10;
  tmpvar_10 = abs(((xlv_TEXCOORD4.xy * 2.0) - 1.0));
  coordCheck_9 = tmpvar_10;
  bvec2 tmpvar_11;
  tmpvar_11 = greaterThan (coordCheck_9, vec2(1.0, 1.0));
  lowp float tmpvar_12;
  if (tmpvar_11.x) {
    tmpvar_12 = 1.0;
  } else {
    tmpvar_12 = 0.0;
  };
  lowp float tmpvar_13;
  if (tmpvar_11.y) {
    tmpvar_13 = 1.0;
  } else {
    tmpvar_13 = 0.0;
  };
  lowp vec2 tmpvar_14;
  tmpvar_14.x = tmpvar_12;
  tmpvar_14.y = tmpvar_13;
  outsideOfShadowmap_8.y = tmpvar_14.y;
  outsideOfShadowmap_8.x = (tmpvar_12 + tmpvar_13);
  highp float tmpvar_15;
  if ((xlv_TEXCOORD4.z > 1.0)) {
    tmpvar_15 = 1.0;
  } else {
    tmpvar_15 = 0.0;
  };
  outsideOfShadowmap_8.x = (outsideOfShadowmap_8.x + tmpvar_15);
  mediump float tmpvar_16;
  tmpvar_16 = _LightShadowData.x;
  lightShadowDataX_7 = tmpvar_16;
  lowp float tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = clamp ((max (
    float((texture2D (_ShadowMapTexture, xlv_TEXCOORD4.xy).x > xlv_TEXCOORD4.z))
  , lightShadowDataX_7) + outsideOfShadowmap_8.x), 0.0, 1.0);
  tmpvar_17 = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = max (0.0, dot (xlv_TEXCOORD2, lightDir_3));
  diff_2 = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = ((col_4.xyz * _LightColor0.xyz) * (diff_2 * tmpvar_17));
  col_4.xyz = (col_4.xyz * xlv_COLOR0);
  col_4.xyz = (col_4.xyz + tmpvar_20);
  mediump vec4 tmpvar_21;
  tmpvar_21 = (_CausticIntensity * texture2D (_CausticTex, xlv_TEXCOORD1));
  caustic_1 = tmpvar_21;
  caustic_1.xyz = mix (caustic_1.xyz, (caustic_1.xyz * _WaterColor.xyz), _WaterColor.www);
  col_4 = (col_4 + ((caustic_1 * diff_2) * (
    (tmpvar_17 * 0.5)
   + 0.5)));
  highp float tmpvar_22;
  tmpvar_22 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  col_4.xyz = mix (unity_FogColor.xyz, col_4.xyz, vec3(tmpvar_22));
  gl_FragData[0] = col_4;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "FOG_LINEAR" "VERTEXLIGHT_ON" "TINT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_WorldToShadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_FogParams;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _CausticTex_ST;
uniform highp float _Speed;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying lowp vec3 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
void main ()
{
  highp vec3 shlight_1;
  highp vec2 cUv_2;
  highp vec2 tmpvar_3;
  lowp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (glstate_matrix_mvp * tmpvar_6);
  highp vec4 tmpvar_7;
  tmpvar_7 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((_glesNormal * tmpvar_8));
  highp vec2 tmpvar_10;
  tmpvar_10.x = ((tmpvar_7.x * 0.866) + (tmpvar_7.y * 0.5));
  tmpvar_10.y = ((tmpvar_7.z * 0.866) + (tmpvar_7.y * 0.5));
  cUv_2 = ((tmpvar_10 * _CausticTex_ST.xy) + _CausticTex_ST.zw);
  mediump vec2 uv_11;
  uv_11 = cUv_2;
  mediump vec2 distortOffset_12;
  highp float tmpvar_13;
  tmpvar_13 = ((_Time * 20.0) * _Speed).x;
  highp vec2 tmpvar_14;
  tmpvar_14.x = sin((tmpvar_13 + (uv_11.y * 6.28)));
  tmpvar_14.y = sin((tmpvar_13 + (uv_11.x * 6.28)));
  highp vec2 tmpvar_15;
  tmpvar_15 = (tmpvar_14 * vec2(0.025, 0.01));
  distortOffset_12 = tmpvar_15;
  uv_11 = (uv_11 + distortOffset_12);
  uv_11.x = (uv_11.x + (_Time.x * 0.3));
  tmpvar_3 = uv_11;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = tmpvar_9;
  mediump vec4 normal_17;
  normal_17 = tmpvar_16;
  mediump vec3 res_18;
  mediump vec3 x_19;
  x_19.x = dot (unity_SHAr, normal_17);
  x_19.y = dot (unity_SHAg, normal_17);
  x_19.z = dot (unity_SHAb, normal_17);
  mediump vec3 x1_20;
  mediump vec4 tmpvar_21;
  tmpvar_21 = (normal_17.xyzz * normal_17.yzzx);
  x1_20.x = dot (unity_SHBr, tmpvar_21);
  x1_20.y = dot (unity_SHBg, tmpvar_21);
  x1_20.z = dot (unity_SHBb, tmpvar_21);
  res_18 = (x_19 + (x1_20 + (unity_SHC.xyz * 
    ((normal_17.x * normal_17.x) - (normal_17.y * normal_17.y))
  )));
  mediump vec3 tmpvar_22;
  tmpvar_22 = max (((1.055 * 
    pow (max (res_18, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_18 = tmpvar_22;
  shlight_1 = tmpvar_22;
  tmpvar_4 = shlight_1;
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_9;
  xlv_TEXCOORD3 = tmpvar_7.xyz;
  xlv_COLOR0 = tmpvar_4;
  xlv_TEXCOORD4 = (unity_WorldToShadow[0] * tmpvar_7);
  xlv_TEXCOORD5 = ((tmpvar_5.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform mediump vec4 _LightShadowData;
uniform lowp vec4 unity_FogColor;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _ShadowMapTexture;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _CausticTex;
uniform lowp vec4 _WaterColor;
uniform lowp float _CausticIntensity;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
void main ()
{
  lowp vec4 caustic_1;
  lowp float diff_2;
  lowp vec3 lightDir_3;
  lowp vec4 col_4;
  mediump vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_4 = tmpvar_5;
  col_4.xyz = mix (col_4.xyz, (col_4.xyz * _WaterColor.xyz), _WaterColor.www);
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_3 = tmpvar_6;
  highp float lightShadowDataX_7;
  lowp vec2 outsideOfShadowmap_8;
  lowp vec2 coordCheck_9;
  highp vec2 tmpvar_10;
  tmpvar_10 = abs(((xlv_TEXCOORD4.xy * 2.0) - 1.0));
  coordCheck_9 = tmpvar_10;
  bvec2 tmpvar_11;
  tmpvar_11 = greaterThan (coordCheck_9, vec2(1.0, 1.0));
  lowp float tmpvar_12;
  if (tmpvar_11.x) {
    tmpvar_12 = 1.0;
  } else {
    tmpvar_12 = 0.0;
  };
  lowp float tmpvar_13;
  if (tmpvar_11.y) {
    tmpvar_13 = 1.0;
  } else {
    tmpvar_13 = 0.0;
  };
  lowp vec2 tmpvar_14;
  tmpvar_14.x = tmpvar_12;
  tmpvar_14.y = tmpvar_13;
  outsideOfShadowmap_8.y = tmpvar_14.y;
  outsideOfShadowmap_8.x = (tmpvar_12 + tmpvar_13);
  highp float tmpvar_15;
  if ((xlv_TEXCOORD4.z > 1.0)) {
    tmpvar_15 = 1.0;
  } else {
    tmpvar_15 = 0.0;
  };
  outsideOfShadowmap_8.x = (outsideOfShadowmap_8.x + tmpvar_15);
  mediump float tmpvar_16;
  tmpvar_16 = _LightShadowData.x;
  lightShadowDataX_7 = tmpvar_16;
  lowp float tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = clamp ((max (
    float((texture2D (_ShadowMapTexture, xlv_TEXCOORD4.xy).x > xlv_TEXCOORD4.z))
  , lightShadowDataX_7) + outsideOfShadowmap_8.x), 0.0, 1.0);
  tmpvar_17 = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = max (0.0, dot (xlv_TEXCOORD2, lightDir_3));
  diff_2 = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = ((col_4.xyz * _LightColor0.xyz) * (diff_2 * tmpvar_17));
  col_4.xyz = (col_4.xyz * xlv_COLOR0);
  col_4.xyz = (col_4.xyz + tmpvar_20);
  mediump vec4 tmpvar_21;
  tmpvar_21 = (_CausticIntensity * texture2D (_CausticTex, xlv_TEXCOORD1));
  caustic_1 = tmpvar_21;
  caustic_1.xyz = mix (caustic_1.xyz, (caustic_1.xyz * _WaterColor.xyz), _WaterColor.www);
  col_4 = (col_4 + ((caustic_1 * diff_2) * (
    (tmpvar_17 * 0.5)
   + 0.5)));
  highp float tmpvar_22;
  tmpvar_22 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  col_4.xyz = mix (unity_FogColor.xyz, col_4.xyz, vec3(tmpvar_22));
  gl_FragData[0] = col_4;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "FOG_LINEAR" "VERTEXLIGHT_ON" "TINT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_WorldToShadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_FogParams;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _CausticTex_ST;
uniform highp float _Speed;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying lowp vec3 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
void main ()
{
  highp vec3 shlight_1;
  highp vec2 cUv_2;
  highp vec2 tmpvar_3;
  lowp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (glstate_matrix_mvp * tmpvar_6);
  highp vec4 tmpvar_7;
  tmpvar_7 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((_glesNormal * tmpvar_8));
  highp vec2 tmpvar_10;
  tmpvar_10.x = ((tmpvar_7.x * 0.866) + (tmpvar_7.y * 0.5));
  tmpvar_10.y = ((tmpvar_7.z * 0.866) + (tmpvar_7.y * 0.5));
  cUv_2 = ((tmpvar_10 * _CausticTex_ST.xy) + _CausticTex_ST.zw);
  mediump vec2 uv_11;
  uv_11 = cUv_2;
  mediump vec2 distortOffset_12;
  highp float tmpvar_13;
  tmpvar_13 = ((_Time * 20.0) * _Speed).x;
  highp vec2 tmpvar_14;
  tmpvar_14.x = sin((tmpvar_13 + (uv_11.y * 6.28)));
  tmpvar_14.y = sin((tmpvar_13 + (uv_11.x * 6.28)));
  highp vec2 tmpvar_15;
  tmpvar_15 = (tmpvar_14 * vec2(0.025, 0.01));
  distortOffset_12 = tmpvar_15;
  uv_11 = (uv_11 + distortOffset_12);
  uv_11.x = (uv_11.x + (_Time.x * 0.3));
  tmpvar_3 = uv_11;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = tmpvar_9;
  mediump vec4 normal_17;
  normal_17 = tmpvar_16;
  mediump vec3 res_18;
  mediump vec3 x_19;
  x_19.x = dot (unity_SHAr, normal_17);
  x_19.y = dot (unity_SHAg, normal_17);
  x_19.z = dot (unity_SHAb, normal_17);
  mediump vec3 x1_20;
  mediump vec4 tmpvar_21;
  tmpvar_21 = (normal_17.xyzz * normal_17.yzzx);
  x1_20.x = dot (unity_SHBr, tmpvar_21);
  x1_20.y = dot (unity_SHBg, tmpvar_21);
  x1_20.z = dot (unity_SHBb, tmpvar_21);
  res_18 = (x_19 + (x1_20 + (unity_SHC.xyz * 
    ((normal_17.x * normal_17.x) - (normal_17.y * normal_17.y))
  )));
  mediump vec3 tmpvar_22;
  tmpvar_22 = max (((1.055 * 
    pow (max (res_18, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_18 = tmpvar_22;
  shlight_1 = tmpvar_22;
  tmpvar_4 = shlight_1;
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_9;
  xlv_TEXCOORD3 = tmpvar_7.xyz;
  xlv_COLOR0 = tmpvar_4;
  xlv_TEXCOORD4 = (unity_WorldToShadow[0] * tmpvar_7);
  xlv_TEXCOORD5 = ((tmpvar_5.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform mediump vec4 _LightShadowData;
uniform lowp vec4 unity_FogColor;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _ShadowMapTexture;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _CausticTex;
uniform lowp vec4 _WaterColor;
uniform lowp float _CausticIntensity;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
void main ()
{
  lowp vec4 caustic_1;
  lowp float diff_2;
  lowp vec3 lightDir_3;
  lowp vec4 col_4;
  mediump vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_4 = tmpvar_5;
  col_4.xyz = mix (col_4.xyz, (col_4.xyz * _WaterColor.xyz), _WaterColor.www);
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_3 = tmpvar_6;
  highp float lightShadowDataX_7;
  lowp vec2 outsideOfShadowmap_8;
  lowp vec2 coordCheck_9;
  highp vec2 tmpvar_10;
  tmpvar_10 = abs(((xlv_TEXCOORD4.xy * 2.0) - 1.0));
  coordCheck_9 = tmpvar_10;
  bvec2 tmpvar_11;
  tmpvar_11 = greaterThan (coordCheck_9, vec2(1.0, 1.0));
  lowp float tmpvar_12;
  if (tmpvar_11.x) {
    tmpvar_12 = 1.0;
  } else {
    tmpvar_12 = 0.0;
  };
  lowp float tmpvar_13;
  if (tmpvar_11.y) {
    tmpvar_13 = 1.0;
  } else {
    tmpvar_13 = 0.0;
  };
  lowp vec2 tmpvar_14;
  tmpvar_14.x = tmpvar_12;
  tmpvar_14.y = tmpvar_13;
  outsideOfShadowmap_8.y = tmpvar_14.y;
  outsideOfShadowmap_8.x = (tmpvar_12 + tmpvar_13);
  highp float tmpvar_15;
  if ((xlv_TEXCOORD4.z > 1.0)) {
    tmpvar_15 = 1.0;
  } else {
    tmpvar_15 = 0.0;
  };
  outsideOfShadowmap_8.x = (outsideOfShadowmap_8.x + tmpvar_15);
  mediump float tmpvar_16;
  tmpvar_16 = _LightShadowData.x;
  lightShadowDataX_7 = tmpvar_16;
  lowp float tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = clamp ((max (
    float((texture2D (_ShadowMapTexture, xlv_TEXCOORD4.xy).x > xlv_TEXCOORD4.z))
  , lightShadowDataX_7) + outsideOfShadowmap_8.x), 0.0, 1.0);
  tmpvar_17 = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = max (0.0, dot (xlv_TEXCOORD2, lightDir_3));
  diff_2 = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = ((col_4.xyz * _LightColor0.xyz) * (diff_2 * tmpvar_17));
  col_4.xyz = (col_4.xyz * xlv_COLOR0);
  col_4.xyz = (col_4.xyz + tmpvar_20);
  mediump vec4 tmpvar_21;
  tmpvar_21 = (_CausticIntensity * texture2D (_CausticTex, xlv_TEXCOORD1));
  caustic_1 = tmpvar_21;
  caustic_1.xyz = mix (caustic_1.xyz, (caustic_1.xyz * _WaterColor.xyz), _WaterColor.www);
  col_4 = (col_4 + ((caustic_1 * diff_2) * (
    (tmpvar_17 * 0.5)
   + 0.5)));
  highp float tmpvar_22;
  tmpvar_22 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  col_4.xyz = mix (unity_FogColor.xyz, col_4.xyz, vec3(tmpvar_22));
  gl_FragData[0] = col_4;
}


#endif
"
}
}
Program "fp" {
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "TINT" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "TINT" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "TINT" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "TINT" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "TINT" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "TINT" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "TINT" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "TINT" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "TINT" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "FOG_LINEAR" "TINT" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "FOG_LINEAR" "TINT" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "FOG_LINEAR" "TINT" }
""
}
}
}
}
Fallback "Mobile/Diffuse"
}