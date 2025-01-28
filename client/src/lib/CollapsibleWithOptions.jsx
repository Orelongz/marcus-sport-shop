import { useCallback } from "react";
import Checkbox from "@/lib/Checkbox";

const CollapsibleWithOptions = ({ header, options }) => {
  const handleOnSelectAll = useCallback(() => {
    console.log("select all checkboxes clicked");
  }, []);

  console.log("header", header);

  return (
    <div className="collapse bg-base-100 border border-base-300">
      <input type="checkbox" />

      <div className="collapse-title font-semibold">
        {header}

        <Checkbox
          onClick={handleOnSelectAll}
          label="Select All"
          name="select_all"
        />
      </div>

      <div className="collapse-content text-sm">
        {options.map((option) => (
          <Checkbox
            key={option.label}
            label={option.label}
            value={option.value}
            name="complementary_accessories.complementary_ids"
          />
        ))}
      </div>
    </div>
  );
};

export default CollapsibleWithOptions;
