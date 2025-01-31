import { useCallback } from "react";
import SelectField from "@/lib/SelectField";
import InputField from "@/lib/InputField";
import { useForm, FormProvider } from "react-hook-form";
import Checkbox from "@/lib/Checkbox";
import { useProductDetail } from "@/hooks";

const CreateProductDialog = ({
  elementRef,
  productId,
  handleOnClose,
  productTypesOptions,
}) => {
  const { data: product } = useProductDetail(productId);

  const methods = useForm({
    defaultValues: product,
  });

  const onSubmit = useCallback((data) => {
    console.log("data submitting", data);
  }, []);

  return (
    <FormProvider {...methods}>
      <dialog
        ref={elementRef}
        className="modal modal-bottom sm:modal-middle"
        onSubmit={methods.handleSubmit(onSubmit)}
        onCancel={handleOnClose}
      >
        <div className="modal-box">
          <h2 className="modal-title">{productId ? "Edit" : "Add"} Product</h2>

          <InputField label="Name" name="name" placeholder="Name" required />

          <SelectField
            label="Product Type"
            name="product_type_id"
            placeholder="Pick a product type"
            options={productTypesOptions}
          />

          <Checkbox label="Out of Stock" name="out_of_stock" />

          <InputField
            required
            label="Price"
            name="price"
            type="number"
            placeholder="Price"
          />

          <InputField
            required
            label="Image Url"
            name="url_media_files[]"
            placeholder="Image Url"
          />

          <InputField
            required
            label="Product Description"
            name="description"
            placeholder="Product Description"
          />

          <div className="modal-action">
            <form method="dialog">
              {/* if there is a button in form, it will close the modal */}
              <button className="btn">Save</button>
            </form>
          </div>
        </div>
      </dialog>
    </FormProvider>
  );
};

export default CreateProductDialog;
