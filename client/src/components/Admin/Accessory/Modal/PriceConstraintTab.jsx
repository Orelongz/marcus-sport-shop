import InputField from "@/lib/InputField";
import SelectField from "@/lib/SelectField";
import { useFieldArray, useForm } from "react-hook-form";

const PriceConstraintTab = () => {
  const accessoryType = "Frame Type";

  const { control } = useForm();
  const { fields, append, remove } = useFieldArray({
    control,
    name: "price_constraint",
  });

  return (
    <div>
      {fields.map((field, index) => (
        <div
          key={field.id}
          className="flex items-center space-x-4 border-1 border-neutral px-4 py-2 mb-4 rounded-lg"
        >
          <div className="form-control flex-1">
            <div className="flex space-x-8">
              <SelectField
                name="kjkjj"
                label="Accessory Type"
                options={[
                  { value: 1, label: "Frame Type" },
                  { value: 2, label: "Wheel" },
                ]}
              />
              {accessoryType && (
                <SelectField
                  label="Accessory"
                  options={[
                    { value: 1, label: "Fixed" },
                    { value: 2, label: "Percentage" },
                  ]}
                  name={`price_constraint.${index}.complementary_id`}
                />
              )}
            </div>

            <InputField
              type="number"
              label="Price"
              placeholder="New Price of above accessory"
              name={`price_constraint.${index}.price`}
            />
          </div>

          <button
            type="button"
            className="btn btn-error"
            onClick={() => remove(index)}
          >
            Remove
          </button>
        </div>
      ))}

      <div className="place-self-end mt-4">
        <button
          type="button"
          className="btn btn-primary"
          onClick={() => append({ complementary_id: "", price: 0 })}
        >
          Add
        </button>
      </div>
    </div>
  );
};

export default PriceConstraintTab;
