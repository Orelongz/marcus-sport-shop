"use client";

import { useRouter, useSearchParams } from "next/navigation";
import { useProductTypes } from "@/hooks";
import { useState, useCallback, useEffect } from "react";

const SideBar = () => {
  const router = useRouter();
  const searchParams = useSearchParams();
  const { data: productTypes } = useProductTypes();
  const [selectedProductTypes, setSelectedProductTypes] = useState(
    () => searchParams.get("product_type_id")?.split(",") || [],
  );

  const handleOnClickProductType = useCallback((event) => {
    const { value, checked } = event.target;

    if (checked) {
      setSelectedProductTypes((current) => [...current, value]);
    } else {
      setSelectedProductTypes((current) =>
        current.filter((id) => id !== value),
      );
    }
  }, []);

  useEffect(() => {
    const queryParams =
      selectedProductTypes.length > 0
        ? `?product_type_id=${selectedProductTypes.join(",")}`
        : "/";

    router.push(queryParams);
  }, [router, selectedProductTypes]);

  return (
    <>
      {productTypes.map(({ id, name }) => (
        <input
          key={name}
          value={id}
          type="checkbox"
          aria-label={name}
          name="productType"
          onClick={handleOnClickProductType}
          className="btn w-full opacity-100 scale-100 uppercase"
          defaultChecked={selectedProductTypes.includes(id.toString())}
        />
      ))}
    </>
  );
};

export default SideBar;
