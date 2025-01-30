import {
  getProductDetail,
  getProducts,
  getProductTypes,
  getAccessoryTypes,
} from "@/server/actions";
import { useQuery } from "@tanstack/react-query";
import {
  ACCESSORY_TYPES,
  PRODUCT_DETAIL,
  PRODUCTS,
  PRODUCT_TYPES,
} from "@/constants/queryKeys";
import { useParams } from "next/navigation";

import {
  normalizeProductData,
  normalizeProductsData,
  normalizeProductTypesdData,
  normalizeAccessoryTypeData,
} from "@/services/util";

export const useProductTypes = () => {
  const { data, error, loading } = useQuery({
    queryKey: [PRODUCT_TYPES],
    queryFn: getProductTypes,
  });

  return {
    data: normalizeProductTypesdData(data),
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
    data: normalizeProductsData(data),
    loading,
    error,
  };
};

export const useProductDetail = () => {
  const { id: productId } = useParams();

  const { data, error, loading, isPending } = useQuery({
    queryKey: [PRODUCT_DETAIL, productId],
    queryFn: () => getProductDetail(productId),
    enabled: !!productId,
  });

  return {
    data: normalizeProductData(productId, data),
    isPending,
    loading,
    error,
  };
};

export const useAccessoryTypeDetails = () => {
  const { data: product } = useProductDetail();
  const { productTypeId } = product;

  const { data, error, loading, isPending } = useQuery({
    queryKey: [ACCESSORY_TYPES, productTypeId],
    queryFn: () => getAccessoryTypes(productTypeId),
    enabled: !!productTypeId,
  });

  return {
    data: normalizeAccessoryTypeData(data),
    isPending,
    loading,
    error,
  };
};
