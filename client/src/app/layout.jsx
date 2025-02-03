import "./globals.css";

import { Inter } from "next/font/google";

import NavBar from "@/components/NavBar";
import Providers from "@/lib/Providers";
import AlertContextProvider from "@/lib/Alert/AlertContext";

const inter = Inter({ subsets: ["latin"] });

export const metadata = {
  title: "Marcus' Sport Shop",
  description:
    "Sport shop owned by Marcus. Get your custom built bicycles at the best price",
};

export default function RootLayout({ children }) {
  return (
    <html lang="en" data-theme="corporate">
      <body className={`${inter.className} antialiased`}>
        <Providers>
          <AlertContextProvider>
            <NavBar />

            <main className="mt-[64px]">{children}</main>
          </AlertContextProvider>
        </Providers>
      </body>
    </html>
  );
}
