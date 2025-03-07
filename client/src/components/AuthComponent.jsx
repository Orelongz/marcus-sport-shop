import Link from "next/link";

const AuthComponent = ({ type = "sign_up" }) => {
  const signUpForm = type === "sign_up";
  const signInForm = type === "sign_in";
  const buttonText = signUpForm ? "Sign up" : "Sign in";
  const title = signUpForm
    ? "Sign up for an account"
    : "Sign in to your account";

  return (
    <div className="flex min-h-full flex-col justify-center px-6 py-12 lg:px-8">
      <div className="sm:mx-auto sm:w-full sm:max-w-sm">
        <h2 className="mt-10 text-center text-2xl/9 font-bold tracking-tight text-gray-900">
          {title}
        </h2>
      </div>

      <div className="mt-10 sm:mx-auto sm:w-full sm:max-w-sm">
        <form className="space-y-6" action="#" method="POST">
          <div>
            <label
              htmlFor="email"
              className="block text-sm/6 font-medium text-gray-900"
            >
              Email address
            </label>
            <div className="mt-2">
              <input
                type="email"
                name="email"
                id="email"
                autoComplete="email"
                required
                className="block w-full rounded-md bg-white px-3 py-1.5 text-base text-gray-900 outline-1 -outline-offset-1 outline-gray-300 placeholder:text-gray-400 focus:outline-2 focus:-outline-offset-2 focus:outline-indigo-600 sm:text-sm/6"
              />
            </div>
          </div>

          <div>
            <div className="flex items-center justify-between">
              <label
                htmlFor="password"
                className="block text-sm/6 font-medium text-gray-900"
              >
                Password
              </label>
            </div>
            <div className="mt-2">
              <input
                type="password"
                name="password"
                id="password"
                autoComplete="current-password"
                required
                className="block w-full rounded-md bg-white px-3 py-1.5 text-base text-gray-900 outline-1 -outline-offset-1 outline-gray-300 placeholder:text-gray-400 focus:outline-2 focus:-outline-offset-2 focus:outline-indigo-600 sm:text-sm/6"
              />
            </div>
          </div>

          <div>
            <button type="submit" className="btn btn-primary w-full">
              {buttonText}
            </button>
          </div>
        </form>

        {signInForm && (
          <div className="mt-4 text-center">
            Not a member?
            <Link href="/signup" className="btn btn-link px-1">
              Sign up
            </Link>
          </div>
        )}

        {signUpForm && (
          <div className="mt-4 text-center">
            Already have an account?{" "}
            <Link href="/login" className="btn btn-link px-1">
              Log in
            </Link>
          </div>
        )}
      </div>
    </div>
  );
};

export default AuthComponent;
