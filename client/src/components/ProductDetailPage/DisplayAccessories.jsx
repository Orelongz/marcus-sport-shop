import Image from "next/image";
import { formatCentToEuro } from "@/services/util";
import { useFormContext } from "react-hook-form";

const DisplayAccessories = ({
  accessories,
  accessoryTypeId,
  complementaryPriceHash,
  complementaryConstrainIdHash,
}) => {
  const { register } = useFormContext();

  const filteredAccessories = Object.values(accessories).filter((accessory) => {
    return (
      !accessory.attributes.outOfStock &&
      Number(accessory.attributes.accessoryTypeId) == Number(accessoryTypeId) &&
      !complementaryConstrainIdHash[accessory.id]
    );
  });

  return (
    <div className="collapse-content text-sm flex flex-wrap space-x-4 space-y-4">
      {filteredAccessories.map((accessory) => (
        <div key={accessory.id} className="flex card content-between">
          {accessory.attributes.image && (
            <div className="card-image h-{150px}">
              <Image
                src={accessory.attributes.image}
                alt="Shoes"
                className="w-full"
                width={80}
                height={80}
              />
            </div>
          )}

          <div>
            <input
              type="radio"
              className="btn w-full"
              value={accessory.id}
              aria-label={accessory.attributes.name}
              {...register(
                `accessory_cart_item.accessory_id.${accessoryTypeId}`,
              )}
            />

            <div className="text-center">
              {formatCentToEuro(
                complementaryPriceHash[accessory.id]?.price ||
                  accessory.attributes.price,
              )}
            </div>
          </div>
        </div>
      ))}
    </div>
  );
};

export default DisplayAccessories;
