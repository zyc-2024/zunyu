Shader "Mobile/Diffuse(Color-mat, static light)" {
Properties {
_Color ("Color", Color) = (1,1,1,1)
_LightColorT ("Light Color", Color) = (1,1,1,1)
_LightDirT ("Light Direction", Vector) = (50,-30,0,0)
_AmbientStr ("Ambient Strength", Range(0, 1)) = 0.2
}
SubShader {
 LOD 150
 Tags { "RenderType" = "Opaque" }
 Pass {
  Name "FORWARD"
  LOD 150
  Tags { "LIGHTMODE" = "ForwardBase" "RenderType" = "Opaque" "SHADOWSUPPORT" = "true" }
  ZClip Off
  GpuProgramID 41332
Program "vp" {
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_WorldToObject;
varying mediump vec3 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD1;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_4;
  tmpvar_4[0] = unity_WorldToObject[0].xyz;
  tmpvar_4[1] = unity_WorldToObject[1].xyz;
  tmpvar_4[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize((_glesNormal * tmpvar_4));
  worldNormal_1 = tmpvar_5;
  tmpvar_2 = worldNormal_1;
  gl_Position = (glstate_matrix_mvp * tmpvar_3);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = vec3(0.0, 0.0, 0.0);
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 _Color;
uniform lowp vec4 _LightColorT;
uniform mediump vec4 _LightDirT;
uniform mediump float _AmbientStr;
varying mediump vec3 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  tmpvar_2 = xlv_TEXCOORD0;
  c_1.w = 0.0;
  c_1.xyz = (_Color.xyz * xlv_TEXCOORD1);
  lowp vec3 lightDir_3;
  lowp vec4 c_4;
  lowp float diff_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = normalize(_LightDirT.xyz);
  lightDir_3 = tmpvar_6;
  diff_5 = (max (0.0, dot (tmpvar_2, lightDir_3)) + _AmbientStr);
  c_4.xyz = ((_Color.xyz * _LightColorT.xyz) * diff_5);
  c_4.w = 1.0;
  c_1.xyz = (c_1 + c_4).xyz;
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
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
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_WorldToObject;
varying mediump vec3 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD1;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_4;
  tmpvar_4[0] = unity_WorldToObject[0].xyz;
  tmpvar_4[1] = unity_WorldToObject[1].xyz;
  tmpvar_4[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize((_glesNormal * tmpvar_4));
  worldNormal_1 = tmpvar_5;
  tmpvar_2 = worldNormal_1;
  gl_Position = (glstate_matrix_mvp * tmpvar_3);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = vec3(0.0, 0.0, 0.0);
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 _Color;
uniform lowp vec4 _LightColorT;
uniform mediump vec4 _LightDirT;
uniform mediump float _AmbientStr;
varying mediump vec3 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  tmpvar_2 = xlv_TEXCOORD0;
  c_1.w = 0.0;
  c_1.xyz = (_Color.xyz * xlv_TEXCOORD1);
  lowp vec3 lightDir_3;
  lowp vec4 c_4;
  lowp float diff_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = normalize(_LightDirT.xyz);
  lightDir_3 = tmpvar_6;
  diff_5 = (max (0.0, dot (tmpvar_2, lightDir_3)) + _AmbientStr);
  c_4.xyz = ((_Color.xyz * _LightColorT.xyz) * diff_5);
  c_4.w = 1.0;
  c_1.xyz = (c_1 + c_4).xyz;
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
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
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_WorldToObject;
varying mediump vec3 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD1;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_4;
  tmpvar_4[0] = unity_WorldToObject[0].xyz;
  tmpvar_4[1] = unity_WorldToObject[1].xyz;
  tmpvar_4[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize((_glesNormal * tmpvar_4));
  worldNormal_1 = tmpvar_5;
  tmpvar_2 = worldNormal_1;
  gl_Position = (glstate_matrix_mvp * tmpvar_3);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = vec3(0.0, 0.0, 0.0);
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 _Color;
uniform lowp vec4 _LightColorT;
uniform mediump vec4 _LightDirT;
uniform mediump float _AmbientStr;
varying mediump vec3 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  tmpvar_2 = xlv_TEXCOORD0;
  c_1.w = 0.0;
  c_1.xyz = (_Color.xyz * xlv_TEXCOORD1);
  lowp vec3 lightDir_3;
  lowp vec4 c_4;
  lowp float diff_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = normalize(_LightDirT.xyz);
  lightDir_3 = tmpvar_6;
  diff_5 = (max (0.0, dot (tmpvar_2, lightDir_3)) + _AmbientStr);
  c_4.xyz = ((_Color.xyz * _LightColorT.xyz) * diff_5);
  c_4.w = 1.0;
  c_1.xyz = (c_1 + c_4).xyz;
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
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
uniform highp mat4 unity_WorldToShadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
varying mediump vec3 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_4;
  tmpvar_4[0] = unity_WorldToObject[0].xyz;
  tmpvar_4[1] = unity_WorldToObject[1].xyz;
  tmpvar_4[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize((_glesNormal * tmpvar_4));
  worldNormal_1 = tmpvar_5;
  tmpvar_2 = worldNormal_1;
  gl_Position = (glstate_matrix_mvp * tmpvar_3);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = vec3(0.0, 0.0, 0.0);
  xlv_TEXCOORD2 = (unity_WorldToShadow[0] * (unity_ObjectToWorld * _glesVertex));
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _LightShadowData;
uniform highp sampler2D _ShadowMapTexture;
uniform lowp vec4 _Color;
uniform lowp vec4 _LightColorT;
uniform mediump vec4 _LightDirT;
uniform mediump float _AmbientStr;
varying mediump vec3 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  tmpvar_2 = xlv_TEXCOORD0;
  highp float lightShadowDataX_3;
  lowp vec2 outsideOfShadowmap_4;
  lowp vec2 coordCheck_5;
  highp vec2 tmpvar_6;
  tmpvar_6 = abs(((xlv_TEXCOORD2.xy * 2.0) - 1.0));
  coordCheck_5 = tmpvar_6;
  bvec2 tmpvar_7;
  tmpvar_7 = greaterThan (coordCheck_5, vec2(1.0, 1.0));
  lowp float tmpvar_8;
  if (tmpvar_7.x) {
    tmpvar_8 = 1.0;
  } else {
    tmpvar_8 = 0.0;
  };
  lowp float tmpvar_9;
  if (tmpvar_7.y) {
    tmpvar_9 = 1.0;
  } else {
    tmpvar_9 = 0.0;
  };
  lowp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_8;
  tmpvar_10.y = tmpvar_9;
  outsideOfShadowmap_4.y = tmpvar_10.y;
  outsideOfShadowmap_4.x = (tmpvar_8 + tmpvar_9);
  highp float tmpvar_11;
  if ((xlv_TEXCOORD2.z > 1.0)) {
    tmpvar_11 = 1.0;
  } else {
    tmpvar_11 = 0.0;
  };
  outsideOfShadowmap_4.x = (outsideOfShadowmap_4.x + tmpvar_11);
  mediump float tmpvar_12;
  tmpvar_12 = _LightShadowData.x;
  lightShadowDataX_3 = tmpvar_12;
  lowp float tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = clamp ((max (
    float((texture2D (_ShadowMapTexture, xlv_TEXCOORD2.xy).x > xlv_TEXCOORD2.z))
  , lightShadowDataX_3) + outsideOfShadowmap_4.x), 0.0, 1.0);
  tmpvar_13 = tmpvar_14;
  c_1.w = 0.0;
  c_1.xyz = (_Color.xyz * xlv_TEXCOORD1);
  lowp vec3 lightDir_15;
  lowp vec4 c_16;
  lowp float diff_17;
  mediump vec3 tmpvar_18;
  tmpvar_18 = normalize(_LightDirT.xyz);
  lightDir_15 = tmpvar_18;
  diff_17 = (max (0.0, dot (tmpvar_2, lightDir_15)) + _AmbientStr);
  c_16.xyz = ((_Color.xyz * _LightColorT.xyz) * (diff_17 * tmpvar_13));
  c_16.w = 1.0;
  c_1.xyz = (c_1 + c_16).xyz;
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
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
uniform highp mat4 unity_WorldToShadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
varying mediump vec3 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_4;
  tmpvar_4[0] = unity_WorldToObject[0].xyz;
  tmpvar_4[1] = unity_WorldToObject[1].xyz;
  tmpvar_4[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize((_glesNormal * tmpvar_4));
  worldNormal_1 = tmpvar_5;
  tmpvar_2 = worldNormal_1;
  gl_Position = (glstate_matrix_mvp * tmpvar_3);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = vec3(0.0, 0.0, 0.0);
  xlv_TEXCOORD2 = (unity_WorldToShadow[0] * (unity_ObjectToWorld * _glesVertex));
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _LightShadowData;
uniform highp sampler2D _ShadowMapTexture;
uniform lowp vec4 _Color;
uniform lowp vec4 _LightColorT;
uniform mediump vec4 _LightDirT;
uniform mediump float _AmbientStr;
varying mediump vec3 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  tmpvar_2 = xlv_TEXCOORD0;
  highp float lightShadowDataX_3;
  lowp vec2 outsideOfShadowmap_4;
  lowp vec2 coordCheck_5;
  highp vec2 tmpvar_6;
  tmpvar_6 = abs(((xlv_TEXCOORD2.xy * 2.0) - 1.0));
  coordCheck_5 = tmpvar_6;
  bvec2 tmpvar_7;
  tmpvar_7 = greaterThan (coordCheck_5, vec2(1.0, 1.0));
  lowp float tmpvar_8;
  if (tmpvar_7.x) {
    tmpvar_8 = 1.0;
  } else {
    tmpvar_8 = 0.0;
  };
  lowp float tmpvar_9;
  if (tmpvar_7.y) {
    tmpvar_9 = 1.0;
  } else {
    tmpvar_9 = 0.0;
  };
  lowp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_8;
  tmpvar_10.y = tmpvar_9;
  outsideOfShadowmap_4.y = tmpvar_10.y;
  outsideOfShadowmap_4.x = (tmpvar_8 + tmpvar_9);
  highp float tmpvar_11;
  if ((xlv_TEXCOORD2.z > 1.0)) {
    tmpvar_11 = 1.0;
  } else {
    tmpvar_11 = 0.0;
  };
  outsideOfShadowmap_4.x = (outsideOfShadowmap_4.x + tmpvar_11);
  mediump float tmpvar_12;
  tmpvar_12 = _LightShadowData.x;
  lightShadowDataX_3 = tmpvar_12;
  lowp float tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = clamp ((max (
    float((texture2D (_ShadowMapTexture, xlv_TEXCOORD2.xy).x > xlv_TEXCOORD2.z))
  , lightShadowDataX_3) + outsideOfShadowmap_4.x), 0.0, 1.0);
  tmpvar_13 = tmpvar_14;
  c_1.w = 0.0;
  c_1.xyz = (_Color.xyz * xlv_TEXCOORD1);
  lowp vec3 lightDir_15;
  lowp vec4 c_16;
  lowp float diff_17;
  mediump vec3 tmpvar_18;
  tmpvar_18 = normalize(_LightDirT.xyz);
  lightDir_15 = tmpvar_18;
  diff_17 = (max (0.0, dot (tmpvar_2, lightDir_15)) + _AmbientStr);
  c_16.xyz = ((_Color.xyz * _LightColorT.xyz) * (diff_17 * tmpvar_13));
  c_16.w = 1.0;
  c_1.xyz = (c_1 + c_16).xyz;
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
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
uniform highp mat4 unity_WorldToShadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
varying mediump vec3 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_4;
  tmpvar_4[0] = unity_WorldToObject[0].xyz;
  tmpvar_4[1] = unity_WorldToObject[1].xyz;
  tmpvar_4[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize((_glesNormal * tmpvar_4));
  worldNormal_1 = tmpvar_5;
  tmpvar_2 = worldNormal_1;
  gl_Position = (glstate_matrix_mvp * tmpvar_3);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = vec3(0.0, 0.0, 0.0);
  xlv_TEXCOORD2 = (unity_WorldToShadow[0] * (unity_ObjectToWorld * _glesVertex));
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _LightShadowData;
uniform highp sampler2D _ShadowMapTexture;
uniform lowp vec4 _Color;
uniform lowp vec4 _LightColorT;
uniform mediump vec4 _LightDirT;
uniform mediump float _AmbientStr;
varying mediump vec3 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  tmpvar_2 = xlv_TEXCOORD0;
  highp float lightShadowDataX_3;
  lowp vec2 outsideOfShadowmap_4;
  lowp vec2 coordCheck_5;
  highp vec2 tmpvar_6;
  tmpvar_6 = abs(((xlv_TEXCOORD2.xy * 2.0) - 1.0));
  coordCheck_5 = tmpvar_6;
  bvec2 tmpvar_7;
  tmpvar_7 = greaterThan (coordCheck_5, vec2(1.0, 1.0));
  lowp float tmpvar_8;
  if (tmpvar_7.x) {
    tmpvar_8 = 1.0;
  } else {
    tmpvar_8 = 0.0;
  };
  lowp float tmpvar_9;
  if (tmpvar_7.y) {
    tmpvar_9 = 1.0;
  } else {
    tmpvar_9 = 0.0;
  };
  lowp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_8;
  tmpvar_10.y = tmpvar_9;
  outsideOfShadowmap_4.y = tmpvar_10.y;
  outsideOfShadowmap_4.x = (tmpvar_8 + tmpvar_9);
  highp float tmpvar_11;
  if ((xlv_TEXCOORD2.z > 1.0)) {
    tmpvar_11 = 1.0;
  } else {
    tmpvar_11 = 0.0;
  };
  outsideOfShadowmap_4.x = (outsideOfShadowmap_4.x + tmpvar_11);
  mediump float tmpvar_12;
  tmpvar_12 = _LightShadowData.x;
  lightShadowDataX_3 = tmpvar_12;
  lowp float tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = clamp ((max (
    float((texture2D (_ShadowMapTexture, xlv_TEXCOORD2.xy).x > xlv_TEXCOORD2.z))
  , lightShadowDataX_3) + outsideOfShadowmap_4.x), 0.0, 1.0);
  tmpvar_13 = tmpvar_14;
  c_1.w = 0.0;
  c_1.xyz = (_Color.xyz * xlv_TEXCOORD1);
  lowp vec3 lightDir_15;
  lowp vec4 c_16;
  lowp float diff_17;
  mediump vec3 tmpvar_18;
  tmpvar_18 = normalize(_LightDirT.xyz);
  lightDir_15 = tmpvar_18;
  diff_17 = (max (0.0, dot (tmpvar_2, lightDir_15)) + _AmbientStr);
  c_16.xyz = ((_Color.xyz * _LightColorT.xyz) * (diff_17 * tmpvar_13));
  c_16.w = 1.0;
  c_1.xyz = (c_1 + c_16).xyz;
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
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
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
varying mediump vec3 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD1;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  lowp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_6;
  tmpvar_6[0] = unity_WorldToObject[0].xyz;
  tmpvar_6[1] = unity_WorldToObject[1].xyz;
  tmpvar_6[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((_glesNormal * tmpvar_6));
  worldNormal_1 = tmpvar_7;
  tmpvar_2 = worldNormal_1;
  highp vec3 lightColor0_8;
  lightColor0_8 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_9;
  lightColor1_9 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_10;
  lightColor2_10 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_11;
  lightColor3_11 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_12;
  lightAttenSq_12 = unity_4LightAtten0;
  highp vec3 normal_13;
  normal_13 = worldNormal_1;
  highp vec3 col_14;
  highp vec4 ndotl_15;
  highp vec4 lengthSq_16;
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_4LightPosX0 - tmpvar_5.x);
  highp vec4 tmpvar_18;
  tmpvar_18 = (unity_4LightPosY0 - tmpvar_5.y);
  highp vec4 tmpvar_19;
  tmpvar_19 = (unity_4LightPosZ0 - tmpvar_5.z);
  lengthSq_16 = (tmpvar_17 * tmpvar_17);
  lengthSq_16 = (lengthSq_16 + (tmpvar_18 * tmpvar_18));
  lengthSq_16 = (lengthSq_16 + (tmpvar_19 * tmpvar_19));
  highp vec4 tmpvar_20;
  tmpvar_20 = max (lengthSq_16, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_16 = tmpvar_20;
  ndotl_15 = (tmpvar_17 * normal_13.x);
  ndotl_15 = (ndotl_15 + (tmpvar_18 * normal_13.y));
  ndotl_15 = (ndotl_15 + (tmpvar_19 * normal_13.z));
  highp vec4 tmpvar_21;
  tmpvar_21 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_15 * inversesqrt(tmpvar_20)));
  ndotl_15 = tmpvar_21;
  highp vec4 tmpvar_22;
  tmpvar_22 = (tmpvar_21 * (1.0/((1.0 + 
    (tmpvar_20 * lightAttenSq_12)
  ))));
  col_14 = (lightColor0_8 * tmpvar_22.x);
  col_14 = (col_14 + (lightColor1_9 * tmpvar_22.y));
  col_14 = (col_14 + (lightColor2_10 * tmpvar_22.z));
  col_14 = (col_14 + (lightColor3_11 * tmpvar_22.w));
  tmpvar_3 = col_14;
  gl_Position = (glstate_matrix_mvp * tmpvar_4);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 _Color;
uniform lowp vec4 _LightColorT;
uniform mediump vec4 _LightDirT;
uniform mediump float _AmbientStr;
varying mediump vec3 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  tmpvar_2 = xlv_TEXCOORD0;
  c_1.w = 0.0;
  c_1.xyz = (_Color.xyz * xlv_TEXCOORD1);
  lowp vec3 lightDir_3;
  lowp vec4 c_4;
  lowp float diff_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = normalize(_LightDirT.xyz);
  lightDir_3 = tmpvar_6;
  diff_5 = (max (0.0, dot (tmpvar_2, lightDir_3)) + _AmbientStr);
  c_4.xyz = ((_Color.xyz * _LightColorT.xyz) * diff_5);
  c_4.w = 1.0;
  c_1.xyz = (c_1 + c_4).xyz;
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
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
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
varying mediump vec3 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD1;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  lowp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_6;
  tmpvar_6[0] = unity_WorldToObject[0].xyz;
  tmpvar_6[1] = unity_WorldToObject[1].xyz;
  tmpvar_6[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((_glesNormal * tmpvar_6));
  worldNormal_1 = tmpvar_7;
  tmpvar_2 = worldNormal_1;
  highp vec3 lightColor0_8;
  lightColor0_8 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_9;
  lightColor1_9 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_10;
  lightColor2_10 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_11;
  lightColor3_11 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_12;
  lightAttenSq_12 = unity_4LightAtten0;
  highp vec3 normal_13;
  normal_13 = worldNormal_1;
  highp vec3 col_14;
  highp vec4 ndotl_15;
  highp vec4 lengthSq_16;
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_4LightPosX0 - tmpvar_5.x);
  highp vec4 tmpvar_18;
  tmpvar_18 = (unity_4LightPosY0 - tmpvar_5.y);
  highp vec4 tmpvar_19;
  tmpvar_19 = (unity_4LightPosZ0 - tmpvar_5.z);
  lengthSq_16 = (tmpvar_17 * tmpvar_17);
  lengthSq_16 = (lengthSq_16 + (tmpvar_18 * tmpvar_18));
  lengthSq_16 = (lengthSq_16 + (tmpvar_19 * tmpvar_19));
  highp vec4 tmpvar_20;
  tmpvar_20 = max (lengthSq_16, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_16 = tmpvar_20;
  ndotl_15 = (tmpvar_17 * normal_13.x);
  ndotl_15 = (ndotl_15 + (tmpvar_18 * normal_13.y));
  ndotl_15 = (ndotl_15 + (tmpvar_19 * normal_13.z));
  highp vec4 tmpvar_21;
  tmpvar_21 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_15 * inversesqrt(tmpvar_20)));
  ndotl_15 = tmpvar_21;
  highp vec4 tmpvar_22;
  tmpvar_22 = (tmpvar_21 * (1.0/((1.0 + 
    (tmpvar_20 * lightAttenSq_12)
  ))));
  col_14 = (lightColor0_8 * tmpvar_22.x);
  col_14 = (col_14 + (lightColor1_9 * tmpvar_22.y));
  col_14 = (col_14 + (lightColor2_10 * tmpvar_22.z));
  col_14 = (col_14 + (lightColor3_11 * tmpvar_22.w));
  tmpvar_3 = col_14;
  gl_Position = (glstate_matrix_mvp * tmpvar_4);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 _Color;
uniform lowp vec4 _LightColorT;
uniform mediump vec4 _LightDirT;
uniform mediump float _AmbientStr;
varying mediump vec3 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  tmpvar_2 = xlv_TEXCOORD0;
  c_1.w = 0.0;
  c_1.xyz = (_Color.xyz * xlv_TEXCOORD1);
  lowp vec3 lightDir_3;
  lowp vec4 c_4;
  lowp float diff_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = normalize(_LightDirT.xyz);
  lightDir_3 = tmpvar_6;
  diff_5 = (max (0.0, dot (tmpvar_2, lightDir_3)) + _AmbientStr);
  c_4.xyz = ((_Color.xyz * _LightColorT.xyz) * diff_5);
  c_4.w = 1.0;
  c_1.xyz = (c_1 + c_4).xyz;
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
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
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
varying mediump vec3 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD1;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  lowp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_6;
  tmpvar_6[0] = unity_WorldToObject[0].xyz;
  tmpvar_6[1] = unity_WorldToObject[1].xyz;
  tmpvar_6[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((_glesNormal * tmpvar_6));
  worldNormal_1 = tmpvar_7;
  tmpvar_2 = worldNormal_1;
  highp vec3 lightColor0_8;
  lightColor0_8 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_9;
  lightColor1_9 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_10;
  lightColor2_10 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_11;
  lightColor3_11 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_12;
  lightAttenSq_12 = unity_4LightAtten0;
  highp vec3 normal_13;
  normal_13 = worldNormal_1;
  highp vec3 col_14;
  highp vec4 ndotl_15;
  highp vec4 lengthSq_16;
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_4LightPosX0 - tmpvar_5.x);
  highp vec4 tmpvar_18;
  tmpvar_18 = (unity_4LightPosY0 - tmpvar_5.y);
  highp vec4 tmpvar_19;
  tmpvar_19 = (unity_4LightPosZ0 - tmpvar_5.z);
  lengthSq_16 = (tmpvar_17 * tmpvar_17);
  lengthSq_16 = (lengthSq_16 + (tmpvar_18 * tmpvar_18));
  lengthSq_16 = (lengthSq_16 + (tmpvar_19 * tmpvar_19));
  highp vec4 tmpvar_20;
  tmpvar_20 = max (lengthSq_16, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_16 = tmpvar_20;
  ndotl_15 = (tmpvar_17 * normal_13.x);
  ndotl_15 = (ndotl_15 + (tmpvar_18 * normal_13.y));
  ndotl_15 = (ndotl_15 + (tmpvar_19 * normal_13.z));
  highp vec4 tmpvar_21;
  tmpvar_21 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_15 * inversesqrt(tmpvar_20)));
  ndotl_15 = tmpvar_21;
  highp vec4 tmpvar_22;
  tmpvar_22 = (tmpvar_21 * (1.0/((1.0 + 
    (tmpvar_20 * lightAttenSq_12)
  ))));
  col_14 = (lightColor0_8 * tmpvar_22.x);
  col_14 = (col_14 + (lightColor1_9 * tmpvar_22.y));
  col_14 = (col_14 + (lightColor2_10 * tmpvar_22.z));
  col_14 = (col_14 + (lightColor3_11 * tmpvar_22.w));
  tmpvar_3 = col_14;
  gl_Position = (glstate_matrix_mvp * tmpvar_4);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 _Color;
uniform lowp vec4 _LightColorT;
uniform mediump vec4 _LightDirT;
uniform mediump float _AmbientStr;
varying mediump vec3 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  tmpvar_2 = xlv_TEXCOORD0;
  c_1.w = 0.0;
  c_1.xyz = (_Color.xyz * xlv_TEXCOORD1);
  lowp vec3 lightDir_3;
  lowp vec4 c_4;
  lowp float diff_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = normalize(_LightDirT.xyz);
  lightDir_3 = tmpvar_6;
  diff_5 = (max (0.0, dot (tmpvar_2, lightDir_3)) + _AmbientStr);
  c_4.xyz = ((_Color.xyz * _LightColorT.xyz) * diff_5);
  c_4.w = 1.0;
  c_1.xyz = (c_1 + c_4).xyz;
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
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
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
uniform highp mat4 unity_WorldToShadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
varying mediump vec3 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  lowp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  highp vec4 tmpvar_5;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_6;
  tmpvar_6[0] = unity_WorldToObject[0].xyz;
  tmpvar_6[1] = unity_WorldToObject[1].xyz;
  tmpvar_6[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((_glesNormal * tmpvar_6));
  worldNormal_1 = tmpvar_7;
  tmpvar_2 = worldNormal_1;
  highp vec3 lightColor0_8;
  lightColor0_8 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_9;
  lightColor1_9 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_10;
  lightColor2_10 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_11;
  lightColor3_11 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_12;
  lightAttenSq_12 = unity_4LightAtten0;
  highp vec3 normal_13;
  normal_13 = worldNormal_1;
  highp vec3 col_14;
  highp vec4 ndotl_15;
  highp vec4 lengthSq_16;
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_4LightPosX0 - tmpvar_5.x);
  highp vec4 tmpvar_18;
  tmpvar_18 = (unity_4LightPosY0 - tmpvar_5.y);
  highp vec4 tmpvar_19;
  tmpvar_19 = (unity_4LightPosZ0 - tmpvar_5.z);
  lengthSq_16 = (tmpvar_17 * tmpvar_17);
  lengthSq_16 = (lengthSq_16 + (tmpvar_18 * tmpvar_18));
  lengthSq_16 = (lengthSq_16 + (tmpvar_19 * tmpvar_19));
  highp vec4 tmpvar_20;
  tmpvar_20 = max (lengthSq_16, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_16 = tmpvar_20;
  ndotl_15 = (tmpvar_17 * normal_13.x);
  ndotl_15 = (ndotl_15 + (tmpvar_18 * normal_13.y));
  ndotl_15 = (ndotl_15 + (tmpvar_19 * normal_13.z));
  highp vec4 tmpvar_21;
  tmpvar_21 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_15 * inversesqrt(tmpvar_20)));
  ndotl_15 = tmpvar_21;
  highp vec4 tmpvar_22;
  tmpvar_22 = (tmpvar_21 * (1.0/((1.0 + 
    (tmpvar_20 * lightAttenSq_12)
  ))));
  col_14 = (lightColor0_8 * tmpvar_22.x);
  col_14 = (col_14 + (lightColor1_9 * tmpvar_22.y));
  col_14 = (col_14 + (lightColor2_10 * tmpvar_22.z));
  col_14 = (col_14 + (lightColor3_11 * tmpvar_22.w));
  tmpvar_3 = col_14;
  gl_Position = (glstate_matrix_mvp * tmpvar_4);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = (unity_WorldToShadow[0] * tmpvar_5);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _LightShadowData;
uniform highp sampler2D _ShadowMapTexture;
uniform lowp vec4 _Color;
uniform lowp vec4 _LightColorT;
uniform mediump vec4 _LightDirT;
uniform mediump float _AmbientStr;
varying mediump vec3 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  tmpvar_2 = xlv_TEXCOORD0;
  highp float lightShadowDataX_3;
  lowp vec2 outsideOfShadowmap_4;
  lowp vec2 coordCheck_5;
  highp vec2 tmpvar_6;
  tmpvar_6 = abs(((xlv_TEXCOORD2.xy * 2.0) - 1.0));
  coordCheck_5 = tmpvar_6;
  bvec2 tmpvar_7;
  tmpvar_7 = greaterThan (coordCheck_5, vec2(1.0, 1.0));
  lowp float tmpvar_8;
  if (tmpvar_7.x) {
    tmpvar_8 = 1.0;
  } else {
    tmpvar_8 = 0.0;
  };
  lowp float tmpvar_9;
  if (tmpvar_7.y) {
    tmpvar_9 = 1.0;
  } else {
    tmpvar_9 = 0.0;
  };
  lowp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_8;
  tmpvar_10.y = tmpvar_9;
  outsideOfShadowmap_4.y = tmpvar_10.y;
  outsideOfShadowmap_4.x = (tmpvar_8 + tmpvar_9);
  highp float tmpvar_11;
  if ((xlv_TEXCOORD2.z > 1.0)) {
    tmpvar_11 = 1.0;
  } else {
    tmpvar_11 = 0.0;
  };
  outsideOfShadowmap_4.x = (outsideOfShadowmap_4.x + tmpvar_11);
  mediump float tmpvar_12;
  tmpvar_12 = _LightShadowData.x;
  lightShadowDataX_3 = tmpvar_12;
  lowp float tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = clamp ((max (
    float((texture2D (_ShadowMapTexture, xlv_TEXCOORD2.xy).x > xlv_TEXCOORD2.z))
  , lightShadowDataX_3) + outsideOfShadowmap_4.x), 0.0, 1.0);
  tmpvar_13 = tmpvar_14;
  c_1.w = 0.0;
  c_1.xyz = (_Color.xyz * xlv_TEXCOORD1);
  lowp vec3 lightDir_15;
  lowp vec4 c_16;
  lowp float diff_17;
  mediump vec3 tmpvar_18;
  tmpvar_18 = normalize(_LightDirT.xyz);
  lightDir_15 = tmpvar_18;
  diff_17 = (max (0.0, dot (tmpvar_2, lightDir_15)) + _AmbientStr);
  c_16.xyz = ((_Color.xyz * _LightColorT.xyz) * (diff_17 * tmpvar_13));
  c_16.w = 1.0;
  c_1.xyz = (c_1 + c_16).xyz;
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
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
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
uniform highp mat4 unity_WorldToShadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
varying mediump vec3 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  lowp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  highp vec4 tmpvar_5;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_6;
  tmpvar_6[0] = unity_WorldToObject[0].xyz;
  tmpvar_6[1] = unity_WorldToObject[1].xyz;
  tmpvar_6[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((_glesNormal * tmpvar_6));
  worldNormal_1 = tmpvar_7;
  tmpvar_2 = worldNormal_1;
  highp vec3 lightColor0_8;
  lightColor0_8 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_9;
  lightColor1_9 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_10;
  lightColor2_10 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_11;
  lightColor3_11 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_12;
  lightAttenSq_12 = unity_4LightAtten0;
  highp vec3 normal_13;
  normal_13 = worldNormal_1;
  highp vec3 col_14;
  highp vec4 ndotl_15;
  highp vec4 lengthSq_16;
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_4LightPosX0 - tmpvar_5.x);
  highp vec4 tmpvar_18;
  tmpvar_18 = (unity_4LightPosY0 - tmpvar_5.y);
  highp vec4 tmpvar_19;
  tmpvar_19 = (unity_4LightPosZ0 - tmpvar_5.z);
  lengthSq_16 = (tmpvar_17 * tmpvar_17);
  lengthSq_16 = (lengthSq_16 + (tmpvar_18 * tmpvar_18));
  lengthSq_16 = (lengthSq_16 + (tmpvar_19 * tmpvar_19));
  highp vec4 tmpvar_20;
  tmpvar_20 = max (lengthSq_16, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_16 = tmpvar_20;
  ndotl_15 = (tmpvar_17 * normal_13.x);
  ndotl_15 = (ndotl_15 + (tmpvar_18 * normal_13.y));
  ndotl_15 = (ndotl_15 + (tmpvar_19 * normal_13.z));
  highp vec4 tmpvar_21;
  tmpvar_21 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_15 * inversesqrt(tmpvar_20)));
  ndotl_15 = tmpvar_21;
  highp vec4 tmpvar_22;
  tmpvar_22 = (tmpvar_21 * (1.0/((1.0 + 
    (tmpvar_20 * lightAttenSq_12)
  ))));
  col_14 = (lightColor0_8 * tmpvar_22.x);
  col_14 = (col_14 + (lightColor1_9 * tmpvar_22.y));
  col_14 = (col_14 + (lightColor2_10 * tmpvar_22.z));
  col_14 = (col_14 + (lightColor3_11 * tmpvar_22.w));
  tmpvar_3 = col_14;
  gl_Position = (glstate_matrix_mvp * tmpvar_4);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = (unity_WorldToShadow[0] * tmpvar_5);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _LightShadowData;
uniform highp sampler2D _ShadowMapTexture;
uniform lowp vec4 _Color;
uniform lowp vec4 _LightColorT;
uniform mediump vec4 _LightDirT;
uniform mediump float _AmbientStr;
varying mediump vec3 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  tmpvar_2 = xlv_TEXCOORD0;
  highp float lightShadowDataX_3;
  lowp vec2 outsideOfShadowmap_4;
  lowp vec2 coordCheck_5;
  highp vec2 tmpvar_6;
  tmpvar_6 = abs(((xlv_TEXCOORD2.xy * 2.0) - 1.0));
  coordCheck_5 = tmpvar_6;
  bvec2 tmpvar_7;
  tmpvar_7 = greaterThan (coordCheck_5, vec2(1.0, 1.0));
  lowp float tmpvar_8;
  if (tmpvar_7.x) {
    tmpvar_8 = 1.0;
  } else {
    tmpvar_8 = 0.0;
  };
  lowp float tmpvar_9;
  if (tmpvar_7.y) {
    tmpvar_9 = 1.0;
  } else {
    tmpvar_9 = 0.0;
  };
  lowp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_8;
  tmpvar_10.y = tmpvar_9;
  outsideOfShadowmap_4.y = tmpvar_10.y;
  outsideOfShadowmap_4.x = (tmpvar_8 + tmpvar_9);
  highp float tmpvar_11;
  if ((xlv_TEXCOORD2.z > 1.0)) {
    tmpvar_11 = 1.0;
  } else {
    tmpvar_11 = 0.0;
  };
  outsideOfShadowmap_4.x = (outsideOfShadowmap_4.x + tmpvar_11);
  mediump float tmpvar_12;
  tmpvar_12 = _LightShadowData.x;
  lightShadowDataX_3 = tmpvar_12;
  lowp float tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = clamp ((max (
    float((texture2D (_ShadowMapTexture, xlv_TEXCOORD2.xy).x > xlv_TEXCOORD2.z))
  , lightShadowDataX_3) + outsideOfShadowmap_4.x), 0.0, 1.0);
  tmpvar_13 = tmpvar_14;
  c_1.w = 0.0;
  c_1.xyz = (_Color.xyz * xlv_TEXCOORD1);
  lowp vec3 lightDir_15;
  lowp vec4 c_16;
  lowp float diff_17;
  mediump vec3 tmpvar_18;
  tmpvar_18 = normalize(_LightDirT.xyz);
  lightDir_15 = tmpvar_18;
  diff_17 = (max (0.0, dot (tmpvar_2, lightDir_15)) + _AmbientStr);
  c_16.xyz = ((_Color.xyz * _LightColorT.xyz) * (diff_17 * tmpvar_13));
  c_16.w = 1.0;
  c_1.xyz = (c_1 + c_16).xyz;
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
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
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
uniform highp mat4 unity_WorldToShadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
varying mediump vec3 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  lowp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  highp vec4 tmpvar_5;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_6;
  tmpvar_6[0] = unity_WorldToObject[0].xyz;
  tmpvar_6[1] = unity_WorldToObject[1].xyz;
  tmpvar_6[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((_glesNormal * tmpvar_6));
  worldNormal_1 = tmpvar_7;
  tmpvar_2 = worldNormal_1;
  highp vec3 lightColor0_8;
  lightColor0_8 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_9;
  lightColor1_9 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_10;
  lightColor2_10 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_11;
  lightColor3_11 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_12;
  lightAttenSq_12 = unity_4LightAtten0;
  highp vec3 normal_13;
  normal_13 = worldNormal_1;
  highp vec3 col_14;
  highp vec4 ndotl_15;
  highp vec4 lengthSq_16;
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_4LightPosX0 - tmpvar_5.x);
  highp vec4 tmpvar_18;
  tmpvar_18 = (unity_4LightPosY0 - tmpvar_5.y);
  highp vec4 tmpvar_19;
  tmpvar_19 = (unity_4LightPosZ0 - tmpvar_5.z);
  lengthSq_16 = (tmpvar_17 * tmpvar_17);
  lengthSq_16 = (lengthSq_16 + (tmpvar_18 * tmpvar_18));
  lengthSq_16 = (lengthSq_16 + (tmpvar_19 * tmpvar_19));
  highp vec4 tmpvar_20;
  tmpvar_20 = max (lengthSq_16, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_16 = tmpvar_20;
  ndotl_15 = (tmpvar_17 * normal_13.x);
  ndotl_15 = (ndotl_15 + (tmpvar_18 * normal_13.y));
  ndotl_15 = (ndotl_15 + (tmpvar_19 * normal_13.z));
  highp vec4 tmpvar_21;
  tmpvar_21 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_15 * inversesqrt(tmpvar_20)));
  ndotl_15 = tmpvar_21;
  highp vec4 tmpvar_22;
  tmpvar_22 = (tmpvar_21 * (1.0/((1.0 + 
    (tmpvar_20 * lightAttenSq_12)
  ))));
  col_14 = (lightColor0_8 * tmpvar_22.x);
  col_14 = (col_14 + (lightColor1_9 * tmpvar_22.y));
  col_14 = (col_14 + (lightColor2_10 * tmpvar_22.z));
  col_14 = (col_14 + (lightColor3_11 * tmpvar_22.w));
  tmpvar_3 = col_14;
  gl_Position = (glstate_matrix_mvp * tmpvar_4);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = (unity_WorldToShadow[0] * tmpvar_5);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _LightShadowData;
uniform highp sampler2D _ShadowMapTexture;
uniform lowp vec4 _Color;
uniform lowp vec4 _LightColorT;
uniform mediump vec4 _LightDirT;
uniform mediump float _AmbientStr;
varying mediump vec3 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  tmpvar_2 = xlv_TEXCOORD0;
  highp float lightShadowDataX_3;
  lowp vec2 outsideOfShadowmap_4;
  lowp vec2 coordCheck_5;
  highp vec2 tmpvar_6;
  tmpvar_6 = abs(((xlv_TEXCOORD2.xy * 2.0) - 1.0));
  coordCheck_5 = tmpvar_6;
  bvec2 tmpvar_7;
  tmpvar_7 = greaterThan (coordCheck_5, vec2(1.0, 1.0));
  lowp float tmpvar_8;
  if (tmpvar_7.x) {
    tmpvar_8 = 1.0;
  } else {
    tmpvar_8 = 0.0;
  };
  lowp float tmpvar_9;
  if (tmpvar_7.y) {
    tmpvar_9 = 1.0;
  } else {
    tmpvar_9 = 0.0;
  };
  lowp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_8;
  tmpvar_10.y = tmpvar_9;
  outsideOfShadowmap_4.y = tmpvar_10.y;
  outsideOfShadowmap_4.x = (tmpvar_8 + tmpvar_9);
  highp float tmpvar_11;
  if ((xlv_TEXCOORD2.z > 1.0)) {
    tmpvar_11 = 1.0;
  } else {
    tmpvar_11 = 0.0;
  };
  outsideOfShadowmap_4.x = (outsideOfShadowmap_4.x + tmpvar_11);
  mediump float tmpvar_12;
  tmpvar_12 = _LightShadowData.x;
  lightShadowDataX_3 = tmpvar_12;
  lowp float tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = clamp ((max (
    float((texture2D (_ShadowMapTexture, xlv_TEXCOORD2.xy).x > xlv_TEXCOORD2.z))
  , lightShadowDataX_3) + outsideOfShadowmap_4.x), 0.0, 1.0);
  tmpvar_13 = tmpvar_14;
  c_1.w = 0.0;
  c_1.xyz = (_Color.xyz * xlv_TEXCOORD1);
  lowp vec3 lightDir_15;
  lowp vec4 c_16;
  lowp float diff_17;
  mediump vec3 tmpvar_18;
  tmpvar_18 = normalize(_LightDirT.xyz);
  lightDir_15 = tmpvar_18;
  diff_17 = (max (0.0, dot (tmpvar_2, lightDir_15)) + _AmbientStr);
  c_16.xyz = ((_Color.xyz * _LightColorT.xyz) * (diff_17 * tmpvar_13));
  c_16.w = 1.0;
  c_1.xyz = (c_1 + c_16).xyz;
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
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
}
}
 Pass {
  Name "META"
  LOD 150
  Tags { "LIGHTMODE" = "Meta" "RenderType" = "Opaque" }
  ZClip Off
  Cull Off
  GpuProgramID 120575
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 unity_DynamicLightmapST;
uniform bvec4 unity_MetaVertexControl;
void main ()
{
  highp vec4 vertex_1;
  vertex_1 = _glesVertex;
  if (unity_MetaVertexControl.x) {
    vertex_1.xy = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
    highp float tmpvar_2;
    if ((_glesVertex.z > 0.0)) {
      tmpvar_2 = 0.0001;
    } else {
      tmpvar_2 = 0.0;
    };
    vertex_1.z = tmpvar_2;
  };
  if (unity_MetaVertexControl.y) {
    vertex_1.xy = ((_glesMultiTexCoord2.xy * unity_DynamicLightmapST.xy) + unity_DynamicLightmapST.zw);
    highp float tmpvar_3;
    if ((vertex_1.z > 0.0)) {
      tmpvar_3 = 0.0001;
    } else {
      tmpvar_3 = 0.0;
    };
    vertex_1.z = tmpvar_3;
  };
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = vertex_1.xyz;
  gl_Position = (glstate_matrix_mvp * tmpvar_4);
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 _Color;
uniform bvec4 unity_MetaFragmentControl;
uniform highp float unity_OneOverOutputBoost;
uniform highp float unity_MaxOutputValue;
uniform highp float unity_UseLinearSpace;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec3 tmpvar_3;
  tmpvar_3 = _Color.xyz;
  tmpvar_2 = tmpvar_3;
  mediump vec4 res_4;
  res_4 = vec4(0.0, 0.0, 0.0, 0.0);
  if (unity_MetaFragmentControl.x) {
    mediump vec4 tmpvar_5;
    tmpvar_5.w = 1.0;
    tmpvar_5.xyz = tmpvar_2;
    res_4.w = tmpvar_5.w;
    highp vec3 tmpvar_6;
    tmpvar_6 = clamp (pow (tmpvar_2, vec3(clamp (unity_OneOverOutputBoost, 0.0, 1.0))), vec3(0.0, 0.0, 0.0), vec3(unity_MaxOutputValue));
    res_4.xyz = tmpvar_6;
  };
  if (unity_MetaFragmentControl.y) {
    mediump vec3 emission_7;
    if (bool(unity_UseLinearSpace)) {
      emission_7 = vec3(0.0, 0.0, 0.0);
    } else {
      emission_7 = vec3(0.0, 0.0, 0.0);
    };
    mediump vec4 tmpvar_8;
    highp float alpha_9;
    highp vec3 tmpvar_10;
    tmpvar_10 = (emission_7 * 0.01030928);
    alpha_9 = (ceil((
      max (max (tmpvar_10.x, tmpvar_10.y), max (tmpvar_10.z, 0.02))
     * 255.0)) / 255.0);
    highp float tmpvar_11;
    tmpvar_11 = max (alpha_9, 0.02);
    alpha_9 = tmpvar_11;
    highp vec4 tmpvar_12;
    tmpvar_12.xyz = (tmpvar_10 / tmpvar_11);
    tmpvar_12.w = tmpvar_11;
    tmpvar_8 = tmpvar_12;
    res_4 = tmpvar_8;
  };
  tmpvar_1 = res_4;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 unity_DynamicLightmapST;
uniform bvec4 unity_MetaVertexControl;
void main ()
{
  highp vec4 vertex_1;
  vertex_1 = _glesVertex;
  if (unity_MetaVertexControl.x) {
    vertex_1.xy = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
    highp float tmpvar_2;
    if ((_glesVertex.z > 0.0)) {
      tmpvar_2 = 0.0001;
    } else {
      tmpvar_2 = 0.0;
    };
    vertex_1.z = tmpvar_2;
  };
  if (unity_MetaVertexControl.y) {
    vertex_1.xy = ((_glesMultiTexCoord2.xy * unity_DynamicLightmapST.xy) + unity_DynamicLightmapST.zw);
    highp float tmpvar_3;
    if ((vertex_1.z > 0.0)) {
      tmpvar_3 = 0.0001;
    } else {
      tmpvar_3 = 0.0;
    };
    vertex_1.z = tmpvar_3;
  };
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = vertex_1.xyz;
  gl_Position = (glstate_matrix_mvp * tmpvar_4);
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 _Color;
uniform bvec4 unity_MetaFragmentControl;
uniform highp float unity_OneOverOutputBoost;
uniform highp float unity_MaxOutputValue;
uniform highp float unity_UseLinearSpace;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec3 tmpvar_3;
  tmpvar_3 = _Color.xyz;
  tmpvar_2 = tmpvar_3;
  mediump vec4 res_4;
  res_4 = vec4(0.0, 0.0, 0.0, 0.0);
  if (unity_MetaFragmentControl.x) {
    mediump vec4 tmpvar_5;
    tmpvar_5.w = 1.0;
    tmpvar_5.xyz = tmpvar_2;
    res_4.w = tmpvar_5.w;
    highp vec3 tmpvar_6;
    tmpvar_6 = clamp (pow (tmpvar_2, vec3(clamp (unity_OneOverOutputBoost, 0.0, 1.0))), vec3(0.0, 0.0, 0.0), vec3(unity_MaxOutputValue));
    res_4.xyz = tmpvar_6;
  };
  if (unity_MetaFragmentControl.y) {
    mediump vec3 emission_7;
    if (bool(unity_UseLinearSpace)) {
      emission_7 = vec3(0.0, 0.0, 0.0);
    } else {
      emission_7 = vec3(0.0, 0.0, 0.0);
    };
    mediump vec4 tmpvar_8;
    highp float alpha_9;
    highp vec3 tmpvar_10;
    tmpvar_10 = (emission_7 * 0.01030928);
    alpha_9 = (ceil((
      max (max (tmpvar_10.x, tmpvar_10.y), max (tmpvar_10.z, 0.02))
     * 255.0)) / 255.0);
    highp float tmpvar_11;
    tmpvar_11 = max (alpha_9, 0.02);
    alpha_9 = tmpvar_11;
    highp vec4 tmpvar_12;
    tmpvar_12.xyz = (tmpvar_10 / tmpvar_11);
    tmpvar_12.w = tmpvar_11;
    tmpvar_8 = tmpvar_12;
    res_4 = tmpvar_8;
  };
  tmpvar_1 = res_4;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 unity_DynamicLightmapST;
uniform bvec4 unity_MetaVertexControl;
void main ()
{
  highp vec4 vertex_1;
  vertex_1 = _glesVertex;
  if (unity_MetaVertexControl.x) {
    vertex_1.xy = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
    highp float tmpvar_2;
    if ((_glesVertex.z > 0.0)) {
      tmpvar_2 = 0.0001;
    } else {
      tmpvar_2 = 0.0;
    };
    vertex_1.z = tmpvar_2;
  };
  if (unity_MetaVertexControl.y) {
    vertex_1.xy = ((_glesMultiTexCoord2.xy * unity_DynamicLightmapST.xy) + unity_DynamicLightmapST.zw);
    highp float tmpvar_3;
    if ((vertex_1.z > 0.0)) {
      tmpvar_3 = 0.0001;
    } else {
      tmpvar_3 = 0.0;
    };
    vertex_1.z = tmpvar_3;
  };
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = vertex_1.xyz;
  gl_Position = (glstate_matrix_mvp * tmpvar_4);
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 _Color;
uniform bvec4 unity_MetaFragmentControl;
uniform highp float unity_OneOverOutputBoost;
uniform highp float unity_MaxOutputValue;
uniform highp float unity_UseLinearSpace;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec3 tmpvar_3;
  tmpvar_3 = _Color.xyz;
  tmpvar_2 = tmpvar_3;
  mediump vec4 res_4;
  res_4 = vec4(0.0, 0.0, 0.0, 0.0);
  if (unity_MetaFragmentControl.x) {
    mediump vec4 tmpvar_5;
    tmpvar_5.w = 1.0;
    tmpvar_5.xyz = tmpvar_2;
    res_4.w = tmpvar_5.w;
    highp vec3 tmpvar_6;
    tmpvar_6 = clamp (pow (tmpvar_2, vec3(clamp (unity_OneOverOutputBoost, 0.0, 1.0))), vec3(0.0, 0.0, 0.0), vec3(unity_MaxOutputValue));
    res_4.xyz = tmpvar_6;
  };
  if (unity_MetaFragmentControl.y) {
    mediump vec3 emission_7;
    if (bool(unity_UseLinearSpace)) {
      emission_7 = vec3(0.0, 0.0, 0.0);
    } else {
      emission_7 = vec3(0.0, 0.0, 0.0);
    };
    mediump vec4 tmpvar_8;
    highp float alpha_9;
    highp vec3 tmpvar_10;
    tmpvar_10 = (emission_7 * 0.01030928);
    alpha_9 = (ceil((
      max (max (tmpvar_10.x, tmpvar_10.y), max (tmpvar_10.z, 0.02))
     * 255.0)) / 255.0);
    highp float tmpvar_11;
    tmpvar_11 = max (alpha_9, 0.02);
    alpha_9 = tmpvar_11;
    highp vec4 tmpvar_12;
    tmpvar_12.xyz = (tmpvar_10 / tmpvar_11);
    tmpvar_12.w = tmpvar_11;
    tmpvar_8 = tmpvar_12;
    res_4 = tmpvar_8;
  };
  tmpvar_1 = res_4;
  gl_FragData[0] = tmpvar_1;
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
Fallback "Mobile/VertexLit"
}