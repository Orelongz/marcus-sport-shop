import compact from "lodash/compact";
import { useFormContext } from "react-hook-form";

const getContrainedAccessoryId = ({
  complementaryAccessoryConstraints,
  selectedAccessoryIds,
}) => {
  const constraintHash = {};
  const complementaryConstrainIdHash = {};

  complementaryAccessoryConstraints.forEach((element) => {
    const { accessoryId, complementaryAccessoryId } = element;

    constraintHash[accessoryId] = { id: complementaryAccessoryId };
    constraintHash[complementaryAccessoryId] = { id: accessoryId };
  });

  selectedAccessoryIds.forEach((id) => {
    if (constraintHash[Number(id)]) {
      const complement = constraintHash[Number(id)];

      complementaryConstrainIdHash[complement.id] = true;
    }
  });

  return complementaryConstrainIdHash;
};

const getComplementaryPrice = ({
  complementaryAccessoryPrices,
  selectedAccessoryIds,
}) => {
  const constraintHash = {};
  const complementaryPriceHash = {};

  complementaryAccessoryPrices.forEach((element) => {
    const { price, accessoryId, complementaryAccessoryId } = element;

    constraintHash[accessoryId] = { id: complementaryAccessoryId, price };
  });

  selectedAccessoryIds.forEach((id) => {
    if (constraintHash[Number(id)]) {
      const complement = constraintHash[Number(id)];

      complementaryPriceHash[complement.id] = complement.price;
    }
  });

  return complementaryPriceHash;
};

const useComplementaryAccessory = ({
  complementaryAccessoryPrices,
  complementaryAccessoryConstraints,
}) => {
  const { watch } = useFormContext();
  const selectedAccessoryIds = compact(
    watch("accessory_cart_item.accessory_id"),
  );
  const complementaryConstrainIdHash = getContrainedAccessoryId({
    complementaryAccessoryConstraints,
    selectedAccessoryIds,
  });

  const complementaryPriceHash = getComplementaryPrice({
    complementaryAccessoryPrices,
    selectedAccessoryIds,
  });

  return { complementaryConstrainIdHash, complementaryPriceHash };
};

export default useComplementaryAccessory;
