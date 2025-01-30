"use client";

import { useCallback, useMemo } from "react";
import { useParams } from "next/navigation";
import { getRecordAttributes } from "@/services/util";
import { useForm, FormProvider } from "react-hook-form";
import { useAccessoryTypeDetails, useProductDetail } from "@/hooks";
import ProductDetailPage from "@/components/ProductDetailPage/Index";

const Page = () => {
  const { id: productId } = useParams();

  const { data: product } = useProductDetail();
  const {
    data: accessoryTypesDeserializeHash,
    isPending,
    loading,
    error,
  } = useAccessoryTypeDetails();

  const methods = useForm({
    defaultValues: { productId: productId },
  });

  const onSubmit = useCallback((data) => {
    // send data to cart endpoint to create a cart
    console.log("data add to cart", data);
  }, []);

  const {
    accessories,
    accessoryTypes,
    complementaryAccessoryPrices,
    complementaryAccessoryConstraints,
  } = useMemo(() => {
    if (isPending || loading) return {};

    const {
      accessory,
      accessoryType,
      complementaryAccessoryPrice,
      complementaryAccessoryConstraint,
    } = accessoryTypesDeserializeHash;

    return {
      accessories: getRecordAttributes(accessory),
      accessoryTypes: getRecordAttributes(accessoryType),
      complementaryAccessoryPrices: getRecordAttributes(
        complementaryAccessoryPrice,
      ),
      complementaryAccessoryConstraints: getRecordAttributes(
        complementaryAccessoryConstraint,
      ),
    };
  }, [accessoryTypesDeserializeHash, isPending, loading]);

  if (loading || isPending) return <p>Loading...</p>;
  if (error) return <p>Error: {error.message}</p>;

  return (
    <FormProvider {...methods}>
      <form className="pt-12" onSubmit={methods.handleSubmit(onSubmit)}>
        <ProductDetailPage
          product={product}
          accessories={accessories}
          accessoryTypes={accessoryTypes}
          complementaryAccessoryPrices={complementaryAccessoryPrices}
          complementaryAccessoryConstraints={complementaryAccessoryConstraints}
        />
      </form>
    </FormProvider>
  );
};

export default Page;
