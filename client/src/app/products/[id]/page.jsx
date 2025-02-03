"use client";
import compact from "lodash/compact";
import { useCallback, useContext } from "react";
import { useRouter, useParams } from "next/navigation";
import { useForm, FormProvider } from "react-hook-form";

import { createCartItem } from "@/server/actions";
import { AlertContext } from "@/lib/Alert/AlertContext";
import { useProductDetail, useAccessoryTypeDetails } from "@/hooks";
import ProductDetailPage from "@/components/ProductDetailPage/Index";

const Page = () => {
  const router = useRouter();
  const { id: productId } = useParams();
  const { setAlertProps } = useContext(AlertContext);

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

  const onSubmit = useCallback(
    (data) => {
      createCartItem({
        product_id: data.productId,
        accessory_ids: compact(data.accessoryId),
      })
        .then(() => {
          setAlertProps({
            type: "success",
            message: "Items successfully added to cart",
          });

          router.push("/");
        })
        .catch(() => {
          setAlertProps({
            type: "error",
            message: "Failed to add items to cart",
          });
        });
    },
    [router, setAlertProps],
  );

  if (loading || isPending) return <p>Loading...</p>;
  if (error) return <p>Error: {error.message}</p>;

  const {
    accessory: accessories,
    accessoryType: accessoryTypes,
    complementaryAccessoryPrice: complementaryAccessoryPrices,
    complementaryAccessoryConstraint: complementaryAccessoryConstraints,
  } = accessoryTypesDeserializeHash;

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
