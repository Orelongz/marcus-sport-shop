import "./globals.css";

import { Inter } from "next/font/google";

import NavBar from "@/components/NavBar";

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
        <NavBar />

        {children}
      </body>
    </html>
  );
}
