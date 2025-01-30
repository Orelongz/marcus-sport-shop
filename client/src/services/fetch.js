const buildFetchOptions = (method, options) => {
  const { headers = {}, ...restOptions } = options;

  return {
    method,
    headers: { "Content-Type": "application/json", ...headers },
    ...restOptions,
  };
};

export const fetchJSON = (url, options = {}) =>
  fetch(url, buildFetchOptions("GET", options))
    .then((response) => response.json())
    .catch((error) => console.log(error));
