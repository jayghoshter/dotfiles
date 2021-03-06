" Vim syntax file
" Language: XNS input
" Maintainer: Eva Schlauch
" Latest Revision: 06. Februar 2012

if exists("b:current_syntax")
  finish
endif

" Keywords
syn keyword XnsKeywords ne 
syn keyword XnsKeywords nsd 
syn keyword XnsKeywords ndf 
syn keyword XnsKeywords nn 
syn keyword XnsKeywords nen 
syn keyword XnsKeywords nc 
syn keyword XnsKeywords nec 
syn keyword XnsKeywords rect 
syn keyword XnsKeywords cube 
syn keyword XnsKeywords saveminf 
syn keyword XnsKeywords savemien 
syn keyword XnsKeywords savemxyz 
syn keyword XnsKeywords savemrng 
syn keyword XnsKeywords savemreg 
syn keyword XnsKeywords savemiss 
syn keyword XnsKeywords savedaux 
syn keyword XnsKeywords savemesh 
syn keyword XnsKeywords initexp 
syn keyword XnsKeywords initspe 
syn keyword XnsKeywords noslip 
syn keyword XnsKeywords xslip 
syn keyword XnsKeywords yslip 
syn keyword XnsKeywords zslip 
syn keyword XnsKeywords slip 
syn keyword XnsKeywords rngdset 
syn keyword XnsKeywords voldset 
syn keyword XnsKeywords dispspe 
syn keyword XnsKeywords noslipx 
syn keyword XnsKeywords xslipx 
syn keyword XnsKeywords yslipx 
syn keyword XnsKeywords zslipx 
syn keyword XnsKeywords slipx 
syn keyword XnsKeywords rngxset 
syn keyword XnsKeywords volxset 
syn keyword XnsKeywords rggdset 
syn keyword XnsKeywords regirng 
syn keyword XnsKeywords regireg 
syn keyword XnsKeywords regdelta 
syn keyword XnsKeywords regsteps 
syn keyword XnsKeywords rng_clamp_tangent 
syn keyword XnsKeywords rngdexp 
syn keyword XnsKeywords ufree 
syn keyword XnsKeywords rngdval 
syn keyword XnsKeywords rngdrot 
syn keyword XnsKeywords rngdctr 
syn keyword XnsKeywords tension 
syn keyword XnsKeywords betainv 
syn keyword XnsKeywords gstress 
syn keyword XnsKeywords gheight 
syn keyword XnsKeywords freeobc 
syn keyword XnsKeywords bottom_friction_type 
syn keyword XnsKeywords bodyexp 
syn keyword XnsKeywords gravity 
syn keyword XnsKeywords gravsin 
syn keyword XnsKeywords gravcos 
syn keyword XnsKeywords periodic 
syn keyword XnsKeywords material 
syn keyword XnsKeywords gamma 
syn keyword XnsKeywords incompressible 
syn keyword XnsKeywords compressible 
syn keyword XnsKeywords tup 
syn keyword XnsKeywords swe 
syn keyword XnsKeywords advection 
syn keyword XnsKeywords stokes 
syn keyword XnsKeywords laplace 
syn keyword XnsKeywords lagrange 
syn keyword XnsKeywords mutating 
syn keyword XnsKeywords moving 
syn keyword XnsKeywords mesh_movement 
syn keyword XnsKeywords surface_movement 
syn keyword XnsKeywords turbulence_model 
syn keyword XnsKeywords distread 
syn keyword XnsKeywords distsave 
syn keyword XnsKeywords kappa 
syn keyword XnsKeywords vdc 
syn keyword XnsKeywords steady 
syn keyword XnsKeywords semi-discrete 
syn keyword XnsKeywords space-time 
syn keyword XnsKeywords nts 
syn keyword XnsKeywords dt 
syn keyword XnsKeywords alpha 
syn keyword XnsKeywords iquadqh 
syn keyword XnsKeywords iquadph 
syn keyword XnsKeywords iquadoh 
syn keyword XnsKeywords iquadgh 
syn keyword XnsKeywords iquad 
syn keyword XnsKeywords iquadck 
syn keyword XnsKeywords iquadrc 
syn keyword XnsKeywords stabilization 
syn keyword XnsKeywords element_length 
syn keyword XnsKeywords tau_momentum 
syn keyword XnsKeywords tau_dc 
syn keyword XnsKeywords element_length_factor 
syn keyword XnsKeywords tau_momentum_factor 
syn keyword XnsKeywords tau_dc_factor 
syn keyword XnsKeywords tau_continuity_factor 
syn keyword XnsKeywords element_length_surface 
syn keyword XnsKeywords tau_momentum_surface 
syn keyword XnsKeywords tau_dc_surface 
syn keyword XnsKeywords adjmom 
syn keyword XnsKeywords adjcns 
syn keyword XnsKeywords dtingls 
syn keyword XnsKeywords dtintau 
syn keyword XnsKeywords relativeu 
syn keyword XnsKeywords nit 
syn keyword XnsKeywords ntsbref 
syn keyword XnsKeywords nitbref 
syn keyword XnsKeywords cleardx 
syn keyword XnsKeywords cleardd 
syn keyword XnsKeywords symmetric 
syn keyword XnsKeywords fixedpoint 
syn keyword XnsKeywords explicit 
syn keyword XnsKeywords matrix_free 
syn keyword XnsKeywords matrix_free_mesh 
syn keyword XnsKeywords matrix_free_surface 
syn keyword XnsKeywords epsgmres 
syn keyword XnsKeywords iprecond 
syn keyword XnsKeywords iscaling 
syn keyword XnsKeywords ninner 
syn keyword XnsKeywords ninnerx 
syn keyword XnsKeywords ninnerh 
syn keyword XnsKeywords nouter 
syn keyword XnsKeywords nouterx 
syn keyword XnsKeywords nouterh 
syn keyword XnsKeywords epsilon 
syn keyword XnsKeywords dir 
syn keyword XnsKeywords mien 
syn keyword XnsKeywords minf
syn keyword XnsKeywords mxyz 
syn keyword XnsKeywords mrng 
syn keyword XnsKeywords mreg 
syn keyword XnsKeywords miss 
syn keyword XnsKeywords mnup 
syn keyword XnsKeywords mprm 
syn keyword XnsKeywords nprm 
syn keyword XnsKeywords mprd 
syn keyword XnsKeywords daux 
syn keyword XnsKeywords mien.in 
syn keyword XnsKeywords mxyz.in 
syn keyword XnsKeywords data.in 
syn keyword XnsKeywords mien.out 
syn keyword XnsKeywords mxyz.out 
syn keyword XnsKeywords data.out 
syn keyword XnsKeywords mien.all 
syn keyword XnsKeywords mxyz.all 
syn keyword XnsKeywords data.all 
syn keyword XnsKeywords mien.rng 
syn keyword XnsKeywords mxyz.rng 
syn keyword XnsKeywords data.rng 
syn keyword XnsKeywords kazuo.out 
syn keyword XnsKeywords kazuo.all 
syn keyword XnsKeywords restart 
syn keyword XnsKeywords nrec 
syn keyword XnsKeywords resettime 
syn keyword XnsKeywords ntsbout 
syn keyword XnsKeywords ntsbrng 
syn keyword XnsKeywords nprmsave 
syn keyword XnsKeywords nprmread 
syn keyword XnsKeywords abort 
syn keyword XnsKeywords quit 
syn keyword XnsKeywords source 
syn keyword XnsKeywords prealloc 
syn keyword XnsKeywords debug 
syn keyword XnsKeywords timing 
syn keyword XnsKeywords title 
syn keyword XnsKeywords ambient 
syn keyword XnsKeywords dispset 
syn keyword XnsKeywords displac 
syn keyword XnsKeywords initexp 
syn keyword XnsKeywords delta 
syn keyword XnsKeywords noslip

