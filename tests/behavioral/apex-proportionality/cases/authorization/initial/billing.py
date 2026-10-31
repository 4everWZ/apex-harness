def get_invoice(principal, invoice_id, invoices):
    invoice = invoices.get(invoice_id)
    if invoice is None:
        return 404, None
    return 200, {"id": invoice["id"], "amount": invoice["amount"]}
