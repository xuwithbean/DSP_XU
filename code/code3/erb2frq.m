function [frq,bnd] = erb2frq(erb)
frq = sign(erb).*(676170.4*(47.06538-exp(0.08950404*abs(erb))).^(-1) - 14678.49);
bnd=6.23e-6*frq.^2 + 93.39e-3*abs(frq) + 28.52;
if ~nargout
    plot(erb,frq,'-x');
    xlabel(['Frequency (' xticksi 'Erb-rate)']);
    ylabel(['Frequency (' yticksi 'Hz)']);
end