import Checkbox from "@/lib/Checkbox";
import InputField from "@/lib/InputField";
import SelectField from "@/lib/SelectField";

const DetailsTab = () => {
  return (
    <div>
      <InputField name="name" label="Name" />

      <InputField name="description" label="Description" type="text-area" />

      <SelectField
        label="Accessory Type"
        name="accessory_type"
        placeholder="Pick a Accessory type"
        options={[
          { value: 1, label: "Bicycle" },
          { value: 2, label: "Vehicle" },
        ]}
      />

      <Checkbox name="out_of_stock" label="Out of Stock" />

      <InputField name="price" label="Price" type="number" />
    </div>
  );
};

export default DetailsTab;
