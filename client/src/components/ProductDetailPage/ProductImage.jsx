"use client";

import { useCallback, useState } from "react";
import Image from "next/image";
import classNames from "classnames";

const ProductImage = ({ product }) => {
  const [displayedMediaUrl, setDisplayedMediaUrl] = useState();

  const onClickMedia = useCallback(
    (event) => {
      event.preventDefault();

      const { alt: mediaUrl } = event.target;

      if (mediaUrl !== displayedMediaUrl) setDisplayedMediaUrl(mediaUrl);
    },
    [displayedMediaUrl],
  );

  const { id, mediaUrls } = product;

  return (
    <div className="flex space-x-12" id={`product-${id}`}>
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
              alt={mediaUrl}
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
        alt={displayedMediaUrl || mediaUrls[0]}
        src={displayedMediaUrl || mediaUrls[0]}
        className="aspect-4/5 size-full object-fill lg:object-cover sm:rounded-lg lg:aspect-auto"
      />
    </div>
  );
};

export default ProductImage;
