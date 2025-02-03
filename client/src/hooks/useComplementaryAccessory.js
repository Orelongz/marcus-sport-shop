import { useMemo } from "react";
import { getRecordAttributes } from "@/services/util";

const useGetContrainedAccessoryIdHash = ({
  complementaryAccessoryConstraints,
  selectedAccessoryIds,
}) => {
  const constraintHash = useMemo(() => {
    const result = {};

    getRecordAttributes(complementaryAccessoryConstraints).forEach(
      (element) => {
        const { accessoryId, complementaryAccessoryId } = element;

        result[accessoryId] ||= [];
        result[accessoryId].push(complementaryAccessoryId);

        result[complementaryAccessoryId] ||= [];
        result[complementaryAccessoryId].push(accessoryId);
      },
    );

    return result;
  }, [complementaryAccessoryConstraints]);

  return useMemo(() => {
    const result = {};

    selectedAccessoryIds.forEach((id) => {
      if (constraintHash[Number(id)]) {
        constraintHash[Number(id)].forEach((complement_id) => {
          result[complement_id] = { id: Number(id) };
        });
      }
    });

    return result;
  }, [constraintHash, selectedAccessoryIds]);
};

const useGetComplementaryPrice = ({
  complementaryAccessoryPrices,
  selectedAccessoryIds,
}) => {
  const constraintHash = useMemo(() => {
    const result = {};

    getRecordAttributes(complementaryAccessoryPrices).forEach((element) => {
      const { price, accessoryId, complementaryAccessoryId } = element;

      result[accessoryId] = { id: complementaryAccessoryId, price };
    });

    return result;
  }, [complementaryAccessoryPrices]);

  return useMemo(() => {
    const result = {};

    selectedAccessoryIds.forEach((id) => {
      if (constraintHash[Number(id)]) {
        const complement = constraintHash[Number(id)];

        result[complement.id] = { id: Number(id), price: complement.price };
      }
    });

    return result;
  }, [constraintHash, selectedAccessoryIds]);
};

const useComplementaryAccessory = ({
  selectedAccessoryIds,
  complementaryAccessoryPrices,
  complementaryAccessoryConstraints,
}) => {
  const complementaryConstrainIdHash = useGetContrainedAccessoryIdHash({
    complementaryAccessoryConstraints,
    selectedAccessoryIds,
  });

  const complementaryPriceHash = useGetComplementaryPrice({
    complementaryAccessoryPrices,
    selectedAccessoryIds,
  });

  return { complementaryConstrainIdHash, complementaryPriceHash };
};

export default useComplementaryAccessory;
