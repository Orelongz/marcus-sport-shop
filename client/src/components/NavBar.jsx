import Image from "next/image";
import Link from "next/link";

const NavBar = () => {
  const userName = "John Doe";
  const initials = userName.match(/\b(\w)/g).join("");

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
                <span className="badge badge-sm indicator-item">8</span>
              </Link>
            </div>
          </div>

          <div className="dropdown dropdown-end">
            <div
              tabIndex={0}
              role="button"
              className="btn btn-soft btn-secondary btn-circle"
            >
              <div className="w-10 rounded-full">{initials}</div>
            </div>
            <ul
              tabIndex={0}
              className="menu menu-sm dropdown-content bg-base-100 rounded-box z-1 mt-3 w-52 p-2 shadow text-neutral"
            >
              <li>
                <a>Logout</a>
              </li>
            </ul>
          </div>
        </div>
      </div>
    </div>
  );
};
export default NavBar;
