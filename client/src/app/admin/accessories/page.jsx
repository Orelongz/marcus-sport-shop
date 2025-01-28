"use client";

import { useCallback, useRef } from "react";

import { formatCentToEuro } from "@/services/util";
import AccessoryModal from "@/components/Admin/Accessory/Modal/Index";

const accessories = [
  {
    name: "Type 1",
    accessory_type: "Type 1",
    out_of_stock: false,
    description: "Type 1",
    price: 12323,
    url_media_files: ["Type 1", "Type 2"],
  },
];

const AdminAccessoriesPage = () => {
  const elementRef = useRef(null);

  const onClickAddAccessory = useCallback(() => {
    elementRef.current.showModal();
  }, []);

  return (
    <div className="container mx-auto px-12 py-8">
      <div className="flex justify-between">
        <h1 className="font-bold text-2xl">Accessories</h1>
        <button className="btn btn-primary" onClick={onClickAddAccessory}>
          Add Accessory
        </button>
      </div>

      <div className="overflow-x-auto mt-6">
        <table className="table">
          <thead>
            <tr>
              <th></th>
              <th>Name</th>
              <th>Accessory Type</th>
              <th>Out of Stock</th>
              <th>Description</th>
              <th>Price</th>
              <th>media urls</th>
              <th></th>
              <th></th>
            </tr>
          </thead>
          <tbody>
            {accessories.map((accessory, index) => (
              <tr key={index}>
                <th>{index + 1}</th>
                <td>{accessory.name}</td>
                <td>{accessory.accessory_type}</td>
                <td>{accessory.out_of_stock.toString()}</td>
                <td>{accessory.description}</td>
                <td>{formatCentToEuro(accessory.price)}</td>
                <td>{accessory.accessory_type}</td>
                <td>
                  {
                    <ul>
                      {accessory.url_media_files.map((url, index) => (
                        <li key={index}>{url}</li>
                      ))}
                    </ul>
                  }
                </td>
                <td>
                  <button
                    onClick={onClickAddAccessory}
                    className="btn btn-sm btn-secondary"
                  >
                    Edit
                  </button>
                  <button className="btn btn-sm btn-error">Delete</button>
                </td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>

      <AccessoryModal ref={elementRef} />
    </div>
  );
};

export default AdminAccessoriesPage;
