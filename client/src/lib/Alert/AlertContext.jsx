"use client";

import { isEmpty } from "lodash";
import Alert from "./Alert";
import { createContext, useEffect, useState } from "react";

export const AlertContext = createContext({});

const THREE_SECONDS = 3000;

const AlertContextProvider = ({ children }) => {
  const [alertProps, setAlertProps] = useState({
    type: "",
    message: "",
  });

  useEffect(() => {
    if (isEmpty(alertProps)) return;

    const timer = setTimeout(() => {
      setAlertProps({ type: "", message: "" });
    }, THREE_SECONDS);

    return () => clearTimeout(timer);
  }, [alertProps]);

  return (
    <AlertContext.Provider value={{ alertProps, setAlertProps }}>
      {Boolean(alertProps.message) && (
        <Alert message={alertProps.message} type={alertProps.type} />
      )}

      {children}
    </AlertContext.Provider>
  );
};

export default AlertContextProvider;
