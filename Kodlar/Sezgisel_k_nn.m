function  [hata_orani] = Sezgisel_k_nn(komsu_sayisi, uzaklik_bagintisi_no,agirlik_dizisi)

global VERI;
global komsu;

    gSiniflar = zeros(1, length(VERI.Yeni_Veri));
    tSiniflar = zeros(1, length(VERI.Yeni_Veri));  

    for i=1:length(VERI.Yeni_Veri)
        uzaklik_dizisi=Sezgisel_Uzaklik_Hesaplama(uzaklik_bagintisi_no, VERI.Veri_Seti, VERI.Yeni_Veri(i,:),agirlik_dizisi);
        [komsu]=Komsu_Bul(komsu_sayisi,uzaklik_dizisi,VERI.Veri_Siniflari);
        [sinif]=Sinif_Bul();

        gSiniflar(i) = VERI.Sozluk(char(VERI.Yeni_Veri_Siniflari(i))); 
        tSiniflar(i) = VERI.Sozluk(char(sinif.sinif)); 
    end

    hata_orani = Hata_Fonk(gSiniflar,tSiniflar);
end
