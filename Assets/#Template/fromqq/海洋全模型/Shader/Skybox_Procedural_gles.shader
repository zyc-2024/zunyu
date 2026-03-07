Shader "Skybox/Procedural" {
Properties {
[KeywordEnum(None, Simple, High Quality)] _SunDisk ("Sun", Float) = 2
_SunSize ("Sun Size", Range(0, 1)) = 0.04
_AtmosphereThickness ("Atmoshpere Thickness", Range(0, 5)) = 1
_SkyTint ("Sky Tint", Color) = (0.5,0.5,0.5,1)
_GroundColor ("Ground", Color) = (0.369,0.349,0.341,1)
_Exposure ("Exposure", Range(0, 8)) = 1.3
}
SubShader {
 Tags { "PreviewType" = "Skybox" "QUEUE" = "Background" "RenderType" = "Background" }
 Pass {
  Tags { "PreviewType" = "Skybox" "QUEUE" = "Background" "RenderType" = "Background" }
  ZClip Off
  ZWrite Off
  Cull Off
  GpuProgramID 37
Program "vp" {
SubProgram "gles hw_tier00 " {
Keywords { "_SUNDISK_NONE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform mediump float _Exposure;
uniform mediump vec3 _GroundColor;
uniform mediump vec3 _SkyTint;
uniform mediump float _AtmosphereThickness;
varying mediump float xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  mediump vec3 cOut_1;
  mediump vec3 cIn_2;
  highp float far_3;
  highp float kKr4PI_4;
  highp float kKrESun_5;
  highp vec3 kSkyTintInGammaSpace_6;
  mediump float tmpvar_7;
  mediump vec3 tmpvar_8;
  mediump vec3 tmpvar_9;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (glstate_matrix_mvp * tmpvar_11);
  kSkyTintInGammaSpace_6 = _SkyTint;
  highp vec3 tmpvar_12;
  tmpvar_12 = (1.0/(pow (mix (vec3(0.5, 0.42, 0.325), vec3(0.8, 0.72, 0.625), 
    (vec3(1.0, 1.0, 1.0) - kSkyTintInGammaSpace_6)
  ), vec3(4.0, 4.0, 4.0))));
  mediump float tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = pow (_AtmosphereThickness, 2.5);
  tmpvar_13 = (0.05 * tmpvar_14);
  kKrESun_5 = tmpvar_13;
  mediump float tmpvar_15;
  tmpvar_15 = (0.03141593 * tmpvar_14);
  kKr4PI_4 = tmpvar_15;
  highp mat3 tmpvar_16;
  tmpvar_16[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_16[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_16[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((tmpvar_16 * _glesVertex.xyz));
  far_3 = 0.0;
  if ((tmpvar_17.y >= 0.0)) {
    highp vec3 frontColor_18;
    highp vec3 samplePoint_19;
    far_3 = (sqrt((
      (1.050625 + (tmpvar_17.y * tmpvar_17.y))
     - 1.0)) - tmpvar_17.y);
    highp float tmpvar_20;
    tmpvar_20 = (1.0 - (dot (tmpvar_17, vec3(0.0, 1.0001, 0.0)) / 1.0001));
    highp float tmpvar_21;
    tmpvar_21 = (exp((-0.00287 + 
      (tmpvar_20 * (0.459 + (tmpvar_20 * (3.83 + 
        (tmpvar_20 * (-6.8 + (tmpvar_20 * 5.25)))
      ))))
    )) * 0.2460318);
    highp float tmpvar_22;
    tmpvar_22 = (far_3 / 2.0);
    highp float tmpvar_23;
    tmpvar_23 = (tmpvar_22 * 40.00004);
    highp vec3 tmpvar_24;
    tmpvar_24 = (tmpvar_17 * tmpvar_22);
    highp vec3 tmpvar_25;
    tmpvar_25 = (vec3(0.0, 1.0001, 0.0) + (tmpvar_24 * 0.5));
    highp float tmpvar_26;
    tmpvar_26 = sqrt(dot (tmpvar_25, tmpvar_25));
    highp float tmpvar_27;
    tmpvar_27 = exp((160.0002 * (1.0 - tmpvar_26)));
    highp float tmpvar_28;
    tmpvar_28 = (1.0 - (dot (_WorldSpaceLightPos0.xyz, tmpvar_25) / tmpvar_26));
    highp float tmpvar_29;
    tmpvar_29 = (1.0 - (dot (tmpvar_17, tmpvar_25) / tmpvar_26));
    frontColor_18 = (exp((
      -(clamp ((tmpvar_21 + (tmpvar_27 * 
        ((0.25 * exp((-0.00287 + 
          (tmpvar_28 * (0.459 + (tmpvar_28 * (3.83 + 
            (tmpvar_28 * (-6.8 + (tmpvar_28 * 5.25)))
          ))))
        ))) - (0.25 * exp((-0.00287 + 
          (tmpvar_29 * (0.459 + (tmpvar_29 * (3.83 + 
            (tmpvar_29 * (-6.8 + (tmpvar_29 * 5.25)))
          ))))
        ))))
      )), 0.0, 50.0))
     * 
      ((tmpvar_12 * kKr4PI_4) + 0.01256637)
    )) * (tmpvar_27 * tmpvar_23));
    samplePoint_19 = (tmpvar_25 + tmpvar_24);
    highp float tmpvar_30;
    tmpvar_30 = sqrt(dot (samplePoint_19, samplePoint_19));
    highp float tmpvar_31;
    tmpvar_31 = exp((160.0002 * (1.0 - tmpvar_30)));
    highp float tmpvar_32;
    tmpvar_32 = (1.0 - (dot (_WorldSpaceLightPos0.xyz, samplePoint_19) / tmpvar_30));
    highp float tmpvar_33;
    tmpvar_33 = (1.0 - (dot (tmpvar_17, samplePoint_19) / tmpvar_30));
    frontColor_18 = (frontColor_18 + (exp(
      (-(clamp ((tmpvar_21 + 
        (tmpvar_31 * ((0.25 * exp(
          (-0.00287 + (tmpvar_32 * (0.459 + (tmpvar_32 * 
            (3.83 + (tmpvar_32 * (-6.8 + (tmpvar_32 * 5.25))))
          ))))
        )) - (0.25 * exp(
          (-0.00287 + (tmpvar_33 * (0.459 + (tmpvar_33 * 
            (3.83 + (tmpvar_33 * (-6.8 + (tmpvar_33 * 5.25))))
          ))))
        ))))
      ), 0.0, 50.0)) * ((tmpvar_12 * kKr4PI_4) + 0.01256637))
    ) * (tmpvar_31 * tmpvar_23)));
    samplePoint_19 = (samplePoint_19 + tmpvar_24);
    cIn_2 = (frontColor_18 * (tmpvar_12 * kKrESun_5));
    cOut_1 = (frontColor_18 * 0.02);
  } else {
    highp vec3 frontColor_1_34;
    far_3 = (-0.0001 / min (-0.001, tmpvar_17.y));
    highp vec3 tmpvar_35;
    tmpvar_35 = (vec3(0.0, 1.0001, 0.0) + (far_3 * tmpvar_17));
    highp float tmpvar_36;
    highp float tmpvar_37;
    tmpvar_37 = (1.0 - dot (-(tmpvar_17), tmpvar_35));
    tmpvar_36 = (0.25 * exp((-0.00287 + 
      (tmpvar_37 * (0.459 + (tmpvar_37 * (3.83 + 
        (tmpvar_37 * (-6.8 + (tmpvar_37 * 5.25)))
      ))))
    )));
    highp float tmpvar_38;
    tmpvar_38 = (1.0 - dot (_WorldSpaceLightPos0.xyz, tmpvar_35));
    highp float tmpvar_39;
    tmpvar_39 = (far_3 / 2.0);
    highp vec3 tmpvar_40;
    tmpvar_40 = (vec3(0.0, 1.0001, 0.0) + ((tmpvar_17 * tmpvar_39) * 0.5));
    highp float tmpvar_41;
    tmpvar_41 = exp((160.0002 * (1.0 - 
      sqrt(dot (tmpvar_40, tmpvar_40))
    )));
    highp vec3 tmpvar_42;
    tmpvar_42 = exp((-(
      clamp (((tmpvar_41 * (
        (0.25 * exp((-0.00287 + (tmpvar_38 * 
          (0.459 + (tmpvar_38 * (3.83 + (tmpvar_38 * 
            (-6.8 + (tmpvar_38 * 5.25))
          ))))
        ))))
       + tmpvar_36)) - (0.9996001 * tmpvar_36)), 0.0, 50.0)
    ) * (
      (tmpvar_12 * kKr4PI_4)
     + 0.01256637)));
    frontColor_1_34 = (tmpvar_42 * (tmpvar_41 * (tmpvar_39 * 40.00004)));
    cIn_2 = (frontColor_1_34 * ((tmpvar_12 * kKrESun_5) + 0.02));
    highp vec3 tmpvar_43;
    tmpvar_43 = clamp (tmpvar_42, vec3(0.0, 0.0, 0.0), vec3(1.0, 1.0, 1.0));
    cOut_1 = tmpvar_43;
  };
  tmpvar_7 = (-(tmpvar_17.y) / 0.02);
  tmpvar_8 = (_Exposure * (cIn_2 + (
    (_GroundColor * _GroundColor)
   * cOut_1)));
  mediump vec3 light_44;
  light_44 = _WorldSpaceLightPos0.xyz;
  mediump vec3 ray_45;
  ray_45 = -(tmpvar_17);
  mediump float tmpvar_46;
  tmpvar_46 = dot (light_44, ray_45);
  tmpvar_9 = (_Exposure * (cIn_2 * (0.75 + 
    (0.75 * (tmpvar_46 * tmpvar_46))
  )));
  mediump vec3 tmpvar_47;
  tmpvar_47 = sqrt(tmpvar_8);
  tmpvar_8 = tmpvar_47;
  mediump vec3 tmpvar_48;
  tmpvar_48 = sqrt(tmpvar_9);
  tmpvar_9 = tmpvar_48;
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = tmpvar_7;
  xlv_TEXCOORD1 = tmpvar_47;
  xlv_TEXCOORD2 = tmpvar_48;
}


#endif
#ifdef FRAGMENT
varying mediump float xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = mix (xlv_TEXCOORD2, xlv_TEXCOORD1, vec3(clamp (xlv_TEXCOORD0, 0.0, 1.0)));
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "_SUNDISK_NONE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform mediump float _Exposure;
uniform mediump vec3 _GroundColor;
uniform mediump vec3 _SkyTint;
uniform mediump float _AtmosphereThickness;
varying mediump float xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  mediump vec3 cOut_1;
  mediump vec3 cIn_2;
  highp float far_3;
  highp float kKr4PI_4;
  highp float kKrESun_5;
  highp vec3 kSkyTintInGammaSpace_6;
  mediump float tmpvar_7;
  mediump vec3 tmpvar_8;
  mediump vec3 tmpvar_9;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (glstate_matrix_mvp * tmpvar_11);
  kSkyTintInGammaSpace_6 = _SkyTint;
  highp vec3 tmpvar_12;
  tmpvar_12 = (1.0/(pow (mix (vec3(0.5, 0.42, 0.325), vec3(0.8, 0.72, 0.625), 
    (vec3(1.0, 1.0, 1.0) - kSkyTintInGammaSpace_6)
  ), vec3(4.0, 4.0, 4.0))));
  mediump float tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = pow (_AtmosphereThickness, 2.5);
  tmpvar_13 = (0.05 * tmpvar_14);
  kKrESun_5 = tmpvar_13;
  mediump float tmpvar_15;
  tmpvar_15 = (0.03141593 * tmpvar_14);
  kKr4PI_4 = tmpvar_15;
  highp mat3 tmpvar_16;
  tmpvar_16[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_16[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_16[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((tmpvar_16 * _glesVertex.xyz));
  far_3 = 0.0;
  if ((tmpvar_17.y >= 0.0)) {
    highp vec3 frontColor_18;
    highp vec3 samplePoint_19;
    far_3 = (sqrt((
      (1.050625 + (tmpvar_17.y * tmpvar_17.y))
     - 1.0)) - tmpvar_17.y);
    highp float tmpvar_20;
    tmpvar_20 = (1.0 - (dot (tmpvar_17, vec3(0.0, 1.0001, 0.0)) / 1.0001));
    highp float tmpvar_21;
    tmpvar_21 = (exp((-0.00287 + 
      (tmpvar_20 * (0.459 + (tmpvar_20 * (3.83 + 
        (tmpvar_20 * (-6.8 + (tmpvar_20 * 5.25)))
      ))))
    )) * 0.2460318);
    highp float tmpvar_22;
    tmpvar_22 = (far_3 / 2.0);
    highp float tmpvar_23;
    tmpvar_23 = (tmpvar_22 * 40.00004);
    highp vec3 tmpvar_24;
    tmpvar_24 = (tmpvar_17 * tmpvar_22);
    highp vec3 tmpvar_25;
    tmpvar_25 = (vec3(0.0, 1.0001, 0.0) + (tmpvar_24 * 0.5));
    highp float tmpvar_26;
    tmpvar_26 = sqrt(dot (tmpvar_25, tmpvar_25));
    highp float tmpvar_27;
    tmpvar_27 = exp((160.0002 * (1.0 - tmpvar_26)));
    highp float tmpvar_28;
    tmpvar_28 = (1.0 - (dot (_WorldSpaceLightPos0.xyz, tmpvar_25) / tmpvar_26));
    highp float tmpvar_29;
    tmpvar_29 = (1.0 - (dot (tmpvar_17, tmpvar_25) / tmpvar_26));
    frontColor_18 = (exp((
      -(clamp ((tmpvar_21 + (tmpvar_27 * 
        ((0.25 * exp((-0.00287 + 
          (tmpvar_28 * (0.459 + (tmpvar_28 * (3.83 + 
            (tmpvar_28 * (-6.8 + (tmpvar_28 * 5.25)))
          ))))
        ))) - (0.25 * exp((-0.00287 + 
          (tmpvar_29 * (0.459 + (tmpvar_29 * (3.83 + 
            (tmpvar_29 * (-6.8 + (tmpvar_29 * 5.25)))
          ))))
        ))))
      )), 0.0, 50.0))
     * 
      ((tmpvar_12 * kKr4PI_4) + 0.01256637)
    )) * (tmpvar_27 * tmpvar_23));
    samplePoint_19 = (tmpvar_25 + tmpvar_24);
    highp float tmpvar_30;
    tmpvar_30 = sqrt(dot (samplePoint_19, samplePoint_19));
    highp float tmpvar_31;
    tmpvar_31 = exp((160.0002 * (1.0 - tmpvar_30)));
    highp float tmpvar_32;
    tmpvar_32 = (1.0 - (dot (_WorldSpaceLightPos0.xyz, samplePoint_19) / tmpvar_30));
    highp float tmpvar_33;
    tmpvar_33 = (1.0 - (dot (tmpvar_17, samplePoint_19) / tmpvar_30));
    frontColor_18 = (frontColor_18 + (exp(
      (-(clamp ((tmpvar_21 + 
        (tmpvar_31 * ((0.25 * exp(
          (-0.00287 + (tmpvar_32 * (0.459 + (tmpvar_32 * 
            (3.83 + (tmpvar_32 * (-6.8 + (tmpvar_32 * 5.25))))
          ))))
        )) - (0.25 * exp(
          (-0.00287 + (tmpvar_33 * (0.459 + (tmpvar_33 * 
            (3.83 + (tmpvar_33 * (-6.8 + (tmpvar_33 * 5.25))))
          ))))
        ))))
      ), 0.0, 50.0)) * ((tmpvar_12 * kKr4PI_4) + 0.01256637))
    ) * (tmpvar_31 * tmpvar_23)));
    samplePoint_19 = (samplePoint_19 + tmpvar_24);
    cIn_2 = (frontColor_18 * (tmpvar_12 * kKrESun_5));
    cOut_1 = (frontColor_18 * 0.02);
  } else {
    highp vec3 frontColor_1_34;
    far_3 = (-0.0001 / min (-0.001, tmpvar_17.y));
    highp vec3 tmpvar_35;
    tmpvar_35 = (vec3(0.0, 1.0001, 0.0) + (far_3 * tmpvar_17));
    highp float tmpvar_36;
    highp float tmpvar_37;
    tmpvar_37 = (1.0 - dot (-(tmpvar_17), tmpvar_35));
    tmpvar_36 = (0.25 * exp((-0.00287 + 
      (tmpvar_37 * (0.459 + (tmpvar_37 * (3.83 + 
        (tmpvar_37 * (-6.8 + (tmpvar_37 * 5.25)))
      ))))
    )));
    highp float tmpvar_38;
    tmpvar_38 = (1.0 - dot (_WorldSpaceLightPos0.xyz, tmpvar_35));
    highp float tmpvar_39;
    tmpvar_39 = (far_3 / 2.0);
    highp vec3 tmpvar_40;
    tmpvar_40 = (vec3(0.0, 1.0001, 0.0) + ((tmpvar_17 * tmpvar_39) * 0.5));
    highp float tmpvar_41;
    tmpvar_41 = exp((160.0002 * (1.0 - 
      sqrt(dot (tmpvar_40, tmpvar_40))
    )));
    highp vec3 tmpvar_42;
    tmpvar_42 = exp((-(
      clamp (((tmpvar_41 * (
        (0.25 * exp((-0.00287 + (tmpvar_38 * 
          (0.459 + (tmpvar_38 * (3.83 + (tmpvar_38 * 
            (-6.8 + (tmpvar_38 * 5.25))
          ))))
        ))))
       + tmpvar_36)) - (0.9996001 * tmpvar_36)), 0.0, 50.0)
    ) * (
      (tmpvar_12 * kKr4PI_4)
     + 0.01256637)));
    frontColor_1_34 = (tmpvar_42 * (tmpvar_41 * (tmpvar_39 * 40.00004)));
    cIn_2 = (frontColor_1_34 * ((tmpvar_12 * kKrESun_5) + 0.02));
    highp vec3 tmpvar_43;
    tmpvar_43 = clamp (tmpvar_42, vec3(0.0, 0.0, 0.0), vec3(1.0, 1.0, 1.0));
    cOut_1 = tmpvar_43;
  };
  tmpvar_7 = (-(tmpvar_17.y) / 0.02);
  tmpvar_8 = (_Exposure * (cIn_2 + (
    (_GroundColor * _GroundColor)
   * cOut_1)));
  mediump vec3 light_44;
  light_44 = _WorldSpaceLightPos0.xyz;
  mediump vec3 ray_45;
  ray_45 = -(tmpvar_17);
  mediump float tmpvar_46;
  tmpvar_46 = dot (light_44, ray_45);
  tmpvar_9 = (_Exposure * (cIn_2 * (0.75 + 
    (0.75 * (tmpvar_46 * tmpvar_46))
  )));
  mediump vec3 tmpvar_47;
  tmpvar_47 = sqrt(tmpvar_8);
  tmpvar_8 = tmpvar_47;
  mediump vec3 tmpvar_48;
  tmpvar_48 = sqrt(tmpvar_9);
  tmpvar_9 = tmpvar_48;
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = tmpvar_7;
  xlv_TEXCOORD1 = tmpvar_47;
  xlv_TEXCOORD2 = tmpvar_48;
}


#endif
#ifdef FRAGMENT
varying mediump float xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = mix (xlv_TEXCOORD2, xlv_TEXCOORD1, vec3(clamp (xlv_TEXCOORD0, 0.0, 1.0)));
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "_SUNDISK_NONE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform mediump float _Exposure;
uniform mediump vec3 _GroundColor;
uniform mediump vec3 _SkyTint;
uniform mediump float _AtmosphereThickness;
varying mediump float xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  mediump vec3 cOut_1;
  mediump vec3 cIn_2;
  highp float far_3;
  highp float kKr4PI_4;
  highp float kKrESun_5;
  highp vec3 kSkyTintInGammaSpace_6;
  mediump float tmpvar_7;
  mediump vec3 tmpvar_8;
  mediump vec3 tmpvar_9;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (glstate_matrix_mvp * tmpvar_11);
  kSkyTintInGammaSpace_6 = _SkyTint;
  highp vec3 tmpvar_12;
  tmpvar_12 = (1.0/(pow (mix (vec3(0.5, 0.42, 0.325), vec3(0.8, 0.72, 0.625), 
    (vec3(1.0, 1.0, 1.0) - kSkyTintInGammaSpace_6)
  ), vec3(4.0, 4.0, 4.0))));
  mediump float tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = pow (_AtmosphereThickness, 2.5);
  tmpvar_13 = (0.05 * tmpvar_14);
  kKrESun_5 = tmpvar_13;
  mediump float tmpvar_15;
  tmpvar_15 = (0.03141593 * tmpvar_14);
  kKr4PI_4 = tmpvar_15;
  highp mat3 tmpvar_16;
  tmpvar_16[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_16[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_16[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((tmpvar_16 * _glesVertex.xyz));
  far_3 = 0.0;
  if ((tmpvar_17.y >= 0.0)) {
    highp vec3 frontColor_18;
    highp vec3 samplePoint_19;
    far_3 = (sqrt((
      (1.050625 + (tmpvar_17.y * tmpvar_17.y))
     - 1.0)) - tmpvar_17.y);
    highp float tmpvar_20;
    tmpvar_20 = (1.0 - (dot (tmpvar_17, vec3(0.0, 1.0001, 0.0)) / 1.0001));
    highp float tmpvar_21;
    tmpvar_21 = (exp((-0.00287 + 
      (tmpvar_20 * (0.459 + (tmpvar_20 * (3.83 + 
        (tmpvar_20 * (-6.8 + (tmpvar_20 * 5.25)))
      ))))
    )) * 0.2460318);
    highp float tmpvar_22;
    tmpvar_22 = (far_3 / 2.0);
    highp float tmpvar_23;
    tmpvar_23 = (tmpvar_22 * 40.00004);
    highp vec3 tmpvar_24;
    tmpvar_24 = (tmpvar_17 * tmpvar_22);
    highp vec3 tmpvar_25;
    tmpvar_25 = (vec3(0.0, 1.0001, 0.0) + (tmpvar_24 * 0.5));
    highp float tmpvar_26;
    tmpvar_26 = sqrt(dot (tmpvar_25, tmpvar_25));
    highp float tmpvar_27;
    tmpvar_27 = exp((160.0002 * (1.0 - tmpvar_26)));
    highp float tmpvar_28;
    tmpvar_28 = (1.0 - (dot (_WorldSpaceLightPos0.xyz, tmpvar_25) / tmpvar_26));
    highp float tmpvar_29;
    tmpvar_29 = (1.0 - (dot (tmpvar_17, tmpvar_25) / tmpvar_26));
    frontColor_18 = (exp((
      -(clamp ((tmpvar_21 + (tmpvar_27 * 
        ((0.25 * exp((-0.00287 + 
          (tmpvar_28 * (0.459 + (tmpvar_28 * (3.83 + 
            (tmpvar_28 * (-6.8 + (tmpvar_28 * 5.25)))
          ))))
        ))) - (0.25 * exp((-0.00287 + 
          (tmpvar_29 * (0.459 + (tmpvar_29 * (3.83 + 
            (tmpvar_29 * (-6.8 + (tmpvar_29 * 5.25)))
          ))))
        ))))
      )), 0.0, 50.0))
     * 
      ((tmpvar_12 * kKr4PI_4) + 0.01256637)
    )) * (tmpvar_27 * tmpvar_23));
    samplePoint_19 = (tmpvar_25 + tmpvar_24);
    highp float tmpvar_30;
    tmpvar_30 = sqrt(dot (samplePoint_19, samplePoint_19));
    highp float tmpvar_31;
    tmpvar_31 = exp((160.0002 * (1.0 - tmpvar_30)));
    highp float tmpvar_32;
    tmpvar_32 = (1.0 - (dot (_WorldSpaceLightPos0.xyz, samplePoint_19) / tmpvar_30));
    highp float tmpvar_33;
    tmpvar_33 = (1.0 - (dot (tmpvar_17, samplePoint_19) / tmpvar_30));
    frontColor_18 = (frontColor_18 + (exp(
      (-(clamp ((tmpvar_21 + 
        (tmpvar_31 * ((0.25 * exp(
          (-0.00287 + (tmpvar_32 * (0.459 + (tmpvar_32 * 
            (3.83 + (tmpvar_32 * (-6.8 + (tmpvar_32 * 5.25))))
          ))))
        )) - (0.25 * exp(
          (-0.00287 + (tmpvar_33 * (0.459 + (tmpvar_33 * 
            (3.83 + (tmpvar_33 * (-6.8 + (tmpvar_33 * 5.25))))
          ))))
        ))))
      ), 0.0, 50.0)) * ((tmpvar_12 * kKr4PI_4) + 0.01256637))
    ) * (tmpvar_31 * tmpvar_23)));
    samplePoint_19 = (samplePoint_19 + tmpvar_24);
    cIn_2 = (frontColor_18 * (tmpvar_12 * kKrESun_5));
    cOut_1 = (frontColor_18 * 0.02);
  } else {
    highp vec3 frontColor_1_34;
    far_3 = (-0.0001 / min (-0.001, tmpvar_17.y));
    highp vec3 tmpvar_35;
    tmpvar_35 = (vec3(0.0, 1.0001, 0.0) + (far_3 * tmpvar_17));
    highp float tmpvar_36;
    highp float tmpvar_37;
    tmpvar_37 = (1.0 - dot (-(tmpvar_17), tmpvar_35));
    tmpvar_36 = (0.25 * exp((-0.00287 + 
      (tmpvar_37 * (0.459 + (tmpvar_37 * (3.83 + 
        (tmpvar_37 * (-6.8 + (tmpvar_37 * 5.25)))
      ))))
    )));
    highp float tmpvar_38;
    tmpvar_38 = (1.0 - dot (_WorldSpaceLightPos0.xyz, tmpvar_35));
    highp float tmpvar_39;
    tmpvar_39 = (far_3 / 2.0);
    highp vec3 tmpvar_40;
    tmpvar_40 = (vec3(0.0, 1.0001, 0.0) + ((tmpvar_17 * tmpvar_39) * 0.5));
    highp float tmpvar_41;
    tmpvar_41 = exp((160.0002 * (1.0 - 
      sqrt(dot (tmpvar_40, tmpvar_40))
    )));
    highp vec3 tmpvar_42;
    tmpvar_42 = exp((-(
      clamp (((tmpvar_41 * (
        (0.25 * exp((-0.00287 + (tmpvar_38 * 
          (0.459 + (tmpvar_38 * (3.83 + (tmpvar_38 * 
            (-6.8 + (tmpvar_38 * 5.25))
          ))))
        ))))
       + tmpvar_36)) - (0.9996001 * tmpvar_36)), 0.0, 50.0)
    ) * (
      (tmpvar_12 * kKr4PI_4)
     + 0.01256637)));
    frontColor_1_34 = (tmpvar_42 * (tmpvar_41 * (tmpvar_39 * 40.00004)));
    cIn_2 = (frontColor_1_34 * ((tmpvar_12 * kKrESun_5) + 0.02));
    highp vec3 tmpvar_43;
    tmpvar_43 = clamp (tmpvar_42, vec3(0.0, 0.0, 0.0), vec3(1.0, 1.0, 1.0));
    cOut_1 = tmpvar_43;
  };
  tmpvar_7 = (-(tmpvar_17.y) / 0.02);
  tmpvar_8 = (_Exposure * (cIn_2 + (
    (_GroundColor * _GroundColor)
   * cOut_1)));
  mediump vec3 light_44;
  light_44 = _WorldSpaceLightPos0.xyz;
  mediump vec3 ray_45;
  ray_45 = -(tmpvar_17);
  mediump float tmpvar_46;
  tmpvar_46 = dot (light_44, ray_45);
  tmpvar_9 = (_Exposure * (cIn_2 * (0.75 + 
    (0.75 * (tmpvar_46 * tmpvar_46))
  )));
  mediump vec3 tmpvar_47;
  tmpvar_47 = sqrt(tmpvar_8);
  tmpvar_8 = tmpvar_47;
  mediump vec3 tmpvar_48;
  tmpvar_48 = sqrt(tmpvar_9);
  tmpvar_9 = tmpvar_48;
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = tmpvar_7;
  xlv_TEXCOORD1 = tmpvar_47;
  xlv_TEXCOORD2 = tmpvar_48;
}


#endif
#ifdef FRAGMENT
varying mediump float xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = mix (xlv_TEXCOORD2, xlv_TEXCOORD1, vec3(clamp (xlv_TEXCOORD0, 0.0, 1.0)));
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "_SUNDISK_SIMPLE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform lowp vec4 _LightColor0;
uniform mediump float _Exposure;
uniform mediump vec3 _GroundColor;
uniform mediump vec3 _SkyTint;
uniform mediump float _AtmosphereThickness;
varying mediump vec3 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  mediump vec3 cOut_1;
  mediump vec3 cIn_2;
  highp float far_3;
  highp float kKr4PI_4;
  highp float kKrESun_5;
  highp vec3 kSkyTintInGammaSpace_6;
  mediump vec3 tmpvar_7;
  mediump vec3 tmpvar_8;
  mediump vec3 tmpvar_9;
  mediump vec3 tmpvar_10;
  highp vec4 tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _glesVertex.xyz;
  tmpvar_11 = (glstate_matrix_mvp * tmpvar_12);
  kSkyTintInGammaSpace_6 = _SkyTint;
  highp vec3 tmpvar_13;
  tmpvar_13 = (1.0/(pow (mix (vec3(0.5, 0.42, 0.325), vec3(0.8, 0.72, 0.625), 
    (vec3(1.0, 1.0, 1.0) - kSkyTintInGammaSpace_6)
  ), vec3(4.0, 4.0, 4.0))));
  mediump float tmpvar_14;
  mediump float tmpvar_15;
  tmpvar_15 = pow (_AtmosphereThickness, 2.5);
  tmpvar_14 = (0.05 * tmpvar_15);
  kKrESun_5 = tmpvar_14;
  mediump float tmpvar_16;
  tmpvar_16 = (0.03141593 * tmpvar_15);
  kKr4PI_4 = tmpvar_16;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_17[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_17[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((tmpvar_17 * _glesVertex.xyz));
  far_3 = 0.0;
  if ((tmpvar_18.y >= 0.0)) {
    highp vec3 frontColor_19;
    highp vec3 samplePoint_20;
    far_3 = (sqrt((
      (1.050625 + (tmpvar_18.y * tmpvar_18.y))
     - 1.0)) - tmpvar_18.y);
    highp float tmpvar_21;
    tmpvar_21 = (1.0 - (dot (tmpvar_18, vec3(0.0, 1.0001, 0.0)) / 1.0001));
    highp float tmpvar_22;
    tmpvar_22 = (exp((-0.00287 + 
      (tmpvar_21 * (0.459 + (tmpvar_21 * (3.83 + 
        (tmpvar_21 * (-6.8 + (tmpvar_21 * 5.25)))
      ))))
    )) * 0.2460318);
    highp float tmpvar_23;
    tmpvar_23 = (far_3 / 2.0);
    highp float tmpvar_24;
    tmpvar_24 = (tmpvar_23 * 40.00004);
    highp vec3 tmpvar_25;
    tmpvar_25 = (tmpvar_18 * tmpvar_23);
    highp vec3 tmpvar_26;
    tmpvar_26 = (vec3(0.0, 1.0001, 0.0) + (tmpvar_25 * 0.5));
    highp float tmpvar_27;
    tmpvar_27 = sqrt(dot (tmpvar_26, tmpvar_26));
    highp float tmpvar_28;
    tmpvar_28 = exp((160.0002 * (1.0 - tmpvar_27)));
    highp float tmpvar_29;
    tmpvar_29 = (1.0 - (dot (_WorldSpaceLightPos0.xyz, tmpvar_26) / tmpvar_27));
    highp float tmpvar_30;
    tmpvar_30 = (1.0 - (dot (tmpvar_18, tmpvar_26) / tmpvar_27));
    frontColor_19 = (exp((
      -(clamp ((tmpvar_22 + (tmpvar_28 * 
        ((0.25 * exp((-0.00287 + 
          (tmpvar_29 * (0.459 + (tmpvar_29 * (3.83 + 
            (tmpvar_29 * (-6.8 + (tmpvar_29 * 5.25)))
          ))))
        ))) - (0.25 * exp((-0.00287 + 
          (tmpvar_30 * (0.459 + (tmpvar_30 * (3.83 + 
            (tmpvar_30 * (-6.8 + (tmpvar_30 * 5.25)))
          ))))
        ))))
      )), 0.0, 50.0))
     * 
      ((tmpvar_13 * kKr4PI_4) + 0.01256637)
    )) * (tmpvar_28 * tmpvar_24));
    samplePoint_20 = (tmpvar_26 + tmpvar_25);
    highp float tmpvar_31;
    tmpvar_31 = sqrt(dot (samplePoint_20, samplePoint_20));
    highp float tmpvar_32;
    tmpvar_32 = exp((160.0002 * (1.0 - tmpvar_31)));
    highp float tmpvar_33;
    tmpvar_33 = (1.0 - (dot (_WorldSpaceLightPos0.xyz, samplePoint_20) / tmpvar_31));
    highp float tmpvar_34;
    tmpvar_34 = (1.0 - (dot (tmpvar_18, samplePoint_20) / tmpvar_31));
    frontColor_19 = (frontColor_19 + (exp(
      (-(clamp ((tmpvar_22 + 
        (tmpvar_32 * ((0.25 * exp(
          (-0.00287 + (tmpvar_33 * (0.459 + (tmpvar_33 * 
            (3.83 + (tmpvar_33 * (-6.8 + (tmpvar_33 * 5.25))))
          ))))
        )) - (0.25 * exp(
          (-0.00287 + (tmpvar_34 * (0.459 + (tmpvar_34 * 
            (3.83 + (tmpvar_34 * (-6.8 + (tmpvar_34 * 5.25))))
          ))))
        ))))
      ), 0.0, 50.0)) * ((tmpvar_13 * kKr4PI_4) + 0.01256637))
    ) * (tmpvar_32 * tmpvar_24)));
    samplePoint_20 = (samplePoint_20 + tmpvar_25);
    cIn_2 = (frontColor_19 * (tmpvar_13 * kKrESun_5));
    cOut_1 = (frontColor_19 * 0.02);
  } else {
    highp vec3 frontColor_1_35;
    far_3 = (-0.0001 / min (-0.001, tmpvar_18.y));
    highp vec3 tmpvar_36;
    tmpvar_36 = (vec3(0.0, 1.0001, 0.0) + (far_3 * tmpvar_18));
    highp float tmpvar_37;
    highp float tmpvar_38;
    tmpvar_38 = (1.0 - dot (-(tmpvar_18), tmpvar_36));
    tmpvar_37 = (0.25 * exp((-0.00287 + 
      (tmpvar_38 * (0.459 + (tmpvar_38 * (3.83 + 
        (tmpvar_38 * (-6.8 + (tmpvar_38 * 5.25)))
      ))))
    )));
    highp float tmpvar_39;
    tmpvar_39 = (1.0 - dot (_WorldSpaceLightPos0.xyz, tmpvar_36));
    highp float tmpvar_40;
    tmpvar_40 = (far_3 / 2.0);
    highp vec3 tmpvar_41;
    tmpvar_41 = (vec3(0.0, 1.0001, 0.0) + ((tmpvar_18 * tmpvar_40) * 0.5));
    highp float tmpvar_42;
    tmpvar_42 = exp((160.0002 * (1.0 - 
      sqrt(dot (tmpvar_41, tmpvar_41))
    )));
    highp vec3 tmpvar_43;
    tmpvar_43 = exp((-(
      clamp (((tmpvar_42 * (
        (0.25 * exp((-0.00287 + (tmpvar_39 * 
          (0.459 + (tmpvar_39 * (3.83 + (tmpvar_39 * 
            (-6.8 + (tmpvar_39 * 5.25))
          ))))
        ))))
       + tmpvar_37)) - (0.9996001 * tmpvar_37)), 0.0, 50.0)
    ) * (
      (tmpvar_13 * kKr4PI_4)
     + 0.01256637)));
    frontColor_1_35 = (tmpvar_43 * (tmpvar_42 * (tmpvar_40 * 40.00004)));
    cIn_2 = (frontColor_1_35 * ((tmpvar_13 * kKrESun_5) + 0.02));
    highp vec3 tmpvar_44;
    tmpvar_44 = clamp (tmpvar_43, vec3(0.0, 0.0, 0.0), vec3(1.0, 1.0, 1.0));
    cOut_1 = tmpvar_44;
  };
  tmpvar_7 = -(tmpvar_18);
  tmpvar_8 = (_Exposure * (cIn_2 + (
    (_GroundColor * _GroundColor)
   * cOut_1)));
  mediump vec3 light_45;
  light_45 = _WorldSpaceLightPos0.xyz;
  mediump vec3 ray_46;
  ray_46 = -(tmpvar_18);
  mediump float tmpvar_47;
  tmpvar_47 = dot (light_45, ray_46);
  tmpvar_9 = (_Exposure * (cIn_2 * (0.75 + 
    (0.75 * (tmpvar_47 * tmpvar_47))
  )));
  tmpvar_10 = (_Exposure * (cOut_1 * _LightColor0.xyz));
  mediump vec3 tmpvar_48;
  tmpvar_48 = sqrt(tmpvar_8);
  tmpvar_8 = tmpvar_48;
  mediump vec3 tmpvar_49;
  tmpvar_49 = sqrt(tmpvar_9);
  tmpvar_9 = tmpvar_49;
  mediump vec3 tmpvar_50;
  tmpvar_50 = sqrt(tmpvar_10);
  tmpvar_10 = tmpvar_50;
  gl_Position = tmpvar_11;
  xlv_TEXCOORD0 = tmpvar_7;
  xlv_TEXCOORD1 = tmpvar_48;
  xlv_TEXCOORD2 = tmpvar_49;
  xlv_TEXCOORD3 = tmpvar_50;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _WorldSpaceLightPos0;
uniform mediump float _SunSize;
varying mediump vec3 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  mediump vec3 col_1;
  mediump float tmpvar_2;
  tmpvar_2 = (xlv_TEXCOORD0.y / 0.02);
  mediump vec3 tmpvar_3;
  tmpvar_3 = mix (xlv_TEXCOORD2, xlv_TEXCOORD1, vec3(clamp (tmpvar_2, 0.0, 1.0)));
  col_1 = tmpvar_3;
  if ((tmpvar_2 < 0.0)) {
    mediump vec3 vec1_4;
    vec1_4 = _WorldSpaceLightPos0.xyz;
    mediump vec3 tmpvar_5;
    tmpvar_5 = (vec1_4 - -(xlv_TEXCOORD0));
    mediump float tmpvar_6;
    tmpvar_6 = clamp ((sqrt(
      dot (tmpvar_5, tmpvar_5)
    ) / _SunSize), 0.0, 1.0);
    mediump float tmpvar_7;
    tmpvar_7 = (1.0 - (tmpvar_6 * (tmpvar_6 * 
      (3.0 - (2.0 * tmpvar_6))
    )));
    col_1 = (tmpvar_3 + ((
      (8000.0 * tmpvar_7)
     * tmpvar_7) * xlv_TEXCOORD3));
  };
  mediump vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = col_1;
  gl_FragData[0] = tmpvar_8;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "_SUNDISK_SIMPLE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform lowp vec4 _LightColor0;
uniform mediump float _Exposure;
uniform mediump vec3 _GroundColor;
uniform mediump vec3 _SkyTint;
uniform mediump float _AtmosphereThickness;
varying mediump vec3 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  mediump vec3 cOut_1;
  mediump vec3 cIn_2;
  highp float far_3;
  highp float kKr4PI_4;
  highp float kKrESun_5;
  highp vec3 kSkyTintInGammaSpace_6;
  mediump vec3 tmpvar_7;
  mediump vec3 tmpvar_8;
  mediump vec3 tmpvar_9;
  mediump vec3 tmpvar_10;
  highp vec4 tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _glesVertex.xyz;
  tmpvar_11 = (glstate_matrix_mvp * tmpvar_12);
  kSkyTintInGammaSpace_6 = _SkyTint;
  highp vec3 tmpvar_13;
  tmpvar_13 = (1.0/(pow (mix (vec3(0.5, 0.42, 0.325), vec3(0.8, 0.72, 0.625), 
    (vec3(1.0, 1.0, 1.0) - kSkyTintInGammaSpace_6)
  ), vec3(4.0, 4.0, 4.0))));
  mediump float tmpvar_14;
  mediump float tmpvar_15;
  tmpvar_15 = pow (_AtmosphereThickness, 2.5);
  tmpvar_14 = (0.05 * tmpvar_15);
  kKrESun_5 = tmpvar_14;
  mediump float tmpvar_16;
  tmpvar_16 = (0.03141593 * tmpvar_15);
  kKr4PI_4 = tmpvar_16;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_17[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_17[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((tmpvar_17 * _glesVertex.xyz));
  far_3 = 0.0;
  if ((tmpvar_18.y >= 0.0)) {
    highp vec3 frontColor_19;
    highp vec3 samplePoint_20;
    far_3 = (sqrt((
      (1.050625 + (tmpvar_18.y * tmpvar_18.y))
     - 1.0)) - tmpvar_18.y);
    highp float tmpvar_21;
    tmpvar_21 = (1.0 - (dot (tmpvar_18, vec3(0.0, 1.0001, 0.0)) / 1.0001));
    highp float tmpvar_22;
    tmpvar_22 = (exp((-0.00287 + 
      (tmpvar_21 * (0.459 + (tmpvar_21 * (3.83 + 
        (tmpvar_21 * (-6.8 + (tmpvar_21 * 5.25)))
      ))))
    )) * 0.2460318);
    highp float tmpvar_23;
    tmpvar_23 = (far_3 / 2.0);
    highp float tmpvar_24;
    tmpvar_24 = (tmpvar_23 * 40.00004);
    highp vec3 tmpvar_25;
    tmpvar_25 = (tmpvar_18 * tmpvar_23);
    highp vec3 tmpvar_26;
    tmpvar_26 = (vec3(0.0, 1.0001, 0.0) + (tmpvar_25 * 0.5));
    highp float tmpvar_27;
    tmpvar_27 = sqrt(dot (tmpvar_26, tmpvar_26));
    highp float tmpvar_28;
    tmpvar_28 = exp((160.0002 * (1.0 - tmpvar_27)));
    highp float tmpvar_29;
    tmpvar_29 = (1.0 - (dot (_WorldSpaceLightPos0.xyz, tmpvar_26) / tmpvar_27));
    highp float tmpvar_30;
    tmpvar_30 = (1.0 - (dot (tmpvar_18, tmpvar_26) / tmpvar_27));
    frontColor_19 = (exp((
      -(clamp ((tmpvar_22 + (tmpvar_28 * 
        ((0.25 * exp((-0.00287 + 
          (tmpvar_29 * (0.459 + (tmpvar_29 * (3.83 + 
            (tmpvar_29 * (-6.8 + (tmpvar_29 * 5.25)))
          ))))
        ))) - (0.25 * exp((-0.00287 + 
          (tmpvar_30 * (0.459 + (tmpvar_30 * (3.83 + 
            (tmpvar_30 * (-6.8 + (tmpvar_30 * 5.25)))
          ))))
        ))))
      )), 0.0, 50.0))
     * 
      ((tmpvar_13 * kKr4PI_4) + 0.01256637)
    )) * (tmpvar_28 * tmpvar_24));
    samplePoint_20 = (tmpvar_26 + tmpvar_25);
    highp float tmpvar_31;
    tmpvar_31 = sqrt(dot (samplePoint_20, samplePoint_20));
    highp float tmpvar_32;
    tmpvar_32 = exp((160.0002 * (1.0 - tmpvar_31)));
    highp float tmpvar_33;
    tmpvar_33 = (1.0 - (dot (_WorldSpaceLightPos0.xyz, samplePoint_20) / tmpvar_31));
    highp float tmpvar_34;
    tmpvar_34 = (1.0 - (dot (tmpvar_18, samplePoint_20) / tmpvar_31));
    frontColor_19 = (frontColor_19 + (exp(
      (-(clamp ((tmpvar_22 + 
        (tmpvar_32 * ((0.25 * exp(
          (-0.00287 + (tmpvar_33 * (0.459 + (tmpvar_33 * 
            (3.83 + (tmpvar_33 * (-6.8 + (tmpvar_33 * 5.25))))
          ))))
        )) - (0.25 * exp(
          (-0.00287 + (tmpvar_34 * (0.459 + (tmpvar_34 * 
            (3.83 + (tmpvar_34 * (-6.8 + (tmpvar_34 * 5.25))))
          ))))
        ))))
      ), 0.0, 50.0)) * ((tmpvar_13 * kKr4PI_4) + 0.01256637))
    ) * (tmpvar_32 * tmpvar_24)));
    samplePoint_20 = (samplePoint_20 + tmpvar_25);
    cIn_2 = (frontColor_19 * (tmpvar_13 * kKrESun_5));
    cOut_1 = (frontColor_19 * 0.02);
  } else {
    highp vec3 frontColor_1_35;
    far_3 = (-0.0001 / min (-0.001, tmpvar_18.y));
    highp vec3 tmpvar_36;
    tmpvar_36 = (vec3(0.0, 1.0001, 0.0) + (far_3 * tmpvar_18));
    highp float tmpvar_37;
    highp float tmpvar_38;
    tmpvar_38 = (1.0 - dot (-(tmpvar_18), tmpvar_36));
    tmpvar_37 = (0.25 * exp((-0.00287 + 
      (tmpvar_38 * (0.459 + (tmpvar_38 * (3.83 + 
        (tmpvar_38 * (-6.8 + (tmpvar_38 * 5.25)))
      ))))
    )));
    highp float tmpvar_39;
    tmpvar_39 = (1.0 - dot (_WorldSpaceLightPos0.xyz, tmpvar_36));
    highp float tmpvar_40;
    tmpvar_40 = (far_3 / 2.0);
    highp vec3 tmpvar_41;
    tmpvar_41 = (vec3(0.0, 1.0001, 0.0) + ((tmpvar_18 * tmpvar_40) * 0.5));
    highp float tmpvar_42;
    tmpvar_42 = exp((160.0002 * (1.0 - 
      sqrt(dot (tmpvar_41, tmpvar_41))
    )));
    highp vec3 tmpvar_43;
    tmpvar_43 = exp((-(
      clamp (((tmpvar_42 * (
        (0.25 * exp((-0.00287 + (tmpvar_39 * 
          (0.459 + (tmpvar_39 * (3.83 + (tmpvar_39 * 
            (-6.8 + (tmpvar_39 * 5.25))
          ))))
        ))))
       + tmpvar_37)) - (0.9996001 * tmpvar_37)), 0.0, 50.0)
    ) * (
      (tmpvar_13 * kKr4PI_4)
     + 0.01256637)));
    frontColor_1_35 = (tmpvar_43 * (tmpvar_42 * (tmpvar_40 * 40.00004)));
    cIn_2 = (frontColor_1_35 * ((tmpvar_13 * kKrESun_5) + 0.02));
    highp vec3 tmpvar_44;
    tmpvar_44 = clamp (tmpvar_43, vec3(0.0, 0.0, 0.0), vec3(1.0, 1.0, 1.0));
    cOut_1 = tmpvar_44;
  };
  tmpvar_7 = -(tmpvar_18);
  tmpvar_8 = (_Exposure * (cIn_2 + (
    (_GroundColor * _GroundColor)
   * cOut_1)));
  mediump vec3 light_45;
  light_45 = _WorldSpaceLightPos0.xyz;
  mediump vec3 ray_46;
  ray_46 = -(tmpvar_18);
  mediump float tmpvar_47;
  tmpvar_47 = dot (light_45, ray_46);
  tmpvar_9 = (_Exposure * (cIn_2 * (0.75 + 
    (0.75 * (tmpvar_47 * tmpvar_47))
  )));
  tmpvar_10 = (_Exposure * (cOut_1 * _LightColor0.xyz));
  mediump vec3 tmpvar_48;
  tmpvar_48 = sqrt(tmpvar_8);
  tmpvar_8 = tmpvar_48;
  mediump vec3 tmpvar_49;
  tmpvar_49 = sqrt(tmpvar_9);
  tmpvar_9 = tmpvar_49;
  mediump vec3 tmpvar_50;
  tmpvar_50 = sqrt(tmpvar_10);
  tmpvar_10 = tmpvar_50;
  gl_Position = tmpvar_11;
  xlv_TEXCOORD0 = tmpvar_7;
  xlv_TEXCOORD1 = tmpvar_48;
  xlv_TEXCOORD2 = tmpvar_49;
  xlv_TEXCOORD3 = tmpvar_50;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _WorldSpaceLightPos0;
uniform mediump float _SunSize;
varying mediump vec3 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  mediump vec3 col_1;
  mediump float tmpvar_2;
  tmpvar_2 = (xlv_TEXCOORD0.y / 0.02);
  mediump vec3 tmpvar_3;
  tmpvar_3 = mix (xlv_TEXCOORD2, xlv_TEXCOORD1, vec3(clamp (tmpvar_2, 0.0, 1.0)));
  col_1 = tmpvar_3;
  if ((tmpvar_2 < 0.0)) {
    mediump vec3 vec1_4;
    vec1_4 = _WorldSpaceLightPos0.xyz;
    mediump vec3 tmpvar_5;
    tmpvar_5 = (vec1_4 - -(xlv_TEXCOORD0));
    mediump float tmpvar_6;
    tmpvar_6 = clamp ((sqrt(
      dot (tmpvar_5, tmpvar_5)
    ) / _SunSize), 0.0, 1.0);
    mediump float tmpvar_7;
    tmpvar_7 = (1.0 - (tmpvar_6 * (tmpvar_6 * 
      (3.0 - (2.0 * tmpvar_6))
    )));
    col_1 = (tmpvar_3 + ((
      (8000.0 * tmpvar_7)
     * tmpvar_7) * xlv_TEXCOORD3));
  };
  mediump vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = col_1;
  gl_FragData[0] = tmpvar_8;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "_SUNDISK_SIMPLE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform lowp vec4 _LightColor0;
uniform mediump float _Exposure;
uniform mediump vec3 _GroundColor;
uniform mediump vec3 _SkyTint;
uniform mediump float _AtmosphereThickness;
varying mediump vec3 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  mediump vec3 cOut_1;
  mediump vec3 cIn_2;
  highp float far_3;
  highp float kKr4PI_4;
  highp float kKrESun_5;
  highp vec3 kSkyTintInGammaSpace_6;
  mediump vec3 tmpvar_7;
  mediump vec3 tmpvar_8;
  mediump vec3 tmpvar_9;
  mediump vec3 tmpvar_10;
  highp vec4 tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _glesVertex.xyz;
  tmpvar_11 = (glstate_matrix_mvp * tmpvar_12);
  kSkyTintInGammaSpace_6 = _SkyTint;
  highp vec3 tmpvar_13;
  tmpvar_13 = (1.0/(pow (mix (vec3(0.5, 0.42, 0.325), vec3(0.8, 0.72, 0.625), 
    (vec3(1.0, 1.0, 1.0) - kSkyTintInGammaSpace_6)
  ), vec3(4.0, 4.0, 4.0))));
  mediump float tmpvar_14;
  mediump float tmpvar_15;
  tmpvar_15 = pow (_AtmosphereThickness, 2.5);
  tmpvar_14 = (0.05 * tmpvar_15);
  kKrESun_5 = tmpvar_14;
  mediump float tmpvar_16;
  tmpvar_16 = (0.03141593 * tmpvar_15);
  kKr4PI_4 = tmpvar_16;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_17[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_17[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((tmpvar_17 * _glesVertex.xyz));
  far_3 = 0.0;
  if ((tmpvar_18.y >= 0.0)) {
    highp vec3 frontColor_19;
    highp vec3 samplePoint_20;
    far_3 = (sqrt((
      (1.050625 + (tmpvar_18.y * tmpvar_18.y))
     - 1.0)) - tmpvar_18.y);
    highp float tmpvar_21;
    tmpvar_21 = (1.0 - (dot (tmpvar_18, vec3(0.0, 1.0001, 0.0)) / 1.0001));
    highp float tmpvar_22;
    tmpvar_22 = (exp((-0.00287 + 
      (tmpvar_21 * (0.459 + (tmpvar_21 * (3.83 + 
        (tmpvar_21 * (-6.8 + (tmpvar_21 * 5.25)))
      ))))
    )) * 0.2460318);
    highp float tmpvar_23;
    tmpvar_23 = (far_3 / 2.0);
    highp float tmpvar_24;
    tmpvar_24 = (tmpvar_23 * 40.00004);
    highp vec3 tmpvar_25;
    tmpvar_25 = (tmpvar_18 * tmpvar_23);
    highp vec3 tmpvar_26;
    tmpvar_26 = (vec3(0.0, 1.0001, 0.0) + (tmpvar_25 * 0.5));
    highp float tmpvar_27;
    tmpvar_27 = sqrt(dot (tmpvar_26, tmpvar_26));
    highp float tmpvar_28;
    tmpvar_28 = exp((160.0002 * (1.0 - tmpvar_27)));
    highp float tmpvar_29;
    tmpvar_29 = (1.0 - (dot (_WorldSpaceLightPos0.xyz, tmpvar_26) / tmpvar_27));
    highp float tmpvar_30;
    tmpvar_30 = (1.0 - (dot (tmpvar_18, tmpvar_26) / tmpvar_27));
    frontColor_19 = (exp((
      -(clamp ((tmpvar_22 + (tmpvar_28 * 
        ((0.25 * exp((-0.00287 + 
          (tmpvar_29 * (0.459 + (tmpvar_29 * (3.83 + 
            (tmpvar_29 * (-6.8 + (tmpvar_29 * 5.25)))
          ))))
        ))) - (0.25 * exp((-0.00287 + 
          (tmpvar_30 * (0.459 + (tmpvar_30 * (3.83 + 
            (tmpvar_30 * (-6.8 + (tmpvar_30 * 5.25)))
          ))))
        ))))
      )), 0.0, 50.0))
     * 
      ((tmpvar_13 * kKr4PI_4) + 0.01256637)
    )) * (tmpvar_28 * tmpvar_24));
    samplePoint_20 = (tmpvar_26 + tmpvar_25);
    highp float tmpvar_31;
    tmpvar_31 = sqrt(dot (samplePoint_20, samplePoint_20));
    highp float tmpvar_32;
    tmpvar_32 = exp((160.0002 * (1.0 - tmpvar_31)));
    highp float tmpvar_33;
    tmpvar_33 = (1.0 - (dot (_WorldSpaceLightPos0.xyz, samplePoint_20) / tmpvar_31));
    highp float tmpvar_34;
    tmpvar_34 = (1.0 - (dot (tmpvar_18, samplePoint_20) / tmpvar_31));
    frontColor_19 = (frontColor_19 + (exp(
      (-(clamp ((tmpvar_22 + 
        (tmpvar_32 * ((0.25 * exp(
          (-0.00287 + (tmpvar_33 * (0.459 + (tmpvar_33 * 
            (3.83 + (tmpvar_33 * (-6.8 + (tmpvar_33 * 5.25))))
          ))))
        )) - (0.25 * exp(
          (-0.00287 + (tmpvar_34 * (0.459 + (tmpvar_34 * 
            (3.83 + (tmpvar_34 * (-6.8 + (tmpvar_34 * 5.25))))
          ))))
        ))))
      ), 0.0, 50.0)) * ((tmpvar_13 * kKr4PI_4) + 0.01256637))
    ) * (tmpvar_32 * tmpvar_24)));
    samplePoint_20 = (samplePoint_20 + tmpvar_25);
    cIn_2 = (frontColor_19 * (tmpvar_13 * kKrESun_5));
    cOut_1 = (frontColor_19 * 0.02);
  } else {
    highp vec3 frontColor_1_35;
    far_3 = (-0.0001 / min (-0.001, tmpvar_18.y));
    highp vec3 tmpvar_36;
    tmpvar_36 = (vec3(0.0, 1.0001, 0.0) + (far_3 * tmpvar_18));
    highp float tmpvar_37;
    highp float tmpvar_38;
    tmpvar_38 = (1.0 - dot (-(tmpvar_18), tmpvar_36));
    tmpvar_37 = (0.25 * exp((-0.00287 + 
      (tmpvar_38 * (0.459 + (tmpvar_38 * (3.83 + 
        (tmpvar_38 * (-6.8 + (tmpvar_38 * 5.25)))
      ))))
    )));
    highp float tmpvar_39;
    tmpvar_39 = (1.0 - dot (_WorldSpaceLightPos0.xyz, tmpvar_36));
    highp float tmpvar_40;
    tmpvar_40 = (far_3 / 2.0);
    highp vec3 tmpvar_41;
    tmpvar_41 = (vec3(0.0, 1.0001, 0.0) + ((tmpvar_18 * tmpvar_40) * 0.5));
    highp float tmpvar_42;
    tmpvar_42 = exp((160.0002 * (1.0 - 
      sqrt(dot (tmpvar_41, tmpvar_41))
    )));
    highp vec3 tmpvar_43;
    tmpvar_43 = exp((-(
      clamp (((tmpvar_42 * (
        (0.25 * exp((-0.00287 + (tmpvar_39 * 
          (0.459 + (tmpvar_39 * (3.83 + (tmpvar_39 * 
            (-6.8 + (tmpvar_39 * 5.25))
          ))))
        ))))
       + tmpvar_37)) - (0.9996001 * tmpvar_37)), 0.0, 50.0)
    ) * (
      (tmpvar_13 * kKr4PI_4)
     + 0.01256637)));
    frontColor_1_35 = (tmpvar_43 * (tmpvar_42 * (tmpvar_40 * 40.00004)));
    cIn_2 = (frontColor_1_35 * ((tmpvar_13 * kKrESun_5) + 0.02));
    highp vec3 tmpvar_44;
    tmpvar_44 = clamp (tmpvar_43, vec3(0.0, 0.0, 0.0), vec3(1.0, 1.0, 1.0));
    cOut_1 = tmpvar_44;
  };
  tmpvar_7 = -(tmpvar_18);
  tmpvar_8 = (_Exposure * (cIn_2 + (
    (_GroundColor * _GroundColor)
   * cOut_1)));
  mediump vec3 light_45;
  light_45 = _WorldSpaceLightPos0.xyz;
  mediump vec3 ray_46;
  ray_46 = -(tmpvar_18);
  mediump float tmpvar_47;
  tmpvar_47 = dot (light_45, ray_46);
  tmpvar_9 = (_Exposure * (cIn_2 * (0.75 + 
    (0.75 * (tmpvar_47 * tmpvar_47))
  )));
  tmpvar_10 = (_Exposure * (cOut_1 * _LightColor0.xyz));
  mediump vec3 tmpvar_48;
  tmpvar_48 = sqrt(tmpvar_8);
  tmpvar_8 = tmpvar_48;
  mediump vec3 tmpvar_49;
  tmpvar_49 = sqrt(tmpvar_9);
  tmpvar_9 = tmpvar_49;
  mediump vec3 tmpvar_50;
  tmpvar_50 = sqrt(tmpvar_10);
  tmpvar_10 = tmpvar_50;
  gl_Position = tmpvar_11;
  xlv_TEXCOORD0 = tmpvar_7;
  xlv_TEXCOORD1 = tmpvar_48;
  xlv_TEXCOORD2 = tmpvar_49;
  xlv_TEXCOORD3 = tmpvar_50;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _WorldSpaceLightPos0;
uniform mediump float _SunSize;
varying mediump vec3 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  mediump vec3 col_1;
  mediump float tmpvar_2;
  tmpvar_2 = (xlv_TEXCOORD0.y / 0.02);
  mediump vec3 tmpvar_3;
  tmpvar_3 = mix (xlv_TEXCOORD2, xlv_TEXCOORD1, vec3(clamp (tmpvar_2, 0.0, 1.0)));
  col_1 = tmpvar_3;
  if ((tmpvar_2 < 0.0)) {
    mediump vec3 vec1_4;
    vec1_4 = _WorldSpaceLightPos0.xyz;
    mediump vec3 tmpvar_5;
    tmpvar_5 = (vec1_4 - -(xlv_TEXCOORD0));
    mediump float tmpvar_6;
    tmpvar_6 = clamp ((sqrt(
      dot (tmpvar_5, tmpvar_5)
    ) / _SunSize), 0.0, 1.0);
    mediump float tmpvar_7;
    tmpvar_7 = (1.0 - (tmpvar_6 * (tmpvar_6 * 
      (3.0 - (2.0 * tmpvar_6))
    )));
    col_1 = (tmpvar_3 + ((
      (8000.0 * tmpvar_7)
     * tmpvar_7) * xlv_TEXCOORD3));
  };
  mediump vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = col_1;
  gl_FragData[0] = tmpvar_8;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "_SUNDISK_HIGH_QUALITY" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform lowp vec4 _LightColor0;
uniform mediump float _Exposure;
uniform mediump vec3 _GroundColor;
uniform mediump vec3 _SkyTint;
uniform mediump float _AtmosphereThickness;
varying mediump vec3 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  mediump vec3 cOut_1;
  mediump vec3 cIn_2;
  highp float far_3;
  highp float kKr4PI_4;
  highp float kKrESun_5;
  highp vec3 kSkyTintInGammaSpace_6;
  mediump vec3 tmpvar_7;
  mediump vec3 tmpvar_8;
  mediump vec3 tmpvar_9;
  mediump vec3 tmpvar_10;
  highp vec4 tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _glesVertex.xyz;
  tmpvar_11 = (glstate_matrix_mvp * tmpvar_12);
  kSkyTintInGammaSpace_6 = _SkyTint;
  highp vec3 tmpvar_13;
  tmpvar_13 = (1.0/(pow (mix (vec3(0.5, 0.42, 0.325), vec3(0.8, 0.72, 0.625), 
    (vec3(1.0, 1.0, 1.0) - kSkyTintInGammaSpace_6)
  ), vec3(4.0, 4.0, 4.0))));
  mediump float tmpvar_14;
  mediump float tmpvar_15;
  tmpvar_15 = pow (_AtmosphereThickness, 2.5);
  tmpvar_14 = (0.05 * tmpvar_15);
  kKrESun_5 = tmpvar_14;
  mediump float tmpvar_16;
  tmpvar_16 = (0.03141593 * tmpvar_15);
  kKr4PI_4 = tmpvar_16;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_17[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_17[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((tmpvar_17 * _glesVertex.xyz));
  far_3 = 0.0;
  if ((tmpvar_18.y >= 0.0)) {
    highp vec3 frontColor_19;
    highp vec3 samplePoint_20;
    far_3 = (sqrt((
      (1.050625 + (tmpvar_18.y * tmpvar_18.y))
     - 1.0)) - tmpvar_18.y);
    highp float tmpvar_21;
    tmpvar_21 = (1.0 - (dot (tmpvar_18, vec3(0.0, 1.0001, 0.0)) / 1.0001));
    highp float tmpvar_22;
    tmpvar_22 = (exp((-0.00287 + 
      (tmpvar_21 * (0.459 + (tmpvar_21 * (3.83 + 
        (tmpvar_21 * (-6.8 + (tmpvar_21 * 5.25)))
      ))))
    )) * 0.2460318);
    highp float tmpvar_23;
    tmpvar_23 = (far_3 / 2.0);
    highp float tmpvar_24;
    tmpvar_24 = (tmpvar_23 * 40.00004);
    highp vec3 tmpvar_25;
    tmpvar_25 = (tmpvar_18 * tmpvar_23);
    highp vec3 tmpvar_26;
    tmpvar_26 = (vec3(0.0, 1.0001, 0.0) + (tmpvar_25 * 0.5));
    highp float tmpvar_27;
    tmpvar_27 = sqrt(dot (tmpvar_26, tmpvar_26));
    highp float tmpvar_28;
    tmpvar_28 = exp((160.0002 * (1.0 - tmpvar_27)));
    highp float tmpvar_29;
    tmpvar_29 = (1.0 - (dot (_WorldSpaceLightPos0.xyz, tmpvar_26) / tmpvar_27));
    highp float tmpvar_30;
    tmpvar_30 = (1.0 - (dot (tmpvar_18, tmpvar_26) / tmpvar_27));
    frontColor_19 = (exp((
      -(clamp ((tmpvar_22 + (tmpvar_28 * 
        ((0.25 * exp((-0.00287 + 
          (tmpvar_29 * (0.459 + (tmpvar_29 * (3.83 + 
            (tmpvar_29 * (-6.8 + (tmpvar_29 * 5.25)))
          ))))
        ))) - (0.25 * exp((-0.00287 + 
          (tmpvar_30 * (0.459 + (tmpvar_30 * (3.83 + 
            (tmpvar_30 * (-6.8 + (tmpvar_30 * 5.25)))
          ))))
        ))))
      )), 0.0, 50.0))
     * 
      ((tmpvar_13 * kKr4PI_4) + 0.01256637)
    )) * (tmpvar_28 * tmpvar_24));
    samplePoint_20 = (tmpvar_26 + tmpvar_25);
    highp float tmpvar_31;
    tmpvar_31 = sqrt(dot (samplePoint_20, samplePoint_20));
    highp float tmpvar_32;
    tmpvar_32 = exp((160.0002 * (1.0 - tmpvar_31)));
    highp float tmpvar_33;
    tmpvar_33 = (1.0 - (dot (_WorldSpaceLightPos0.xyz, samplePoint_20) / tmpvar_31));
    highp float tmpvar_34;
    tmpvar_34 = (1.0 - (dot (tmpvar_18, samplePoint_20) / tmpvar_31));
    frontColor_19 = (frontColor_19 + (exp(
      (-(clamp ((tmpvar_22 + 
        (tmpvar_32 * ((0.25 * exp(
          (-0.00287 + (tmpvar_33 * (0.459 + (tmpvar_33 * 
            (3.83 + (tmpvar_33 * (-6.8 + (tmpvar_33 * 5.25))))
          ))))
        )) - (0.25 * exp(
          (-0.00287 + (tmpvar_34 * (0.459 + (tmpvar_34 * 
            (3.83 + (tmpvar_34 * (-6.8 + (tmpvar_34 * 5.25))))
          ))))
        ))))
      ), 0.0, 50.0)) * ((tmpvar_13 * kKr4PI_4) + 0.01256637))
    ) * (tmpvar_32 * tmpvar_24)));
    samplePoint_20 = (samplePoint_20 + tmpvar_25);
    cIn_2 = (frontColor_19 * (tmpvar_13 * kKrESun_5));
    cOut_1 = (frontColor_19 * 0.02);
  } else {
    highp vec3 frontColor_1_35;
    far_3 = (-0.0001 / min (-0.001, tmpvar_18.y));
    highp vec3 tmpvar_36;
    tmpvar_36 = (vec3(0.0, 1.0001, 0.0) + (far_3 * tmpvar_18));
    highp float tmpvar_37;
    highp float tmpvar_38;
    tmpvar_38 = (1.0 - dot (-(tmpvar_18), tmpvar_36));
    tmpvar_37 = (0.25 * exp((-0.00287 + 
      (tmpvar_38 * (0.459 + (tmpvar_38 * (3.83 + 
        (tmpvar_38 * (-6.8 + (tmpvar_38 * 5.25)))
      ))))
    )));
    highp float tmpvar_39;
    tmpvar_39 = (1.0 - dot (_WorldSpaceLightPos0.xyz, tmpvar_36));
    highp float tmpvar_40;
    tmpvar_40 = (far_3 / 2.0);
    highp vec3 tmpvar_41;
    tmpvar_41 = (vec3(0.0, 1.0001, 0.0) + ((tmpvar_18 * tmpvar_40) * 0.5));
    highp float tmpvar_42;
    tmpvar_42 = exp((160.0002 * (1.0 - 
      sqrt(dot (tmpvar_41, tmpvar_41))
    )));
    highp vec3 tmpvar_43;
    tmpvar_43 = exp((-(
      clamp (((tmpvar_42 * (
        (0.25 * exp((-0.00287 + (tmpvar_39 * 
          (0.459 + (tmpvar_39 * (3.83 + (tmpvar_39 * 
            (-6.8 + (tmpvar_39 * 5.25))
          ))))
        ))))
       + tmpvar_37)) - (0.9996001 * tmpvar_37)), 0.0, 50.0)
    ) * (
      (tmpvar_13 * kKr4PI_4)
     + 0.01256637)));
    frontColor_1_35 = (tmpvar_43 * (tmpvar_42 * (tmpvar_40 * 40.00004)));
    cIn_2 = (frontColor_1_35 * ((tmpvar_13 * kKrESun_5) + 0.02));
    highp vec3 tmpvar_44;
    tmpvar_44 = clamp (tmpvar_43, vec3(0.0, 0.0, 0.0), vec3(1.0, 1.0, 1.0));
    cOut_1 = tmpvar_44;
  };
  highp vec3 tmpvar_45;
  tmpvar_45 = -(_glesVertex).xyz;
  tmpvar_7 = tmpvar_45;
  tmpvar_8 = (_Exposure * (cIn_2 + (
    (_GroundColor * _GroundColor)
   * cOut_1)));
  mediump vec3 light_46;
  light_46 = _WorldSpaceLightPos0.xyz;
  mediump vec3 ray_47;
  ray_47 = -(tmpvar_18);
  mediump float tmpvar_48;
  tmpvar_48 = dot (light_46, ray_47);
  tmpvar_9 = (_Exposure * (cIn_2 * (0.75 + 
    (0.75 * (tmpvar_48 * tmpvar_48))
  )));
  tmpvar_10 = (_Exposure * (cOut_1 * _LightColor0.xyz));
  mediump vec3 tmpvar_49;
  tmpvar_49 = sqrt(tmpvar_8);
  tmpvar_8 = tmpvar_49;
  mediump vec3 tmpvar_50;
  tmpvar_50 = sqrt(tmpvar_9);
  tmpvar_9 = tmpvar_50;
  mediump vec3 tmpvar_51;
  tmpvar_51 = sqrt(tmpvar_10);
  tmpvar_10 = tmpvar_51;
  gl_Position = tmpvar_11;
  xlv_TEXCOORD0 = tmpvar_7;
  xlv_TEXCOORD1 = tmpvar_49;
  xlv_TEXCOORD2 = tmpvar_50;
  xlv_TEXCOORD3 = tmpvar_51;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform mediump float _SunSize;
varying mediump vec3 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  mediump vec3 col_1;
  highp mat3 tmpvar_2;
  tmpvar_2[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_2[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_2[2] = unity_ObjectToWorld[2].xyz;
  mediump vec3 tmpvar_3;
  tmpvar_3 = normalize((tmpvar_2 * xlv_TEXCOORD0));
  mediump float tmpvar_4;
  tmpvar_4 = (tmpvar_3.y / 0.02);
  mediump vec3 tmpvar_5;
  tmpvar_5 = mix (xlv_TEXCOORD2, xlv_TEXCOORD1, vec3(clamp (tmpvar_4, 0.0, 1.0)));
  col_1 = tmpvar_5;
  if ((tmpvar_4 < 0.0)) {
    mediump float eyeCos_6;
    highp float tmpvar_7;
    tmpvar_7 = dot (_WorldSpaceLightPos0.xyz, tmpvar_3);
    eyeCos_6 = tmpvar_7;
    mediump float temp_8;
    temp_8 = ((0.01001645 * (1.0 + 
      (eyeCos_6 * eyeCos_6)
    )) / max (pow (
      (1.9801 - (-1.98 * eyeCos_6))
    , 
      (pow (_SunSize, 0.65) * 10.0)
    ), 0.0001));
    mediump float tmpvar_9;
    tmpvar_9 = pow (temp_8, 0.454545);
    temp_8 = tmpvar_9;
    col_1 = (tmpvar_5 + (tmpvar_9 * xlv_TEXCOORD3));
  };
  mediump vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = col_1;
  gl_FragData[0] = tmpvar_10;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "_SUNDISK_HIGH_QUALITY" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform lowp vec4 _LightColor0;
uniform mediump float _Exposure;
uniform mediump vec3 _GroundColor;
uniform mediump vec3 _SkyTint;
uniform mediump float _AtmosphereThickness;
varying mediump vec3 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  mediump vec3 cOut_1;
  mediump vec3 cIn_2;
  highp float far_3;
  highp float kKr4PI_4;
  highp float kKrESun_5;
  highp vec3 kSkyTintInGammaSpace_6;
  mediump vec3 tmpvar_7;
  mediump vec3 tmpvar_8;
  mediump vec3 tmpvar_9;
  mediump vec3 tmpvar_10;
  highp vec4 tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _glesVertex.xyz;
  tmpvar_11 = (glstate_matrix_mvp * tmpvar_12);
  kSkyTintInGammaSpace_6 = _SkyTint;
  highp vec3 tmpvar_13;
  tmpvar_13 = (1.0/(pow (mix (vec3(0.5, 0.42, 0.325), vec3(0.8, 0.72, 0.625), 
    (vec3(1.0, 1.0, 1.0) - kSkyTintInGammaSpace_6)
  ), vec3(4.0, 4.0, 4.0))));
  mediump float tmpvar_14;
  mediump float tmpvar_15;
  tmpvar_15 = pow (_AtmosphereThickness, 2.5);
  tmpvar_14 = (0.05 * tmpvar_15);
  kKrESun_5 = tmpvar_14;
  mediump float tmpvar_16;
  tmpvar_16 = (0.03141593 * tmpvar_15);
  kKr4PI_4 = tmpvar_16;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_17[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_17[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((tmpvar_17 * _glesVertex.xyz));
  far_3 = 0.0;
  if ((tmpvar_18.y >= 0.0)) {
    highp vec3 frontColor_19;
    highp vec3 samplePoint_20;
    far_3 = (sqrt((
      (1.050625 + (tmpvar_18.y * tmpvar_18.y))
     - 1.0)) - tmpvar_18.y);
    highp float tmpvar_21;
    tmpvar_21 = (1.0 - (dot (tmpvar_18, vec3(0.0, 1.0001, 0.0)) / 1.0001));
    highp float tmpvar_22;
    tmpvar_22 = (exp((-0.00287 + 
      (tmpvar_21 * (0.459 + (tmpvar_21 * (3.83 + 
        (tmpvar_21 * (-6.8 + (tmpvar_21 * 5.25)))
      ))))
    )) * 0.2460318);
    highp float tmpvar_23;
    tmpvar_23 = (far_3 / 2.0);
    highp float tmpvar_24;
    tmpvar_24 = (tmpvar_23 * 40.00004);
    highp vec3 tmpvar_25;
    tmpvar_25 = (tmpvar_18 * tmpvar_23);
    highp vec3 tmpvar_26;
    tmpvar_26 = (vec3(0.0, 1.0001, 0.0) + (tmpvar_25 * 0.5));
    highp float tmpvar_27;
    tmpvar_27 = sqrt(dot (tmpvar_26, tmpvar_26));
    highp float tmpvar_28;
    tmpvar_28 = exp((160.0002 * (1.0 - tmpvar_27)));
    highp float tmpvar_29;
    tmpvar_29 = (1.0 - (dot (_WorldSpaceLightPos0.xyz, tmpvar_26) / tmpvar_27));
    highp float tmpvar_30;
    tmpvar_30 = (1.0 - (dot (tmpvar_18, tmpvar_26) / tmpvar_27));
    frontColor_19 = (exp((
      -(clamp ((tmpvar_22 + (tmpvar_28 * 
        ((0.25 * exp((-0.00287 + 
          (tmpvar_29 * (0.459 + (tmpvar_29 * (3.83 + 
            (tmpvar_29 * (-6.8 + (tmpvar_29 * 5.25)))
          ))))
        ))) - (0.25 * exp((-0.00287 + 
          (tmpvar_30 * (0.459 + (tmpvar_30 * (3.83 + 
            (tmpvar_30 * (-6.8 + (tmpvar_30 * 5.25)))
          ))))
        ))))
      )), 0.0, 50.0))
     * 
      ((tmpvar_13 * kKr4PI_4) + 0.01256637)
    )) * (tmpvar_28 * tmpvar_24));
    samplePoint_20 = (tmpvar_26 + tmpvar_25);
    highp float tmpvar_31;
    tmpvar_31 = sqrt(dot (samplePoint_20, samplePoint_20));
    highp float tmpvar_32;
    tmpvar_32 = exp((160.0002 * (1.0 - tmpvar_31)));
    highp float tmpvar_33;
    tmpvar_33 = (1.0 - (dot (_WorldSpaceLightPos0.xyz, samplePoint_20) / tmpvar_31));
    highp float tmpvar_34;
    tmpvar_34 = (1.0 - (dot (tmpvar_18, samplePoint_20) / tmpvar_31));
    frontColor_19 = (frontColor_19 + (exp(
      (-(clamp ((tmpvar_22 + 
        (tmpvar_32 * ((0.25 * exp(
          (-0.00287 + (tmpvar_33 * (0.459 + (tmpvar_33 * 
            (3.83 + (tmpvar_33 * (-6.8 + (tmpvar_33 * 5.25))))
          ))))
        )) - (0.25 * exp(
          (-0.00287 + (tmpvar_34 * (0.459 + (tmpvar_34 * 
            (3.83 + (tmpvar_34 * (-6.8 + (tmpvar_34 * 5.25))))
          ))))
        ))))
      ), 0.0, 50.0)) * ((tmpvar_13 * kKr4PI_4) + 0.01256637))
    ) * (tmpvar_32 * tmpvar_24)));
    samplePoint_20 = (samplePoint_20 + tmpvar_25);
    cIn_2 = (frontColor_19 * (tmpvar_13 * kKrESun_5));
    cOut_1 = (frontColor_19 * 0.02);
  } else {
    highp vec3 frontColor_1_35;
    far_3 = (-0.0001 / min (-0.001, tmpvar_18.y));
    highp vec3 tmpvar_36;
    tmpvar_36 = (vec3(0.0, 1.0001, 0.0) + (far_3 * tmpvar_18));
    highp float tmpvar_37;
    highp float tmpvar_38;
    tmpvar_38 = (1.0 - dot (-(tmpvar_18), tmpvar_36));
    tmpvar_37 = (0.25 * exp((-0.00287 + 
      (tmpvar_38 * (0.459 + (tmpvar_38 * (3.83 + 
        (tmpvar_38 * (-6.8 + (tmpvar_38 * 5.25)))
      ))))
    )));
    highp float tmpvar_39;
    tmpvar_39 = (1.0 - dot (_WorldSpaceLightPos0.xyz, tmpvar_36));
    highp float tmpvar_40;
    tmpvar_40 = (far_3 / 2.0);
    highp vec3 tmpvar_41;
    tmpvar_41 = (vec3(0.0, 1.0001, 0.0) + ((tmpvar_18 * tmpvar_40) * 0.5));
    highp float tmpvar_42;
    tmpvar_42 = exp((160.0002 * (1.0 - 
      sqrt(dot (tmpvar_41, tmpvar_41))
    )));
    highp vec3 tmpvar_43;
    tmpvar_43 = exp((-(
      clamp (((tmpvar_42 * (
        (0.25 * exp((-0.00287 + (tmpvar_39 * 
          (0.459 + (tmpvar_39 * (3.83 + (tmpvar_39 * 
            (-6.8 + (tmpvar_39 * 5.25))
          ))))
        ))))
       + tmpvar_37)) - (0.9996001 * tmpvar_37)), 0.0, 50.0)
    ) * (
      (tmpvar_13 * kKr4PI_4)
     + 0.01256637)));
    frontColor_1_35 = (tmpvar_43 * (tmpvar_42 * (tmpvar_40 * 40.00004)));
    cIn_2 = (frontColor_1_35 * ((tmpvar_13 * kKrESun_5) + 0.02));
    highp vec3 tmpvar_44;
    tmpvar_44 = clamp (tmpvar_43, vec3(0.0, 0.0, 0.0), vec3(1.0, 1.0, 1.0));
    cOut_1 = tmpvar_44;
  };
  highp vec3 tmpvar_45;
  tmpvar_45 = -(_glesVertex).xyz;
  tmpvar_7 = tmpvar_45;
  tmpvar_8 = (_Exposure * (cIn_2 + (
    (_GroundColor * _GroundColor)
   * cOut_1)));
  mediump vec3 light_46;
  light_46 = _WorldSpaceLightPos0.xyz;
  mediump vec3 ray_47;
  ray_47 = -(tmpvar_18);
  mediump float tmpvar_48;
  tmpvar_48 = dot (light_46, ray_47);
  tmpvar_9 = (_Exposure * (cIn_2 * (0.75 + 
    (0.75 * (tmpvar_48 * tmpvar_48))
  )));
  tmpvar_10 = (_Exposure * (cOut_1 * _LightColor0.xyz));
  mediump vec3 tmpvar_49;
  tmpvar_49 = sqrt(tmpvar_8);
  tmpvar_8 = tmpvar_49;
  mediump vec3 tmpvar_50;
  tmpvar_50 = sqrt(tmpvar_9);
  tmpvar_9 = tmpvar_50;
  mediump vec3 tmpvar_51;
  tmpvar_51 = sqrt(tmpvar_10);
  tmpvar_10 = tmpvar_51;
  gl_Position = tmpvar_11;
  xlv_TEXCOORD0 = tmpvar_7;
  xlv_TEXCOORD1 = tmpvar_49;
  xlv_TEXCOORD2 = tmpvar_50;
  xlv_TEXCOORD3 = tmpvar_51;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform mediump float _SunSize;
varying mediump vec3 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  mediump vec3 col_1;
  highp mat3 tmpvar_2;
  tmpvar_2[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_2[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_2[2] = unity_ObjectToWorld[2].xyz;
  mediump vec3 tmpvar_3;
  tmpvar_3 = normalize((tmpvar_2 * xlv_TEXCOORD0));
  mediump float tmpvar_4;
  tmpvar_4 = (tmpvar_3.y / 0.02);
  mediump vec3 tmpvar_5;
  tmpvar_5 = mix (xlv_TEXCOORD2, xlv_TEXCOORD1, vec3(clamp (tmpvar_4, 0.0, 1.0)));
  col_1 = tmpvar_5;
  if ((tmpvar_4 < 0.0)) {
    mediump float eyeCos_6;
    highp float tmpvar_7;
    tmpvar_7 = dot (_WorldSpaceLightPos0.xyz, tmpvar_3);
    eyeCos_6 = tmpvar_7;
    mediump float temp_8;
    temp_8 = ((0.01001645 * (1.0 + 
      (eyeCos_6 * eyeCos_6)
    )) / max (pow (
      (1.9801 - (-1.98 * eyeCos_6))
    , 
      (pow (_SunSize, 0.65) * 10.0)
    ), 0.0001));
    mediump float tmpvar_9;
    tmpvar_9 = pow (temp_8, 0.454545);
    temp_8 = tmpvar_9;
    col_1 = (tmpvar_5 + (tmpvar_9 * xlv_TEXCOORD3));
  };
  mediump vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = col_1;
  gl_FragData[0] = tmpvar_10;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "_SUNDISK_HIGH_QUALITY" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform lowp vec4 _LightColor0;
uniform mediump float _Exposure;
uniform mediump vec3 _GroundColor;
uniform mediump vec3 _SkyTint;
uniform mediump float _AtmosphereThickness;
varying mediump vec3 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  mediump vec3 cOut_1;
  mediump vec3 cIn_2;
  highp float far_3;
  highp float kKr4PI_4;
  highp float kKrESun_5;
  highp vec3 kSkyTintInGammaSpace_6;
  mediump vec3 tmpvar_7;
  mediump vec3 tmpvar_8;
  mediump vec3 tmpvar_9;
  mediump vec3 tmpvar_10;
  highp vec4 tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _glesVertex.xyz;
  tmpvar_11 = (glstate_matrix_mvp * tmpvar_12);
  kSkyTintInGammaSpace_6 = _SkyTint;
  highp vec3 tmpvar_13;
  tmpvar_13 = (1.0/(pow (mix (vec3(0.5, 0.42, 0.325), vec3(0.8, 0.72, 0.625), 
    (vec3(1.0, 1.0, 1.0) - kSkyTintInGammaSpace_6)
  ), vec3(4.0, 4.0, 4.0))));
  mediump float tmpvar_14;
  mediump float tmpvar_15;
  tmpvar_15 = pow (_AtmosphereThickness, 2.5);
  tmpvar_14 = (0.05 * tmpvar_15);
  kKrESun_5 = tmpvar_14;
  mediump float tmpvar_16;
  tmpvar_16 = (0.03141593 * tmpvar_15);
  kKr4PI_4 = tmpvar_16;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_17[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_17[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((tmpvar_17 * _glesVertex.xyz));
  far_3 = 0.0;
  if ((tmpvar_18.y >= 0.0)) {
    highp vec3 frontColor_19;
    highp vec3 samplePoint_20;
    far_3 = (sqrt((
      (1.050625 + (tmpvar_18.y * tmpvar_18.y))
     - 1.0)) - tmpvar_18.y);
    highp float tmpvar_21;
    tmpvar_21 = (1.0 - (dot (tmpvar_18, vec3(0.0, 1.0001, 0.0)) / 1.0001));
    highp float tmpvar_22;
    tmpvar_22 = (exp((-0.00287 + 
      (tmpvar_21 * (0.459 + (tmpvar_21 * (3.83 + 
        (tmpvar_21 * (-6.8 + (tmpvar_21 * 5.25)))
      ))))
    )) * 0.2460318);
    highp float tmpvar_23;
    tmpvar_23 = (far_3 / 2.0);
    highp float tmpvar_24;
    tmpvar_24 = (tmpvar_23 * 40.00004);
    highp vec3 tmpvar_25;
    tmpvar_25 = (tmpvar_18 * tmpvar_23);
    highp vec3 tmpvar_26;
    tmpvar_26 = (vec3(0.0, 1.0001, 0.0) + (tmpvar_25 * 0.5));
    highp float tmpvar_27;
    tmpvar_27 = sqrt(dot (tmpvar_26, tmpvar_26));
    highp float tmpvar_28;
    tmpvar_28 = exp((160.0002 * (1.0 - tmpvar_27)));
    highp float tmpvar_29;
    tmpvar_29 = (1.0 - (dot (_WorldSpaceLightPos0.xyz, tmpvar_26) / tmpvar_27));
    highp float tmpvar_30;
    tmpvar_30 = (1.0 - (dot (tmpvar_18, tmpvar_26) / tmpvar_27));
    frontColor_19 = (exp((
      -(clamp ((tmpvar_22 + (tmpvar_28 * 
        ((0.25 * exp((-0.00287 + 
          (tmpvar_29 * (0.459 + (tmpvar_29 * (3.83 + 
            (tmpvar_29 * (-6.8 + (tmpvar_29 * 5.25)))
          ))))
        ))) - (0.25 * exp((-0.00287 + 
          (tmpvar_30 * (0.459 + (tmpvar_30 * (3.83 + 
            (tmpvar_30 * (-6.8 + (tmpvar_30 * 5.25)))
          ))))
        ))))
      )), 0.0, 50.0))
     * 
      ((tmpvar_13 * kKr4PI_4) + 0.01256637)
    )) * (tmpvar_28 * tmpvar_24));
    samplePoint_20 = (tmpvar_26 + tmpvar_25);
    highp float tmpvar_31;
    tmpvar_31 = sqrt(dot (samplePoint_20, samplePoint_20));
    highp float tmpvar_32;
    tmpvar_32 = exp((160.0002 * (1.0 - tmpvar_31)));
    highp float tmpvar_33;
    tmpvar_33 = (1.0 - (dot (_WorldSpaceLightPos0.xyz, samplePoint_20) / tmpvar_31));
    highp float tmpvar_34;
    tmpvar_34 = (1.0 - (dot (tmpvar_18, samplePoint_20) / tmpvar_31));
    frontColor_19 = (frontColor_19 + (exp(
      (-(clamp ((tmpvar_22 + 
        (tmpvar_32 * ((0.25 * exp(
          (-0.00287 + (tmpvar_33 * (0.459 + (tmpvar_33 * 
            (3.83 + (tmpvar_33 * (-6.8 + (tmpvar_33 * 5.25))))
          ))))
        )) - (0.25 * exp(
          (-0.00287 + (tmpvar_34 * (0.459 + (tmpvar_34 * 
            (3.83 + (tmpvar_34 * (-6.8 + (tmpvar_34 * 5.25))))
          ))))
        ))))
      ), 0.0, 50.0)) * ((tmpvar_13 * kKr4PI_4) + 0.01256637))
    ) * (tmpvar_32 * tmpvar_24)));
    samplePoint_20 = (samplePoint_20 + tmpvar_25);
    cIn_2 = (frontColor_19 * (tmpvar_13 * kKrESun_5));
    cOut_1 = (frontColor_19 * 0.02);
  } else {
    highp vec3 frontColor_1_35;
    far_3 = (-0.0001 / min (-0.001, tmpvar_18.y));
    highp vec3 tmpvar_36;
    tmpvar_36 = (vec3(0.0, 1.0001, 0.0) + (far_3 * tmpvar_18));
    highp float tmpvar_37;
    highp float tmpvar_38;
    tmpvar_38 = (1.0 - dot (-(tmpvar_18), tmpvar_36));
    tmpvar_37 = (0.25 * exp((-0.00287 + 
      (tmpvar_38 * (0.459 + (tmpvar_38 * (3.83 + 
        (tmpvar_38 * (-6.8 + (tmpvar_38 * 5.25)))
      ))))
    )));
    highp float tmpvar_39;
    tmpvar_39 = (1.0 - dot (_WorldSpaceLightPos0.xyz, tmpvar_36));
    highp float tmpvar_40;
    tmpvar_40 = (far_3 / 2.0);
    highp vec3 tmpvar_41;
    tmpvar_41 = (vec3(0.0, 1.0001, 0.0) + ((tmpvar_18 * tmpvar_40) * 0.5));
    highp float tmpvar_42;
    tmpvar_42 = exp((160.0002 * (1.0 - 
      sqrt(dot (tmpvar_41, tmpvar_41))
    )));
    highp vec3 tmpvar_43;
    tmpvar_43 = exp((-(
      clamp (((tmpvar_42 * (
        (0.25 * exp((-0.00287 + (tmpvar_39 * 
          (0.459 + (tmpvar_39 * (3.83 + (tmpvar_39 * 
            (-6.8 + (tmpvar_39 * 5.25))
          ))))
        ))))
       + tmpvar_37)) - (0.9996001 * tmpvar_37)), 0.0, 50.0)
    ) * (
      (tmpvar_13 * kKr4PI_4)
     + 0.01256637)));
    frontColor_1_35 = (tmpvar_43 * (tmpvar_42 * (tmpvar_40 * 40.00004)));
    cIn_2 = (frontColor_1_35 * ((tmpvar_13 * kKrESun_5) + 0.02));
    highp vec3 tmpvar_44;
    tmpvar_44 = clamp (tmpvar_43, vec3(0.0, 0.0, 0.0), vec3(1.0, 1.0, 1.0));
    cOut_1 = tmpvar_44;
  };
  highp vec3 tmpvar_45;
  tmpvar_45 = -(_glesVertex).xyz;
  tmpvar_7 = tmpvar_45;
  tmpvar_8 = (_Exposure * (cIn_2 + (
    (_GroundColor * _GroundColor)
   * cOut_1)));
  mediump vec3 light_46;
  light_46 = _WorldSpaceLightPos0.xyz;
  mediump vec3 ray_47;
  ray_47 = -(tmpvar_18);
  mediump float tmpvar_48;
  tmpvar_48 = dot (light_46, ray_47);
  tmpvar_9 = (_Exposure * (cIn_2 * (0.75 + 
    (0.75 * (tmpvar_48 * tmpvar_48))
  )));
  tmpvar_10 = (_Exposure * (cOut_1 * _LightColor0.xyz));
  mediump vec3 tmpvar_49;
  tmpvar_49 = sqrt(tmpvar_8);
  tmpvar_8 = tmpvar_49;
  mediump vec3 tmpvar_50;
  tmpvar_50 = sqrt(tmpvar_9);
  tmpvar_9 = tmpvar_50;
  mediump vec3 tmpvar_51;
  tmpvar_51 = sqrt(tmpvar_10);
  tmpvar_10 = tmpvar_51;
  gl_Position = tmpvar_11;
  xlv_TEXCOORD0 = tmpvar_7;
  xlv_TEXCOORD1 = tmpvar_49;
  xlv_TEXCOORD2 = tmpvar_50;
  xlv_TEXCOORD3 = tmpvar_51;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform mediump float _SunSize;
varying mediump vec3 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  mediump vec3 col_1;
  highp mat3 tmpvar_2;
  tmpvar_2[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_2[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_2[2] = unity_ObjectToWorld[2].xyz;
  mediump vec3 tmpvar_3;
  tmpvar_3 = normalize((tmpvar_2 * xlv_TEXCOORD0));
  mediump float tmpvar_4;
  tmpvar_4 = (tmpvar_3.y / 0.02);
  mediump vec3 tmpvar_5;
  tmpvar_5 = mix (xlv_TEXCOORD2, xlv_TEXCOORD1, vec3(clamp (tmpvar_4, 0.0, 1.0)));
  col_1 = tmpvar_5;
  if ((tmpvar_4 < 0.0)) {
    mediump float eyeCos_6;
    highp float tmpvar_7;
    tmpvar_7 = dot (_WorldSpaceLightPos0.xyz, tmpvar_3);
    eyeCos_6 = tmpvar_7;
    mediump float temp_8;
    temp_8 = ((0.01001645 * (1.0 + 
      (eyeCos_6 * eyeCos_6)
    )) / max (pow (
      (1.9801 - (-1.98 * eyeCos_6))
    , 
      (pow (_SunSize, 0.65) * 10.0)
    ), 0.0001));
    mediump float tmpvar_9;
    tmpvar_9 = pow (temp_8, 0.454545);
    temp_8 = tmpvar_9;
    col_1 = (tmpvar_5 + (tmpvar_9 * xlv_TEXCOORD3));
  };
  mediump vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = col_1;
  gl_FragData[0] = tmpvar_10;
}


#endif
"
}
}
Program "fp" {
SubProgram "gles hw_tier00 " {
Keywords { "_SUNDISK_NONE" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "_SUNDISK_NONE" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "_SUNDISK_NONE" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "_SUNDISK_SIMPLE" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "_SUNDISK_SIMPLE" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "_SUNDISK_SIMPLE" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "_SUNDISK_HIGH_QUALITY" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "_SUNDISK_HIGH_QUALITY" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "_SUNDISK_HIGH_QUALITY" }
""
}
}
}
}
}