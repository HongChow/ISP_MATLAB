rgb_kodark = imread('kodim19.png');
QuadBayer_KoDark = Quad_Mosaic(rgb_kodark);
Recovery_Bayer = Remosaic_Hong(QuadBayer_KoDark);
