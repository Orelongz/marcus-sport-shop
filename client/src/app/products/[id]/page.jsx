"use client";

import { useCallback, useState } from "react";
import Image from "next/image";
import Footer from "@/components/Footer";

import { formatCentToEuro } from "@/services/util";

import classNames from "classnames";

// const Page = async ({ params }) => {
//   const { id: productId } = await params;

const Page = () => {
  const item = {
    id: 3,
    name: "item name",
    type: "item type",
    price: 1000,
    description: "item description",
    mediaUrls: [
      "https://www.bikeride.com/images/bike/Specialized-Roubaix-SL8-1024x630.jpg",
    ],
  };
  const { mediaUrls } = item;
  const [displayedMediaUrl, setDisplayedMediaUrl] = useState(mediaUrls[0]);

  const onClickMedia = useCallback(
    (event) => {
      event.preventDefault();

      const { src: mediaUrl } = event.target;

      if (mediaUrl !== displayedMediaUrl) setDisplayedMediaUrl(mediaUrl);
    },
    [displayedMediaUrl],
  );

  const accessoryTypes = [
    {
      id: 1,
      name: "Frame type",
      accessories: [
        {
          id: 1,
          name: "Frame type 1",
          price: 100,
        },
        {
          id: 2,
          name: "Frame type 2",
          price: 100,
        },
      ],
    },
    {
      id: 2,
      name: "Frame finish",
      accessories: [
        {
          id: 1,
          name: "Frame finish 1",
          price: 100,
        },
        {
          id: 2,
          name: "Frame finish 2",
          price: 100,
        },
      ],
    },
    {
      id: 3,
      name: "Wheels",
      accessories: [
        {
          id: 1,
          name: "Wheel 1",
          price: 100,
        },
        {
          id: 2,
          name: "Wheel 2",
          price: 100,
        },
      ],
    },
  ];

  return (
    <div className="pt-12">
      <div className="mr-120 px-24">
        <div className="flex space-x-12">
          <div className="flex flex-col space-y-12 items-center mt-12">
            {mediaUrls.map((mediaUrl, index) => (
              <button
                key={`mediaUrl-${index}`}
                className={classNames(
                  "outline-2 outline-offset-2 cursor-pointer rounded-sm",
                  {
                    "outline-stone-300": mediaUrl !== displayedMediaUrl,
                    "outline-blue-500": mediaUrl === displayedMediaUrl,
                  },
                )}
              >
                <Image
                  width={400}
                  height={400}
                  alt={item.name}
                  src={mediaUrl}
                  onClick={onClickMedia}
                  className="max-w-20 aspect-4/5 size-full object-cover rounded-sm lg:aspect-auto"
                />
              </button>
            ))}
          </div>

          <Image
            width={400}
            height={400}
            alt={item.name}
            src={displayedMediaUrl}
            className="aspect-4/5 size-full object-fill lg:object-cover sm:rounded-lg lg:aspect-auto"
          />
        </div>

        <div className="divider divider-neutral" />

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

              <div className="collapse-content text-sm flex flex-wrap space-x-4 space-y-4">
                {accessoryType.accessories.map((accessory) => (
                  <div key={accessory.id} className="">
                    <Image
                      src="https://img.daisyui.com/images/stock/photo-1606107557195-0e29a4b5b4aa.webp"
                      alt="Shoes"
                      className="w-full"
                      width={80}
                      height={80}
                    />
                    <input
                      type="radio"
                      className="btn w-full"
                      value={accessory.id}
                      name={accessoryType.name}
                      aria-label={accessory.name}
                    />
                    <div className="text-center">
                      {formatCentToEuro(accessory.price)}
                    </div>
                  </div>
                ))}
              </div>
            </div>
          ))}
        </div>

        <div className="mt-16">
          <Footer />
        </div>
      </div>

      <div className="sidebar fixed top-[64px] right-0 w-120 h-full overflow-hidden z-1">
        <div className="menu bg-base-200 text-base-content min-h-full p-12 w-full">
          <div className="">
            <h1 className="text-2xl text-gray-900 sm:text-3xl capitalize mb-4">
              {item.type}:
            </h1>

            <h1 className="text-2xl font-bold tracking-tight text-gray-900 sm:text-3xl">
              {item.name}
            </h1>
          </div>

          <div className="mt-12">
            <h2 className="sr-only">item information</h2>
            <p className="text-3xl tracking-tight text-gray-900">
              {formatCentToEuro(item.price)}
            </p>

            <button className="mt-6 btn btn-primary duration-300">
              Add to Cart
            </button>
          </div>

          <div className="mt-12">
            <div>
              <h3 className="sr-only">Description</h3>

              <div className="space-y-6">
                <p className="text-base text-gray-900">{item.description}</p>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
};

export default Page;
