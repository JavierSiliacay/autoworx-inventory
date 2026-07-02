-- Migrate Accounts Payable
INSERT INTO public.accounts_payable (date, invoice_no, supplier, total_invoice_amount, payment_status, amount_paid, remaining_balance, date_of_payment, remarks) VALUES
('2026-05-30', 'CSI-33977', 'GLOBAL SYNERGY TRADE AND DISTRIBUTION CORP.', 125886.8, 'UNPAID', 0, 0, NULL, NULL),
('2026-06-16', NULL, 'JULIUS CAESAR AYING', 20500, 'PAID', 20500, 0, '2026-06-23', 'BDO - 25/6/26'),
('2026-06-25', NULL, 'NIPPON PAINT (COATINGS) PHILS. INC.', 13000, 'UNPAID', 0, 0, NULL, NULL),
('2026-06-25', 'CSI-12780', 'QUADGROUP DISTRIBUTION INC.', 108515, 'PAID', 108515, 0, '2026-06-25', NULL);
