import { getProducts, getProductTypes } from "@/server/actions";
import {
  dehydrate,
  QueryClient,
  HydrationBoundary,
} from "@tanstack/react-query";
import { PRODUCTS, PRODUCT_TYPES } from "@/constants/queryKeys";

const ProductsPageHydrationBoundary = async ({ children }) => {
  const queryClient = new QueryClient();

  await queryClient.prefetchQuery({
    queryKey: [PRODUCT_TYPES],
    queryFn: getProductTypes,
  });

  await queryClient.prefetchQuery({
    queryKey: [PRODUCTS],
    queryFn: getProducts,
  });

  return (
    <HydrationBoundary state={dehydrate(queryClient)}>
      {children}
    </HydrationBoundary>
  );
};

export default ProductsPageHydrationBoundary;
