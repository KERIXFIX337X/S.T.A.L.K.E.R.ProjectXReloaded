#include "common.h"
vf_point main(v_vert v) {
vf_point o;
o.hpos = mul(m_VP,v.P);
o.tc0 = unpack_tc_base(v.uv,v.T.w,v.B.w);
o.color = calc_point(o.tc1,o.tc2,v.P,unpack_normal(v.N));
return o;
}