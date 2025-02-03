const buildFetchOptions = (method, options) => {
  const { headers = {}, ...restOptions } = options;

  return {
    method,
    headers: {
      "Content-Type": "application/json",
      ...headers,
    },
    credentials: "include",
    ...restOptions,
  };
};

export const fetchJSON = (url, options = {}) =>
  fetch(url, buildFetchOptions("GET", options))
    .then((response) => response.json())
    .catch((error) => console.log(error));

export const postJSON = (url, data, options = {}) =>
  fetch(
    url,
    buildFetchOptions("POST", { body: JSON.stringify(data), ...options }),
  );
