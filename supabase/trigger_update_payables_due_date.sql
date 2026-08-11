-- ========================================================
-- AUTOMATION: Trigger to sync Supplier Terms to Payables
-- ========================================================

-- 1. Create the function that will handle the update
CREATE OR REPLACE FUNCTION public.update_payables_due_date()
RETURNS TRIGGER AS $$
BEGIN
  -- Check if the due_days value actually changed
  IF NEW.due_days IS DISTINCT FROM OLD.due_days THEN
    -- Update the due_date of all pending and partially paid payables for this supplier
    UPDATE public.supplier_payables
    SET due_date = created_at + (NEW.due_days || ' days')::interval
    WHERE supplier_name = NEW.name AND status != 'Paid';
  END IF;
  
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- 2. Attach the trigger to the suppliers table
DROP TRIGGER IF EXISTS trigger_update_payables_due_date ON public.suppliers;

CREATE TRIGGER trigger_update_payables_due_date
AFTER UPDATE ON public.suppliers
FOR EACH ROW
EXECUTE FUNCTION public.update_payables_due_date();
