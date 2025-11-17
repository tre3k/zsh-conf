set encoding utf8
#set terminal wxt font "Times New Roman,10"
#set terminal postscript eps color font "Times New Roman,10"
set termoption font "Times New Roman,16"
#set key rmargin

set tics nomirror    # не показаывать x2 и y2 оси
#set tics in
#set tics out

# fit function:
GAUSSE(_a,_x,_xc,_w,_y0) = _y0+_a*exp(-(_x-_xc)**2/2/_w**2)
LORENTZ(_a,_x,_xc,_gamma,_y0) = _y0+_a/pi/_gamma/(1+((_x-_xc)/_gamma)**2)
PSEUDO_VOIGT(_a,_x,_xc,_w,_gamma,_etta,_y0) = _y0 + _a*((1-_etta)*(GAUSSE(_a,_x,_xc,_w,_y0)-_y0)/_a + _etta*(LORENTZ(_a,_x,_xc,_gamma,_y0)-_y0)/_a)
GAUSSE_WAVELET_1(_x) = -_x*exp(-_x**2/2)
GAUSSE_WAVELET_2(_x) = -(_x**2*exp(-_x**2/2)-exp(-_x**2/2))
GAUSSE_WAVELET_3(_x) = 3*_x*exp(-_x**2/2)-_x**3*exp(-_x**2/2)
GAUSSE_WAVELET_4(_x) = -(_x**4*exp(-_x**2/2)-6*_x**2*exp(-_x**2/2)+3*exp(-_x**2/2))


# c = m / 2 / k / T
maxwell(x, _c) = (_c/pi)**(3/2) * exp(-_c * x**2) * 4 * pi * x**2

# a - amplitude
# b - background
# x0 - offset
maxwell_(x, _c, _a, _b, _x0) = \
((x-_x0) >= 0 ? _a * maxwell((x-_x0), _c) + _b : 0)
