"use client";

import Link from "next/link";
import Image from "next/image";
import { useProducts } from "@/hooks";
import { formatCentToEuro } from "@/services/util";

const DisplayProducts = () => {
  const { products } = useProducts();

  return (
    <div className="grid grid-cols-1 gap-x-6 gap-y-10 lg:grid-cols-2 xl:grid-cols-3 xl:gap-x-8">
      {products.map(({ id, name, image, price }) => (
        <Link
          key={name}
          href={`products/${id}`}
          className="card bg-base-100 w-96 shadow-sm"
        >
          <figure className="card-image h-[256px]">
            <Image src={image} alt="Shoes" width={384} height={256} />
          </figure>
          <div className="card-body">
            <h2 className="card-title">{name}</h2>

            <div className="badge badge-outline">Product Type</div>

            <div className="">{formatCentToEuro(price)}</div>
          </div>
        </Link>
      ))}
    </div>
  );
};

export default DisplayProducts;
