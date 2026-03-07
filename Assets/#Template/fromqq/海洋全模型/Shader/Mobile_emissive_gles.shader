Shader "Mobile/emissive" {
Properties {
_MainTex ("Texture(RGB)", 2D) = "grey" { }
_Color ("Color", Color) = (0,0,0,1)
_AtmoColor ("Atmosphere Color", Color) = (0,0.4,1,1)
_Size ("Size", Float) = 0.1
_OutLightPow ("Falloff", Float) = 5
_OutLightStrength ("Transparency", Float) = 15
}
SubShader {
 Pass {
  Name "PLANEBASE"
  Tags { "LIGHTMODE" = "Always" }
  ZClip Off
  Cull Off
  GpuProgramID 64399
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp vec4 _MainTex_ST;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (glstate_matrix_mvp * tmpvar_1);
  xlv_TEXCOORD0 = _glesNormal;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec4 color_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD2);
  color_1 = tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (color_1 * _Color);
  gl_FragData[0] = tmpvar_3;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp vec4 _MainTex_ST;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (glstate_matrix_mvp * tmpvar_1);
  xlv_TEXCOORD0 = _glesNormal;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec4 color_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD2);
  color_1 = tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (color_1 * _Color);
  gl_FragData[0] = tmpvar_3;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp vec4 _MainTex_ST;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (glstate_matrix_mvp * tmpvar_1);
  xlv_TEXCOORD0 = _glesNormal;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec4 color_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD2);
  color_1 = tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (color_1 * _Color);
  gl_FragData[0] = tmpvar_3;
}


#endif
"
}
}
Program "fp" {
SubProgram "gles hw_tier00 " {
""
}
SubProgram "gles hw_tier01 " {
""
}
SubProgram "gles hw_tier02 " {
""
}
}
}
 Pass {
  Name "ATMOSPHEREBASE"
  Tags { "LIGHTMODE" = "Always" }
  ZClip Off
  Cull Front
  GpuProgramID 88791
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp float _Size;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = _glesVertex.w;
  tmpvar_1.xyz = (_glesVertex.xyz + (_glesNormal * _Size));
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = tmpvar_1.xyz;
  gl_Position = (glstate_matrix_mvp * tmpvar_2);
  xlv_TEXCOORD0 = _glesNormal;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * tmpvar_1).xyz;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _AtmoColor;
uniform highp float _OutLightPow;
uniform highp float _OutLightStrength;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
void main ()
{
  highp vec4 color_1;
  highp vec3 tmpvar_2;
  tmpvar_2 = normalize(xlv_TEXCOORD0);
  highp vec3 tmpvar_3;
  tmpvar_3 = normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos));
  color_1.xyz = _AtmoColor.xyz;
  color_1.w = pow (clamp (dot (tmpvar_3, tmpvar_2), 0.0, 1.0), _OutLightPow);
  color_1.w = (color_1.w * (_OutLightStrength * dot (tmpvar_3, tmpvar_2)));
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp float _Size;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = _glesVertex.w;
  tmpvar_1.xyz = (_glesVertex.xyz + (_glesNormal * _Size));
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = tmpvar_1.xyz;
  gl_Position = (glstate_matrix_mvp * tmpvar_2);
  xlv_TEXCOORD0 = _glesNormal;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * tmpvar_1).xyz;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _AtmoColor;
uniform highp float _OutLightPow;
uniform highp float _OutLightStrength;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
void main ()
{
  highp vec4 color_1;
  highp vec3 tmpvar_2;
  tmpvar_2 = normalize(xlv_TEXCOORD0);
  highp vec3 tmpvar_3;
  tmpvar_3 = normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos));
  color_1.xyz = _AtmoColor.xyz;
  color_1.w = pow (clamp (dot (tmpvar_3, tmpvar_2), 0.0, 1.0), _OutLightPow);
  color_1.w = (color_1.w * (_OutLightStrength * dot (tmpvar_3, tmpvar_2)));
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp float _Size;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = _glesVertex.w;
  tmpvar_1.xyz = (_glesVertex.xyz + (_glesNormal * _Size));
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = tmpvar_1.xyz;
  gl_Position = (glstate_matrix_mvp * tmpvar_2);
  xlv_TEXCOORD0 = _glesNormal;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * tmpvar_1).xyz;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _AtmoColor;
uniform highp float _OutLightPow;
uniform highp float _OutLightStrength;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
void main ()
{
  highp vec4 color_1;
  highp vec3 tmpvar_2;
  tmpvar_2 = normalize(xlv_TEXCOORD0);
  highp vec3 tmpvar_3;
  tmpvar_3 = normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos));
  color_1.xyz = _AtmoColor.xyz;
  color_1.w = pow (clamp (dot (tmpvar_3, tmpvar_2), 0.0, 1.0), _OutLightPow);
  color_1.w = (color_1.w * (_OutLightStrength * dot (tmpvar_3, tmpvar_2)));
  gl_FragData[0] = color_1;
}


#endif
"
}
}
Program "fp" {
SubProgram "gles hw_tier00 " {
""
}
SubProgram "gles hw_tier01 " {
""
}
SubProgram "gles hw_tier02 " {
""
}
}
}
}
Fallback "Diffuse"
}