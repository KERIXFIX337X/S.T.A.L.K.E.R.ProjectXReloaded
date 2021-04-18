#include "common.h"
#include "shared\waterconfig.h"
#include "shared\watermove.h"
struct v_vert {
float4 P:POSITION;
float4 N:NORMAL;
float4 T:TANGENT;
float4 B:BINORMAL;
float4 color:COLOR0;
float2 uv:TEXCOORD0;
};
struct vf {
float4 hpos:POSITION;
float2 tbase:TEXCOORD0;
float2 tdist0:TEXCOORD1;
float2 tdist1:TEXCOORD2;
#ifdef USE_SOFT_WATER
#ifdef NEED_SOFT_WATER
float4 tctexgen:TEXCOORD3;
#endif
#endif
};
vf main(v_vert v) {
vf o;
float4 P=v.P;
float3 N=unpack_normal(v.N);
P=watermove(P);
o.tbase=unpack_tc_base(v.uv,v.T.w,v.B.w);
o.tdist0=watermove_tc(o.tbase*W_DISTORT_BASE_TILE_0,P.xz,W_DISTORT_AMP_0);
o.tdist1=watermove_tc(o.tbase*W_DISTORT_BASE_TILE_1,P.xz,W_DISTORT_AMP_1);
o.hpos=mul(m_VP,P);
#ifdef USE_SOFT_WATER
#ifdef NEED_SOFT_WATER
o.tctexgen=mul(m_texgen,P);
float3 Pe=mul(m_V,P);
o.tctexgen.z=Pe.z;
#endif
#endif
return o;
}