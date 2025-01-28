const AdminProductTypesPage = () => {
  const productTypes = ["Type 1", "Type 2", "Type 3"];

  return (
    <div className="container mx-auto px-4 py-8">
      <h1 className="font-bold text-2xl">Product Types</h1>

      <div className="overflow-x-auto">
        <table className="table">
          <thead>
            <tr>
              <th></th>
              <th>Name</th>
              <th>Delete</th>
            </tr>
          </thead>
          <tbody>
            {productTypes.map((productType, index) => (
              <tr key={index}>
                <th>{index + 1}</th>
                <td>{productType}</td>
                <td>
                  <button className="btn btn-sm btn-danger">Delete</button>
                </td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>
    </div>
  );
};

export default AdminProductTypesPage;
