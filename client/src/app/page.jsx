import Link from "next/link";
import Image from "next/image";
import Footer from "@/components/Footer";

const Page = () => {
  const products = [1, 2, 3, 4, 5];
  const productTypes = ["Bicycle", "Vehicle"];

  return (
    <div className="flex flex-row">
      <div className="sidebar fixed top-[64px] w-65 h-full overflow-hidden z-1">
        <div className="menu bg-base-200 text-base-content min-h-full p-4 w-full">
          <div className="flex flex-col space-y-4">
            {productTypes.map((productType) => (
              <input
                type="checkbox"
                key={productType}
                name="productType"
                aria-label={productType}
                className="btn w-full opacity-100 scale-100"
              />
            ))}
          </div>
        </div>
      </div>

      <div className="ml-65">
        <div className="bg-white">
          <div className="mx-auto max-w-2xl px-4 py-12 sm:px-6 lg:max-w-7xl lg:px-8">
            <h2 className="sr-only">Products</h2>

            <div className="grid grid-cols-1 gap-x-6 gap-y-10 lg:grid-cols-2 xl:grid-cols-3 xl:gap-x-8">
              {products.map((item) => (
                <Link
                  href="products/3"
                  key={item}
                  className="card bg-base-100 w-96 shadow-sm"
                >
                  <figure>
                    <Image
                      src="https://img.daisyui.com/images/stock/photo-1606107557195-0e29a4b5b4aa.webp"
                      alt="Shoes"
                      width={384}
                      height={256}
                    />
                  </figure>
                  <div className="card-body">
                    <h2 className="card-title">Product Name</h2>

                    <div className="badge badge-outline">Product Type</div>

                    <div className="">€5,000.00</div>
                  </div>
                </Link>
              ))}
            </div>

            <div className="mt-16">
              <Footer />
            </div>
          </div>
        </div>
      </div>
    </div>
  );
};

export default Page;
