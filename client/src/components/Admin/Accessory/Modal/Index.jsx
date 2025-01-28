"use client";

import { useForm, FormProvider } from "react-hook-form";

import DetailsTab from "@/components/Admin/Accessory/Modal/DetailsTab";
import PriceConstraintTab from "@/components/Admin/Accessory/Modal/PriceConstraintTab";
import ComplementaryAccessoriesTab from "@/components/Admin/Accessory/Modal/ComplementaryAccessoriesTab";
import { useCallback } from "react";

const AccessoryModal = ({ ref }) => {
  const methods = useForm();

  const handleClose = useCallback(() => {
    ref.current.close();
  }, [ref]);

  const onSubmit = useCallback(
    (data) => {
      console.log("data", data);
      handleClose();
    },
    [handleClose],
  );

  return (
    <dialog ref={ref} className="modal modal-middle" onCancel={handleClose}>
      <FormProvider {...methods}>
        <form
          method="dialog"
          onSubmit={methods.handleSubmit(onSubmit)}
          className="modal-box min-w-xl max-w-3xl"
        >
          <h2 className="modal-title my-6">Add/Edit Accessory</h2>

          <div role="tablist" className="tabs tabs-lift">
            <input
              type="radio"
              name="accessories_tab"
              role="tab"
              className="tab"
              aria-label="Accessory Details"
              defaultChecked
            />
            <div className="tab-content bg-base-100 border-base-300 p-6">
              <DetailsTab />
            </div>

            <input
              type="radio"
              name="accessories_tab"
              role="tab"
              className="tab"
              aria-label="Price Constraint"
            />
            <div className="tab-content bg-base-100 border-base-300 p-6">
              <PriceConstraintTab />
            </div>

            <input
              type="radio"
              name="accessories_tab"
              role="tab"
              className="tab"
              aria-label="Complementary Accessories"
            />
            <div className="tab-content bg-base-100 border-base-300 p-6">
              <ComplementaryAccessoriesTab />
            </div>
          </div>

          <div className="modal-action space-x-2">
            <button
              className="btn btn-secondary"
              type="reset"
              onClick={handleClose}
            >
              Close
            </button>
            <button className="btn btn-primary" type="submit">
              Save
            </button>
          </div>
        </form>
      </FormProvider>
    </dialog>
  );
};

export default AccessoryModal;