syn keyword XnsKeywords mmat
syn keyword XnsKeywords nmat
syn keyword XnsKeywords mtbl

syn keyword XnsKeywords chromatography
syn keyword XnsKeywords clcads 
syn keyword XnsKeywords ncomp 
syn keyword XnsKeywords clcepsilon 
syn keyword XnsKeywords mclqmax
syn keyword XnsKeywords clcdiff
syn keyword XnsKeywords mclka
syn keyword XnsKeywords mclkd 
syn keyword XnsKeywords filmcont

syn keyword XnsKeywords ambientdatatype 
syn keyword XnsKeywords ambient_ndf 
syn keyword XnsKeywords ambient_file 
syn keyword XnsKeywords pressureinambient 
syn keyword XnsKeywords chromatogram

syn keyword XnsKeywords dtexp

syn keyword XnsKeywords adaptivedt
syn keyword XnsKeywords reltol
syn keyword XnsKeywords abstol
syn keyword XnsKeywords abstol
syn keyword XnsKeywords mindt
syn keyword XnsKeywords maxdt
syn keyword XnsKeywords nstepsdtinc
syn keyword XnsKeywords nstepsconst
syn keyword XnsKeywords dtincfactor

syn keyword XnsKeywords starttime 0.0
syn keyword XnsKeywords endtime 8000.0

" Comment lines
syn match XnsComment "#.*$"

let b:current_syntax = "xns"

hi def link XnsKeywords        Statement
hi def link XnsComment         Comment






