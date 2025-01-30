import Footer from "@/components/Footer";
import SideBar from "@/components/ProductsPage/SideBar";
import DisplayProducts from "@/components/ProductsPage/DisplayProducts";
import ProductsPageHydrationBoundary from "@/lib/HydrationBoundaries/ProductsPage";

const HomePage = async () => {
  return (
    <ProductsPageHydrationBoundary>
      <div className="flex flex-row">
        <div className="sidebar fixed top-[64px] w-65 h-full overflow-hidden z-1">
          <div className="menu bg-base-200 text-base-content min-h-full p-4 w-full">
            <div className="flex flex-col space-y-4">
              <SideBar />
            </div>
          </div>
        </div>

        <div className="ml-65">
          <div className="bg-white">
            <div className="mx-auto max-w-2xl px-4 py-12 sm:px-6 lg:max-w-7xl lg:px-8">
              <h2 className="sr-only">Products</h2>

              <DisplayProducts />

              <div className="mt-16">
                <Footer />
              </div>
            </div>
          </div>
        </div>
      </div>
    </ProductsPageHydrationBoundary>
  );
};

export default HomePage;
