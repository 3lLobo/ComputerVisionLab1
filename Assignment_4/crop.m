%find corners and crop
[ytemp, xtemp] = size(t4im);
for j = 1:ytemp
    if t4im(j,1) > 0
        cylow = j;
    elseif t4im(j,xtemp) > 0
        cyup = j;
    end
end
for j = 1:xtemp
    if t4im(1,j) > 0
        cxr = j;
    elseif t4im(ytemp, j) > 0
        cxl = j;
    end
end

cropx = cxl-cxr;
cropy = cylow-cyup;
cropim = zeros(cropy, cropx);

for y = 1:cropy
    for x = 1:cropx
        cropim(y,x) = t4im(y+cyup, x+cxr);
    end
end

imshow(uint8(cropim))
