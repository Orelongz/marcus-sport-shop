import { useFormContext } from "react-hook-form";

const Checkbox = ({
  name,
  label,
  value = true,
  required = false,
  defaultChecked = false,
}) => {
  const { register } = useFormContext();

  return (
    <fieldset className="fieldset mt-4 w-full">
      <label className="fieldset-label">
        <input
          name={name}
          value={value}
          type="checkbox"
          className="checkbox"
          defaultChecked={defaultChecked}
          {...register(name, { required })}
        />
        {label}
      </label>
    </fieldset>
  );
};

export default Checkbox;
