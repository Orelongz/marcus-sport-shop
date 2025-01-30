"use client";

import { isEmpty } from "lodash";
import { formatCentToEuro } from "@/services/util";

const ProductDetailDescription = ({
  product,
  complementaryPriceHash,
  complementaryConstrainIdHash,
}) => {
  const { name, price, description, outOfStock } = product;

  return (
    <div className="sidebar fixed top-[64px] right-0 w-120 h-full overflow-hidden z-1">
      <div className="menu bg-base-200 text-base-content min-h-full p-12 w-full">
        <div className="">
          <h1 className="text-2xl text-gray-900 sm:text-3xl capitalize mb-4">
            {product.productTypeName}:
          </h1>

          <h1 className="text-2xl font-bold tracking-tight text-gray-900 sm:text-3xl">
            {name}
          </h1>
        </div>

        <div className="mt-12">
          <h2 className="sr-only">item information</h2>
          <p className="text-3xl tracking-tight text-gray-900">
            {formatCentToEuro(price)}
          </p>

          {outOfStock ? (
            <div>This product is no longer is stock</div>
          ) : (
            <button className="mt-6 btn btn-primary duration-300">
              Add to Cart
            </button>
          )}
        </div>

        <div className="mt-12">
          <div>
            <h3 className="sr-only">Description</h3>

            <div className="space-y-6">
              <p className="text-base text-gray-900">
                {description || "Some product description"}
              </p>
            </div>
          </div>
        </div>

        {!isEmpty(complementaryPriceHash) && (
          <div className="mt-12">
            <div>
              <h3 className="sr-only">Accessory Price Change Description</h3>

              <div className="space-y-6">
                <p className="text-base text-gray-900">
                  Price change occured for at least accessory
                </p>
              </div>
            </div>
          </div>
        )}

        {!isEmpty(complementaryConstrainIdHash) && (
          <div className="mt-12">
            <div>
              <h3 className="sr-only">Accessory Constraint Description</h3>

              <div className="space-y-6">
                <p className="text-base text-gray-900">
                  Accessory constraint was applied
                </p>
              </div>
            </div>
          </div>
        )}
      </div>
    </div>
  );
};

export default ProductDetailDescription;
