import Image from "next/image";
import Link from "next/link";

const NavBar = () => {
  return (
    <div className="navbar bg-info text-neutral-content px-6 lg:px-16 fixed top-0 z-1">
      <div className="flex items-center justify-between w-full">
        <div className="">
          <Link
            href="/"
            className="flex items-center text-lg hover:text-base-300"
          >
            <Image src="/logo.png" alt="logo" width={50} height={50} />
            Marcus&rsquo; Sport Shop
          </Link>
        </div>

        <div className="flex items-center space-x-4">
          <div className="dropdown dropdown-end">
            <div
              tabIndex={0}
              role="button"
              className="btn btn-ghost btn-circle"
            >
              <Link href="/cart" className="indicator">
                <Image src="/cartIcon.svg" alt="logo" width={30} height={30} />
              </Link>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
};
export default NavBar;
