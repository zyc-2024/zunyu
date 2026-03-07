Shader "Mobile/Move/Move4" {
Properties {
_MainTex ("Main Tex", 2D) = "white" { }
_FlagColor ("Flag Color", Color) = (1,1,1,1)
_Frequency ("Frequency", Float) = 1
_AmplitudeStrength ("Amplitude Strength", Float) = 1
_InvWaveLength ("Inverse Wave Length", Float) = 1
_Fold ("Fold", Range(0, 2)) = 0.5
_Leaves ("leaves", Float) = 100
_Init ("InitPostion", Float) = 0
}
SubShader {
 Tags { "DisableBatching" = "true" "RenderType" = "Opaque" }
 Pass {
  Tags { "DisableBatching" = "true" "LIGHTMODE" = "ForwardBase" "RenderType" = "Opaque" "SHADOWSUPPORT" = "true" }
  ZClip Off
  Cull Off
  GpuProgramID 19957
Program "vp" {
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 _MainTex_ST;
uniform highp float _Frequency;
uniform highp float _AmplitudeStrength;
uniform highp float _InvWaveLength;
uniform highp float _Fold;
uniform highp float _Init;
uniform highp int _Leaves;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 offset_1;
  offset_1.xyw = vec3(0.0, 0.0, 0.0);
  offset_1.z = (_AmplitudeStrength * sin((
    ((_Frequency * _Time.y) + (((
      -(sin(abs(_glesVertex.x)))
     * 
      float(_Leaves)
    ) + (
      (unity_ObjectToWorld * _glesVertex)
    .y * _Fold)) * _InvWaveLength))
   + _Init)));
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = (_glesVertex + offset_1).xyz;
  highp mat3 tmpvar_3;
  tmpvar_3[0] = unity_WorldToObject[0].xyz;
  tmpvar_3[1] = unity_WorldToObject[1].xyz;
  tmpvar_3[2] = unity_WorldToObject[2].xyz;
  gl_Position = (glstate_matrix_mvp * tmpvar_2);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = (unity_ObjectToWorld * (_glesVertex + offset_1));
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_3));
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _FlagColor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  highp float tmpvar_1;
  if (gl_FrontFacing) {
    tmpvar_1 = 1.0;
  } else {
    tmpvar_1 = -1.0;
  };
  highp vec3 tmpvar_2;
  tmpvar_2 = xlv_TEXCOORD2;
  lowp vec4 finalRGBA_3;
  highp vec3 lightDirection_4;
  highp int tmpvar_5;
  if ((tmpvar_1 >= 0.0)) {
    tmpvar_5 = 1;
  } else {
    tmpvar_5 = -1;
  };
  tmpvar_2 = (normalize(xlv_TEXCOORD2) * float(tmpvar_5));
  mediump vec3 tmpvar_6;
  tmpvar_6 = normalize(_WorldSpaceLightPos0.xyz);
  lightDirection_4 = tmpvar_6;
  lowp vec4 tmpvar_7;
  highp vec2 P_8;
  P_8 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_7 = texture2D (_MainTex, P_8);
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_7 * _FlagColor);
  highp vec4 tmpvar_10;
  tmpvar_10.xyz = (((
    max (0.0, dot (tmpvar_2, lightDirection_4))
   * _LightColor0.xyz) + (glstate_lightmodel_ambient * 2.0).xyz) * tmpvar_9.xyz);
  tmpvar_10.w = tmpvar_9.w;
  finalRGBA_3 = tmpvar_10;
  gl_FragData[0] = finalRGBA_3;
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
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 _MainTex_ST;
uniform highp float _Frequency;
uniform highp float _AmplitudeStrength;
uniform highp float _InvWaveLength;
uniform highp float _Fold;
uniform highp float _Init;
uniform highp int _Leaves;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 offset_1;
  offset_1.xyw = vec3(0.0, 0.0, 0.0);
  offset_1.z = (_AmplitudeStrength * sin((
    ((_Frequency * _Time.y) + (((
      -(sin(abs(_glesVertex.x)))
     * 
      float(_Leaves)
    ) + (
      (unity_ObjectToWorld * _glesVertex)
    .y * _Fold)) * _InvWaveLength))
   + _Init)));
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = (_glesVertex + offset_1).xyz;
  highp mat3 tmpvar_3;
  tmpvar_3[0] = unity_WorldToObject[0].xyz;
  tmpvar_3[1] = unity_WorldToObject[1].xyz;
  tmpvar_3[2] = unity_WorldToObject[2].xyz;
  gl_Position = (glstate_matrix_mvp * tmpvar_2);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = (unity_ObjectToWorld * (_glesVertex + offset_1));
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_3));
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _FlagColor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  highp float tmpvar_1;
  if (gl_FrontFacing) {
    tmpvar_1 = 1.0;
  } else {
    tmpvar_1 = -1.0;
  };
  highp vec3 tmpvar_2;
  tmpvar_2 = xlv_TEXCOORD2;
  lowp vec4 finalRGBA_3;
  highp vec3 lightDirection_4;
  highp int tmpvar_5;
  if ((tmpvar_1 >= 0.0)) {
    tmpvar_5 = 1;
  } else {
    tmpvar_5 = -1;
  };
  tmpvar_2 = (normalize(xlv_TEXCOORD2) * float(tmpvar_5));
  mediump vec3 tmpvar_6;
  tmpvar_6 = normalize(_WorldSpaceLightPos0.xyz);
  lightDirection_4 = tmpvar_6;
  lowp vec4 tmpvar_7;
  highp vec2 P_8;
  P_8 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_7 = texture2D (_MainTex, P_8);
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_7 * _FlagColor);
  highp vec4 tmpvar_10;
  tmpvar_10.xyz = (((
    max (0.0, dot (tmpvar_2, lightDirection_4))
   * _LightColor0.xyz) + (glstate_lightmodel_ambient * 2.0).xyz) * tmpvar_9.xyz);
  tmpvar_10.w = tmpvar_9.w;
  finalRGBA_3 = tmpvar_10;
  gl_FragData[0] = finalRGBA_3;
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
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 _MainTex_ST;
uniform highp float _Frequency;
uniform highp float _AmplitudeStrength;
uniform highp float _InvWaveLength;
uniform highp float _Fold;
uniform highp float _Init;
uniform highp int _Leaves;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 offset_1;
  offset_1.xyw = vec3(0.0, 0.0, 0.0);
  offset_1.z = (_AmplitudeStrength * sin((
    ((_Frequency * _Time.y) + (((
      -(sin(abs(_glesVertex.x)))
     * 
      float(_Leaves)
    ) + (
      (unity_ObjectToWorld * _glesVertex)
    .y * _Fold)) * _InvWaveLength))
   + _Init)));
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = (_glesVertex + offset_1).xyz;
  highp mat3 tmpvar_3;
  tmpvar_3[0] = unity_WorldToObject[0].xyz;
  tmpvar_3[1] = unity_WorldToObject[1].xyz;
  tmpvar_3[2] = unity_WorldToObject[2].xyz;
  gl_Position = (glstate_matrix_mvp * tmpvar_2);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = (unity_ObjectToWorld * (_glesVertex + offset_1));
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_3));
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _FlagColor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  highp float tmpvar_1;
  if (gl_FrontFacing) {
    tmpvar_1 = 1.0;
  } else {
    tmpvar_1 = -1.0;
  };
  highp vec3 tmpvar_2;
  tmpvar_2 = xlv_TEXCOORD2;
  lowp vec4 finalRGBA_3;
  highp vec3 lightDirection_4;
  highp int tmpvar_5;
  if ((tmpvar_1 >= 0.0)) {
    tmpvar_5 = 1;
  } else {
    tmpvar_5 = -1;
  };
  tmpvar_2 = (normalize(xlv_TEXCOORD2) * float(tmpvar_5));
  mediump vec3 tmpvar_6;
  tmpvar_6 = normalize(_WorldSpaceLightPos0.xyz);
  lightDirection_4 = tmpvar_6;
  lowp vec4 tmpvar_7;
  highp vec2 P_8;
  P_8 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_7 = texture2D (_MainTex, P_8);
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_7 * _FlagColor);
  highp vec4 tmpvar_10;
  tmpvar_10.xyz = (((
    max (0.0, dot (tmpvar_2, lightDirection_4))
   * _LightColor0.xyz) + (glstate_lightmodel_ambient * 2.0).xyz) * tmpvar_9.xyz);
  tmpvar_10.w = tmpvar_9.w;
  finalRGBA_3 = tmpvar_10;
  gl_FragData[0] = finalRGBA_3;
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
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 _MainTex_ST;
uniform highp float _Frequency;
uniform highp float _AmplitudeStrength;
uniform highp float _InvWaveLength;
uniform highp float _Fold;
uniform highp float _Init;
uniform highp int _Leaves;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 offset_1;
  offset_1.xyw = vec3(0.0, 0.0, 0.0);
  offset_1.z = (_AmplitudeStrength * sin((
    ((_Frequency * _Time.y) + (((
      -(sin(abs(_glesVertex.x)))
     * 
      float(_Leaves)
    ) + (
      (unity_ObjectToWorld * _glesVertex)
    .y * _Fold)) * _InvWaveLength))
   + _Init)));
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = (_glesVertex + offset_1).xyz;
  highp mat3 tmpvar_3;
  tmpvar_3[0] = unity_WorldToObject[0].xyz;
  tmpvar_3[1] = unity_WorldToObject[1].xyz;
  tmpvar_3[2] = unity_WorldToObject[2].xyz;
  gl_Position = (glstate_matrix_mvp * tmpvar_2);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = (unity_ObjectToWorld * (_glesVertex + offset_1));
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_3));
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _FlagColor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  highp float tmpvar_1;
  if (gl_FrontFacing) {
    tmpvar_1 = 1.0;
  } else {
    tmpvar_1 = -1.0;
  };
  highp vec3 tmpvar_2;
  tmpvar_2 = xlv_TEXCOORD2;
  lowp vec4 finalRGBA_3;
  highp vec3 lightDirection_4;
  highp int tmpvar_5;
  if ((tmpvar_1 >= 0.0)) {
    tmpvar_5 = 1;
  } else {
    tmpvar_5 = -1;
  };
  tmpvar_2 = (normalize(xlv_TEXCOORD2) * float(tmpvar_5));
  mediump vec3 tmpvar_6;
  tmpvar_6 = normalize(_WorldSpaceLightPos0.xyz);
  lightDirection_4 = tmpvar_6;
  lowp vec4 tmpvar_7;
  highp vec2 P_8;
  P_8 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_7 = texture2D (_MainTex, P_8);
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_7 * _FlagColor);
  highp vec4 tmpvar_10;
  tmpvar_10.xyz = (((
    max (0.0, dot (tmpvar_2, lightDirection_4))
   * _LightColor0.xyz) + (glstate_lightmodel_ambient * 2.0).xyz) * tmpvar_9.xyz);
  tmpvar_10.w = tmpvar_9.w;
  finalRGBA_3 = tmpvar_10;
  gl_FragData[0] = finalRGBA_3;
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
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 _MainTex_ST;
uniform highp float _Frequency;
uniform highp float _AmplitudeStrength;
uniform highp float _InvWaveLength;
uniform highp float _Fold;
uniform highp float _Init;
uniform highp int _Leaves;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 offset_1;
  offset_1.xyw = vec3(0.0, 0.0, 0.0);
  offset_1.z = (_AmplitudeStrength * sin((
    ((_Frequency * _Time.y) + (((
      -(sin(abs(_glesVertex.x)))
     * 
      float(_Leaves)
    ) + (
      (unity_ObjectToWorld * _glesVertex)
    .y * _Fold)) * _InvWaveLength))
   + _Init)));
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = (_glesVertex + offset_1).xyz;
  highp mat3 tmpvar_3;
  tmpvar_3[0] = unity_WorldToObject[0].xyz;
  tmpvar_3[1] = unity_WorldToObject[1].xyz;
  tmpvar_3[2] = unity_WorldToObject[2].xyz;
  gl_Position = (glstate_matrix_mvp * tmpvar_2);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = (unity_ObjectToWorld * (_glesVertex + offset_1));
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_3));
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _FlagColor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  highp float tmpvar_1;
  if (gl_FrontFacing) {
    tmpvar_1 = 1.0;
  } else {
    tmpvar_1 = -1.0;
  };
  highp vec3 tmpvar_2;
  tmpvar_2 = xlv_TEXCOORD2;
  lowp vec4 finalRGBA_3;
  highp vec3 lightDirection_4;
  highp int tmpvar_5;
  if ((tmpvar_1 >= 0.0)) {
    tmpvar_5 = 1;
  } else {
    tmpvar_5 = -1;
  };
  tmpvar_2 = (normalize(xlv_TEXCOORD2) * float(tmpvar_5));
  mediump vec3 tmpvar_6;
  tmpvar_6 = normalize(_WorldSpaceLightPos0.xyz);
  lightDirection_4 = tmpvar_6;
  lowp vec4 tmpvar_7;
  highp vec2 P_8;
  P_8 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_7 = texture2D (_MainTex, P_8);
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_7 * _FlagColor);
  highp vec4 tmpvar_10;
  tmpvar_10.xyz = (((
    max (0.0, dot (tmpvar_2, lightDirection_4))
   * _LightColor0.xyz) + (glstate_lightmodel_ambient * 2.0).xyz) * tmpvar_9.xyz);
  tmpvar_10.w = tmpvar_9.w;
  finalRGBA_3 = tmpvar_10;
  gl_FragData[0] = finalRGBA_3;
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
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 _MainTex_ST;
uniform highp float _Frequency;
uniform highp float _AmplitudeStrength;
uniform highp float _InvWaveLength;
uniform highp float _Fold;
uniform highp float _Init;
uniform highp int _Leaves;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 offset_1;
  offset_1.xyw = vec3(0.0, 0.0, 0.0);
  offset_1.z = (_AmplitudeStrength * sin((
    ((_Frequency * _Time.y) + (((
      -(sin(abs(_glesVertex.x)))
     * 
      float(_Leaves)
    ) + (
      (unity_ObjectToWorld * _glesVertex)
    .y * _Fold)) * _InvWaveLength))
   + _Init)));
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = (_glesVertex + offset_1).xyz;
  highp mat3 tmpvar_3;
  tmpvar_3[0] = unity_WorldToObject[0].xyz;
  tmpvar_3[1] = unity_WorldToObject[1].xyz;
  tmpvar_3[2] = unity_WorldToObject[2].xyz;
  gl_Position = (glstate_matrix_mvp * tmpvar_2);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = (unity_ObjectToWorld * (_glesVertex + offset_1));
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_3));
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _FlagColor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  highp float tmpvar_1;
  if (gl_FrontFacing) {
    tmpvar_1 = 1.0;
  } else {
    tmpvar_1 = -1.0;
  };
  highp vec3 tmpvar_2;
  tmpvar_2 = xlv_TEXCOORD2;
  lowp vec4 finalRGBA_3;
  highp vec3 lightDirection_4;
  highp int tmpvar_5;
  if ((tmpvar_1 >= 0.0)) {
    tmpvar_5 = 1;
  } else {
    tmpvar_5 = -1;
  };
  tmpvar_2 = (normalize(xlv_TEXCOORD2) * float(tmpvar_5));
  mediump vec3 tmpvar_6;
  tmpvar_6 = normalize(_WorldSpaceLightPos0.xyz);
  lightDirection_4 = tmpvar_6;
  lowp vec4 tmpvar_7;
  highp vec2 P_8;
  P_8 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_7 = texture2D (_MainTex, P_8);
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_7 * _FlagColor);
  highp vec4 tmpvar_10;
  tmpvar_10.xyz = (((
    max (0.0, dot (tmpvar_2, lightDirection_4))
   * _LightColor0.xyz) + (glstate_lightmodel_ambient * 2.0).xyz) * tmpvar_9.xyz);
  tmpvar_10.w = tmpvar_9.w;
  finalRGBA_3 = tmpvar_10;
  gl_FragData[0] = finalRGBA_3;
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
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 _MainTex_ST;
uniform highp float _Frequency;
uniform highp float _AmplitudeStrength;
uniform highp float _InvWaveLength;
uniform highp float _Fold;
uniform highp float _Init;
uniform highp int _Leaves;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 offset_1;
  offset_1.xyw = vec3(0.0, 0.0, 0.0);
  offset_1.z = (_AmplitudeStrength * sin((
    ((_Frequency * _Time.y) + (((
      -(sin(abs(_glesVertex.x)))
     * 
      float(_Leaves)
    ) + (
      (unity_ObjectToWorld * _glesVertex)
    .y * _Fold)) * _InvWaveLength))
   + _Init)));
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = (_glesVertex + offset_1).xyz;
  highp mat3 tmpvar_3;
  tmpvar_3[0] = unity_WorldToObject[0].xyz;
  tmpvar_3[1] = unity_WorldToObject[1].xyz;
  tmpvar_3[2] = unity_WorldToObject[2].xyz;
  gl_Position = (glstate_matrix_mvp * tmpvar_2);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = (unity_ObjectToWorld * (_glesVertex + offset_1));
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_3));
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _FlagColor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  highp float tmpvar_1;
  if (gl_FrontFacing) {
    tmpvar_1 = 1.0;
  } else {
    tmpvar_1 = -1.0;
  };
  highp vec3 tmpvar_2;
  tmpvar_2 = xlv_TEXCOORD2;
  lowp vec4 finalRGBA_3;
  highp vec3 lightDirection_4;
  highp int tmpvar_5;
  if ((tmpvar_1 >= 0.0)) {
    tmpvar_5 = 1;
  } else {
    tmpvar_5 = -1;
  };
  tmpvar_2 = (normalize(xlv_TEXCOORD2) * float(tmpvar_5));
  mediump vec3 tmpvar_6;
  tmpvar_6 = normalize(_WorldSpaceLightPos0.xyz);
  lightDirection_4 = tmpvar_6;
  lowp vec4 tmpvar_7;
  highp vec2 P_8;
  P_8 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_7 = texture2D (_MainTex, P_8);
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_7 * _FlagColor);
  highp vec4 tmpvar_10;
  tmpvar_10.xyz = (((
    max (0.0, dot (tmpvar_2, lightDirection_4))
   * _LightColor0.xyz) + (glstate_lightmodel_ambient * 2.0).xyz) * tmpvar_9.xyz);
  tmpvar_10.w = tmpvar_9.w;
  finalRGBA_3 = tmpvar_10;
  gl_FragData[0] = finalRGBA_3;
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
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 _MainTex_ST;
uniform highp float _Frequency;
uniform highp float _AmplitudeStrength;
uniform highp float _InvWaveLength;
uniform highp float _Fold;
uniform highp float _Init;
uniform highp int _Leaves;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 offset_1;
  offset_1.xyw = vec3(0.0, 0.0, 0.0);
  offset_1.z = (_AmplitudeStrength * sin((
    ((_Frequency * _Time.y) + (((
      -(sin(abs(_glesVertex.x)))
     * 
      float(_Leaves)
    ) + (
      (unity_ObjectToWorld * _glesVertex)
    .y * _Fold)) * _InvWaveLength))
   + _Init)));
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = (_glesVertex + offset_1).xyz;
  highp mat3 tmpvar_3;
  tmpvar_3[0] = unity_WorldToObject[0].xyz;
  tmpvar_3[1] = unity_WorldToObject[1].xyz;
  tmpvar_3[2] = unity_WorldToObject[2].xyz;
  gl_Position = (glstate_matrix_mvp * tmpvar_2);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = (unity_ObjectToWorld * (_glesVertex + offset_1));
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_3));
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _FlagColor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  highp float tmpvar_1;
  if (gl_FrontFacing) {
    tmpvar_1 = 1.0;
  } else {
    tmpvar_1 = -1.0;
  };
  highp vec3 tmpvar_2;
  tmpvar_2 = xlv_TEXCOORD2;
  lowp vec4 finalRGBA_3;
  highp vec3 lightDirection_4;
  highp int tmpvar_5;
  if ((tmpvar_1 >= 0.0)) {
    tmpvar_5 = 1;
  } else {
    tmpvar_5 = -1;
  };
  tmpvar_2 = (normalize(xlv_TEXCOORD2) * float(tmpvar_5));
  mediump vec3 tmpvar_6;
  tmpvar_6 = normalize(_WorldSpaceLightPos0.xyz);
  lightDirection_4 = tmpvar_6;
  lowp vec4 tmpvar_7;
  highp vec2 P_8;
  P_8 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_7 = texture2D (_MainTex, P_8);
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_7 * _FlagColor);
  highp vec4 tmpvar_10;
  tmpvar_10.xyz = (((
    max (0.0, dot (tmpvar_2, lightDirection_4))
   * _LightColor0.xyz) + (glstate_lightmodel_ambient * 2.0).xyz) * tmpvar_9.xyz);
  tmpvar_10.w = tmpvar_9.w;
  finalRGBA_3 = tmpvar_10;
  gl_FragData[0] = finalRGBA_3;
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
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 _MainTex_ST;
uniform highp float _Frequency;
uniform highp float _AmplitudeStrength;
uniform highp float _InvWaveLength;
uniform highp float _Fold;
uniform highp float _Init;
uniform highp int _Leaves;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 offset_1;
  offset_1.xyw = vec3(0.0, 0.0, 0.0);
  offset_1.z = (_AmplitudeStrength * sin((
    ((_Frequency * _Time.y) + (((
      -(sin(abs(_glesVertex.x)))
     * 
      float(_Leaves)
    ) + (
      (unity_ObjectToWorld * _glesVertex)
    .y * _Fold)) * _InvWaveLength))
   + _Init)));
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = (_glesVertex + offset_1).xyz;
  highp mat3 tmpvar_3;
  tmpvar_3[0] = unity_WorldToObject[0].xyz;
  tmpvar_3[1] = unity_WorldToObject[1].xyz;
  tmpvar_3[2] = unity_WorldToObject[2].xyz;
  gl_Position = (glstate_matrix_mvp * tmpvar_2);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = (unity_ObjectToWorld * (_glesVertex + offset_1));
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_3));
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _FlagColor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  highp float tmpvar_1;
  if (gl_FrontFacing) {
    tmpvar_1 = 1.0;
  } else {
    tmpvar_1 = -1.0;
  };
  highp vec3 tmpvar_2;
  tmpvar_2 = xlv_TEXCOORD2;
  lowp vec4 finalRGBA_3;
  highp vec3 lightDirection_4;
  highp int tmpvar_5;
  if ((tmpvar_1 >= 0.0)) {
    tmpvar_5 = 1;
  } else {
    tmpvar_5 = -1;
  };
  tmpvar_2 = (normalize(xlv_TEXCOORD2) * float(tmpvar_5));
  mediump vec3 tmpvar_6;
  tmpvar_6 = normalize(_WorldSpaceLightPos0.xyz);
  lightDirection_4 = tmpvar_6;
  lowp vec4 tmpvar_7;
  highp vec2 P_8;
  P_8 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_7 = texture2D (_MainTex, P_8);
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_7 * _FlagColor);
  highp vec4 tmpvar_10;
  tmpvar_10.xyz = (((
    max (0.0, dot (tmpvar_2, lightDirection_4))
   * _LightColor0.xyz) + (glstate_lightmodel_ambient * 2.0).xyz) * tmpvar_9.xyz);
  tmpvar_10.w = tmpvar_9.w;
  finalRGBA_3 = tmpvar_10;
  gl_FragData[0] = finalRGBA_3;
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
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 _MainTex_ST;
uniform highp float _Frequency;
uniform highp float _AmplitudeStrength;
uniform highp float _InvWaveLength;
uniform highp float _Fold;
uniform highp float _Init;
uniform highp int _Leaves;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 offset_1;
  offset_1.xyw = vec3(0.0, 0.0, 0.0);
  offset_1.z = (_AmplitudeStrength * sin((
    ((_Frequency * _Time.y) + (((
      -(sin(abs(_glesVertex.x)))
     * 
      float(_Leaves)
    ) + (
      (unity_ObjectToWorld * _glesVertex)
    .y * _Fold)) * _InvWaveLength))
   + _Init)));
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = (_glesVertex + offset_1).xyz;
  highp mat3 tmpvar_3;
  tmpvar_3[0] = unity_WorldToObject[0].xyz;
  tmpvar_3[1] = unity_WorldToObject[1].xyz;
  tmpvar_3[2] = unity_WorldToObject[2].xyz;
  gl_Position = (glstate_matrix_mvp * tmpvar_2);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = (unity_ObjectToWorld * (_glesVertex + offset_1));
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_3));
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _FlagColor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  highp float tmpvar_1;
  if (gl_FrontFacing) {
    tmpvar_1 = 1.0;
  } else {
    tmpvar_1 = -1.0;
  };
  highp vec3 tmpvar_2;
  tmpvar_2 = xlv_TEXCOORD2;
  lowp vec4 finalRGBA_3;
  highp vec3 lightDirection_4;
  highp int tmpvar_5;
  if ((tmpvar_1 >= 0.0)) {
    tmpvar_5 = 1;
  } else {
    tmpvar_5 = -1;
  };
  tmpvar_2 = (normalize(xlv_TEXCOORD2) * float(tmpvar_5));
  mediump vec3 tmpvar_6;
  tmpvar_6 = normalize(_WorldSpaceLightPos0.xyz);
  lightDirection_4 = tmpvar_6;
  lowp vec4 tmpvar_7;
  highp vec2 P_8;
  P_8 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_7 = texture2D (_MainTex, P_8);
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_7 * _FlagColor);
  highp vec4 tmpvar_10;
  tmpvar_10.xyz = (((
    max (0.0, dot (tmpvar_2, lightDirection_4))
   * _LightColor0.xyz) + (glstate_lightmodel_ambient * 2.0).xyz) * tmpvar_9.xyz);
  tmpvar_10.w = tmpvar_9.w;
  finalRGBA_3 = tmpvar_10;
  gl_FragData[0] = finalRGBA_3;
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
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 _MainTex_ST;
uniform highp float _Frequency;
uniform highp float _AmplitudeStrength;
uniform highp float _InvWaveLength;
uniform highp float _Fold;
uniform highp float _Init;
uniform highp int _Leaves;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 offset_1;
  offset_1.xyw = vec3(0.0, 0.0, 0.0);
  offset_1.z = (_AmplitudeStrength * sin((
    ((_Frequency * _Time.y) + (((
      -(sin(abs(_glesVertex.x)))
     * 
      float(_Leaves)
    ) + (
      (unity_ObjectToWorld * _glesVertex)
    .y * _Fold)) * _InvWaveLength))
   + _Init)));
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = (_glesVertex + offset_1).xyz;
  highp mat3 tmpvar_3;
  tmpvar_3[0] = unity_WorldToObject[0].xyz;
  tmpvar_3[1] = unity_WorldToObject[1].xyz;
  tmpvar_3[2] = unity_WorldToObject[2].xyz;
  gl_Position = (glstate_matrix_mvp * tmpvar_2);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = (unity_ObjectToWorld * (_glesVertex + offset_1));
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_3));
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _FlagColor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  highp float tmpvar_1;
  if (gl_FrontFacing) {
    tmpvar_1 = 1.0;
  } else {
    tmpvar_1 = -1.0;
  };
  highp vec3 tmpvar_2;
  tmpvar_2 = xlv_TEXCOORD2;
  lowp vec4 finalRGBA_3;
  highp vec3 lightDirection_4;
  highp int tmpvar_5;
  if ((tmpvar_1 >= 0.0)) {
    tmpvar_5 = 1;
  } else {
    tmpvar_5 = -1;
  };
  tmpvar_2 = (normalize(xlv_TEXCOORD2) * float(tmpvar_5));
  mediump vec3 tmpvar_6;
  tmpvar_6 = normalize(_WorldSpaceLightPos0.xyz);
  lightDirection_4 = tmpvar_6;
  lowp vec4 tmpvar_7;
  highp vec2 P_8;
  P_8 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_7 = texture2D (_MainTex, P_8);
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_7 * _FlagColor);
  highp vec4 tmpvar_10;
  tmpvar_10.xyz = (((
    max (0.0, dot (tmpvar_2, lightDirection_4))
   * _LightColor0.xyz) + (glstate_lightmodel_ambient * 2.0).xyz) * tmpvar_9.xyz);
  tmpvar_10.w = tmpvar_9.w;
  finalRGBA_3 = tmpvar_10;
  gl_FragData[0] = finalRGBA_3;
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
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 _MainTex_ST;
uniform highp float _Frequency;
uniform highp float _AmplitudeStrength;
uniform highp float _InvWaveLength;
uniform highp float _Fold;
uniform highp float _Init;
uniform highp int _Leaves;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 offset_1;
  offset_1.xyw = vec3(0.0, 0.0, 0.0);
  offset_1.z = (_AmplitudeStrength * sin((
    ((_Frequency * _Time.y) + (((
      -(sin(abs(_glesVertex.x)))
     * 
      float(_Leaves)
    ) + (
      (unity_ObjectToWorld * _glesVertex)
    .y * _Fold)) * _InvWaveLength))
   + _Init)));
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = (_glesVertex + offset_1).xyz;
  highp mat3 tmpvar_3;
  tmpvar_3[0] = unity_WorldToObject[0].xyz;
  tmpvar_3[1] = unity_WorldToObject[1].xyz;
  tmpvar_3[2] = unity_WorldToObject[2].xyz;
  gl_Position = (glstate_matrix_mvp * tmpvar_2);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = (unity_ObjectToWorld * (_glesVertex + offset_1));
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_3));
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _FlagColor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  highp float tmpvar_1;
  if (gl_FrontFacing) {
    tmpvar_1 = 1.0;
  } else {
    tmpvar_1 = -1.0;
  };
  highp vec3 tmpvar_2;
  tmpvar_2 = xlv_TEXCOORD2;
  lowp vec4 finalRGBA_3;
  highp vec3 lightDirection_4;
  highp int tmpvar_5;
  if ((tmpvar_1 >= 0.0)) {
    tmpvar_5 = 1;
  } else {
    tmpvar_5 = -1;
  };
  tmpvar_2 = (normalize(xlv_TEXCOORD2) * float(tmpvar_5));
  mediump vec3 tmpvar_6;
  tmpvar_6 = normalize(_WorldSpaceLightPos0.xyz);
  lightDirection_4 = tmpvar_6;
  lowp vec4 tmpvar_7;
  highp vec2 P_8;
  P_8 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_7 = texture2D (_MainTex, P_8);
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_7 * _FlagColor);
  highp vec4 tmpvar_10;
  tmpvar_10.xyz = (((
    max (0.0, dot (tmpvar_2, lightDirection_4))
   * _LightColor0.xyz) + (glstate_lightmodel_ambient * 2.0).xyz) * tmpvar_9.xyz);
  tmpvar_10.w = tmpvar_9.w;
  finalRGBA_3 = tmpvar_10;
  gl_FragData[0] = finalRGBA_3;
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
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
uniform highp float _Frequency;
uniform highp float _AmplitudeStrength;
uniform highp float _InvWaveLength;
uniform highp float _Fold;
uniform highp float _Init;
uniform highp int _Leaves;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD3;
void main ()
{
  highp vec4 offset_1;
  offset_1.xyw = vec3(0.0, 0.0, 0.0);
  offset_1.z = (_AmplitudeStrength * sin((
    ((_Frequency * _Time.y) + (((
      -(sin(abs(_glesVertex.x)))
     * 
      float(_Leaves)
    ) + (
      (unity_ObjectToWorld * _glesVertex)
    .y * _Fold)) * _InvWaveLength))
   + _Init)));
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = (_glesVertex + offset_1).xyz;
  tmpvar_2 = (glstate_matrix_mvp * tmpvar_3);
  highp mat3 tmpvar_4;
  tmpvar_4[0] = unity_WorldToObject[0].xyz;
  tmpvar_4[1] = unity_WorldToObject[1].xyz;
  tmpvar_4[2] = unity_WorldToObject[2].xyz;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = (unity_ObjectToWorld * (_glesVertex + offset_1));
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_4));
  xlv_TEXCOORD3 = ((tmpvar_2.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform lowp vec4 unity_FogColor;
uniform highp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _FlagColor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD3;
void main ()
{
  highp float tmpvar_1;
  if (gl_FrontFacing) {
    tmpvar_1 = 1.0;
  } else {
    tmpvar_1 = -1.0;
  };
  highp vec3 tmpvar_2;
  tmpvar_2 = xlv_TEXCOORD2;
  lowp vec4 finalRGBA_3;
  highp vec3 lightDirection_4;
  highp int tmpvar_5;
  if ((tmpvar_1 >= 0.0)) {
    tmpvar_5 = 1;
  } else {
    tmpvar_5 = -1;
  };
  tmpvar_2 = (normalize(xlv_TEXCOORD2) * float(tmpvar_5));
  mediump vec3 tmpvar_6;
  tmpvar_6 = normalize(_WorldSpaceLightPos0.xyz);
  lightDirection_4 = tmpvar_6;
  lowp vec4 tmpvar_7;
  highp vec2 P_8;
  P_8 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_7 = texture2D (_MainTex, P_8);
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_7 * _FlagColor);
  highp vec4 tmpvar_10;
  tmpvar_10.xyz = (((
    max (0.0, dot (tmpvar_2, lightDirection_4))
   * _LightColor0.xyz) + (glstate_lightmodel_ambient * 2.0).xyz) * tmpvar_9.xyz);
  tmpvar_10.w = tmpvar_9.w;
  finalRGBA_3 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = clamp (xlv_TEXCOORD3, 0.0, 1.0);
  finalRGBA_3.xyz = mix (unity_FogColor.xyz, finalRGBA_3.xyz, vec3(tmpvar_11));
  gl_FragData[0] = finalRGBA_3;
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
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
uniform highp float _Frequency;
uniform highp float _AmplitudeStrength;
uniform highp float _InvWaveLength;
uniform highp float _Fold;
uniform highp float _Init;
uniform highp int _Leaves;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD3;
void main ()
{
  highp vec4 offset_1;
  offset_1.xyw = vec3(0.0, 0.0, 0.0);
  offset_1.z = (_AmplitudeStrength * sin((
    ((_Frequency * _Time.y) + (((
      -(sin(abs(_glesVertex.x)))
     * 
      float(_Leaves)
    ) + (
      (unity_ObjectToWorld * _glesVertex)
    .y * _Fold)) * _InvWaveLength))
   + _Init)));
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = (_glesVertex + offset_1).xyz;
  tmpvar_2 = (glstate_matrix_mvp * tmpvar_3);
  highp mat3 tmpvar_4;
  tmpvar_4[0] = unity_WorldToObject[0].xyz;
  tmpvar_4[1] = unity_WorldToObject[1].xyz;
  tmpvar_4[2] = unity_WorldToObject[2].xyz;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = (unity_ObjectToWorld * (_glesVertex + offset_1));
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_4));
  xlv_TEXCOORD3 = ((tmpvar_2.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform lowp vec4 unity_FogColor;
uniform highp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _FlagColor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD3;
void main ()
{
  highp float tmpvar_1;
  if (gl_FrontFacing) {
    tmpvar_1 = 1.0;
  } else {
    tmpvar_1 = -1.0;
  };
  highp vec3 tmpvar_2;
  tmpvar_2 = xlv_TEXCOORD2;
  lowp vec4 finalRGBA_3;
  highp vec3 lightDirection_4;
  highp int tmpvar_5;
  if ((tmpvar_1 >= 0.0)) {
    tmpvar_5 = 1;
  } else {
    tmpvar_5 = -1;
  };
  tmpvar_2 = (normalize(xlv_TEXCOORD2) * float(tmpvar_5));
  mediump vec3 tmpvar_6;
  tmpvar_6 = normalize(_WorldSpaceLightPos0.xyz);
  lightDirection_4 = tmpvar_6;
  lowp vec4 tmpvar_7;
  highp vec2 P_8;
  P_8 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_7 = texture2D (_MainTex, P_8);
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_7 * _FlagColor);
  highp vec4 tmpvar_10;
  tmpvar_10.xyz = (((
    max (0.0, dot (tmpvar_2, lightDirection_4))
   * _LightColor0.xyz) + (glstate_lightmodel_ambient * 2.0).xyz) * tmpvar_9.xyz);
  tmpvar_10.w = tmpvar_9.w;
  finalRGBA_3 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = clamp (xlv_TEXCOORD3, 0.0, 1.0);
  finalRGBA_3.xyz = mix (unity_FogColor.xyz, finalRGBA_3.xyz, vec3(tmpvar_11));
  gl_FragData[0] = finalRGBA_3;
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
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
uniform highp float _Frequency;
uniform highp float _AmplitudeStrength;
uniform highp float _InvWaveLength;
uniform highp float _Fold;
uniform highp float _Init;
uniform highp int _Leaves;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD3;
void main ()
{
  highp vec4 offset_1;
  offset_1.xyw = vec3(0.0, 0.0, 0.0);
  offset_1.z = (_AmplitudeStrength * sin((
    ((_Frequency * _Time.y) + (((
      -(sin(abs(_glesVertex.x)))
     * 
      float(_Leaves)
    ) + (
      (unity_ObjectToWorld * _glesVertex)
    .y * _Fold)) * _InvWaveLength))
   + _Init)));
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = (_glesVertex + offset_1).xyz;
  tmpvar_2 = (glstate_matrix_mvp * tmpvar_3);
  highp mat3 tmpvar_4;
  tmpvar_4[0] = unity_WorldToObject[0].xyz;
  tmpvar_4[1] = unity_WorldToObject[1].xyz;
  tmpvar_4[2] = unity_WorldToObject[2].xyz;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = (unity_ObjectToWorld * (_glesVertex + offset_1));
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_4));
  xlv_TEXCOORD3 = ((tmpvar_2.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform lowp vec4 unity_FogColor;
uniform highp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _FlagColor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD3;
void main ()
{
  highp float tmpvar_1;
  if (gl_FrontFacing) {
    tmpvar_1 = 1.0;
  } else {
    tmpvar_1 = -1.0;
  };
  highp vec3 tmpvar_2;
  tmpvar_2 = xlv_TEXCOORD2;
  lowp vec4 finalRGBA_3;
  highp vec3 lightDirection_4;
  highp int tmpvar_5;
  if ((tmpvar_1 >= 0.0)) {
    tmpvar_5 = 1;
  } else {
    tmpvar_5 = -1;
  };
  tmpvar_2 = (normalize(xlv_TEXCOORD2) * float(tmpvar_5));
  mediump vec3 tmpvar_6;
  tmpvar_6 = normalize(_WorldSpaceLightPos0.xyz);
  lightDirection_4 = tmpvar_6;
  lowp vec4 tmpvar_7;
  highp vec2 P_8;
  P_8 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_7 = texture2D (_MainTex, P_8);
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_7 * _FlagColor);
  highp vec4 tmpvar_10;
  tmpvar_10.xyz = (((
    max (0.0, dot (tmpvar_2, lightDirection_4))
   * _LightColor0.xyz) + (glstate_lightmodel_ambient * 2.0).xyz) * tmpvar_9.xyz);
  tmpvar_10.w = tmpvar_9.w;
  finalRGBA_3 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = clamp (xlv_TEXCOORD3, 0.0, 1.0);
  finalRGBA_3.xyz = mix (unity_FogColor.xyz, finalRGBA_3.xyz, vec3(tmpvar_11));
  gl_FragData[0] = finalRGBA_3;
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
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
uniform highp float _Frequency;
uniform highp float _AmplitudeStrength;
uniform highp float _InvWaveLength;
uniform highp float _Fold;
uniform highp float _Init;
uniform highp int _Leaves;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD3;
void main ()
{
  highp vec4 offset_1;
  offset_1.xyw = vec3(0.0, 0.0, 0.0);
  offset_1.z = (_AmplitudeStrength * sin((
    ((_Frequency * _Time.y) + (((
      -(sin(abs(_glesVertex.x)))
     * 
      float(_Leaves)
    ) + (
      (unity_ObjectToWorld * _glesVertex)
    .y * _Fold)) * _InvWaveLength))
   + _Init)));
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = (_glesVertex + offset_1).xyz;
  tmpvar_2 = (glstate_matrix_mvp * tmpvar_3);
  highp mat3 tmpvar_4;
  tmpvar_4[0] = unity_WorldToObject[0].xyz;
  tmpvar_4[1] = unity_WorldToObject[1].xyz;
  tmpvar_4[2] = unity_WorldToObject[2].xyz;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = (unity_ObjectToWorld * (_glesVertex + offset_1));
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_4));
  xlv_TEXCOORD3 = ((tmpvar_2.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform lowp vec4 unity_FogColor;
uniform highp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _FlagColor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD3;
void main ()
{
  highp float tmpvar_1;
  if (gl_FrontFacing) {
    tmpvar_1 = 1.0;
  } else {
    tmpvar_1 = -1.0;
  };
  highp vec3 tmpvar_2;
  tmpvar_2 = xlv_TEXCOORD2;
  lowp vec4 finalRGBA_3;
  highp vec3 lightDirection_4;
  highp int tmpvar_5;
  if ((tmpvar_1 >= 0.0)) {
    tmpvar_5 = 1;
  } else {
    tmpvar_5 = -1;
  };
  tmpvar_2 = (normalize(xlv_TEXCOORD2) * float(tmpvar_5));
  mediump vec3 tmpvar_6;
  tmpvar_6 = normalize(_WorldSpaceLightPos0.xyz);
  lightDirection_4 = tmpvar_6;
  lowp vec4 tmpvar_7;
  highp vec2 P_8;
  P_8 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_7 = texture2D (_MainTex, P_8);
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_7 * _FlagColor);
  highp vec4 tmpvar_10;
  tmpvar_10.xyz = (((
    max (0.0, dot (tmpvar_2, lightDirection_4))
   * _LightColor0.xyz) + (glstate_lightmodel_ambient * 2.0).xyz) * tmpvar_9.xyz);
  tmpvar_10.w = tmpvar_9.w;
  finalRGBA_3 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = clamp (xlv_TEXCOORD3, 0.0, 1.0);
  finalRGBA_3.xyz = mix (unity_FogColor.xyz, finalRGBA_3.xyz, vec3(tmpvar_11));
  gl_FragData[0] = finalRGBA_3;
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
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
uniform highp float _Frequency;
uniform highp float _AmplitudeStrength;
uniform highp float _InvWaveLength;
uniform highp float _Fold;
uniform highp float _Init;
uniform highp int _Leaves;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD3;
void main ()
{
  highp vec4 offset_1;
  offset_1.xyw = vec3(0.0, 0.0, 0.0);
  offset_1.z = (_AmplitudeStrength * sin((
    ((_Frequency * _Time.y) + (((
      -(sin(abs(_glesVertex.x)))
     * 
      float(_Leaves)
    ) + (
      (unity_ObjectToWorld * _glesVertex)
    .y * _Fold)) * _InvWaveLength))
   + _Init)));
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = (_glesVertex + offset_1).xyz;
  tmpvar_2 = (glstate_matrix_mvp * tmpvar_3);
  highp mat3 tmpvar_4;
  tmpvar_4[0] = unity_WorldToObject[0].xyz;
  tmpvar_4[1] = unity_WorldToObject[1].xyz;
  tmpvar_4[2] = unity_WorldToObject[2].xyz;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = (unity_ObjectToWorld * (_glesVertex + offset_1));
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_4));
  xlv_TEXCOORD3 = ((tmpvar_2.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform lowp vec4 unity_FogColor;
uniform highp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _FlagColor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD3;
void main ()
{
  highp float tmpvar_1;
  if (gl_FrontFacing) {
    tmpvar_1 = 1.0;
  } else {
    tmpvar_1 = -1.0;
  };
  highp vec3 tmpvar_2;
  tmpvar_2 = xlv_TEXCOORD2;
  lowp vec4 finalRGBA_3;
  highp vec3 lightDirection_4;
  highp int tmpvar_5;
  if ((tmpvar_1 >= 0.0)) {
    tmpvar_5 = 1;
  } else {
    tmpvar_5 = -1;
  };
  tmpvar_2 = (normalize(xlv_TEXCOORD2) * float(tmpvar_5));
  mediump vec3 tmpvar_6;
  tmpvar_6 = normalize(_WorldSpaceLightPos0.xyz);
  lightDirection_4 = tmpvar_6;
  lowp vec4 tmpvar_7;
  highp vec2 P_8;
  P_8 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_7 = texture2D (_MainTex, P_8);
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_7 * _FlagColor);
  highp vec4 tmpvar_10;
  tmpvar_10.xyz = (((
    max (0.0, dot (tmpvar_2, lightDirection_4))
   * _LightColor0.xyz) + (glstate_lightmodel_ambient * 2.0).xyz) * tmpvar_9.xyz);
  tmpvar_10.w = tmpvar_9.w;
  finalRGBA_3 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = clamp (xlv_TEXCOORD3, 0.0, 1.0);
  finalRGBA_3.xyz = mix (unity_FogColor.xyz, finalRGBA_3.xyz, vec3(tmpvar_11));
  gl_FragData[0] = finalRGBA_3;
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
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
uniform highp float _Frequency;
uniform highp float _AmplitudeStrength;
uniform highp float _InvWaveLength;
uniform highp float _Fold;
uniform highp float _Init;
uniform highp int _Leaves;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD3;
void main ()
{
  highp vec4 offset_1;
  offset_1.xyw = vec3(0.0, 0.0, 0.0);
  offset_1.z = (_AmplitudeStrength * sin((
    ((_Frequency * _Time.y) + (((
      -(sin(abs(_glesVertex.x)))
     * 
      float(_Leaves)
    ) + (
      (unity_ObjectToWorld * _glesVertex)
    .y * _Fold)) * _InvWaveLength))
   + _Init)));
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = (_glesVertex + offset_1).xyz;
  tmpvar_2 = (glstate_matrix_mvp * tmpvar_3);
  highp mat3 tmpvar_4;
  tmpvar_4[0] = unity_WorldToObject[0].xyz;
  tmpvar_4[1] = unity_WorldToObject[1].xyz;
  tmpvar_4[2] = unity_WorldToObject[2].xyz;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = (unity_ObjectToWorld * (_glesVertex + offset_1));
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_4));
  xlv_TEXCOORD3 = ((tmpvar_2.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform lowp vec4 unity_FogColor;
uniform highp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _FlagColor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD3;
void main ()
{
  highp float tmpvar_1;
  if (gl_FrontFacing) {
    tmpvar_1 = 1.0;
  } else {
    tmpvar_1 = -1.0;
  };
  highp vec3 tmpvar_2;
  tmpvar_2 = xlv_TEXCOORD2;
  lowp vec4 finalRGBA_3;
  highp vec3 lightDirection_4;
  highp int tmpvar_5;
  if ((tmpvar_1 >= 0.0)) {
    tmpvar_5 = 1;
  } else {
    tmpvar_5 = -1;
  };
  tmpvar_2 = (normalize(xlv_TEXCOORD2) * float(tmpvar_5));
  mediump vec3 tmpvar_6;
  tmpvar_6 = normalize(_WorldSpaceLightPos0.xyz);
  lightDirection_4 = tmpvar_6;
  lowp vec4 tmpvar_7;
  highp vec2 P_8;
  P_8 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_7 = texture2D (_MainTex, P_8);
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_7 * _FlagColor);
  highp vec4 tmpvar_10;
  tmpvar_10.xyz = (((
    max (0.0, dot (tmpvar_2, lightDirection_4))
   * _LightColor0.xyz) + (glstate_lightmodel_ambient * 2.0).xyz) * tmpvar_9.xyz);
  tmpvar_10.w = tmpvar_9.w;
  finalRGBA_3 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = clamp (xlv_TEXCOORD3, 0.0, 1.0);
  finalRGBA_3.xyz = mix (unity_FogColor.xyz, finalRGBA_3.xyz, vec3(tmpvar_11));
  gl_FragData[0] = finalRGBA_3;
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
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
uniform highp float _Frequency;
uniform highp float _AmplitudeStrength;
uniform highp float _InvWaveLength;
uniform highp float _Fold;
uniform highp float _Init;
uniform highp int _Leaves;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD3;
void main ()
{
  highp vec4 offset_1;
  offset_1.xyw = vec3(0.0, 0.0, 0.0);
  offset_1.z = (_AmplitudeStrength * sin((
    ((_Frequency * _Time.y) + (((
      -(sin(abs(_glesVertex.x)))
     * 
      float(_Leaves)
    ) + (
      (unity_ObjectToWorld * _glesVertex)
    .y * _Fold)) * _InvWaveLength))
   + _Init)));
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = (_glesVertex + offset_1).xyz;
  tmpvar_2 = (glstate_matrix_mvp * tmpvar_3);
  highp mat3 tmpvar_4;
  tmpvar_4[0] = unity_WorldToObject[0].xyz;
  tmpvar_4[1] = unity_WorldToObject[1].xyz;
  tmpvar_4[2] = unity_WorldToObject[2].xyz;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = (unity_ObjectToWorld * (_glesVertex + offset_1));
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_4));
  xlv_TEXCOORD3 = ((tmpvar_2.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform lowp vec4 unity_FogColor;
uniform highp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _FlagColor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD3;
void main ()
{
  highp float tmpvar_1;
  if (gl_FrontFacing) {
    tmpvar_1 = 1.0;
  } else {
    tmpvar_1 = -1.0;
  };
  highp vec3 tmpvar_2;
  tmpvar_2 = xlv_TEXCOORD2;
  lowp vec4 finalRGBA_3;
  highp vec3 lightDirection_4;
  highp int tmpvar_5;
  if ((tmpvar_1 >= 0.0)) {
    tmpvar_5 = 1;
  } else {
    tmpvar_5 = -1;
  };
  tmpvar_2 = (normalize(xlv_TEXCOORD2) * float(tmpvar_5));
  mediump vec3 tmpvar_6;
  tmpvar_6 = normalize(_WorldSpaceLightPos0.xyz);
  lightDirection_4 = tmpvar_6;
  lowp vec4 tmpvar_7;
  highp vec2 P_8;
  P_8 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_7 = texture2D (_MainTex, P_8);
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_7 * _FlagColor);
  highp vec4 tmpvar_10;
  tmpvar_10.xyz = (((
    max (0.0, dot (tmpvar_2, lightDirection_4))
   * _LightColor0.xyz) + (glstate_lightmodel_ambient * 2.0).xyz) * tmpvar_9.xyz);
  tmpvar_10.w = tmpvar_9.w;
  finalRGBA_3 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = clamp (xlv_TEXCOORD3, 0.0, 1.0);
  finalRGBA_3.xyz = mix (unity_FogColor.xyz, finalRGBA_3.xyz, vec3(tmpvar_11));
  gl_FragData[0] = finalRGBA_3;
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
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
uniform highp float _Frequency;
uniform highp float _AmplitudeStrength;
uniform highp float _InvWaveLength;
uniform highp float _Fold;
uniform highp float _Init;
uniform highp int _Leaves;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD3;
void main ()
{
  highp vec4 offset_1;
  offset_1.xyw = vec3(0.0, 0.0, 0.0);
  offset_1.z = (_AmplitudeStrength * sin((
    ((_Frequency * _Time.y) + (((
      -(sin(abs(_glesVertex.x)))
     * 
      float(_Leaves)
    ) + (
      (unity_ObjectToWorld * _glesVertex)
    .y * _Fold)) * _InvWaveLength))
   + _Init)));
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = (_glesVertex + offset_1).xyz;
  tmpvar_2 = (glstate_matrix_mvp * tmpvar_3);
  highp mat3 tmpvar_4;
  tmpvar_4[0] = unity_WorldToObject[0].xyz;
  tmpvar_4[1] = unity_WorldToObject[1].xyz;
  tmpvar_4[2] = unity_WorldToObject[2].xyz;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = (unity_ObjectToWorld * (_glesVertex + offset_1));
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_4));
  xlv_TEXCOORD3 = ((tmpvar_2.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform lowp vec4 unity_FogColor;
uniform highp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _FlagColor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD3;
void main ()
{
  highp float tmpvar_1;
  if (gl_FrontFacing) {
    tmpvar_1 = 1.0;
  } else {
    tmpvar_1 = -1.0;
  };
  highp vec3 tmpvar_2;
  tmpvar_2 = xlv_TEXCOORD2;
  lowp vec4 finalRGBA_3;
  highp vec3 lightDirection_4;
  highp int tmpvar_5;
  if ((tmpvar_1 >= 0.0)) {
    tmpvar_5 = 1;
  } else {
    tmpvar_5 = -1;
  };
  tmpvar_2 = (normalize(xlv_TEXCOORD2) * float(tmpvar_5));
  mediump vec3 tmpvar_6;
  tmpvar_6 = normalize(_WorldSpaceLightPos0.xyz);
  lightDirection_4 = tmpvar_6;
  lowp vec4 tmpvar_7;
  highp vec2 P_8;
  P_8 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_7 = texture2D (_MainTex, P_8);
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_7 * _FlagColor);
  highp vec4 tmpvar_10;
  tmpvar_10.xyz = (((
    max (0.0, dot (tmpvar_2, lightDirection_4))
   * _LightColor0.xyz) + (glstate_lightmodel_ambient * 2.0).xyz) * tmpvar_9.xyz);
  tmpvar_10.w = tmpvar_9.w;
  finalRGBA_3 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = clamp (xlv_TEXCOORD3, 0.0, 1.0);
  finalRGBA_3.xyz = mix (unity_FogColor.xyz, finalRGBA_3.xyz, vec3(tmpvar_11));
  gl_FragData[0] = finalRGBA_3;
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
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
uniform highp float _Frequency;
uniform highp float _AmplitudeStrength;
uniform highp float _InvWaveLength;
uniform highp float _Fold;
uniform highp float _Init;
uniform highp int _Leaves;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD3;
void main ()
{
  highp vec4 offset_1;
  offset_1.xyw = vec3(0.0, 0.0, 0.0);
  offset_1.z = (_AmplitudeStrength * sin((
    ((_Frequency * _Time.y) + (((
      -(sin(abs(_glesVertex.x)))
     * 
      float(_Leaves)
    ) + (
      (unity_ObjectToWorld * _glesVertex)
    .y * _Fold)) * _InvWaveLength))
   + _Init)));
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = (_glesVertex + offset_1).xyz;
  tmpvar_2 = (glstate_matrix_mvp * tmpvar_3);
  highp mat3 tmpvar_4;
  tmpvar_4[0] = unity_WorldToObject[0].xyz;
  tmpvar_4[1] = unity_WorldToObject[1].xyz;
  tmpvar_4[2] = unity_WorldToObject[2].xyz;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = (unity_ObjectToWorld * (_glesVertex + offset_1));
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_4));
  xlv_TEXCOORD3 = ((tmpvar_2.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform lowp vec4 unity_FogColor;
uniform highp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _FlagColor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD3;
void main ()
{
  highp float tmpvar_1;
  if (gl_FrontFacing) {
    tmpvar_1 = 1.0;
  } else {
    tmpvar_1 = -1.0;
  };
  highp vec3 tmpvar_2;
  tmpvar_2 = xlv_TEXCOORD2;
  lowp vec4 finalRGBA_3;
  highp vec3 lightDirection_4;
  highp int tmpvar_5;
  if ((tmpvar_1 >= 0.0)) {
    tmpvar_5 = 1;
  } else {
    tmpvar_5 = -1;
  };
  tmpvar_2 = (normalize(xlv_TEXCOORD2) * float(tmpvar_5));
  mediump vec3 tmpvar_6;
  tmpvar_6 = normalize(_WorldSpaceLightPos0.xyz);
  lightDirection_4 = tmpvar_6;
  lowp vec4 tmpvar_7;
  highp vec2 P_8;
  P_8 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_7 = texture2D (_MainTex, P_8);
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_7 * _FlagColor);
  highp vec4 tmpvar_10;
  tmpvar_10.xyz = (((
    max (0.0, dot (tmpvar_2, lightDirection_4))
   * _LightColor0.xyz) + (glstate_lightmodel_ambient * 2.0).xyz) * tmpvar_9.xyz);
  tmpvar_10.w = tmpvar_9.w;
  finalRGBA_3 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = clamp (xlv_TEXCOORD3, 0.0, 1.0);
  finalRGBA_3.xyz = mix (unity_FogColor.xyz, finalRGBA_3.xyz, vec3(tmpvar_11));
  gl_FragData[0] = finalRGBA_3;
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
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
uniform highp float _Frequency;
uniform highp float _AmplitudeStrength;
uniform highp float _InvWaveLength;
uniform highp float _Fold;
uniform highp float _Init;
uniform highp int _Leaves;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD3;
void main ()
{
  highp vec4 offset_1;
  offset_1.xyw = vec3(0.0, 0.0, 0.0);
  offset_1.z = (_AmplitudeStrength * sin((
    ((_Frequency * _Time.y) + (((
      -(sin(abs(_glesVertex.x)))
     * 
      float(_Leaves)
    ) + (
      (unity_ObjectToWorld * _glesVertex)
    .y * _Fold)) * _InvWaveLength))
   + _Init)));
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = (_glesVertex + offset_1).xyz;
  tmpvar_2 = (glstate_matrix_mvp * tmpvar_3);
  highp mat3 tmpvar_4;
  tmpvar_4[0] = unity_WorldToObject[0].xyz;
  tmpvar_4[1] = unity_WorldToObject[1].xyz;
  tmpvar_4[2] = unity_WorldToObject[2].xyz;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = (unity_ObjectToWorld * (_glesVertex + offset_1));
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_4));
  xlv_TEXCOORD3 = ((tmpvar_2.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform lowp vec4 unity_FogColor;
uniform highp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _FlagColor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD3;
void main ()
{
  highp float tmpvar_1;
  if (gl_FrontFacing) {
    tmpvar_1 = 1.0;
  } else {
    tmpvar_1 = -1.0;
  };
  highp vec3 tmpvar_2;
  tmpvar_2 = xlv_TEXCOORD2;
  lowp vec4 finalRGBA_3;
  highp vec3 lightDirection_4;
  highp int tmpvar_5;
  if ((tmpvar_1 >= 0.0)) {
    tmpvar_5 = 1;
  } else {
    tmpvar_5 = -1;
  };
  tmpvar_2 = (normalize(xlv_TEXCOORD2) * float(tmpvar_5));
  mediump vec3 tmpvar_6;
  tmpvar_6 = normalize(_WorldSpaceLightPos0.xyz);
  lightDirection_4 = tmpvar_6;
  lowp vec4 tmpvar_7;
  highp vec2 P_8;
  P_8 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_7 = texture2D (_MainTex, P_8);
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_7 * _FlagColor);
  highp vec4 tmpvar_10;
  tmpvar_10.xyz = (((
    max (0.0, dot (tmpvar_2, lightDirection_4))
   * _LightColor0.xyz) + (glstate_lightmodel_ambient * 2.0).xyz) * tmpvar_9.xyz);
  tmpvar_10.w = tmpvar_9.w;
  finalRGBA_3 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = clamp (xlv_TEXCOORD3, 0.0, 1.0);
  finalRGBA_3.xyz = mix (unity_FogColor.xyz, finalRGBA_3.xyz, vec3(tmpvar_11));
  gl_FragData[0] = finalRGBA_3;
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
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
uniform highp float _Frequency;
uniform highp float _AmplitudeStrength;
uniform highp float _InvWaveLength;
uniform highp float _Fold;
uniform highp float _Init;
uniform highp int _Leaves;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD3;
void main ()
{
  highp vec4 offset_1;
  offset_1.xyw = vec3(0.0, 0.0, 0.0);
  offset_1.z = (_AmplitudeStrength * sin((
    ((_Frequency * _Time.y) + (((
      -(sin(abs(_glesVertex.x)))
     * 
      float(_Leaves)
    ) + (
      (unity_ObjectToWorld * _glesVertex)
    .y * _Fold)) * _InvWaveLength))
   + _Init)));
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = (_glesVertex + offset_1).xyz;
  tmpvar_2 = (glstate_matrix_mvp * tmpvar_3);
  highp mat3 tmpvar_4;
  tmpvar_4[0] = unity_WorldToObject[0].xyz;
  tmpvar_4[1] = unity_WorldToObject[1].xyz;
  tmpvar_4[2] = unity_WorldToObject[2].xyz;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = (unity_ObjectToWorld * (_glesVertex + offset_1));
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_4));
  xlv_TEXCOORD3 = ((tmpvar_2.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform lowp vec4 unity_FogColor;
uniform highp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _FlagColor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD3;
void main ()
{
  highp float tmpvar_1;
  if (gl_FrontFacing) {
    tmpvar_1 = 1.0;
  } else {
    tmpvar_1 = -1.0;
  };
  highp vec3 tmpvar_2;
  tmpvar_2 = xlv_TEXCOORD2;
  lowp vec4 finalRGBA_3;
  highp vec3 lightDirection_4;
  highp int tmpvar_5;
  if ((tmpvar_1 >= 0.0)) {
    tmpvar_5 = 1;
  } else {
    tmpvar_5 = -1;
  };
  tmpvar_2 = (normalize(xlv_TEXCOORD2) * float(tmpvar_5));
  mediump vec3 tmpvar_6;
  tmpvar_6 = normalize(_WorldSpaceLightPos0.xyz);
  lightDirection_4 = tmpvar_6;
  lowp vec4 tmpvar_7;
  highp vec2 P_8;
  P_8 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_7 = texture2D (_MainTex, P_8);
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_7 * _FlagColor);
  highp vec4 tmpvar_10;
  tmpvar_10.xyz = (((
    max (0.0, dot (tmpvar_2, lightDirection_4))
   * _LightColor0.xyz) + (glstate_lightmodel_ambient * 2.0).xyz) * tmpvar_9.xyz);
  tmpvar_10.w = tmpvar_9.w;
  finalRGBA_3 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = clamp (xlv_TEXCOORD3, 0.0, 1.0);
  finalRGBA_3.xyz = mix (unity_FogColor.xyz, finalRGBA_3.xyz, vec3(tmpvar_11));
  gl_FragData[0] = finalRGBA_3;
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
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
uniform highp float _Frequency;
uniform highp float _AmplitudeStrength;
uniform highp float _InvWaveLength;
uniform highp float _Fold;
uniform highp float _Init;
uniform highp int _Leaves;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD3;
void main ()
{
  highp vec4 offset_1;
  offset_1.xyw = vec3(0.0, 0.0, 0.0);
  offset_1.z = (_AmplitudeStrength * sin((
    ((_Frequency * _Time.y) + (((
      -(sin(abs(_glesVertex.x)))
     * 
      float(_Leaves)
    ) + (
      (unity_ObjectToWorld * _glesVertex)
    .y * _Fold)) * _InvWaveLength))
   + _Init)));
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = (_glesVertex + offset_1).xyz;
  tmpvar_2 = (glstate_matrix_mvp * tmpvar_3);
  highp mat3 tmpvar_4;
  tmpvar_4[0] = unity_WorldToObject[0].xyz;
  tmpvar_4[1] = unity_WorldToObject[1].xyz;
  tmpvar_4[2] = unity_WorldToObject[2].xyz;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = (unity_ObjectToWorld * (_glesVertex + offset_1));
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_4));
  xlv_TEXCOORD3 = ((tmpvar_2.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform lowp vec4 unity_FogColor;
uniform highp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _FlagColor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD3;
void main ()
{
  highp float tmpvar_1;
  if (gl_FrontFacing) {
    tmpvar_1 = 1.0;
  } else {
    tmpvar_1 = -1.0;
  };
  highp vec3 tmpvar_2;
  tmpvar_2 = xlv_TEXCOORD2;
  lowp vec4 finalRGBA_3;
  highp vec3 lightDirection_4;
  highp int tmpvar_5;
  if ((tmpvar_1 >= 0.0)) {
    tmpvar_5 = 1;
  } else {
    tmpvar_5 = -1;
  };
  tmpvar_2 = (normalize(xlv_TEXCOORD2) * float(tmpvar_5));
  mediump vec3 tmpvar_6;
  tmpvar_6 = normalize(_WorldSpaceLightPos0.xyz);
  lightDirection_4 = tmpvar_6;
  lowp vec4 tmpvar_7;
  highp vec2 P_8;
  P_8 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_7 = texture2D (_MainTex, P_8);
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_7 * _FlagColor);
  highp vec4 tmpvar_10;
  tmpvar_10.xyz = (((
    max (0.0, dot (tmpvar_2, lightDirection_4))
   * _LightColor0.xyz) + (glstate_lightmodel_ambient * 2.0).xyz) * tmpvar_9.xyz);
  tmpvar_10.w = tmpvar_9.w;
  finalRGBA_3 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = clamp (xlv_TEXCOORD3, 0.0, 1.0);
  finalRGBA_3.xyz = mix (unity_FogColor.xyz, finalRGBA_3.xyz, vec3(tmpvar_11));
  gl_FragData[0] = finalRGBA_3;
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
}
}
}
Fallback "VertexLit"
}