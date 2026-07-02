-- Update the sync_ar_balance trigger to also update payment_status
CREATE OR REPLACE FUNCTION public.sync_ar_balance()
RETURNS TRIGGER AS $$
BEGIN
    IF TG_OP = 'INSERT' THEN
        IF NEW.status IN ('Completed', 'Pending', 'Cleared') THEN
            UPDATE public.accounts_receivable
            SET amount_collected = amount_collected + NEW.amount,
                remaining_balance = remaining_balance - NEW.amount,
                payment_status = CASE WHEN (remaining_balance - NEW.amount) <= 0 THEN 'Cleared' ELSE payment_status END
            WHERE id = NEW.ar_id;
        END IF;
    ELSIF TG_OP = 'UPDATE' THEN
        -- If status changes from Completed/Pending to Bounced/Cancelled
        IF OLD.status IN ('Completed', 'Pending', 'Cleared') AND NEW.status IN ('Bounced', 'Cancelled') THEN
            UPDATE public.accounts_receivable
            SET amount_collected = amount_collected - NEW.amount,
                remaining_balance = remaining_balance + NEW.amount,
                payment_status = CASE WHEN (remaining_balance + NEW.amount) > 0 THEN 'Unpaid' ELSE payment_status END
            WHERE id = NEW.ar_id;
        -- If status changes from Bounced/Cancelled to Cleared/Pending/Completed
        ELSIF OLD.status IN ('Bounced', 'Cancelled') AND NEW.status IN ('Completed', 'Pending', 'Cleared') THEN
            UPDATE public.accounts_receivable
            SET amount_collected = amount_collected + NEW.amount,
                remaining_balance = remaining_balance - NEW.amount,
                payment_status = CASE WHEN (remaining_balance - NEW.amount) <= 0 THEN 'Cleared' ELSE payment_status END
            WHERE id = NEW.ar_id;
        END IF;
    ELSIF TG_OP = 'DELETE' THEN
        IF OLD.status IN ('Completed', 'Pending', 'Cleared') THEN
            UPDATE public.accounts_receivable
            SET amount_collected = amount_collected - OLD.amount,
                remaining_balance = remaining_balance + OLD.amount,
                payment_status = CASE WHEN (remaining_balance + OLD.amount) > 0 THEN 'Unpaid' ELSE payment_status END
            WHERE id = OLD.ar_id;
        END IF;
    END IF;
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

-- Also bulk update existing accounts_receivable that have 0 balance
UPDATE public.accounts_receivable
SET payment_status = 'Cleared'
WHERE remaining_balance <= 0;
