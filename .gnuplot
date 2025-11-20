set encoding utf8
#set terminal wxt font "Times New Roman,10"
#set terminal postscript eps color font "Times New Roman,10"
set termoption font "Times New Roman,16"
#set key rmargin
set key inside

set tics nomirror    # не показаывать x2 и y2 оси
#set tics in
#set tics out

# fit function:
gausse(_x,_a,_xc,_w,_y0) = _y0 + _a*exp(-(_x-_xc)**2/2/_w**2)
lorentz(_a,_x,_xc,_gamma,_y0) = _y0+_a/pi/_gamma/(1+((_x-_xc)/_gamma)**2)
pseudo_voigt(_a,_x,_xc,_w,_gamma,_etta,_y0) = _y0 + \
_a*((1-_etta) * (gausse(_a,_x,_xc,_w,_y0)-_y0)/_a + \
_etta*(lorentz(_a,_x,_xc,_gamma,_y0)-_y0)/_a)

gausse_wavelet_1(_x) = -_x*exp(-_x**2/2)
gausse_wavelet_2(_x) = -(_x**2*exp(-_x**2/2)-exp(-_x**2/2))
gausse_wavelet_3(_x) = 3*_x*exp(-_x**2/2)-_x**3*exp(-_x**2/2)
gausse_wavelet_4(_x) = -(_x**4*exp(-_x**2/2)-6*_x**2*exp(-_x**2/2)+3*exp(-_x**2/2))


# c = m / 2 / k / T
maxwell(_x, _c) = (_c/pi)**(3/2) * exp(-_c * _x**2) * 4 * pi * _x**2

# a - amplitude
# b - background
# x0 - offset
maxwell_(_x, _c, _a, _b, _x0) = \
((_x-_x0) >= 0 ? _a * maxwell((_x-_x0), _c) + _b : 0)
