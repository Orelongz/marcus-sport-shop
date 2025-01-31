"use client";

import { useCallback, useRef, useState } from "react";
import { formatCentToEuro } from "@/services/util";
import { useProducts, useProductTypes } from "@/hooks";
import CreateProductDialog from "@/components/Admin/Products/CreateProductDialog";

const DisplayProducts = () => {
  const { data: products } = useProducts();
  const [productId, setProductId] = useState();
  const { data: productTypes } = useProductTypes();

  const elementRef = useRef(null);

  const onClickAddProduct = useCallback(() => {
    elementRef.current.showModal();
  }, []);

  const handleOnClose = useCallback(() => {
    setProductId();
    elementRef.current.close();
  }, [elementRef]);

  const productTypesOptions = productTypes.map((productType) => ({
    label: productType.name,
    value: productType.id,
  }));

  const handleOnClickEdit = useCallback((event) => {
    const { productId } = event.target.dataset;

    setProductId(productId);
    elementRef.current.showModal();
  }, []);

  const handleOnClickDelete = useCallback((event) => {
    const { productId } = event.target.dataset;

    setProductId(productId);

    console.log("deleting productId", productId);
  }, []);

  return (
    <>
      <div className="flex justify-between">
        <h1 className="font-bold text-2xl">Products</h1>
        <button className="btn btn-primary" onClick={onClickAddProduct}>
          Add Product
        </button>
      </div>

      <div className="overflow-x-auto">
        <table className="table w-full">
          <thead>
            <tr>
              <th>#</th>
              <th>Name</th>
              <th>Product Type</th>
              <th>Price</th>
              <th>Delete</th>
            </tr>
          </thead>
          <tbody>
            {products.map((product, index) => (
              <tr key={index}>
                <th>{index + 1}</th>
                <td>{product.name}</td>
                <td>{product.productTypeName}</td>
                <td>{formatCentToEuro(product.price)}</td>
                <td>
                  <button
                    data-product-id={product.id}
                    className="btn btn-sm btn-danger"
                    onClick={handleOnClickEdit}
                  >
                    Edit
                  </button>
                  <button
                    data-product-id={product.id}
                    className="btn btn-sm btn-danger"
                    onClick={handleOnClickDelete}
                  >
                    Delete
                  </button>
                </td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>

      <CreateProductDialog
        productId={productId}
        elementRef={elementRef}
        handleOnClose={handleOnClose}
        productTypesOptions={productTypesOptions}
      />
    </>
  );
};

export default DisplayProducts;
