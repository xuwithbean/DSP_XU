function [erb,bnd] = frq2erb(frq)
g=abs(frq);
erb=11.17268*sign(frq).*log(1+46.06538*g./(g+14678.49));
bnd=6.23e-6*g.^2 + 93.39e-3*g + 28.52;
if ~nargout
    plot(frq,erb,'-x');
    xlabel(['Frequency (' xticksi 'Hz)']);
    ylabel(['Frequency (' yticksi 'Erb-rate)']);
end
