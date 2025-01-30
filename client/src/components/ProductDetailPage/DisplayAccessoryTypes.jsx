import DisplayAccessories from "./DisplayAccessories";

const DisplayAccessoryTypes = ({
  accessories,
  accessoryTypes,
  complementaryPriceHash,
  complementaryConstrainIdHash,
}) => {
  return (
    <>
      <h2>Accessories to customize bicycle</h2>

      <div className="accordion flex flex-col space-y-4">
        {accessoryTypes.map((accessoryType, index) => (
          <div
            key={accessoryType.id}
            className="collapse bg-base-100 border border-base-300"
          >
            <input
              type="checkbox"
              name="my-accordion-1"
              defaultChecked={index === 0}
            />

            <div className="collapse-title font-semibold">
              {accessoryType.name}
            </div>

            <DisplayAccessories
              accessories={accessories}
              accessoryTypeId={accessoryType.id}
              complementaryPriceHash={complementaryPriceHash}
              complementaryConstrainIdHash={complementaryConstrainIdHash}
            />
          </div>
        ))}
      </div>
    </>
  );
};

export default DisplayAccessoryTypes;
