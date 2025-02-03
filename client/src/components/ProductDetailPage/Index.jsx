import compact from "lodash/compact";
import Footer from "@/components/Footer";
import { useFormContext } from "react-hook-form";
import ProductImage from "@/components/ProductDetailPage/ProductImage";
import DisplayAccessoryTypes from "@/components/ProductDetailPage/DisplayAccessoryTypes";
import ProductDetailDescription from "@/components/ProductDetailPage/ProductDetailDescription";
import useComplementaryAccessory from "@/hooks/useComplementaryAccessory";

const ProductDetailPage = ({
  product,
  accessories,
  accessoryTypes,
  complementaryAccessoryPrices,
  complementaryAccessoryConstraints,
}) => {
  const { watch } = useFormContext();
  const selectedAccessoryIds = compact(
    watch("accessory_cart_item.accessory_id"),
  );

  const { complementaryConstrainIdHash, complementaryPriceHash } =
    useComplementaryAccessory({
      selectedAccessoryIds,
      complementaryAccessoryPrices,
      complementaryAccessoryConstraints,
    });

  return (
    <>
      <div className="mr-120 px-24">
        <ProductImage product={product} />

        <div className="divider divider-neutral" />

        <DisplayAccessoryTypes
          accessories={accessories}
          accessoryTypes={accessoryTypes}
          complementaryPriceHash={complementaryPriceHash}
          complementaryConstrainIdHash={complementaryConstrainIdHash}
        />

        <div className="mt-16">
          <Footer />
        </div>
      </div>

      <ProductDetailDescription
        product={product}
        accessories={accessories}
        selectedAccessoryIds={selectedAccessoryIds}
        complementaryPriceHash={complementaryPriceHash}
        complementaryConstrainIdHash={complementaryConstrainIdHash}
      />
    </>
  );
};

export default ProductDetailPage;
