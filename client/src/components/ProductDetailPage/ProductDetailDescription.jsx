"use client";

import { useMemo } from "react";
import { isEmpty } from "lodash";
import { formatCentToEuro } from "@/services/util";

const ProductDetailDescription = ({
  product,
  accessories,
  selectedAccessoryIds,
  complementaryPriceHash,
  complementaryConstrainIdHash,
}) => {
  const { name, price, description, outOfStock } = product;

  const totalPrice = useMemo(() => {
    const accessoryTotalPrice = selectedAccessoryIds.reduce(
      (acc, accessoryId) => {
        const accessoryPrice =
          complementaryPriceHash[accessoryId]?.price ||
          accessories[accessoryId].attributes.price;

        return acc + accessoryPrice;
      },
      0,
    );

    return price + accessoryTotalPrice;
  }, [selectedAccessoryIds, price, accessories, complementaryPriceHash]);

  return (
    <div className="sidebar fixed top-[64px] right-0 w-120 h-full overflow-hidden z-1">
      <div className="menu bg-base-200 text-base-content min-h-full p-12 w-full">
        <div>
          <div className="text-xl text-gray-900 capitalize mb-4">
            {product.productTypeName}:{" "}
          </div>
          <div className="text-2xl font-bold">{name}</div>
        </div>

        <div className="mt-12">
          <h2 className="sr-only">item information</h2>

          <div>
            <h3 className="text-lg font-bold text-gray-900">Product Price</h3>
            <p className="tracking-tight text-gray-900">
              {formatCentToEuro(price)}
            </p>
          </div>

          {selectedAccessoryIds.map((accessoryId) => (
            <div key={accessoryId}>
              <div>
                <h3 className="text-lg font-bold text-gray-900 inline">
                  {accessories[accessoryId].attributes.accessoryType.name}:{" "}
                </h3>
                {accessories[accessoryId].attributes.name}
              </div>

              <p className="tracking-tight text-gray-900">
                {formatCentToEuro(
                  complementaryPriceHash[accessoryId]?.price ||
                    accessories[accessoryId].attributes.price,
                )}
              </p>
            </div>
          ))}

          <div>
            <h3 className="text-lg font-bold text-gray-900">Total Price</h3>
            <p className="tracking-tight text-gray-900">
              {formatCentToEuro(totalPrice)}
            </p>
          </div>

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
              <h3 className="font-bold text-lg">
                Accessory Price Change Description
              </h3>

              <ul className="space-y-6">
                {Object.entries(complementaryPriceHash).map(
                  ([accessoryId, priceChange]) => (
                    <li
                      key={`${accessoryId}_price_change`}
                      className="text-base text-gray-900"
                    >
                      <p className="flow-root">
                        The price of{" "}
                        <span className="font-bold">
                          {accessories[accessoryId].attributes.name}
                        </span>{" "}
                        changed from{" "}
                        {formatCentToEuro(
                          accessories[accessoryId].attributes.price,
                        )}{" "}
                        to {formatCentToEuro(priceChange.price)} because you
                        selected{" "}
                        <span className="font-bold">
                          {accessories[priceChange.id].attributes.name}
                        </span>
                      </p>
                    </li>
                  ),
                )}
              </ul>
            </div>
          </div>
        )}

        {!isEmpty(complementaryConstrainIdHash) && (
          <div className="mt-12">
            <div>
              <h3 className="font-bold text-lg">
                Accessory Constraint Description
              </h3>

              <ul className="space-y-6">
                {Object.entries(complementaryConstrainIdHash).map(
                  ([accessoryId, { id: complementaryId }]) => (
                    <li
                      className="text-base text-gray-900"
                      key={`${accessoryId}_constrain_addition`}
                    >
                      <p className="flow-root">
                        {accessories[accessoryId].attributes.accessoryType.name}{" "}
                        <span className="font-bold">
                          {accessories[accessoryId].attributes.name}
                        </span>{" "}
                        was removed because it can&apos;t be purchased with{" "}
                        <span className="font-bold">
                          {accessories[complementaryId].attributes.name}
                        </span>{" "}
                        {
                          accessories[complementaryId].attributes.accessoryType
                            .name
                        }
                      </p>
                    </li>
                  ),
                )}
              </ul>
            </div>
          </div>
        )}
      </div>
    </div>
  );
};

export default ProductDetailDescription;
