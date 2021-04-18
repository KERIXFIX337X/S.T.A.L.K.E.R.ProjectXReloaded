#include "ShaderSettings.txt"
#ifndef MBLUR_H
#define MBLUR_H
#define MBLUR_CLAMP float(0.001)
#ifdef SKY4CE_MBLUR
#include "common.h"
uniform float4x4 m_current;
uniform float4x4 m_previous;
uniform float2 m_blur;
float3 mblur(float2 UV,float3 pos,float3 c_original){
float4 pos4=float4(pos,1.h);
float4 p_current=mul(m_current,pos4);
float4 p_previous=mul(m_previous,pos4);
float2 p_velocity=float2(SCALE_X,SCALE_Y)*(p_current.xy/p_current.w-(p_previous.xy/p_previous.w));
float VL=length(p_velocity);
p_velocity=clamp(p_velocity,-IMB_CLAMP,+IMB_CLAMP);
int modif=MBLUR_SAMPLES;
p_velocity=(VL>VEL_START?p_velocity:float2(0,0);
float3 blurred=c_original;
for(int i=1;i<(modif);UV+=p_velocity ,i++) blurred+=tex2D(s_image,UV).rgb;
float3 distance_soft=(pos.z>START_DIST && pos.z<FINAL_DIST)?(c_original+((((blurred/(modif))-c_original)*(pos.z-START_DIST))/(FINAL_DIST-START_DIST))):blurred/(modif);
float3 velocity_soft=(VL>VEL_START && VL<VEL_FIN)?(c_original+((((blurred/(modif))-c_original)*(VL-VEL_START))/(VEL_FIN-VEL_START))):blurred/(modif);
return (distance_soft+velocity_soft)/2;
}
#else
#ifndef USE_MBLUR
float3 mblur(float2 UV,float3 pos,float3 c_original){ return c_original;}
#else
#include "common.h"
uniform float4x4 m_current;
uniform float4x4 m_previous;
uniform float2 m_blur;
float3 mblur(float2 UV,float3 pos,float3 c_original){
float4 pos4=float4(pos,1.h);
float4 p_current=mul(m_current,pos4);
float4 p_previous=mul (m_previous,pos4);
float2 p_velocity=m_blur*((p_current.xy/p_current.w)-(p_previous.xy/p_previous.w));
p_velocity=clamp(p_velocity,-MBLUR_CLAMP,+MBLUR_CLAMP);
float VL=length(p_velocity);
float3 blurred=c_original;
blurred+=tex2D(s_image,p_velocity*1.h+UV).rgb;
blurred+=tex2D(s_image,p_velocity*2.h+UV).rgb;
blurred+=tex2D(s_image,p_velocity*3.h+UV).rgb;
blurred+=tex2D(s_image,p_velocity*4.h+UV).rgb;
blurred+=tex2D(s_image,p_velocity*5.h+UV).rgb;
blurred+=tex2D(s_image,p_velocity*6.h+UV).rgb;
blurred+=tex2D(s_image,p_velocity*7.h+UV).rgb;
blurred+=tex2D(s_image,p_velocity*8.h+UV).rgb;
blurred+=tex2D(s_image,p_velocity*9.h+UV).rgb;
blurred+=tex2D(s_image,p_velocity*10.h+UV).rgb;
blurred+=tex2D(s_image,p_velocity*11.h+UV).rgb;
return blurred/12;
}
#endif
#endif
#endif