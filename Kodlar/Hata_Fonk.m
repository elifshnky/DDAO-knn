function [hata] = HataFonksiyonu(y1, y2)
    hata = 0;
    
    for j=1:length(y1)
        if y1(j) ~= y2(j)
            hata = hata + 1;
        end
    end
    
    hata = hata * 100 / length(y1);
end