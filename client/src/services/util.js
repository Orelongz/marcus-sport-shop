import normalize from "json-api-normalizer";

export const formatCentToEuro = (cents) => {
  return (cents / 100).toLocaleString("en-US", {
    style: "currency",
    currency: "EUR",
  });
};

export const getRecordAttributes = (data) => {
  if (!data) return {};

  return Object.values(data).map((prod) => prod.attributes);
};

export const normalizeProductsData = (data) => {
  if (!data) return {};

  return Object.values(normalize(data).product).map((prod) => prod.attributes);
};

export const normalizeProductTypesdData = (data) => {
  if (!data) return {};

  return Object.values(normalize(data).productType).map(
    (prod) => prod.attributes,
  );
};

export const normalizeProductData = (productId, data) => {
  if (!data) return {};

  return normalize(data).product[productId].attributes;
};

export const normalizeAccessoryTypeData = (data) => {
  if (!data) return {};

  return normalize(data);
};
