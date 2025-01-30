import JSONAPISerializer from "json-api-serializer";

const Serializer = new JSONAPISerializer();

Serializer.register("product");
Serializer.register("product_type");

export const formatCentToEuro = (cents) => {
  return (cents / 100).toLocaleString("en-US", {
    style: "currency",
    currency: "EUR",
  });
};

export const normalizeSerializedData = (type, data) => {
  return Serializer.deserialize(type, data);
};
