function [x, mc, mn, mx] = melbankm(p, n, fs, fl, fh, w)
if nargin < 6
    w = 'tz'; 
    if nargin < 5
        fh = 0.5; 
        if nargin < 4
            fl = 0;
        end
    end
end
sfact = 2 - any(w == 's');
wr = ' ';
for i = 1:length(w)
    if any(w(i) == 'lebf')
        wr = w(i);
    end
end
if any(w == 'h') || any(w == 'H')
    mflh = [fl, fh];
else
    mflh = [fl, fh] * fs;
end
if ~any(w == 'H')
    switch wr
        case 'f' 
        case 'l'
            if fl <= 0
                error('Low frequency limit must be >0 for l option');
            end
            mflh = log10(mflh); 
        case 'e'
            mflh = frq2erb(mflh);
        case 'b'
            mflh = frq2bark(mflh);
        otherwise
            mflh = frq2mel(mflh);
    end
end
melrng = mflh * (-1:2:1)';
fn2 = floor(n/2); 
if isempty(p)
    p = ceil(4.6*log10(fs));
end
if any(w == 'c')
    if p < 1
        p = round(melrng/(p * 1000)) + 1;
    end
    melinc = melrng / (p - 1);
    mflh = mflh + (-1:2:1) * melinc;
else
    if p < 1
        p = round(melrng/(p * 1000)) - 1;
    end
    melinc = melrng / (p + 1);
end
switch wr
    case 'f'
        blim = (mflh(1) + [0, 1, p, p + 1] * melinc) * n / fs;
    case 'l'
        blim = 10.^(mflh(1) + [0, 1, p, p + 1] * melinc) * n / fs;
    case 'e'
        blim = erb2frq(mflh(1)+[0, 1, p, p + 1]*melinc) * n / fs;
    case 'b'
        blim = bark2frq(mflh(1)+[0, 1, p, p + 1]*melinc) * n / fs;
    otherwise
        blim = mel2frq(mflh(1)+[0, 1, p, p + 1]*melinc) * n / fs;
end
mc = mflh(1) + (1:p) * melinc;
b1 = floor(blim(1)) + 1;
b4 = min(fn2, ceil(blim(4))-1);
switch wr
    case 'f'
        pf = ((b1:b4) * fs / n - mflh(1)) / melinc;
    case 'l'
        pf = (log10((b1:b4)*fs/n) - mflh(1)) / melinc;
    case 'e'
        pf = (frq2erb((b1:b4)*fs/n) - mflh(1)) / melinc;
    case 'b'
        pf = (frq2bark((b1:b4)*fs/n) - mflh(1)) / melinc;
    otherwise
        pf = (frq2mel((b1:b4)*fs/n) - mflh(1)) / melinc;
end
if pf(1) < 0
    pf(1) = [];
    b1 = b1 + 1;
end
if pf(end) >= p + 1
    pf(end) = [];
    b4 = b4 - 1;
end
fp = floor(pf); 
pm = pf - fp;
k2 = find(fp > 0, 1);
k3 = find(fp < p, 1, 'last');
k4 = numel(fp);
if isempty(k2)
    k2 = k4 + 1;
end
if isempty(k3)
    k3 = 0;
end
if any(w == 'y')
    mn = 1;
    mx = fn2 + 1;
    r = [ones(1, k2+b1-1), 1 + fp(k2:k3), fp(k2:k3), repmat(p, 1, fn2-k3-b1+1)];
    c = [1:k2 + b1 - 1, k2 + b1:k3 + b1, k2 + b1:k3 + b1, k3 + b1 + 1:fn2 + 1];
    v = [ones(1, k2+b1-1), pm(k2:k3), 1 - pm(k2:k3), ones(1, fn2-k3-b1+1)];
else
    r = [1 + fp(1:k3), fp(k2:k4)];
    c = [1:k3, k2:k4];
    v = [pm(1:k3), 1 - pm(k2:k4)];
    mn = b1 + 1;
    mx = b4 + 1;
end
if b1 < 0
    c = abs(c+b1-1) - b1 + 1;
end
if any(w == 'n')
    v = 0.5 - 0.5 * cos(v*pi);
elseif any(w == 'm')
    v = 0.5 - 0.46 / 1.08 * cos(v*pi);
end
if sfact == 2
    msk = (c + mn > 2) & (c + mn < n - fn2 + 2);
    v(msk) = 2 * v(msk);
end
if nargout > 2
    x = sparse(r, c, v);
    if nargout == 3
        mc = mn;
        mn = mx;
    end
else
    x = sparse(r, c+mn-1, v, p, 1+fn2);
end
if any(w == 'u')
    sx = sum(x, 2);
    x = x ./ repmat(sx+(sx == 0), 1, size(x, 2));
end
if ~nargout || any(w == 'g')
    ng = 201;
    me = mflh(1) + (0:p + 1)' * melinc;
    switch wr
        case 'f'
            fe = me;
            xg = repmat(linspace(0, 1, ng), p, 1) .* repmat(me(3:end)-me(1:end-2), 1, ng) + repmat(me(1:end-2), 1, ng);
        case 'l'
            fe = 10.^me;
            xg = 10.^(repmat(linspace(0, 1, ng), p, 1) .* repmat(me(3:end)-me(1:end-2), 1, ng) + repmat(me(1:end-2), 1, ng));
        case 'e'
            fe = erb2frq(me);
            xg = erb2frq(repmat(linspace(0, 1, ng), p, 1).*repmat(me(3:end)-me(1:end-2), 1, ng)+repmat(me(1:end-2), 1, ng));
        case 'b'
            fe = bark2frq(me);
            xg = bark2frq(repmat(linspace(0, 1, ng), p, 1).*repmat(me(3:end)-me(1:end-2), 1, ng)+repmat(me(1:end-2), 1, ng));
        otherwise
            fe = mel2frq(me);
            xg = mel2frq(repmat(linspace(0, 1, ng), p, 1).*repmat(me(3:end)-me(1:end-2), 1, ng)+repmat(me(1:end-2), 1, ng));
    end

    v = 1 - abs(linspace(-1, 1, ng));
    if any(w == 'n')
        v = 0.5 - 0.5 * cos(v*pi);
    elseif any(w == 'm')
        v = 0.5 - 0.46 / 1.08 * cos(v*pi);
    end
    v = v * sfact;
    v = repmat(v, p, 1);
    if any(w == 'y')
        v(1, xg(1, :) < fe(2)) = sfact;
        v(end, xg(end, :) > fe(p+1)) = sfact;
    end
    if any(w == 'u')
        dx = (xg(:, 3:end) - xg(:, 1:end-2)) / 2;
        dx = dx(:, [1, 1:ng - 2, ng - 2]);
        vs = sum(v.*dx, 2);
        v = v ./ repmat(vs+(vs == 0), 1, ng) * fs / n;
    end
    plot(xg', v', 'b');
    set(gca, 'xlim', [fe(1), fe(end)]);
    xlabel(['Frequency (', xticks, 'Hz)']);
end