import { fetchJSON } from "../services/fetch";

export const getProductTypes = async () => {
  const productTypes = await fetchJSON(
    "http://localhost:8080/api/v1/product_types",
  );

  return productTypes;
};

export const getProducts = async () => {
  const productTypes = await fetchJSON("http://localhost:8080/api/v1/products");

  return productTypes;
};
