import CollapsibleWithOptions from "@/lib/CollapsibleWithOptions";

const ComplementaryAccessoriesTab = () => {
  const accessoryTypes = [
    { value: 1, label: "Frame Type" },
    { value: 2, label: "Wheel" },
  ];
  const accessories = [
    { value: 1, label: "Fixed" },
    { value: 2, label: "Percentage" },
  ];

  return (
    <div className="space-y-6">
      {accessoryTypes.map((accessoryType) => (
        <CollapsibleWithOptions
          key={accessoryType.label}
          header={accessoryType.label}
          options={accessories}
        />
      ))}
    </div>
  );
};

export default ComplementaryAccessoriesTab;
