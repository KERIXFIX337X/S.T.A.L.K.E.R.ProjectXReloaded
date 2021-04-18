function l_special (shader,t_base,t_second,t_detail)
shader:begin("model_distort4glass","particle_distort")
:sorting(3,true)
:blend(true,blend.srcalpha,blend.invsrcalpha)
:zb(true,false)
:fog(false)
:distort(true)
shader:sampler("s_base"):texture(t_base)
shader:sampler("s_distort"):texture("pfx\\pfx_dist_glass2")
end
function normal (shader,t_base,t_second,t_detail)
shader:begin ("model_env_lq","model_env_lq")
:fog(true)
:zb(true,false)
:blend(true,blend.srcalpha,blend.invsrcalpha)
:aref(true,0)
:sorting(3,true)
:distort(true)
shader:sampler("s_base"):texture(t_base)
shader:sampler("s_env"):texture("sky\\sky_5_cube"):clamp()
end