-- Migrate Isuzu Sales Color Codes
DO $$
BEGIN

  UPDATE public.sales
  SET color_code = 'ULTIMA ARC WHITE'
  WHERE invoice_no = 'CSI 004003'
    AND item_id IN (SELECT id FROM public.inventory WHERE sku = 'NAXISUTRA-4L');

  UPDATE public.sales
  SET color_code = 'MERCURY SILVER'
  WHERE invoice_no = 'CSI 004008'
    AND item_id IN (SELECT id FROM public.inventory WHERE sku = 'PREMILAMIX');

  UPDATE public.sales
  SET color_code = 'ARC WHITE'
  WHERE invoice_no = 'CSI 004009'
    AND item_id IN (SELECT id FROM public.inventory WHERE sku = 'NAXISUTRA-4L');

  UPDATE public.sales
  SET color_code = 'SPINEL RED'
  WHERE invoice_no = 'CSI 004010'
    AND item_id IN (SELECT id FROM public.inventory WHERE sku = 'PREMILAMIX');

  UPDATE public.sales
  SET color_code = 'GRANITE GRAY'
  WHERE invoice_no = 'CSI 004010'
    AND item_id IN (SELECT id FROM public.inventory WHERE sku = 'PREMILAMIX');

  UPDATE public.sales
  SET color_code = 'SILKY WHITE'
  WHERE invoice_no = 'CSI 004010'
    AND item_id IN (SELECT id FROM public.inventory WHERE sku = 'PREMILAMIX');

  UPDATE public.sales
  SET color_code = 'SILKY PEARL'
  WHERE invoice_no = 'CSI 004010'
    AND item_id IN (SELECT id FROM public.inventory WHERE sku = 'PREMILAMIX');

  UPDATE public.sales
  SET color_code = 'SPLUSH WHITE'
  WHERE invoice_no = 'CSI 004012'
    AND item_id IN (SELECT id FROM public.inventory WHERE sku = 'NAX/EXTMIX');

  UPDATE public.sales
  SET color_code = 'MORROCAN GOLD'
  WHERE invoice_no = 'CSI 004013'
    AND item_id IN (SELECT id FROM public.inventory WHERE sku = 'PREMILAMIX');

  UPDATE public.sales
  SET color_code = 'SATIN WHITE'
  WHERE invoice_no = 'CSI 004015'
    AND item_id IN (SELECT id FROM public.inventory WHERE sku = 'PREMILAMIX');

  UPDATE public.sales
  SET color_code = 'SATIN PEARL'
  WHERE invoice_no = 'CSI 004015'
    AND item_id IN (SELECT id FROM public.inventory WHERE sku = 'PREMILAMIX');

  UPDATE public.sales
  SET color_code = 'KINABALO GREY'
  WHERE invoice_no = 'CSI 004016'
    AND item_id IN (SELECT id FROM public.inventory WHERE sku = 'PREMILAMIX');

  UPDATE public.sales
  SET color_code = 'VALENCIA ORANGE'
  WHERE invoice_no = 'CSI 004017'
    AND item_id IN (SELECT id FROM public.inventory WHERE sku = 'PREMILAMIX');

  UPDATE public.sales
  SET color_code = 'NP GRANITE GRAY'
  WHERE invoice_no = 'CSI 004017'
    AND item_id IN (SELECT id FROM public.inventory WHERE sku = 'PREMILAMIX');

  UPDATE public.sales
  SET color_code = 'ONYX BLACK'
  WHERE invoice_no = 'CSI 004019'
    AND item_id IN (SELECT id FROM public.inventory WHERE sku = 'PREMILAMIX');

  UPDATE public.sales
  SET color_code = 'GRANITE GRAY'
  WHERE invoice_no = 'CSI 004019'
    AND item_id IN (SELECT id FROM public.inventory WHERE sku = 'PREMILAMIX');

  UPDATE public.sales
  SET color_code = 'NAX SPLASH WHITE'
  WHERE invoice_no = 'CSI 004021'
    AND item_id IN (SELECT id FROM public.inventory WHERE sku = 'NAX/EXTMIX');

  UPDATE public.sales
  SET color_code = 'OBSEDIAN GREY'
  WHERE invoice_no = 'CSI 004022'
    AND item_id IN (SELECT id FROM public.inventory WHERE sku = 'PREMILAMIX');

  UPDATE public.sales
  SET color_code = 'GRANITE GREY'
  WHERE invoice_no = 'CSI 004022'
    AND item_id IN (SELECT id FROM public.inventory WHERE sku = 'PREMILAMIX');

  UPDATE public.sales
  SET color_code = 'ARC WHITE'
  WHERE invoice_no = 'CSI 004024'
    AND item_id IN (SELECT id FROM public.inventory WHERE sku = 'NAXISUTRA-4L');

  UPDATE public.sales
  SET color_code = 'SILKY WHITE'
  WHERE invoice_no = 'CSI 004026'
    AND item_id IN (SELECT id FROM public.inventory WHERE sku = 'PREMILAMIX');

  UPDATE public.sales
  SET color_code = 'SILKY PEARL'
  WHERE invoice_no = 'CSI 004026'
    AND item_id IN (SELECT id FROM public.inventory WHERE sku = 'PREMILAMIX');

  UPDATE public.sales
  SET color_code = 'SPLUSH WHITE'
  WHERE invoice_no = 'CSI 004028'
    AND item_id IN (SELECT id FROM public.inventory WHERE sku = 'PREMILAMIX');

  UPDATE public.sales
  SET color_code = 'BLARITTS BLUE'
  WHERE invoice_no = 'CSI 004029'
    AND item_id IN (SELECT id FROM public.inventory WHERE sku = 'PREMILAMIX');

  UPDATE public.sales
  SET color_code = 'NAX FLAT BLACK'
  WHERE invoice_no = 'CSI 004029'
    AND item_id IN (SELECT id FROM public.inventory WHERE sku = 'NAX3974');

  UPDATE public.sales
  SET color_code = 'NAX SPLASH WHITE'
  WHERE invoice_no = 'CSI 004030'
    AND item_id IN (SELECT id FROM public.inventory WHERE sku = 'NAX/EXTMIX');

  UPDATE public.sales
  SET color_code = 'GRANITE GREY'
  WHERE invoice_no = 'CSI 004030'
    AND item_id IN (SELECT id FROM public.inventory WHERE sku = 'PREMILAMIX');

  UPDATE public.sales
  SET color_code = 'KIWABALO GREY'
  WHERE invoice_no = 'CSI 004032'
    AND item_id IN (SELECT id FROM public.inventory WHERE sku = 'PREMILAMIX');

  UPDATE public.sales
  SET color_code = 'ONYX BLACK'
  WHERE invoice_no = 'CSI 004032'
    AND item_id IN (SELECT id FROM public.inventory WHERE sku = 'PREMILAMIX');

  UPDATE public.sales
  SET color_code = 'NAX SPLASH WHITE'
  WHERE invoice_no = 'CSI 004033'
    AND item_id IN (SELECT id FROM public.inventory WHERE sku = 'NAX/EXTMIX');

  UPDATE public.sales
  SET color_code = 'SILKY WHITE'
  WHERE invoice_no = 'CSI 004034'
    AND item_id IN (SELECT id FROM public.inventory WHERE sku = 'PREMILAMIX');

  UPDATE public.sales
  SET color_code = 'SILKY PEARL'
  WHERE invoice_no = 'CSI 004034'
    AND item_id IN (SELECT id FROM public.inventory WHERE sku = 'PREMILAMIX');

  UPDATE public.sales
  SET color_code = 'SILKY WHITE'
  WHERE invoice_no = 'CSI 004035'
    AND item_id IN (SELECT id FROM public.inventory WHERE sku = 'PREMILAMIX');

  UPDATE public.sales
  SET color_code = 'SILKY PEARL'
  WHERE invoice_no = 'CSI 004035'
    AND item_id IN (SELECT id FROM public.inventory WHERE sku = 'PREMILAMIX');

  UPDATE public.sales
  SET color_code = 'KINABALU GREY'
  WHERE invoice_no = 'CSI 004037'
    AND item_id IN (SELECT id FROM public.inventory WHERE sku = 'PREMILAMIX');

  UPDATE public.sales
  SET color_code = 'TITANIUM SILVER'
  WHERE invoice_no = 'CSI 004038'
    AND item_id IN (SELECT id FROM public.inventory WHERE sku = 'NP9200');

  UPDATE public.sales
  SET color_code = 'SILKY WHITE'
  WHERE invoice_no = 'CSI 004039'
    AND item_id IN (SELECT id FROM public.inventory WHERE sku = 'PREMILAMIX');

  UPDATE public.sales
  SET color_code = 'SILKY PEARL'
  WHERE invoice_no = 'CSI 004039'
    AND item_id IN (SELECT id FROM public.inventory WHERE sku = 'PREMILAMIX');

  UPDATE public.sales
  SET color_code = 'NAMIBU ORANGE'
  WHERE invoice_no = 'CSI 004040'
    AND item_id IN (SELECT id FROM public.inventory WHERE sku = 'PREMILAMIX');

END $$;
