import Footer from "@/components/Footer";
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
  const { complementaryConstrainIdHash, complementaryPriceHash } =
    useComplementaryAccessory({
      complementaryAccessoryPrices,
      complementaryAccessoryConstraints,
    });

  console.log(
    "dkaljlkksjflaf;lksfdsdlfaksf",
    complementaryConstrainIdHash,
    complementaryPriceHash,
  );
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
        complementaryPriceHash={complementaryPriceHash}
        complementaryConstrainIdHash={complementaryConstrainIdHash}
      />
    </>
  );
};

export default ProductDetailPage;
