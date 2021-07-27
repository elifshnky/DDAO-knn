function Verileri_Oku( )

global VERI

training_data = readtable('ornek_veri_seti.xls', 'Sheet', 'Training_Data','range', 'A:F');
test_data = readtable('ornek_veri_seti.xls', 'Sheet', 'Test_Data','range', 'A:F');

VERI.Veri_Seti = training_data{:,1:5};
VERI.Veri_Siniflari = training_data{:,6}';

VERI.Yeni_Veri = test_data{:,1:5};
VERI.Yeni_Veri_Siniflari = test_data{:,6}';

keySet = unique(VERI.Veri_Siniflari);
valueSet = 1:length(keySet);

VERI.Sozluk = containers.Map(keySet,valueSet);


end

