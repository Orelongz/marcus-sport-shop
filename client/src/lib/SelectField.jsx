import { useFormContext } from "react-hook-form";

const SelectField = ({ name, label, placeholder, options }) => {
  const { register } = useFormContext();

  return (
    <fieldset className="fieldset">
      <legend className="fieldset-legend">{label}</legend>
      <select
        name={name}
        className="select"
        {...register(name)}
        defaultValue={placeholder}
      >
        <option disabled={true}>{placeholder}</option>
        {options.map((option) => (
          <option key={option.label} value={option.value}>
            {option.label}
          </option>
        ))}
      </select>
      <span className="fieldset-label">Optional</span>
    </fieldset>
  );
};

export default SelectField;
