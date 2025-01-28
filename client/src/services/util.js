export const formatCentToEuro = (cents) => {
  return (cents / 100).toLocaleString("en-US", {
    style: "currency",
    currency: "EUR",
  });
};
