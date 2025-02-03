import { fetchJSON, postJSON } from "../services/fetch";

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

export const getProductDetail = async (productId) => {
  const product = await fetchJSON(
    `http://localhost:8080/api/v1/products/${productId}`,
  );

  return product;
};

export const getAccessoryTypes = async (productTypeId) => {
  const accessoryTypes = await fetchJSON(
    `http://localhost:8080/api/v1/accessory_types/?product_type_id=${productTypeId}`,
  );

  return accessoryTypes;
};

export const createCartItem = async (data) => {
  const response = await postJSON("http://localhost:8080/api/v1/cart_items", {
    cart_item: data,
  });

  const responsJSON = await response.json();

  if (!response.ok) throw new Error(responsJSON);

  return responsJSON;
};
