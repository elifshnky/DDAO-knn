    function [ uzaklik_dizisi] = Sezgisel_Uzaklik_Hesaplama( baginti_no,veri_seti,yeni_veri, agirlik_dizisi )

        if (baginti_no==1)
            uzaklik_dizisi= Sezgisel_Baginti_Oklit(veri_seti,yeni_veri, agirlik_dizisi);
            elseif (baginti_no==2)
            uzaklik_dizisi= Baginti_Manhattan(veri_seti,yeni_veri);
            else

        end

    end

