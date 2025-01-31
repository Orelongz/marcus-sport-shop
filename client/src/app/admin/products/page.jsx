import ProductsPageHydrationBoundary from "@/lib/HydrationBoundaries/ProductsPage";

import DisplayProducts from "@/components/Admin/Products/DisplayProducts";

const AdminProductsPage = () => {
  return (
    <ProductsPageHydrationBoundary>
      <div className="container mx-auto px-12 py-8">
        <DisplayProducts />
      </div>
    </ProductsPageHydrationBoundary>
  );
};

export default AdminProductsPage;
