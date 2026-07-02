-- Migrate Check Logs
INSERT INTO public.check_logs (invoice_no, customer_name, bank, check_no, check_date, check_amount, status, date_posted) VALUES
('CSI-0004306', 'CAR CRAZY', 'BDO', '123', '2026-06-15', 10000, 'CLEARED', NULL),
('CSI-0004306', 'CAR CRAZY', 'BDO', '123', '2026-06-15', 10000, 'CLEARED', NULL),
('CSI-0004306', 'CAR CRAZY', 'BDO', '123', '2026-06-15', 10300, 'CLEARED', NULL);
