import { getProducts, getProductTypes } from "@/server/actions";
import { useQuery } from "@tanstack/react-query";
import { PRODUCTS, PRODUCT_TYPES } from "@/constants/queryKeys";

import { normalizeSerializedData } from "@/services/util";

export const useProductTypes = () => {
  const { data, error, loading } = useQuery({
    queryKey: [PRODUCT_TYPES],
    queryFn: getProductTypes,
  });

  return {
    productTypes: normalizeSerializedData("product_type", data),
    loading,
    error,
  };
};

export const useProducts = () => {
  const { data, error, loading } = useQuery({
    queryKey: [PRODUCTS],
    queryFn: getProducts,
  });

  return {
    products: normalizeSerializedData("product", data),
    loading,
    error,
  };
};
