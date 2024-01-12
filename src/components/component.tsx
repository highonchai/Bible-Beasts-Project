/**
 * This code was generated by v0 by Vercel.
 * @see https://v0.dev/t/wuY8EfqBbTC
 */
import Link from "next/link";
import { Button } from "@/components/ui/button";
import { AvatarImage, Avatar } from "@/components/ui/avatar";
import { CardHeader, CardContent, Card } from "@/components/ui/card";
import leviathan from "./ui/leviathan.png";
import bear from "./ui/bear.png";

export function Component() {
  return (
    <div className="flex flex-col min-h-screen bg-white text-black">
      <header className="px-6 py-4 flex items-center justify-between">
        <Link className="flex items-center" href="#">
          <BookIcon className="w-6 h-6 mr-2" />
          <span className="text-lg font-bold">Bible Beasts Project</span>
        </Link>
        <nav className="flex space-x-4">
          <Link className="text-sm font-medium hover:underline" href="#">
            About
          </Link>
          <Link className="text-sm font-medium hover:underline" href="#">
            Beasts
          </Link>
          <Link className="text-sm font-medium hover:underline" href="#">
            Stories
          </Link>
          <Link className="text-sm font-medium hover:underline" href="#">
            Contact
          </Link>
        </nav>
      </header>
      <main className="flex-1">
        <section className="container mx-auto px-6 py-12">
          <div className="text-center space-y-6">
            <h1 className="text-4xl font-bold">
              Welcome to the Bible Beasts Project!
            </h1>
            <p className="text-lg text-gray-700">
              A new way to experience the beasts in the bible.
            </p>
            <Button className="px-6 py-2 rounded bg-blue-600 text-white">
              Get Started
            </Button>
          </div>
        </section>
        <section className="bg-gray-100 py-12">
          <div className="container mx-auto px-6">
            <h2 className="text-2xl font-bold text-center mb-8">
              Meet the Beasts
            </h2>
            <div className="flex flex-wrap justify-center items-center gap-8">
              <Card className="max-w-sm">
                <CardHeader className="px-4 py-2 flex items-center">
                  <Avatar className="large-avatar">
                    <AvatarImage alt="Leviathan" src={leviathan.src} />
                  </Avatar>
                  <h3 className="text-xl font-bold">Leviathan</h3>
                </CardHeader>
                <CardContent className="p-4">
                  <p>{/*  */}</p>
                </CardContent>
              </Card>
              <Card className="max-w-sm">
                <CardHeader className="px-4 py-2 flex items-center">
                  <Avatar className="large-avatar">
                    <AvatarImage alt="The Bear" src={bear.src} />
                  </Avatar>
                  <h3 className="text-xl font-bold">Bear</h3>
                </CardHeader>
                <CardContent className="p-4">
                  <p>{/*  */}</p>
                </CardContent>
              </Card>
            </div>
          </div>
        </section>
      </main>
      <footer className="px-6 py-4 bg-blue-600 text-white">
        <div className="container mx-auto flex justify-between items-center">
          <div className="flex items-center space-x-4">
            <BookIcon className="w-6 h-6" />
            <Link className="text-sm font-medium hover:underline" href="#">
              Bible Beasts Project
            </Link>
          </div>
          <nav className="flex space-x-4">
            <Link className="text-sm font-medium hover:underline" href="#">
              About
            </Link>
            <Link className="text-sm font-medium hover:underline" href="#">
              Characters
            </Link>
            <Link className="text-sm font-medium hover:underline" href="#">
              Stories
            </Link>
            <Link className="text-sm font-medium hover:underline" href="#">
              Contact
            </Link>
          </nav>
        </div>
      </footer>
    </div>
  );
}

function BookIcon(props: any) {
  return (
    <svg
      {...props}
      xmlns="http://www.w3.org/2000/svg"
      width="24"
      height="24"
      viewBox="0 0 24 24"
      fill="none"
      stroke="currentColor"
      strokeWidth="2"
      strokeLinecap="round"
      strokeLinejoin="round"
    >
      <path d="M4 19.5v-15A2.5 2.5 0 0 1 6.5 2H20v20H6.5a2.5 2.5 0 0 1 0-5H20" />
    </svg>
  );
}
