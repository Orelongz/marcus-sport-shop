import { useFormContext } from "react-hook-form";

const InputField = ({
  name,
  label,
  type = "text",
  placeholder = "",
  required = false,
}) => {
  const { register } = useFormContext();

  return (
    <fieldset className="fieldset">
      <legend className="fieldset-legend">{label}</legend>
      <input
        type={type}
        name={name}
        className="input"
        placeholder={placeholder || label}
        {...register(name, { required })}
      />
    </fieldset>
  );
};

export default InputField;
