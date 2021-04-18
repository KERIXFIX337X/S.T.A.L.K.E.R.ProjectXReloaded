#include "common.h"
#include "skin.h"
struct vf {
float4 hpos:POSITION;
float2 tc0:TEXCOORD0;
float3 tc1:TEXCOORD1;
float4 tc2:TEXCOORD2;
float3 c0:COLOR0;
float4 c1:COLOR1;
float fog:FOG;
};
vf _main(v_model v) {
vf o;
float4 pos = v.pos;
float3 pos_w = mul(m_W,pos);
float4 pos_w4 = float4(pos_w,1);
float3 norm_w = normalize(mul(m_W,v.norm));
o.hpos = mul(m_WVP,pos);
o.tc0 = v.tc.xy;
o.tc1 = calc_reflection(pos_w,norm_w);
o.tc2 = calc_model_lmap(pos_w);
o.c0 = calc_sun(norm_w);
o.c1 = float4(calc_model_lq_lighting(norm_w),m_plmap_clamp[0].w);
o.fog = calc_fogging(pos_w4);
#ifdef SKIN_COLOR
o.c1.rgb*= v.rgb_tint;
o.c1.w = 1;
#endif
return o;
}
#ifdef SKIN_NONE
vf main(v_model v) { return _main(v);}
#endif
#ifdef SKIN_0
vf main(v_model_skinned_0 v) { return _main(skinning_0(v));}
#endif
#ifdef SKIN_1
vf main(v_model_skinned_1 v) { return _main(skinning_1(v));}
#endif
#ifdef SKIN_2
vf main(v_model_skinned_2 v) { return _main(skinning_2(v));}
#endif