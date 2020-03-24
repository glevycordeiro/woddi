function redirectToStripe() {
  const payButton = document.getElementById("pay")
  const stripe = Stripe(payButton.dataset.stripePublishabledKeyId);
  stripe.redirectToCheckout({
    sessionId: payButton.dataset.stripeSessionId
  });
}

export {redirectToStripe};
