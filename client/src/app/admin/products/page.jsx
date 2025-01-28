"use client";

import { useCallback, useRef } from "react";

import { formatCentToEuro } from "@/services/util";

const products = [
  {
    name: "Type 1",
    product_type: "Type 1",
    out_of_stock: false,
    description: "Type 1",
    price: 12323,
    accessory_types: ["Type 1"],
    url_media_files: ["Type 1"],
  },
];

const AdminProductsPage = () => {
  const elementRef = useRef(null);

  const onClickAddProduct = useCallback(() => {
    elementRef.current.showModal();
  }, []);

  return (
    <div className="container mx-auto px-12 py-8">
      <div className="flex justify-between">
        <h1 className="font-bold text-2xl">Products</h1>
        <button className="btn btn-primary" onClick={onClickAddProduct}>
          Add Product
        </button>
      </div>

      <div className="overflow-x-auto mt-6">
        <table className="table">
          <thead>
            <tr>
              <th></th>
              <th>Name</th>
              <th>Product Type</th>
              <th>Out of Stock</th>
              <th>Description</th>
              <th>Price</th>
              <th>accessory types</th>
              <th>media urls</th>
              <th>Delete</th>
            </tr>
          </thead>
          <tbody>
            {products.map((product, index) => (
              <tr key={index}>
                <th>{index + 1}</th>
                <td>{product.name}</td>
                <td>{product.product_type}</td>
                <td>{product.out_of_stock.toString()}</td>
                <td>{product.description}</td>
                <td>{formatCentToEuro(product.price)}</td>
                <td>{product.accessory_types.join(", ")}</td>
                <td>{product.url_media_files.join(", ")}</td>
                <td>
                  <button className="btn btn-sm btn-danger">Delete</button>
                </td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>

      <dialog ref={elementRef} className="modal modal-bottom sm:modal-middle">
        <div className="modal-box">
          <h2 className="modal-title">Add/Edit Product</h2>

          <fieldset className="fieldset mt-4">
            <legend className="fieldset-legend">Name</legend>
            <input type="text" className="input w-full" placeholder="Name" />
          </fieldset>

          <fieldset className="fieldset mt-4">
            <legend className="fieldset-legend">Product Type</legend>

            {/*  loop through product types to display list*/}
            <select
              defaultValue="Pick a product type"
              className="select w-full"
            >
              <option disabled={true}>Pick a product type</option>
              <option>Bicycle</option>
              <option>Vehicle</option>
            </select>
          </fieldset>

          <fieldset className="fieldset mt-4 w-full">
            <label className="fieldset-label">
              <input type="checkbox" className="checkbox" />
              Out of Stock
            </label>
          </fieldset>

          <fieldset className="fieldset mt-4">
            <legend className="fieldset-legend">Price</legend>
            <input type="text" className="input w-full" placeholder="Name" />
          </fieldset>

          <div className="modal-action">
            <form method="dialog">
              {/* if there is a button in form, it will close the modal */}
              <button className="btn">Save</button>
            </form>
          </div>
        </div>
      </dialog>
    </div>
  );
};

export default AdminProductsPage;
